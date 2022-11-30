package paypalcontroller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.paypal.api.payments.PayerInfo;
import com.paypal.api.payments.Payment;
import com.paypal.api.payments.Transaction;
import com.paypal.base.rest.PayPalRESTException;

import dao.DatabaseOperationDonationRoundDAO;
import model.PaypalUser;
import paypalmodel.PaymentServices;

/**
 * Servlet implementation class ExecutePaymentServlet
 */
public class ExecutePaymentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ExecutePaymentServlet() {
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
//		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		
		// for login (for header jsp)
		if (session.getAttribute("loginAccount") != null) {
			session.setAttribute("loginAccount", session.getAttribute("loginAccount")); // for login if already login
		}
		
		PaypalUser paypalUser = (PaypalUser) session.getAttribute("paypalUser");
		
		String paymentId = request.getParameter("paymentId");
        String payerId = request.getParameter("PayerID");
 
        try {
            PaymentServices paymentServices = new PaymentServices();
            Payment payment = paymentServices.executePayment(paymentId, payerId);
             
            PayerInfo payerInfo = payment.getPayer().getPayerInfo();
            Transaction transaction = payment.getTransactions().get(0);
             
            request.setAttribute("payer", payerInfo);
            request.setAttribute("transaction", transaction);  
            
            System.out.println("money from paypal: " + transaction.getAmount().getTotal());
            System.out.println("float money from paypal: " + Float.parseFloat(transaction.getAmount().getTotal()));
            System.out.println("money: " + paypalUser.getMoney());
            System.out.println("donation name from paypal: " + transaction.getDescription());
            System.out.println("donation name: " + paypalUser.getdNm());
            if (Float.parseFloat(transaction.getAmount().getTotal()) == paypalUser.getMoney()  ) {//&& transaction.getDescription().equals(paypalUser.getdNm())
            	DatabaseOperationDonationRoundDAO insertQuery = new DatabaseOperationDonationRoundDAO(); 
            	//String acc = "anonymous";
            	String acc = "";
//            	//session.setAttribute("kq", "ok"); // TEST 
//            	//session.setAttribute("dr", paypalUser.getdID()); // TEST 
            	if (paypalUser.getAcc() == null) {
            		acc = "anonymous";
//            		session.setAttribute("usr", paypalUser.getAcc().getAccount()); // TEST 
            	} else {
            		acc = paypalUser.getAcc().getAccount();
//            		//session.setAttribute("usr", "anonymous"); // TEST
            	} 
            	
            	try {
					insertQuery.AnDonationDone(acc, paypalUser.getdID(), paypalUser.getMoney());
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					request.setAttribute("paypalErrorMessage", "Số tiền quyên góp đã được chuyển khoản thành công nhưng dữ liệu chưa được lưu vào cơ sở dữ liệu của chúng tôi do sự cố không mong muốn");		            
		            request.getRequestDispatcher("/jsp/paypal-error.jsp").forward(request, response);
					e.printStackTrace();
				}
            } else {
            	request.setAttribute("paypalErrorMessage", "Số tiền quyên góp chuyển khoản không thành công");		            
	            request.getRequestDispatcher("/jsp/paypal-error.jsp").forward(request, response);
//            	//session.setAttribute("kq", "not ok"); // TEST 
            }
// 
            //request.getRequestDispatcher("receipt.jsp").forward(request, response);
            request.getRequestDispatcher("/jsp/paypal-receipt-details.jsp").forward(request, response);
            //////////////////////////////////////////////???? 
            //System.out.print("ACC AT ExecutePaymentServlet OF SESSION FROM DB OF QuyTuThienVanTinh IS: " + paypalUser.getAcc().getAccount() ); // TEST: just test as paypalUser.getAcc() not null
        } catch (PayPalRESTException ex) {
            request.setAttribute("paypalErrorMessage", ex.getMessage());
            ex.printStackTrace();
            request.getRequestDispatcher("/jsp/paypal-error.jsp").forward(request, response);
        }
	}

}
