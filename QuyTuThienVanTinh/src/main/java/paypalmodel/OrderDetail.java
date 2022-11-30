package paypalmodel;

public class OrderDetail {
	private String donationRoundName;
    private float total;
    private float subtotal;
    private float shipping;
    private float tax;
   
 
    public OrderDetail(String donationRoundName, String subtotal,
            String shipping, String tax, String total) {
        this.donationRoundName = donationRoundName;
        this.subtotal = Float.parseFloat(subtotal);
        this.shipping = Float.parseFloat(shipping);
        this.tax = Float.parseFloat(tax);
        this.total = Float.parseFloat(total);
    }
 
    public String getDonationRoundName() {
		return donationRoundName;
	}

	public String getSubtotal() {
        return String.format("%.2f", subtotal);
    }
 
    public String getShipping() {
        return String.format("%.2f", shipping);
    }
 
    public String getTax() {
        return String.format("%.2f", tax);
    }
     
    public String getTotal() {
        return String.format("%.2f", total);
    }
	
}
