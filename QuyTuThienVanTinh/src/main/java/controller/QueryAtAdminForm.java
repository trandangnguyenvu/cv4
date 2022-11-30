package controller;

import java.io.IOException;

import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.DatabaseOperationDonationRoundDAO;
import model.DonationRound;
import model.User;


/**
 * Servlet implementation class QueryAtAdminForm
 * 
 * Form of a donation round (admin type) will come here
 * 
 * admin manage donations here
 * 
 * this servlet will execute tasks 
 * 
 * CONTROLLER OF admin-form jsp (body-admin-form-edit jsp, body-admin-form-create jsp): edit + create a Donation Round functions
 * CONTROLLER OF admin jsp (body-admin jsp): delete / search a Donation Round function
 *   
 * controller of sql query from JSPs (body-admin + body-admin-form-* + body-admin-search) for tasks: search/delete/update/create  donation-rounds/a donation-round
 */


public class QueryAtAdminForm extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public QueryAtAdminForm() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("UTF-8"); // WITHOUT THIS => VIETNAMESE VALUE OF ATTRIBUTE OF SESSION THAT JSP GET TO SHOW WILL NOT RIGHT SHOWING
		HttpSession session = request.getSession();
		
		String action = request.getParameter("action");
		String idDonationRound = request.getParameter("iddonationround");
		String title = request.getParameter("title");
		String summary = request.getParameter("summary");
		String story = request.getParameter("story");
		String startDate = request.getParameter("startdate");
		String endDate = request.getParameter("enddate");
		String partnerId = request.getParameter("partnerid");
		
		String targetMoney = request.getParameter("targetmoney");
		
		
		User loginAcc =  (User) session.getAttribute("loginAccount"); // for check the role
		
		
		if (loginAcc != null) {
			if (loginAcc.getRole().equals("Admin")) {
				DatabaseOperationDonationRoundDAO databaseOperation = new DatabaseOperationDonationRoundDAO();
				
				DonationRound dr = new DonationRound(title, summary, story);
				
				session.setAttribute("stitle", title);
				session.setAttribute("ssummary", summary);
				session.setAttribute("sstory", story);
				session.setAttribute("sstart", startDate);
				session.setAttribute("send", endDate);
				session.setAttribute("spartnerId", partnerId);
				
				session.setAttribute("stargetmoney", targetMoney);
				
				
				if (action.equals("delete")) {
					try {
						if (databaseOperation.delete(idDonationRound)) {
							session.setAttribute("sqlExcutionStatus", "done");
							request.getRequestDispatcher("/jsp/admin.jsp").forward(request, response);
						} else {
							session.setAttribute("sqlExcutionStatus", "fail");
							request.getRequestDispatcher("/jsp/admin.jsp").forward(request, response);
						}
					} catch (SQLException e) {
						// TODO Auto-generated catch block 
						session.setAttribute("sqlExcutionStatus", "fail");
						request.getRequestDispatcher("/jsp/admin.jsp").forward(request, response);
						e.printStackTrace();
					}
				} else  if (action.equals("search")) {
					//String characters = request.getParameter("characters");			
					request.getRequestDispatcher("/jsp/admin-search.jsp").forward(request, response);
				} else if (!dr.validate2()) {
					session.setAttribute("errormessage", dr.getMessage());
					request.getRequestDispatcher("/jsp/admin-form.jsp").forward(request, response);
				} else if (partnerId == null || partnerId.equals("")) {
					dr.setMessage("Mục đối tác đồng hành không được để trống");
					session.setAttribute("errormessage", dr.getMessage());
					request.getRequestDispatcher("/jsp/admin-form.jsp").forward(request, response);
				} else if (startDate == null || startDate.equals("")) {
					dr.setMessage("Mục ngày bắt đầu không được để trống");
					session.setAttribute("errormessage", dr.getMessage());
					request.getRequestDispatcher("/jsp/admin-form.jsp").forward(request, response);
				} else if (endDate == null || endDate.equals("")) {
					dr.setMessage("Mục ngày kết thúc không được để trống");
					session.setAttribute("errormessage", dr.getMessage());
					request.getRequestDispatcher("/jsp/admin-form.jsp").forward(request, response);
				} else if (targetMoney == null || targetMoney.equals("")) {
					dr.setMessage("Số tiền định mức không được để trống");
					session.setAttribute("errormessage", dr.getMessage());
					request.getRequestDispatcher("/jsp/admin-form.jsp").forward(request, response);
				} else {
					int partnerIdInt = Integer.parseInt(partnerId); 
					float flTargetMoney = Float.parseFloat(targetMoney);
					
					Date startD = null; //important
					Date endD = null; //important
					try {
						startD = new SimpleDateFormat("yyyy-MM-dd").parse(startDate); //"yyyy-MM-dd"
						endD = new SimpleDateFormat("yyyy-MM-dd").parse(endDate); //"yyyy-MM-dd"
					} catch (ParseException e1) {
						// TODO Auto-generated catch block
						e1.printStackTrace();
						return; //important
					}
					
					java.sql.Date start = new java.sql.Date(startD.getTime());
					java.sql.Date end = new java.sql.Date(endD.getTime());
					
					dr.setPartnerId(partnerIdInt); // constructor of dr above just passed 3 parameter to 3 fields while 3 others fields are still null
					dr.setStartDate(start);
					dr.setEndDate(end);
					dr.setTargetMoney(flTargetMoney);
					
					/*
					 * body-admin-form-edit jsp will use this servlet with action value is "update" ; body-admin-form-create with "create"
					 */
					if (action.equals("update")) {
						if (dr.validate1()) {
							// cause sql => must surrounded by try catch
							try {
								if (databaseOperation.update(title, summary, story, partnerId, startDate, endDate, idDonationRound, targetMoney)) {
									session.setAttribute("sqlExcutionStatus", "done");
									request.getRequestDispatcher("/jsp/admin.jsp").forward(request, response);
								} else {
									session.setAttribute("sqlExcutionStatus", "fail");
									request.getRequestDispatcher("/jsp/admin.jsp").forward(request, response);
								}					
							} catch (SQLException e) {
								// TODO Auto-generated catch block
								session.setAttribute("sqlExcutionStatus", "fail");
								request.getRequestDispatcher("/jsp/admin.jsp").forward(request, response);
								e.printStackTrace();
							}
						} else {
							// session.setAttribute("iddonationround", idDonationRound);
							session.setAttribute("errormessage", dr.getMessage());
							request.getRequestDispatcher("/jsp/admin-form.jsp?iddonationround=" + idDonationRound)
									.forward(request, response);
						}
					} else if (action.equals("create")) {
						// cause sql => must surrounded by try catch
						try {
							if (dr.validate1()) {
								if (databaseOperation.create(title, summary, story, partnerId, startDate, endDate, targetMoney)) {
									session.setAttribute("sqlExcutionStatus", "done");
									request.getRequestDispatcher("/jsp/admin.jsp").forward(request, response);
								} else {
									session.setAttribute("sqlExcutionStatus", "fail");
									request.getRequestDispatcher("/jsp/admin.jsp").forward(request, response);
								}
							} else {
								session.setAttribute("errormessage", dr.getMessage());
								request.getRequestDispatcher("/jsp/admin-form.jsp").forward(request, response);
							}
						} catch (SQLException e) {
							// TODO Auto-generated catch block
							session.setAttribute("sqlExcutionStatus", "fail");
							request.getRequestDispatcher("/jsp/admin.jsp").forward(request, response);
							e.printStackTrace();
						}
					}
				}
			} // end of 'if (loginAcc.getRole().equals("Admin")) {'
		}	
		
		loginAcc = null;
		
	
	}
		

}
