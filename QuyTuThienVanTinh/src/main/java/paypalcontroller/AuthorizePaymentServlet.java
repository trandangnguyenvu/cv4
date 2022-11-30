package paypalcontroller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import paypalmodel.OrderDetail;
import paypalmodel.PaymentServices;

import com.paypal.base.rest.PayPalRESTException;

import model.PaypalUser;
import model.User;

/**
 * AuthorizePaymentServlet class - requests PayPal for payment
 * 
 * Servlet implementation class AuthorizePaymentServlet
 */
public class AuthorizePaymentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AuthorizePaymentServlet() {
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
		HttpSession session = request.getSession();
		request.setCharacterEncoding("UTF-8");
		
		// for login (for header jsp)
		if (session.getAttribute("loginAccount") != null) {
			session.setAttribute("loginAccount", session.getAttribute("loginAccount")); // for login if already login
		}
		
		String donationRoundName = request.getParameter("donationName");
        String total = request.getParameter("money");
        String subtotal = request.getParameter("subtotal");
        String shipping = request.getParameter("shipping");
        String tax = request.getParameter("tax");
        String donationRoundId = request.getParameter("donationId");
        

        PaypalUser paypalUser = new PaypalUser(donationRoundId, donationRoundName, total);
//        if (session.getAttribute("loginAccount") != null ) {
//        	
//        } 
        paypalUser.setAcc((User) session.getAttribute("loginAccount"));
//        else {
//        	User user = new User();
//        	user.setAccount("anonymous");
//        	paypalUser.setAcc(user);
//        }
        
        session.setAttribute("paypalUser", paypalUser);
        
        
        OrderDetail orderDetail = new OrderDetail(donationRoundName, subtotal, shipping, tax, total);
        System.out.println("donation name from OrderDetail model: " + orderDetail.getDonationRoundName());
        
        try {
            PaymentServices paymentServices = new PaymentServices();
            String approvalLink = paymentServices.authorizePayment(orderDetail);
 
            response.sendRedirect(approvalLink);
            
            //System.out.print("ACC AT AuthorizePaymentServlet OF VARIABLE FROM DB OF QuyTuThienVanTinh IS: " + paypalUser.getAcc().getAccount()); // TEST: just test as paypalUser.getAcc() not null 
            
        } catch (PayPalRESTException ex) {
            request.setAttribute("paypalErrorMessage", ex.getMessage());
            ex.printStackTrace();
            request.getRequestDispatcher("paypal-error.jsp").forward(request, response);
        }
	}

}
