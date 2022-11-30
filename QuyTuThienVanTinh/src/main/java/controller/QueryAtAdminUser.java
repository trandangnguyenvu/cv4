package controller;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.AccountDAO;
import dao.DatabaseOperationDonationRoundDAO;
import model.DonationRound;
import model.EncodePass;
import model.MailConfig;
import model.RandomString;
import model.SendMailSSL;
import model.User;


/**
 * Servlet implementation class QueryAtAdminUser
 * 
 * Form (info) of an User  (admin type) will come here
 * 
 * admin manage user accounts here
 * 
 * this servlet will execute tasks
 */
public class QueryAtAdminUser extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public QueryAtAdminUser() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("UTF-8"); // WITHOUT THIS => VIETNAMESE VALUE OF ATTRIBUTE OF SESSION THAT JSP GET TO SHOW WILL NOT RIGHT SHOWING
		HttpSession session = request.getSession();
		
		String action = request.getParameter("action");
		String characters = request.getParameter("characters"); // from searching bar
		String accountFromDeleteButton = request.getParameter("account");
		
		// prams from Form :		
		String accountFromForm = request.getParameter("usr");
		
//		String accountFromForm = "";
//		String account = request.getParameter("usr");
//		if (account != null && !account.equals("")) {
//			accountFromForm = account.toLowerCase();
//		} else {
//			accountFromForm = account;
//		}

		String email = request.getParameter("mail");
		String name = request.getParameter("nm");
		String lastName = request.getParameter("lnm");
		String gender = request.getParameter("gender");
		String phone = request.getParameter("phone");
		String paypalId = request.getParameter("paypal");
		String role = request.getParameter("role");
		String birthDate = request.getParameter("birthdate");
		
		String pass = request.getParameter("psw");
		String confirmPass = request.getParameter("cpsw");
		
		
		AccountDAO accountQuery = new AccountDAO();
			
		User acc = new User(name, lastName, email, phone);
		
		session.setAttribute("saccount", accountFromForm);
		session.setAttribute("semail", email);
		session.setAttribute("sname", name);
		session.setAttribute("slastname", lastName);
		session.setAttribute("sgender", gender);
		session.setAttribute("sphone", phone);
		session.setAttribute("spaypal", paypalId);
		session.setAttribute("srole", role);
		session.setAttribute("sbirth", birthDate);
		
		session.setAttribute("spass", pass);
		session.setAttribute("sconfirmPass", confirmPass);
		
		
		User loginAcc =  (User) session.getAttribute("loginAccount"); // for check the role
		
		
		if (loginAcc != null) {
			if (loginAcc.getRole().equals("Admin")) {
				if (action.equals("delete")) {
//					User isAdmin = accountQuery.get1Record(accountFromDeleteButton);
//					if (isAdmin.getRole().equals("Admin")) {
//						session.setAttribute("sqlExcutionStatus", "admin");
//						request.getRequestDispatcher("/jsp/admin-user.jsp").forward(request, response);
//						return;
//					}
					// => the function that no apply to delete an admin account and alert is at jsp
						
					try {
						if (accountQuery.delete(accountFromDeleteButton) ) {
							takeAllRecordsFromDB(request);
							session.setAttribute("sqlExcutionStatus", "done");
							request.getRequestDispatcher("/jsp/admin-user.jsp").forward(request, response);
						} else {
							accountQuery.thenDeleteFailure(accountFromDeleteButton); // status become "không hoạt động"
							session.setAttribute("sqlExcutionStatus", "fail");
							request.getRequestDispatcher("/jsp/admin-user.jsp").forward(request, response);
						}
					} catch (SQLException e) {
						// TODO Auto-generated catch block 
						takeAllRecordsFromDB(request);
						accountQuery.thenDeleteFailure(accountFromDeleteButton);
						session.setAttribute("sqlExcutionStatus", "fail");
						request.getRequestDispatcher("/jsp/admin-user.jsp").forward(request, response);
						e.printStackTrace();
						// cant not link to Controller to get List<User> list + go to admin-user
					}
				} else if (action.equals("search")) {
					List<User> listS = AccountDAO.search(characters);
					int lengthS = listS.size();
					session.setAttribute("slist", listS);
					session.setAttribute("ssize", lengthS);
					session.setAttribute("saction", "search");
					request.getRequestDispatcher("/jsp/admin-user.jsp").forward(request, response); 
				} else if (birthDate == null || birthDate.equals("")) {
					//acc.setMessage("Mục ngày tháng năm sinh không được để trống");
					session.setAttribute("errormessage", "Mục ngày tháng năm sinh không được để trống");
					request.getRequestDispatcher("/jsp/admin-user-form.jsp").forward(request, response);
				} else {
					
					/*
					 * birthDate to java.sql.Date
					 */
					Date birthD = null; //important
					try {
						birthD = new SimpleDateFormat("yyyy-MM-dd").parse(birthDate); // String to Date + follow format
					} catch (ParseException e1) {
						// TODO Auto-generated catch block
						e1.printStackTrace();
						return; //important
					}			
					java.sql.Date birth = new java.sql.Date(birthD.getTime()); // java.util.Date to java.sql.Date for being Compatible to data type at User.java
					
					
					/*
					 * date of now
					 */
					java.util.Date dateNow = new java.util.Date();							
					
					SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd");
					
					String ftDateNow = ft.format(dateNow); // Date to String + to "yyyy/MM/dd" format (for "yyyy/MM/dd" => must be String first )
					
					
					//
					Date dtDateNow = null; //important (without this line => java.sql.Date now can not using dtDateNow
					try {
						dtDateNow = ft.parse(ftDateNow);
					} catch (ParseException e1) {
						// TODO Auto-generated catch block
						e1.printStackTrace();
					} // String to Date
					// ft.parse(ftDateNow) cần throws ParseException or try/catch IF THESE CODES BELONG A METHOD OF USER.JAVA MODEL
					//
					
					
					java.sql.Date now = new java.sql.Date(dtDateNow.getTime());
					
					
					acc.setBirthDay(birth);	
					acc.setAccount(accountFromForm);
					
					/*
					 * body-admin-user-form (edit) jsp will use this servlet with action value is "update" ; body-admin-user-form (create) with "create"
					 */
					if (action.equals("update")) {
						if (!acc.validate2() || !acc.validate3(now)) {
							// session.setAttribute("account", accountFromForm);
							session.setAttribute("errormessage", acc.getMessage());
							request.getRequestDispatcher("/jsp/admin-user-form.jsp?account=" + accountFromForm)
									.forward(request, response);// input account: readonly, not disable: for accountFromForm work
						} else if (acc.validate2() && acc.validate3(now)) {
							// cause sql => must surrounded by try catch
							try {
								// DAO => birth should Date or String?
								if (accountQuery.update(name, lastName, email, role, gender, birthDate, paypalId, phone, accountFromForm)) {
									takeAllRecordsFromDB(request);
									session.setAttribute("sqlExcutionStatus", "done");
									request.getRequestDispatcher("/jsp/admin-user.jsp").forward(request, response);
								} else {
									session.setAttribute("sqlExcutionStatus", "fail");
									request.getRequestDispatcher("/jsp/admin-user.jsp").forward(request, response);
								}
							} catch (SQLException e) {
								// TODO Auto-generated catch block
								takeAllRecordsFromDB(request);
								session.setAttribute("sqlExcutionStatus", "fail");
								request.getRequestDispatcher("/jsp/admin-user.jsp").forward(request, response);
								e.printStackTrace();
							}
						} 
					} // close of 'update' 
					else if (action.equals("create")) {			
						if (!acc.validate5() || !acc.validate2() || !acc.validate3(now)) {
							session.setAttribute("errormessage", acc.getMessage());
							request.getRequestDispatcher("/jsp/admin-user-form.jsp").forward(request, response);
						} else if (acc.validate5() && acc.validate2() && acc.validate3(now)) {
							try {
								if (!accountQuery.exists(accountFromForm)) {
									RandomString rDString = new RandomString();
									String rDPass = rDString.getSaltString();// this is a random password
									EncodePass ep = new EncodePass(); // begin of encrypting password						
									String encodePass = "";
									try {
										encodePass = ep.convertHashToString(rDPass);
									} catch (NoSuchAlgorithmException e) {
										// TODO Auto-generated catch block
										e.printStackTrace();
									}
									
									// query
									if (accountQuery.create(name, lastName, email, role, gender, birthDate, paypalId, phone,
											accountFromForm, encodePass)) {
										takeAllRecordsFromDB(request);
										session.setAttribute("sqlExcutionStatus", "done");
										request.getRequestDispatcher("/jsp/admin-user.jsp").forward(request,
												response);

										// send random pass to user's mail
										// MailConfig.RECEIVE_EMAIL = email;
										SendMailSSL s = new SendMailSSL();
										s.send(rDPass, email, accountFromForm);
									} else {
										session.setAttribute("sqlExcutionStatus", "fail");
										request.getRequestDispatcher("/jsp/admin-user.jsp").forward(request,
												response);
									}				
								} // '(!accountQuery.exists(accountFromForm))'
								else {
									session.setAttribute("errormessage", "Tên Tài khoản này đã được sử dụng, bạn hãy thử một tên khác");
									request.getRequestDispatcher("/jsp/admin-user-form.jsp").forward(request, response);
								}
							} catch (SQLException e) {
								// TODO Auto-generated catch block
								session.setAttribute("sqlExcutionStatus", "fail");
								request.getRequestDispatcher("/jsp/admin-user.jsp").forward(request,
										response);
								e.printStackTrace();
							} 
						} // '(acc.validate4() && acc.validate2() && acc.validate3(now))'
					} // close of 'create'
				} // close of  first if
				
			} // end of 'if (loginAcc.getRole().equals("Admin")) {'
		}
		
		loginAcc = null;
		
	}// close of 'do post'
	
	
	// method of taking all records from DB
	public void takeAllRecordsFromDB(HttpServletRequest request) {
		HttpSession session = request.getSession();
		List<User> list = AccountDAO.getAllRecords4AdminUserJsp();
		session.setAttribute("slist", list);
		int length = list.size();
		session.setAttribute("ssize", length);
		session.setAttribute("saction", "");
	}
	

}
