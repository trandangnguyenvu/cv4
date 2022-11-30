/*
 * PaymentServices class - encapsulates PayPal payment integration functions
 * 
 */

package paypalmodel;

import java.util.*;


import com.paypal.api.payments.*;
import com.paypal.base.rest.*;

public class PaymentServices {	
	private static final String CLIENT_ID = "AVhdB_d9eJzyBfYgYeV-UMMmI0r7BYl2bD_dvV9v7iUZNTT7GICfVR8RIzCIltH7PxaLaG7WTHlMR906"; // 'User'
//	private static final String CLIENT_ID = "AaAqQ0WSepE5SE-8qRd0QAHj0MvH-NrvZP1_v0QgL6VjxeGSmGYZlwd3xo7mUsuGBSxvYibRRU-ebglY"; // 'QuyTuThienVanTinh'
    private static final String CLIENT_SECRET = "ECvnR0zcHuugdoyiuIWHYJ-esCNgkRfhjcaKzdZfKaeuktexuRCoLQReEkF1Iygfk4a83zmEj0otMOHx"; // 'User'
//	private static final String CLIENT_SECRET = "ELZlS6Ue3lbbS10Qwi1qi7_oOh1WQdkmryXMojVtBXpo79aok7JvRKbHCkNXn4oKAATrtfP-wAdxLxo6"; // 'QuyTuThienVanTinh'
    private static final String MODE = "sandbox";
 
    public String authorizePayment(OrderDetail orderDetail)        
            throws PayPalRESTException {       
 
        Payer payer = getPayerInformation();
        RedirectUrls redirectUrls = getRedirectURLs();
        List<Transaction> listTransaction = getTransactionInformation(orderDetail);
         
        Payment requestPayment = new Payment();
        requestPayment.setTransactions(listTransaction);
        requestPayment.setRedirectUrls(redirectUrls);
        requestPayment.setPayer(payer);
        requestPayment.setIntent("authorize");
 
        APIContext apiContext = new APIContext(CLIENT_ID, CLIENT_SECRET, MODE);
 
        Payment approvedPayment = requestPayment.create(apiContext);
 
        return getApprovalLink(approvedPayment);
 
    }
     
    
    
    
    private Payer getPayerInformation() {
    	Payer payer = new Payer();
        payer.setPaymentMethod("paypal");
         
        PayerInfo payerInfo = new PayerInfo();
//        payerInfo.setFirstName("Vu")
//                 .setLastName("Tran")
//                 .setEmail("hop.thu.trung.chuyen@gmail.com");
        payerInfo.setFirstName("Vu")
        		 .setLastName("Tran")
        	     .setEmail("thuyettaisinhvovan@gmail.com"); // "sb-9023g21982128@business.example.com"
         
        payer.setPayerInfo(payerInfo);
         
        return payer;
    }
     
    
    
    
    private RedirectUrls getRedirectURLs() {
    	RedirectUrls redirectUrls = new RedirectUrls();
        redirectUrls.setCancelUrl("http://localhost:8080/QuyTuThienVanTinh/Controller");
        redirectUrls.setReturnUrl("http://localhost:8080/QuyTuThienVanTinh/ReviewPaymentServlet"); // or paypal-review.jsp ????
         
        return redirectUrls;
    }
     
    
    
    
    private List<Transaction> getTransactionInformation(OrderDetail orderDetail) {
    	Details details = new Details();
        details.setShipping(orderDetail.getShipping());
        details.setSubtotal(orderDetail.getSubtotal());
        details.setTax(orderDetail.getTax());
     
        Amount amount = new Amount();
        amount.setCurrency("USD");
        amount.setTotal(orderDetail.getTotal());
        amount.setDetails(details);
     
        Transaction transaction = new Transaction();
        transaction.setAmount(amount);
        transaction.setDescription(orderDetail.getDonationRoundName());
         
        ItemList itemList = new ItemList();
        List<Item> items = new ArrayList<>();
         
        Item item = new Item();
        item.setCurrency("USD");
        item.setName(orderDetail.getDonationRoundName());
        item.setPrice(orderDetail.getSubtotal());
        item.setTax(orderDetail.getTax());
        item.setQuantity("1");
         
        items.add(item);
        itemList.setItems(items);
        transaction.setItemList(itemList);
     
        List<Transaction> listTransaction = new ArrayList<>();
        listTransaction.add(transaction);  
         
        System.out.println("d name from PaymentServices model: " + item.getName());
        
        return listTransaction;
    }
     
        
    
    
    private String getApprovalLink(Payment approvedPayment) {
    	List<Links> links = approvedPayment.getLinks();
        String approvalLink = null;
         
        for (Links link : links) {
            if (link.getRel().equalsIgnoreCase("approval_url")) {
                approvalLink = link.getHref();
                break;
            }
        }      
         
        return approvalLink;
    }
    
    
    
    
    public Payment getPaymentDetails(String paymentId) throws PayPalRESTException {
        APIContext apiContext = new APIContext(CLIENT_ID, CLIENT_SECRET, MODE);
        return Payment.get(apiContext, paymentId);
    }
    
    
    
    
    public Payment executePayment(String paymentId, String payerId)
            throws PayPalRESTException {
        PaymentExecution paymentExecution = new PaymentExecution();
        paymentExecution.setPayerId(payerId);
     
        Payment payment = new Payment().setId(paymentId);
     
        APIContext apiContext = new APIContext(CLIENT_ID, CLIENT_SECRET, MODE);
     
        return payment.execute(apiContext, paymentExecution);
    }
    
    
}
