package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.AccountDAO;
import dao.ListOfDonationRoundDAO;
import model.DonationRound;
import model.User;

/**
 * Servlet implementation class Controller
 */
public class Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Controller() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html;charset=UTF-8");
		HttpSession session = request.getSession();
		
		String action = request.getParameter("action");
		String page = request.getParameter("page");
		String donationRoundID = request.getParameter("iddonationround"); // lấy ID của một đợt quyên góp
		 
		User loginAcc =  (User) session.getAttribute("loginAccount"); // for check the role
//		// for login
//		if (session.getAttribute("loginAccount") != null ) {			
//			session.setAttribute("loginAccount", session.getAttribute("loginAccount")); // for login if already login
//		}
		
		// sites for all: guest/User/Admin
		// about donation round (directed to admin.jsp) : not to need to get session attribute below, cause List<User> list is at jsp, not servlet
		if (action == null) {	
			session.setAttribute("sqlExcutionStatus", "");
			
			if (page == null) {
				request.getRequestDispatcher("/jsp/index.jsp?page=1").forward(request, response); // home page ; need param 'page', cause: if page == null => error 'can  not parse null string' => cause Pagnigation need a value of 'page'
			} else {
				request.getRequestDispatcher("/jsp/index.jsp?page=" + page).forward(request, response); // home page ; need param 'page', cause: if page == null => error 'can  not parse null string' => cause Pagnigation need a value of 'page'
			}
		} else if (action.equals("one")) {
			session.setAttribute("sqlExcutionStatus", "");
			String iD = request.getParameter("id");
//			session.setAttribute("id",iD);
			request.getRequestDispatcher("/jsp/one.jsp?id=" + iD).forward(request, response);
		} else if (action.equals("register")) {
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
			request.getRequestDispatcher("/jsp/user-register.jsp").forward(request, response); // page of register form (for user)
		} else if (action.equals("login" )) {
			session.setAttribute("errormessage", "");
//			
			session.setAttribute("saccount", "");
//			session.setAttribute("semail", "");
//			session.setAttribute("sname", "");
//			session.setAttribute("slastname", "");
//			session.setAttribute("sgender", "");
//			session.setAttribute("sphone", "");
//			session.setAttribute("spaypal", "");
//			session.setAttribute("srole", "");
//			session.setAttribute("sbirth", "");
//			
			session.setAttribute("spass", "");
			session.setAttribute("sqlExcutionStatus", "");//????
			request.getRequestDispatcher("/jsp/user-login.jsp").forward(request, response); // page of login form (for user)
		} else if (action.equals("forgotpass" )) {
			session.setAttribute("errormessage", "");
			
			session.setAttribute("saccount", "");
			session.setAttribute("semail", "");
			
			session.setAttribute("sqlExcutionStatus", "");
			request.getRequestDispatcher("/jsp/user-forgot-pass.jsp").forward(request, response); // page of forgot pass form
		} else if (action.equals("donate")) { // donate with paypal
			session.setAttribute("sqlExcutionStatus", "");
			request.getRequestDispatcher("/jsp/paypal-checkout.jsp").forward(request, response);
		} else if (action.equals("search") ) {
			session.setAttribute("sqlExcutionStatus", "");			
			if (page == null) {
				request.getRequestDispatcher("/jsp/nobody-index-search.jsp?page=1").forward(request, response); // home page ; need param 'page', cause: if page == null => error 'can  not parse null string' => cause Pagnigation need a value of 'page'
			} else {
				request.getRequestDispatcher("/jsp/nobody-index-search.jsp?page=" + page).forward(request, response); // home page ; need param 'page', cause: if page == null => error 'can  not parse null string' => cause Pagnigation need a value of 'page'
			}
		// user is not guest (user is User or Admin)	
		} else if (loginAcc != null) { 
			// sites for admin
			if (loginAcc.getRole().equals("Admin")) {
				if (action.equals("admindonation") ) {
					session.setAttribute("sqlExcutionStatus", "");
					request.getRequestDispatcher("/jsp/admin.jsp").forward(request, response); // donation manager page (for admin)
				} else if (action.equals("adminuser") ) { 
					// session.invalidate(); // not this at here
					List<User> list = AccountDAO.getAllRecords4AdminUserJsp();
					session.setAttribute("slist", list);
					int length = list.size();
					session.setAttribute("ssize", length);
					session.setAttribute("saction", ""); // delete this Attribute setup at QueryAtAdminUser with action Param value is "search"
					// session.invalidate(); // not this at here, cause value of slist, ssize, saction will be deleted
					session.setAttribute("sqlExcutionStatus", "");
					request.getRequestDispatcher("/jsp/admin-user.jsp").forward(request, response); // user manager page (for admin)
				} else if (action.equals("donnortableforadmin")) { // liệt kê các đợt QG có ít nhất 1 lượt QG đã được xác nhận
					request.getRequestDispatcher("/jsp/admin-donnor.jsp").forward(request, response);
				} else if (action.equals("donnortabledetailforadmin")) { // liệt kê các nhà hảo tâm (theo lượt QG) (detail)
					session.setAttribute("sqlExcutionStatus", "");
					request.getRequestDispatcher("/jsp/admin-donor-detail.jsp").forward(request, response);
				} else if (action.equals("donorpending")) { // liệt kê các đợt QG có lượt QG đang chờ xác nhận
					session.setAttribute("sqlExcutionStatus", "");
					request.getRequestDispatcher("/jsp/nobody-admin-donor-pending.jsp").forward(request, response);
				} else if (action.equals("donornonedonor")) { // liệt kê các đợt QG chưa nhận được lượt QG nào kể cả lượt đang chờ xác nhận
					session.setAttribute("sqlExcutionStatus", "");
					request.getRequestDispatcher("/jsp/nobody-admin-donor-none-donor.jsp").forward(request, response);
				} else if (action.equals("donnortableforadminfull")) { // liệt kê tất cả các đợt QG, ngoại trừ chưa triển khai và đã triển khai nhưng chưa nhận được bất cứ lượt quyên góp nào kể cả lượt đang chờ hay đã bị hủy
					session.setAttribute("sqlExcutionStatus", "");
					request.getRequestDispatcher("/jsp/nobody-admin-donor-full.jsp").forward(request, response);
				} else if (action.equals("detaildonor") ) {
					session.setAttribute("sqlExcutionStatus", "");
					//String donationRoundID = request.getParameter("iddonationround");
					session.setAttribute("iddonationround", donationRoundID);
					request.getRequestDispatcher("/jsp/detail-admin-donor.jsp").forward(request, response);//
				} else if (action.equals("detaildonorfull")) {
					session.setAttribute("sqlExcutionStatus", "");
					//String donationRoundID = request.getParameter("iddonationround");
					session.setAttribute("iddonationround", donationRoundID);
					request.getRequestDispatcher("/jsp/detail-admin-donor.jsp").forward(request, response);//
				} else if (action.equals("detaildonorpending")) {
					session.setAttribute("sqlExcutionStatus", "");
					session.setAttribute("iddonationround", donationRoundID);
					request.getRequestDispatcher("/jsp/detail-admin-donor.jsp").forward(request, response);//
				} else if (action.equals("detaildonornonedonor") ) {
					session.setAttribute("sqlExcutionStatus", "");
					session.setAttribute("iddonationround", donationRoundID);
					request.getRequestDispatcher("/jsp/detail-admin-donor.jsp").forward(request, response);//
				} else if (action.equals("donorempty")) { // liệt kê các đợt QG chưa nhận được bất cứ lượt QG nào kể cả lượt đang chờ xác nhận
					session.setAttribute("sqlExcutionStatus", "");
					request.getRequestDispatcher("/jsp/nobody-admin-donor-empty.jsp").forward(request, response);
				} 
			}
			
			
			
			// sites for all both User and Admin
			if (loginAcc.getRole().equals("Admin") || loginAcc.getRole().equals("User")) {
				if (action.equals("logout" )) {
					session.invalidate(); // terminate session
					
					if (page == null) {
						request.getRequestDispatcher("/jsp/index.jsp?page=1").forward(request, response); // home page ; need param 'page', cause: if page == null => error 'can  not parse null string' => cause Pagnigation need a value of 'page'
					} else {
						request.getRequestDispatcher("/jsp/index.jsp?page=" + page).forward(request, response); // home page ; need param 'page', cause: if page == null => error 'can  not parse null string' => cause Pagnigation need a value of 'page'
					}			
					
				} else if (action.equals("donnortableforuser")) { // liệt kê hoạt động QG của tài khoản đang đăng nhập
					request.getRequestDispatcher("/jsp/user-donnor.jsp").forward(request, response);
				} 
			}
		} // end of 'if (loginAcc != null) {'
		
		loginAcc = null;
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}
