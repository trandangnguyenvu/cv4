package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.User;

/**
 * Servlet implementation class AdminForm
 * 
 * Form not come here, it just direct to the Form that an admin will type at
 * 
 * this servlet do not execute tasks, it just direct to sreen of FORM
 * 
 * CONTROLLER for admin jsp: it would navigated to  admin-form jsp as user click edit / create
 * 
 * controller of JSPs: admin, admin-user (this servlet get param from this JSPs
 *  
 */
public class AdminForm extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminForm() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//AdminForm?action=editofadminform ; createofadminform
		response.setContentType("text/html;charset=UTF-8");
		HttpSession session = request.getSession();
		
		String action = request.getParameter("action");
		//String idDonationRound = request.getParameter("iddonationround");
		
		User loginAcc =  (User) session.getAttribute("loginAccount"); // for check the role
		
		
		if (loginAcc != null) {
			if (loginAcc.getRole().equals("Admin")) {
				if (action.equals("editofadminform") || action.equals("createofadminform")) {
					
					session.setAttribute("errormessage", "");
					
					session.setAttribute("stitle", "");
					session.setAttribute("ssummary", "");
					session.setAttribute("sstory", "");
					session.setAttribute("sstart", "");
					session.setAttribute("send", "");
					session.setAttribute("spartnerId", "");
					session.setAttribute("stargetmoney", "");
					
					session.setAttribute("sqlExcutionStatus", "");
					request.getRequestDispatcher("/jsp/admin-form.jsp").forward(request, response);
					
				} else if (action.equals("editofadminuserform") || action.equals("createofadminuserform")) {
					
					session.setAttribute("errormessage", "");
					
					session.setAttribute("saccount", "");
					session.setAttribute("semail", "");
					session.setAttribute("sname", "");
					session.setAttribute("slastname", "");
					session.setAttribute("sgender", "");
					session.setAttribute("sphone", "");
					session.setAttribute("spaypal", "");
					session.setAttribute("srole", "");
					session.setAttribute("sbirth", "");
					
					session.setAttribute("spass", "");
					session.setAttribute("sconfirmPass", "");
					
					session.setAttribute("sqlExcutionStatus", "");
					request.getRequestDispatcher("/jsp/admin-user-form.jsp").forward(request, response);
				}
			} // end of 'if (loginAcc.getRole().equals("Admin")) {'
		}
		
		loginAcc = null;
			
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
