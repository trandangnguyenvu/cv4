package model;

import java.sql.Date;


public class DonationRound {
	private int id;
	private String title;
	private String summary;
	private String story;
	private String imgSource1;
	private String imgSource2;
	private String imgSource3;
	private String imgSource4;
	private String imgSource5;
	private String imgSource6;
	private float targetMoney;
	private float totalMoney;
	private int partnerId;
	private int number;
	private Date startDate;
	private Date endDate;
	private String status;
	
	private String message = "";
	//"Error validating error message."

	
	public DonationRound(int id, String title, String summary, String story, String imgSource1, String imgSource2,
			String imgSource3, String imgSource4, String imgSource5, String imgSource6, float targetMoney,
			float totalMoney, int partnerId, int number, Date startDate, Date endDate, String status) {
		super();
		this.id = id;
		this.title = title;
		this.summary = summary;
		this.story = story;
		this.imgSource1 = imgSource1;
		this.imgSource2 = imgSource2;
		this.imgSource3 = imgSource3;
		this.imgSource4 = imgSource4;
		this.imgSource5 = imgSource5;
		this.imgSource6 = imgSource6;
		this.targetMoney = targetMoney;
		this.totalMoney = totalMoney;
		this.partnerId = partnerId;
		this.number = number;
		this.startDate = startDate;
		this.endDate = endDate;
		this.status = status;
	}	
	

	public DonationRound(int id, String title, String summary, String story, Date startDate, Date endDate) {
		super();
		this.id = id;
		this.title = title;
		this.summary = summary;
		this.story = story;
		this.startDate = startDate;
		this.endDate = endDate;
	}
	
	
	public DonationRound(int id, String title, String summary, Date startDate, Date endDate) {
		super();
		this.id = id;
		this.title = title;
		this.summary = summary;
		this.startDate = startDate;
		this.endDate = endDate;
	}

	
	
	public DonationRound(String title, String summary, String story, int partnerId, Date startDate, Date endDate) {
		super();
		this.title = title;
		this.summary = summary;
		this.story = story;
		this.partnerId = partnerId;
		this.startDate = startDate;
		this.endDate = endDate;
	}

	

	public DonationRound(String title, String summary, String story) {
		super();
		this.title = title;
		this.summary = summary;
		this.story = story;
	}


	public DonationRound() {
		super();
		// TODO Auto-generated constructor stub
	}
	




	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getSummary() {
		return summary;
	}

	public void setSummary(String summary) {
		this.summary = summary;
	}

	public String getStory() {
		return story;
	}

	public void setStory(String story) {
		this.story = story;
	}

	public String getImgSource1() {
		return imgSource1;
	}

	public void setImgSource1(String imgSource1) {
		this.imgSource1 = imgSource1;
	}

	public String getImgSource2() {
		return imgSource2;
	}

	public void setImgSource2(String imgSource2) {
		this.imgSource2 = imgSource2;
	}

	public String getImgSource3() {
		return imgSource3;
	}

	public void setImgSource3(String imgSource3) {
		this.imgSource3 = imgSource3;
	}

	public String getImgSource4() {
		return imgSource4;
	}

	public void setImgSource4(String imgSource4) {
		this.imgSource4 = imgSource4;
	}

	public String getImgSource5() {
		return imgSource5;
	}

	public void setImgSource5(String imgSource5) {
		this.imgSource5 = imgSource5;
	}

	public String getImgSource6() {
		return imgSource6;
	}

	public void setImgSource6(String imgSource6) {
		this.imgSource6 = imgSource6;
	}

	public float getTargetMoney() {
		return targetMoney;
	}

	public void setTargetMoney(float targetMoney) {
		this.targetMoney = targetMoney;
	}

	public float getTotalMoney() {
		return totalMoney;
	}

	public void setTotalMoney(float totalMoney) {
		this.totalMoney = totalMoney;
	}

	public int getPartnerId() {
		return partnerId;
	}

	public void setPartnerId(int partnerId) {
		this.partnerId = partnerId;
	}

	public int getNumber() {
		return number;
	}

	public void setNumber(int number) {
		this.number = number;
	}

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	
	public String getMessage() {
		return message;
	}


	public void setMessage(String message) {
		this.message = message;
	}
	
	
	

	
	public boolean validate1() {		
		if (title == null || title == "") {
			message = "Ti??u ????? kh??ng ???????c ????? tr???ng";
			return false;
		}
		
		if (summary == null || summary == "") {
			message = "M???c t??m t???t n???i dung kh??ng ???????c ????? tr???ng";
			return false;
		}
		
		if (story == null || story == "") {
			message = "M???c n???i dung kh??ng ???????c ????? tr???ng";
			return false;
		}
		
		if (String.valueOf(partnerId) == null || String.valueOf(partnerId) == "") {
			message = "M???c ?????i t??c ?????ng h??nh kh??ng ???????c ????? tr???ng";
			return false;
		}
		
		
		/*
		 * Start date must be earlier than end date
		 */		
		if (startDate == null) {
			message = "Ng??y b???t ?????u kh??ng ???????c ????? tr???ng";
			return false;
		} else if (endDate == null) {
			message = "Ng??y k???t th??c kh??ng ???????c ????? tr???ng";
			return false;
		} else if (startDate.compareTo(endDate)>0) {
			message = "Ng??y b???t ?????u ph???i s???m h??n ng??y k???t th??c";
			return false;
		}
		
		/* with case that fields startDate + endDate are String (not Date)
		int startInt = Integer.valueOf(startDate);
		int endInt = Integer.valueOf(endDate);
		Date start = new Date(startInt);
		Date end = new Date(endInt);
		
		if (start.compareTo(end)>0) {
			message = "Ng??y b???t ?????u ph???i s???m h??n ng??y k???t th??c";
			return false;
		}
		*/
		
		String stTargetMoney = Float.toString(targetMoney);
		String regexpTargetMoney = "([+-]?(\\d+\\.)?\\d+)"; //"^(\\d+\\.)?\\d+$" // "[+-]?\\d*([.]?\\d+)" //
		if (!stTargetMoney.matches(regexpTargetMoney)) {
			message = "S??? ti???n ?????nh m???c ch??? ???????c bao g???m s???";
			return false;
		}
						
		// return true
		message = "";
		return true;
	}
	
	
	
	
		
	public boolean validate2() {		
		if (title == null || title == "") {
			message = "Ti??u ????? kh??ng ???????c ????? tr???ng";
			return false;
		}
		
		if (summary == null || summary == "") {
			message = "M???c t??m t???t n???i dung kh??ng ???????c ????? tr???ng";
			return false;
		}
		
		if (story == null || story == "") {
			message = "M???c n???i dung kh??ng ???????c ????? tr???ng";
			return false;
		}
		
		message = "";
		return true;
	}
	

	
//	public boolean validate3() {
//		String stTargetMoney = Float.toString(targetMoney);
//		//String regexpTargetMoney = ;
//		if (!stTargetMoney.matches(regexpTargetMoney)) {
//			message = "S??? ti???n ?????nh m???c ch??? ???????c bao g???m s???";
//			return false;
//		}
//		message = "";
//		return true;
//	}
	
	
}
