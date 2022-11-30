package model;

/*
 * for using from paypal servlets 
 */
public class PaypalUser {
	private User acc;
	private String dID; // 	donationRoundId
	private String dNm; // donationRoundName
	private float money; // total
	
	public PaypalUser(String dID, String dNm, String money) {
		super();		
		this.dID = dID;
		this.dNm = dNm;
		this.money = Float.parseFloat(money);
	}
	
	

	public PaypalUser() {
		super();
		// TODO Auto-generated constructor stub
	}



	public User getAcc() {
		return acc;
	}

	public void setAcc(User acc) {
		this.acc = acc;
	}

	public String getdID() {
		return dID;
	}

	public void setdID(String dID) {
		this.dID = dID;
	}

	public String getdNm() {
		return dNm;
	}

	public void setdNm(String dNm) {
		this.dNm = dNm;
	}

	public float getMoney() {
		return money;
	}

	public void setMoney(float money) {
		this.money = money;
	}
	
	
}


