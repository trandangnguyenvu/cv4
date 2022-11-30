package paypalcontroller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.paypal.api.payments.PayerInfo;
import com.paypal.api.payments.Payment;
import com.paypal.api.payments.ShippingAddress;
import com.paypal.api.payments.Transaction;
import com.paypal.base.rest.PayPalRESTException;

import model.PaypalUser;
import paypalmodel.PaymentServices;

/**
 * Servlet implementation class ReviewPaymentServlet
 */
public class ReviewPaymentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReviewPaymentServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		
		// for login (for header jsp)
		if (session.getAttribute("loginAccount") != null) {
			session.setAttribute("loginAccount", session.getAttribute("loginAccount")); // for login if already login
		}
		
		session.setAttribute("paypalUser", session.getAttribute("paypalUser"));		
		
		String paymentId = request.getParameter("paymentId");
        String payerId = request.getParameter("PayerID");
         
        try {
            PaymentServices paymentServices = new PaymentServices();
            Payment payment = paymentServices.getPaymentDetails(paymentId);
             
            PayerInfo payerInfo = payment.getPayer().getPayerInfo();
            Transaction transaction = payment.getTransactions().get(0);
            ShippingAddress shippingAddress = transaction.getItemList().getShippingAddress();
             
            request.setAttribute("payer", payerInfo);
            request.setAttribute("transaction", transaction);
            request.setAttribute("shippingAddress", shippingAddress);
             
            //String url = "review.jsp?paymentId=" + paymentId + "&PayerID=" + payerId;
            //////////////////////////////////////////////???????????? =>
            String url = "/jsp/paypal-review.jsp?paymentId=" + paymentId + "&PayerID=" + payerId;
            
            request.getRequestDispatcher(url).forward(request, response);
            
            PaypalUser paypalUser = (PaypalUser) session.getAttribute("paypalUser"); // TEST
            //System.out.print("ACC AT ReviewPaymentServlet OF SESSION FROM DB OF QuyTuThienVanTinh IS: " + paypalUser.getAcc().getAccount() ); // TEST: just test as paypalUser.getAcc() not null 
            System.out.println("ReviewPaymentServlet: DR name from transaction: " + transaction.getDescription());
            System.out.println("ReviewPaymentServlet: DR name from payment: " + payment.getTransactions().get(0));
            System.out.println("DR name from paymentId: " + paymentId);
            
        } catch (PayPalRESTException ex) {
            request.setAttribute("paypalErrorMessage", ex.getMessage());
            ex.printStackTrace();
            request.getRequestDispatcher("paypal-error.jsp").forward(request, response);
        }      
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
