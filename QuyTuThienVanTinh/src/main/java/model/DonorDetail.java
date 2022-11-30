package model;

import java.sql.Date;

/*
 * contain data from Donor_detail table
 */
public class DonorDetail {
	private String iD; // donor id
	private String acc; // account of donor
	private String dID; // donation round ID
	private float money; 
	private Date date; // donation date
	private String status;
	
	public DonorDetail() {
		super();
		// TODO Auto-generated constructor stub
	}

	public String getiD() {
		return iD;
	}

	public void setiD(String iD) {
		this.iD = iD;
	}

	public String getAcc() {
		return acc;
	}

	public void setAcc(String acc) {
		this.acc = acc;
	}

	public String getdID() {
		return dID;
	}

	public void setdID(String dID) {
		this.dID = dID;
	}

	public float getMoney() {
		return money;
		//return String.format("%.2f", money);
	}

	public void setMoney(float money) {
		this.money = money;
		//this.money = Float.parseFloat(money);
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	
}

