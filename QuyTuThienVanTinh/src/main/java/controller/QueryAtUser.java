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

import org.graalvm.compiler.lir.LIRInstruction.Use;

import dao.AccountDAO;
import model.EncodePass;
import model.RandomString;
import model.SendMailSSL;
import model.User;

/**
 * Servlet implementation class QueryAtUser
 * 
 * Form (info) of an User  (User type) will come here
 * 
 */
public class QueryAtUser extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public QueryAtUser() {
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
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("UTF-8"); // WITHOUT THIS => VIETNAMESE VALUE OF ATTRIBUTE OF SESSION THAT JSP GET TO SHOW WILL NOT RIGHT SHOWING
		HttpSession session = request.getSession();
		
		String action = request.getParameter("action");
		String characters = request.getParameter("characters"); // from searching bar ????????
		String accountFromURL = request.getParameter("account"); 
		String afteraction = request.getParameter("afteraction");
		String page = request.getParameter("page"); // for pagination of index jsp
		
		// prams from Form : 	
		String accountFromForm = request.getParameter("usr");
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
		
		// for change password
		String olderPass = request.getParameter("opsw");
		String newPass = request.getParameter("npsw");
		String confirmNewPass = request.getParameter("ncpsw");
		
		
		
		
		
		AccountDAO accountQuery = new AccountDAO();
			
		//User acc = new User(accountFromForm, pass, confirmPass,name, lastName, email, phone);	
		//User acc = new User(accountFromForm, pass, confirmPass);	
		User acc = new User(name, lastName, email, phone); // for validate this Argument 
		
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
		
		// for change password
		session.setAttribute("sOlderPass", olderPass);
		session.setAttribute("sNewPass", newPass);
		session.setAttribute("sConfirmNewPass", confirmNewPass);
		
		
		User loginAcc =  (User) session.getAttribute("loginAccount"); // for check the role

		User userOrAdmin = new User(); // for login if not yet login
		
		
		// login
		if (action.equals("login")) {
			User acc1 = new User(accountFromForm, pass);			
			if (acc1.validate8()) { // not need to complex validate at 'login'
				EncodePass ep = new EncodePass(); // begin of encrypting password
				String encodePass = "";
				try {
					encodePass = ep.convertHashToString(pass);												
				} catch (NoSuchAlgorithmException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				// pass comparing + acc comparing
				try {
					if (accountQuery.login(accountFromForm, encodePass)) {
											
						userOrAdmin = accountQuery.get1Record(accountFromForm); // for log in
						session.setAttribute("loginAccount", userOrAdmin); // for log in
						// (direction 1 after login success) => going to the home page after login success			
						// afteraction == null => do not (!afteraction.equals("useredit")), will be error, cause String is null -> can not invoke equals()
						if (afteraction == null) {
							session.setAttribute("sqlExcutionStatus", "");				
							
							if (page == null) {
								request.getRequestDispatcher("/jsp/index.jsp?page=1").forward(request, response); // home page ; need param 'page', cause: if page == null => error 'can  not parse null string' => cause Pagnigation need a value of 'page'
							} else {
								request.getRequestDispatcher("/jsp/index.jsp?page=" + page).forward(request, response); // home page ; need param 'page', cause: if page == null => error 'can  not parse null string' => cause Pagnigation need a value of 'page'
							}
							
						// (direction 2 after login success) => login to the form of editing info of an user: going to the login form firt, but then, going to the form to edit info of an user
						} else if (loginAcc != null) {
							if (loginAcc.getRole().equals("Admin") || loginAcc.getRole().equals("User")) {
								if (afteraction.equals("useredit")) {
									session.setAttribute("errormessage", "");							
									request.getRequestDispatcher("/jsp/user-edit.jsp?account=" + accountFromForm).forward(request, response);
								// this is close of direction 2 (after login) ; direction 3 below: going to change password form
								} else if (afteraction.equals("aftchangepass")) {
									session.setAttribute("errormessage", "");
									session.setAttribute("solderPass", "");
									session.setAttribute("sNewPass", "");
									session.setAttribute("sconfirmNewPass", "");
									request.getRequestDispatcher("/jsp/user-change-pass.jsp?account=" + accountFromForm).forward(request, response);
								}
							}
						}
						
					} else {
						//session.setAttribute("encode", encodePass); // just for testing
						session.setAttribute("errormessage", "Tên Tài khoản hoặc Mật khẩu không đúng");
						request.getRequestDispatcher("/jsp/user-login.jsp").forward(request, response);
					}
				} catch (SQLException e) {
					// TODO Auto-generated catch block					
					e.printStackTrace();
				} 
			// this else of 'if (acc1.validate8())'
			} else {
				session.setAttribute("errormessage", acc1.getMessage()); // remember: acc1, not acc
				request.getRequestDispatcher("/jsp/user-login.jsp").forward(request, response);
			}	
		//password change => this can not be inside else of 'else if - (birthDate == null || birthDate.equals(""))', cause it has not input of birth day
		// end of 'login' function
		} else if (action.equals("forgotpass")) {
			User acc1 = new User();
			acc1.setAccount(accountFromForm);
			acc1.setEmail(email);
			if (acc1.validate9()) {
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
				
				// recording new encrypting random password to database
				try {	
					if (accountQuery.updatePass(accountFromForm, encodePass)) {
						// send random pass to user's mail
						// MailConfig.RECEIVE_EMAIL = email;
						SendMailSSL s = new SendMailSSL();
						s.send(rDPass, email, accountFromForm);
						session.setAttribute("sqlExcutionStatus", "done");
						
						if (page == null) {
							request.getRequestDispatcher("/jsp/index.jsp?page=1").forward(request, response); // home page ; need param 'page', cause: if page == null => error 'can  not parse null string' => cause Pagnigation need a value of 'page'
						} else {
							request.getRequestDispatcher("/jsp/index.jsp?page=" + page).forward(request, response); // home page ; need param 'page', cause: if page == null => error 'can  not parse null string' => cause Pagnigation need a value of 'page'
						}
						
					} else 	{
						session.setAttribute("sqlExcutionStatus", "fail");
						
						if (page == null) {
							request.getRequestDispatcher("/jsp/index.jsp?page=1").forward(request, response); // home page ; need param 'page', cause: if page == null => error 'can  not parse null string' => cause Pagnigation need a value of 'page'
						} else {
							request.getRequestDispatcher("/jsp/index.jsp?page=" + page).forward(request, response); // home page ; need param 'page', cause: if page == null => error 'can  not parse null string' => cause Pagnigation need a value of 'page'
						}
						
					}
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					session.setAttribute("sqlExcutionStatus", "fail");
					
					if (page == null) {
						request.getRequestDispatcher("/jsp/index.jsp?page=1").forward(request, response); // home page ; need param 'page', cause: if page == null => error 'can  not parse null string' => cause Pagnigation need a value of 'page'
					} else {
						request.getRequestDispatcher("/jsp/index.jsp?page=" + page).forward(request, response); // home page ; need param 'page', cause: if page == null => error 'can  not parse null string' => cause Pagnigation need a value of 'page'
					}

					e.printStackTrace();
				}				
			} else {
				session.setAttribute("errormessage", acc1.getMessage()); // remember: acc1, not acc						
				request.getRequestDispatcher("/jsp/user-forgot-pass.jsp").forward(request, response);
			}			
		// close of 'forgotpass'		
		} else if (loginAcc != null) { // < [ for Admin or User ] >
			if (loginAcc.getRole().equals("Admin") || loginAcc.getRole().equals("User")) {
				if (action.equals("changepass")) {
					User acc1 = new User();	
					acc1.setPass(olderPass);
					
					if (acc1.validate8()) { // not need to complex validate at 'login'
						EncodePass ep = new EncodePass(); // begin of encrypting password
						String encodePass = "";
						try {
							encodePass = ep.convertHashToString(olderPass);												
						} catch (NoSuchAlgorithmException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}				
					
						
						// pass comparing + acc comparing					
						try {
							if (accountQuery.login(accountFromURL, encodePass)) {
								acc1.setPass(newPass);
								acc1.setConfirm(confirmNewPass);	
								userOrAdmin = accountQuery.get1Record(accountFromForm);
								session.setAttribute("loginAccount", userOrAdmin); // for log in
								if (acc1.validate7()) {								
									String encodePassChange = ""; // begin of encrypting password
									try {
										encodePassChange = ep.convertHashToString(newPass);												
									} catch (NoSuchAlgorithmException e) {
										// TODO Auto-generated catch block
										e.printStackTrace();
									}
									// SQL excute	
									if (accountQuery.changePass(encodePassChange, accountFromURL)) {
										session.setAttribute("sqlExcutionStatus", "done");
										
										if (page == null) {
											request.getRequestDispatcher("/jsp/index.jsp?page=1").forward(request, response); // home page ; need param 'page', cause: if page == null => error 'can  not parse null string' => cause Pagnigation need a value of 'page'
										} else {
											request.getRequestDispatcher("/jsp/index.jsp?page=" + page).forward(request, response); // home page ; need param 'page', cause: if page == null => error 'can  not parse null string' => cause Pagnigation need a value of 'page'
										}
										
									} else {
										session.setAttribute("sqlExcutionStatus", "fail");	
										
										if (page == null) {
											request.getRequestDispatcher("/jsp/index.jsp?page=1").forward(request, response); // home page ; need param 'page', cause: if page == null => error 'can  not parse null string' => cause Pagnigation need a value of 'page'
										} else {
											request.getRequestDispatcher("/jsp/index.jsp?page=" + page).forward(request, response); // home page ; need param 'page', cause: if page == null => error 'can  not parse null string' => cause Pagnigation need a value of 'page'
										}
										
									}
								} else {
									session.setAttribute("errormessage", acc1.getMessage()); // remember: acc1, not acc								
									request.getRequestDispatcher("/jsp/user-change-pass.jsp?account=" + accountFromURL).forward(request, response);
								}
							} else {
								session.setAttribute("errormessage", "Mật khẩu cũ không đúng");
								request.getRequestDispatcher("/jsp/user-change-pass.jsp?account=" + accountFromURL).forward(request, response);
							}
						} catch (SQLException e) {
							// TODO Auto-generated catch block	
							
							if (page == null) {
								request.getRequestDispatcher("/jsp/index.jsp?page=1").forward(request, response); // home page ; need param 'page', cause: if page == null => error 'can  not parse null string' => cause Pagnigation need a value of 'page'
							} else {
								request.getRequestDispatcher("/jsp/index.jsp?page=" + page).forward(request, response); // home page ; need param 'page', cause: if page == null => error 'can  not parse null string' => cause Pagnigation need a value of 'page'
							}
							
							e.printStackTrace();
						}
					// this else of 'if (acc1.validate8())'
					} else {
							session.setAttribute("errormessage", acc1.getMessage()); // remember: acc1, not acc						
							request.getRequestDispatcher("/jsp/user-change-pass.jsp?account=" + accountFromURL).forward(request, response);
					}			 		
				// close of 'changepass'
				// this 'else if' split this mother block to 2 part: one there is no param birth (no input of birth) and the rest there is an param birth
				} else if (birthDate == null || birthDate.equals("")) {
					//acc.setMessage("Mục ngày tháng năm sinh không được để trống");
					session.setAttribute("errormessage", "Mục ngày tháng năm sinh không được để trống");
					request.getRequestDispatcher("/jsp/user-register.jsp").forward(request, response);
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
					
					
					java.sql.Date now = new java.sql.Date(dtDateNow.getTime());
					
					
					acc.setBirthDay(birth);			
					
					
					/*
					 * body-admin-user-form (edit) jsp will use this servlet with action value is
					 * "update" 
					 */	
					if (action.equals("update")) {
						if (!acc.validate2() || !acc.validate3(now)) {
							// session.setAttribute("account", accountFromForm);					
							session.setAttribute("errormessage", acc.getMessage());
							request.getRequestDispatcher("/jsp/user-edit.jsp?account=" + accountFromURL).forward(request, response); // accountFromForm????
							// must accountFromURL, do not accountFromForm, cause input was disable, for accountFromURL => input must readonly
						} else if (acc.validate2() && acc.validate3(now)) {
							// cause sql => must surrounded by try catch					
							try {
								// DAO => birth should be Date or String? 
								if (accountQuery.userUpdate(name, lastName, email, gender, birthDate, paypalId, phone, accountFromURL)) {
									session.setAttribute("sqlExcutionStatus", "done");
									
									if (page == null) {
										request.getRequestDispatcher("/jsp/index.jsp?page=1").forward(request, response); // home page ; need param 'page', cause: if page == null => error 'can  not parse null string' => cause Pagnigation need a value of 'page'
									} else {
										request.getRequestDispatcher("/jsp/index.jsp?page=" + page).forward(request, response); // home page ; need param 'page', cause: if page == null => error 'can  not parse null string' => cause Pagnigation need a value of 'page'
									}
									
								} else {
									session.setAttribute("sqlExcutionStatus", "fail");
									
									if (page == null) {
										request.getRequestDispatcher("/jsp/index.jsp?page=1").forward(request, response); // home page ; need param 'page', cause: if page == null => error 'can  not parse null string' => cause Pagnigation need a value of 'page'
									} else {
										request.getRequestDispatcher("/jsp/index.jsp?page=" + page).forward(request, response); // home page ; need param 'page', cause: if page == null => error 'can  not parse null string' => cause Pagnigation need a value of 'page'
									}
									
								}	
							} catch (SQLException e) {
								// TODO Auto-generated catch block	
								session.setAttribute("sqlExcutionStatus", "fail");
								
								if (page == null) {
									request.getRequestDispatcher("/jsp/index.jsp?page=1").forward(request, response); // home page ; need param 'page', cause: if page == null => error 'can  not parse null string' => cause Pagnigation need a value of 'page'
								} else {
									request.getRequestDispatcher("/jsp/index.jsp?page=" + page).forward(request, response); // home page ; need param 'page', cause: if page == null => error 'can  not parse null string' => cause Pagnigation need a value of 'page'
								}
								
								e.printStackTrace();
							}					
						} // close of 'else if - (acc.validate3(now) && acc.validate2())'
					} // end of 'update'
					
				}// close of else of 'else if - (birthDate == null || birthDate.equals(""))'
				
				
			} // end 'if (loginAcc.getRole().equals("Admin") || loginAcc.getRole().equals("User")) {'
		// end 'if (loginAcc != null) {'
		// this 'else if' split this mother block to 2 part: one there is no param birth (no input of birth) and the rest there is an param birth
		} else if (birthDate == null || birthDate.equals("")) {
			//acc.setMessage("Mục ngày tháng năm sinh không được để trống");
			session.setAttribute("errormessage", "Mục ngày tháng năm sinh không được để trống");
			request.getRequestDispatcher("/jsp/user-register.jsp").forward(request, response);
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
			
			
			java.sql.Date now = new java.sql.Date(dtDateNow.getTime());
			
			
			acc.setBirthDay(birth);			
			
			
			/*
			 * body-admin-user-form (create) jsp will use this servlet with action value is
			 * "create"
			 */	
			if (action.equals("create")) {
				acc.setAccount(accountFromForm);
				acc.setPass(pass);
				acc.setConfirm(confirmPass);
				if (!acc.validate5() || !acc.validate2() || !acc.validate3(now)) {
					session.setAttribute("errormessage", acc.getMessage());
					request.getRequestDispatcher("/jsp/user-register.jsp").forward(request, response);
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
							if (accountQuery.userCreate(name, lastName, email, gender, birthDate, paypalId, phone,
									accountFromForm, encodePass)) {
								
								session.setAttribute("sqlExcutionStatus", "done");
								
								if (page == null) {
									request.getRequestDispatcher("/jsp/index.jsp?page=1").forward(request, response); // home page ; need param 'page', cause: if page == null => error 'can  not parse null string' => cause Pagnigation need a value of 'page'
								} else {
									request.getRequestDispatcher("/jsp/index.jsp?page=" + page).forward(request, response); // home page ; need param 'page', cause: if page == null => error 'can  not parse null string' => cause Pagnigation need a value of 'page'
								}

								// send random pass to user's mail
								// MailConfig.RECEIVE_EMAIL = email;
								SendMailSSL s = new SendMailSSL();
								s.send(rDPass, email, accountFromForm);
							} else {
								session.setAttribute("sqlExcutionStatus", "fail");
								
								if (page == null) {
									request.getRequestDispatcher("/jsp/index.jsp?page=1").forward(request, response); // home page ; need param 'page', cause: if page == null => error 'can  not parse null string' => cause Pagnigation need a value of 'page'
								} else {
									request.getRequestDispatcher("/jsp/index.jsp?page=" + page).forward(request, response); // home page ; need param 'page', cause: if page == null => error 'can  not parse null string' => cause Pagnigation need a value of 'page'
								}
								
							}				
						} // '(!accountQuery.exists(accountFromForm))'
						else {
							session.setAttribute("errormessage", "Tên Tài khoản này đã được sử dụng, bạn hãy thử một tên khác");
							request.getRequestDispatcher("/jsp/user-register.jsp").forward(request, response);
						}
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						session.setAttribute("sqlExcutionStatus", "fail");
						
						if (page == null) {
							request.getRequestDispatcher("/jsp/index.jsp?page=1").forward(request, response); // home page ; need param 'page', cause: if page == null => error 'can  not parse null string' => cause Pagnigation need a value of 'page'
						} else {
							request.getRequestDispatcher("/jsp/index.jsp?page=" + page).forward(request, response); // home page ; need param 'page', cause: if page == null => error 'can  not parse null string' => cause Pagnigation need a value of 'page'
						}
						
						e.printStackTrace();
					} 
											
				} // close of else of 'else if - (!acc.validate3(now) && !acc.validate2() && !acc.validate4())'				
			
			}// close of 'create' ???? ; 
		// close of else of 'else if - (birthDate == null || birthDate.equals(""))'	
		} 
				
		loginAcc = null;
		
		
	} // doPost

	

}
