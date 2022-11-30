package controller;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.AccountDAO;
import dao.DonorDetailDAO;
import dao.ListOfDonationRoundDAO;
import model.DonationRound;
import model.DonorDetail;
import model.SendMailSSL;
import model.User;

/**
 * Servlet implementation class QueryAtAdminDonor
 * Action (query) from admin about a one time of donor (lượt QG) (at donor detail table) 
 */
public class QueryAtAdminDonor extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public QueryAtAdminDonor() {
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
		response.setContentType("text/html;charset=UTF-8");
		HttpSession session = request.getSession();
		
		String action = request.getParameter("action");
		String donorID = request.getParameter("donorid");
		
		
		User loginAcc =  (User) session.getAttribute("loginAccount"); // for check the role
		
		
		if (loginAcc != null) {
			if (loginAcc.getRole().equals("Admin")) {
				DonorDetailDAO query4Donor = new DonorDetailDAO();
				
				if (action.equals("confirm") ) {
					try {
						if(query4Donor.confirm(donorID)) {
							// preparing for mail sending
							String acc = "";					
							String donationID = "";
							String donationTitle = "";
							float money = 0;
							// Date date = null;
							
							// Donor_detail table
							List<DonorDetail> ddList = DonorDetailDAO.getAllRecords4AdminJsp();	
							
							for (DonorDetail  d:ddList) {
								if (donorID.equals(d.getiD())) {
									acc = d.getAcc();
									donationID = d.getdID();
									money = d.getMoney();
									//date = d.getDate();
								}
							}
							
							
							// mail sending if account is not 'anonymous'
							if (!acc.equals("anonymous")) {
								// Donation_Round table
								List<DonationRound> list = ListOfDonationRoundDAO.getAllRecords4AdminJsp();				
								
								for (DonationRound l:list) {
									if (donationID.equals(Integer.toString(l.getId()))) {
										donationTitle = l.getTitle();
										
									}
								}
								
								// Account table
								AccountDAO accountDao = new AccountDAO();
								User accFromAccountTable = accountDao.get1Record(acc);
								
								String message = "Chúng tôi trân trọng cảm ơn tài khoản " + acc + " ("
										+ accFromAccountTable.getLastName() + " " + accFromAccountTable.getName()
										+ ") đã quyên góp cho dự án: " + donationTitle + ". Số tiền: " + money
										+ " USD. Cảm ơn bạn rất nhiều";
								
								// send message to the mail of user (donor)
								// MailConfig.RECEIVE_EMAIL = email;
								SendMailSSL s = new SendMailSSL();
								s.sendThank(message, accFromAccountTable.getEmail());
							}					
							
							//
							session.setAttribute("sqlExcutionStatus", "done");
							request.getRequestDispatcher("/jsp/admin-donor-detail.jsp").forward(request, response);				
						} else {
							session.setAttribute("sqlExcutionStatus", "fail");
							request.getRequestDispatcher("/jsp/admin-donor-detail.jsp").forward(request, response);
						}
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						session.setAttribute("sqlExcutionStatus", "fail");
						request.getRequestDispatcher("/jsp/admin-donor-detail.jsp").forward(request, response);
						e.printStackTrace();
					}
				} else if (action.equals("reject") ) {
					try {
						if(query4Donor.reject(donorID)) {
							session.setAttribute("sqlExcutionStatus", "done");
							request.getRequestDispatcher("/jsp/admin-donor-detail.jsp").forward(request, response);
						} else {
							session.setAttribute("sqlExcutionStatus", "fail");
							request.getRequestDispatcher("/jsp/admin-donor-detail.jsp").forward(request, response);
						}
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						session.setAttribute("sqlExcutionStatus", "fail");
						request.getRequestDispatcher("/jsp/admin-donor-detail.jsp").forward(request, response);
						e.printStackTrace();
					}
				}
			} // end of 'if (loginAcc.getRole().equals("Admin")) {'
		}
		
		loginAcc = null;
		
		
	}// do post

}
