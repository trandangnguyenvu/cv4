package model;

import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;


public class User {
	private String account;
	private String pass;
	private String confirm;
	private String role;
	private	String name;
	private	String lastName;
	private String email;
	private	String status;
	private String gender;
	private	Date birthDay;
	private String phone;
	private String paypal;
	
	private String message = "";
	//"Error validating error message."	

	


	public User(String name, String lastName, String email, String phone) {
		super();
		this.name = name;
		this.lastName = lastName;
		this.email = email;
		this.phone = phone;
	}





	public User(String account, String pass) {
		super();
		this.account = account;
		this.pass = pass;
	}





	public User() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	

	public String getAccount() {
		return account;
	}


	public void setAccount(String account) {
		this.account = account;
	}


	public String getPass() {
		return pass;
	}


	public void setPass(String pass) {
		this.pass = pass;
	}


	public String getConfirm() {
		return confirm;
	}


	public void setConfirm(String confirm) {
		this.confirm = confirm;
	}


	public String getRole() {
		return role;
	}


	public void setRole(String role) {
		this.role = role;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public String getLastName() {
		return lastName;
	}


	public void setLastName(String lastName) {
		this.lastName = lastName;
	}


	public String getEmail() {
		return email;
	}


	public void setEmail(String email) {
		this.email = email;
	}


	public String getStatus() {
		return status;
	}


	public void setStatus(String status) {
		this.status = status;
	}


	public String getGender() {
		return gender;
	}


	public void setGender(String gender) {
		this.gender = gender;
	}


	public Date getBirthDay() {
		return birthDay;
	}


	public void setBirthDay(Date birthDay) {
		this.birthDay = birthDay;
	}


	public String getPhone() {
		return phone;
	}


	public void setPhone(String phone) {
		this.phone = phone;
	}


	public String getPaypal() {
		return paypal;
	}


	public void setPaypal(String paypal) {
		this.paypal = paypal;
	}


	public String getMessage() {
		return message;
	}


	public void setMessage(String message) {
		this.message = message;
	}


	
	
	
	public boolean validate1(Date dateNow) {	
		/*
		 * "throws ParseException" làm cho khi 1 object nào đó call validate1() thì 
		 * dòng mã đó sẽ phải được bọc try/catch => at servlet QueryAtAdminUser => else if (acc.validate2()) { 
		 * => đưa dateNow ra servlet vì ft.parse(ftDateNow) cần throws ParseException or try/catch
		 */
		
		String regexpPass = "(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*]).{8,}";
		String regexpMail = "^([A-Za-z0-9_\\-\\.])+\\@([A-Za-z0-9_\\-\\.])+\\.([A-Za-z]{2,4})$";
		String regexpPhone = "^[0-9]+$"; // =>  /^[0-9]+$/ ; /^\d+$/ 
		
		
		//java.util.Date dateNow = new java.util.Date();							
		
		//SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd");
		
		//String ftDateNow = ft.format(dateNow); // Date to String + to "yyyy/MM/dd" format (for "yyyy/MM/dd" => must be String first )
		//java.util.Date dtDateNow = ft.parse(ftDateNow); // String to Date
		// ft.parse(ftDateNow) cần throws ParseException or try/catch
		
		
		if (account == null || account.equals("")) { // account == "" => WRONG
			message = "Tên Tài khoản không được để trống";
			return false;
		}
		
		
		
		if (email == null || email.equals("")) {
			message = "Ô Email không được để trống";
			return false;
		} else if (!email.matches(regexpMail)) {
			message = "Email không hợp lệ";
			return false;
		}
		
		
		
		if (name == null || name.equals("")) {
			message = "Tên không được để trống";
			return false;
		}
		
		
		
		if (lastName == null || lastName.equals("")) {
			message = "Họ và tên đệm không được để trống";
			return false;
		}
		
		
		
		if (pass == null || pass.equals("")) {
			message = "Mật khẩu không được để trống";
			return false;
		} else if (!pass.matches(regexpPass)) {
			message = "Mật khẩu phải chứa ít nhất 1 chữ số, 1 chữ cái viết hoa, 1 chữ cái thường, 1 ký tự đặc biệt và ít nhất 8 ký tự trở lên";
			return false;
		}
		
		
		
		if (confirm == null || confirm.equals("")) {
			message = "Mật khẩu xác nhận không được để trống";
			return false;			
		} else if (!confirm.equals(pass)) {
			message = "Mật khẩu 'xác nhận' không trùng khớp với Mật khẩu";
			return false;
		}
		
		
		
		if (birthDay == null) {
			message = "Ngày tháng năm sinh không được để trống";
			return false;
		} else if (birthDay.compareTo(dateNow)>0) {		 												
			message = "Ngày sinh không được lớn hơn ngày hiện tại";
			return false;
		}
		
		
		if (gender == null || gender.equals("")) {
			message = "Mục giới tính không được để trống";
			return false;
		}
		

		if (role == null || role.equals("")) {
			message = "Mục Vai trò không được để trống";
			return false;
		}
		
		
		if (phone != null) {
			if (!phone.matches(regexpPhone)) {
				message = "Số điện thoại chỉ được bao gồm số";
				return false;
			}
		}
		
		
		
		
		// return true
		message = "";
		return true;
	}
	
	
	
	
		
	//
	public boolean validate2() {	
		//String regexpPass = "(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*]).{8,}";
		String regexpMail = "^([A-Za-z0-9_\\-\\.])+\\@([A-Za-z0-9_\\-\\.])+\\.([A-Za-z]{2,4})$";
		String regexpPhone = "^[0-9]+$"; // =>  /^[0-9]+$/ ; /^\d+$/ 
				
		
		
		if (email == null || email.equals("")) {
			message = "Ô Email không được để trống";
			return false;
		} else if (!email.matches(regexpMail)) {
			message = "Email không hợp lệ";
			return false;
		}
		
		
		
		if (name == null || name.equals("")) {
			message = "Tên không được để trống";
			return false;
		}
		
		
		
		if (lastName == null || lastName.equals("")) {
			message = "Họ và tên đệm không được để trống";
			return false;
		}
			
		
		
		if (phone != null) {
			if (!phone.matches(regexpPhone)) {
				message = "Số điện thoại chỉ được bao gồm số";
				return false;
			}
		}
		
		
		
		// return true
		message = "";
		return true;
	}
	
	
	
	
	
	//
	public boolean validate3(Date dateNow) {	
		if (birthDay == null) {
			message = "Ngày tháng năm sinh không được để trống";
			return false;
		} else if (birthDay.compareTo(dateNow)>0) {		 												
			message = "Ngày sinh không được lớn hơn ngày hiện tại";
			return false;
		}
		
		
		
		// return true
		message = "";
		return true;
	}
	

		
	
	
	// for login form
	public boolean validate6() {
		String regexpPass = "(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*]).{8,}";

		if (account == null || account.equals("")) {
			message = "Tên Tài khoản không được để trống";
			return false;
		}

		
		
		if (pass == null || pass.equals("")) {
			message = "Mật khẩu không được để trống";
			return false;
		} else if (!pass.matches(regexpPass)) {
			message = "Mật khẩu phải chứa ít nhất 1 chữ số, 1 chữ cái viết hoa, 1 chữ cái thường, 1 ký tự đặc biệt và ít nhất 8 ký tự trở lên";
			return false;
		}

		
		
		// return true
		message = "";
		return true;
	}
	
	
		
	
	
	//
	public boolean validate4() {		
		String regexpPass = "(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*]).{8,}";
		
		if (account == null || account.equals("")) {
			message = "Tên Tài khoản không được để trống";
			return false;
		}
		
		
		if (pass == null || pass.equals("")) {
			message = "Mật khẩu không được để trống";
			return false;
		} else if (!pass.matches(regexpPass)) {
			message = "Mật khẩu phải chứa ít nhất 1 chữ số, 1 chữ cái viết hoa, 1 chữ cái thường, 1 ký tự đặc biệt và ít nhất 8 ký tự trở lên";
			return false;
		}
		
		
		
		if (confirm == null || confirm.equals("")) {
			message = "Mật khẩu xác nhận không được để trống";
			return false;			
		} else if (!confirm.equals(pass)) {
			message = "Mật khẩu 'xác nhận' không trùng khớp với Mật khẩu";
			return false;
		}
			
		
		
		// return true
		message = "";
		return true;
	}
	
	
	
	
	//
	public boolean validate5() {		
		
		if (account == null || account.equals("")) {
			message = "Tên Tài khoản không được để trống";
			return false;
		}
		
		
		
		// return true
				message = "";
				return true;
	}
	
	
	
	
	
	// for password change form
	public boolean validate7() {		
		String regexpPass = "(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*]).{8,}";
		
		if (pass == null || pass.equals("")) {
			message = "Mật khẩu mới không được để trống";
			return false;
		} else if (!pass.matches(regexpPass)) {
			message = "Mật khẩu phải chứa ít nhất 1 chữ số, 1 chữ cái viết hoa, 1 chữ cái thường, 1 ký tự đặc biệt và ít nhất 8 ký tự trở lên";
			return false;
		}
		
		
		
		if (confirm == null || confirm.equals("")) {
			message = "Mật khẩu xác nhận không được để trống";
			return false;			
		} else if (!confirm.equals(pass)) {
			message = "Mật khẩu 'xác nhận' không trùng khớp với Mật khẩu";
			return false;
		}
			
		
		
		// return true
		message = "";
		return true;
	}
	
	
	
	
	// for login form 
	public boolean validate8() {		
		
		if (pass == null || pass.equals("")) {
			message = "Mật khẩu cũ không được để trống";
			return false;
		} 
		
		
		// return true
		message = "";
		return true;
	}
	
	
	
	
	
	// for forgot password
	public boolean validate9() {	
		String regexpMail = "^([A-Za-z0-9_\\-\\.])+\\@([A-Za-z0-9_\\-\\.])+\\.([A-Za-z]{2,4})$";
		
		if (account == null || account.equals("")) {
			message = "Tên Tài khoản không được để trống";
			return false;
		}
		
		
		if (email == null || email.equals("")) {
			message = "Ô Email không được để trống";
			return false;
		} else if (!email.matches(regexpMail)) {
			message = "Email không hợp lệ";
			return false;
		}

		
		
		
		// return true
		message = "";
		return true;
	}
	
	
	
}
