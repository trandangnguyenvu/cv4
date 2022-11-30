package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import connect.DBConnect;
import model.DonationRound;
import model.Partner;
import model.Product;
import model.User;

/*
 * Take data from DB  +  Database operations about User/Admin account
 */
public class AccountDAO {
	
	/*
	 * Take data from DB methods
	 */
	
	/*
	 * Take data about accounts (users) from DB for using at jsp 'Admin-user'
	 */
	public static List<User> getAllRecords4AdminUserJsp(){  
        List<User> list = new ArrayList<User>();  
        try{  
        	Connection con = new DBConnect().getConnection();        	
            
            PreparedStatement ps = con.prepareStatement("select * from Account");  
            ResultSet rs = ps.executeQuery();  
            while(rs.next()){  
            	User e = new User();  
            	
                //e.setId(rs.getInt("donation_round_id"));  
                e.setAccount(rs.getString("user_account")); 
                e.setPass(rs.getString("password"));                           
                e.setRole(rs.getString("account_role"));
                e.setName(rs.getString("user_name"));
                e.setLastName(rs.getString("last_name"));
                e.setGender(rs.getString("gender"));
                e.setEmail(rs.getString("email"));
                e.setStatus(rs.getString("status"));
                e.setPhone(rs.getString("user_phone"));
                e.setPaypal(rs.getString("paypal_ID"));
                e.setBirthDay(rs.getDate("day_of_birth"));                
                
                list.add(e);  
            }  
            con.close();  
        }catch(Exception e){System.out.println(e);}  
        return list;  
    } 
	
	
	
	 
	
	public static List<User> search(String characters) {
    	List<User> list = AccountDAO.getAllRecords4AdminUserJsp();    	
    	
    	List<User> listSearch = new ArrayList<User>();
    	
    	for (User e:list) {
    		// not compareToIgnoreCase
    		if (e.getAccount().toLowerCase().contains(characters.toLowerCase())  || e.getGender().toLowerCase().contains(characters.toLowerCase()) || e.getRole().toLowerCase().contains(characters.toLowerCase()) || e.getLastName().toLowerCase().contains(characters.toLowerCase()) || e.getName().toLowerCase().contains(characters.toLowerCase()) || e.getEmail().toLowerCase().contains(characters.toLowerCase())) {
    			listSearch.add(e);
    		} else if (e.getPaypal() != null ) {
    			if (e.getPaypal().toLowerCase().contains(characters.toLowerCase())) {
    				listSearch.add(e);
    			}
    		} else if (e.getPhone() != null ) {
    			if (e.getPhone().toLowerCase().contains(characters.toLowerCase())) {
    				listSearch.add(e);
    			}
    		} else if (e.getStatus() != null) {
    			if (e.getStatus().toLowerCase().contains(characters.toLowerCase())) {
    				listSearch.add(e);
    			}
    		}
    	}
    	return listSearch;
    }
	
	
	/*
	 * get an account (a record)
	 * 
	 */
	public static List<User> getAnAccount(String account){  
        List<User> list = new ArrayList<User>(); // should be List or just should be User??
        try{   
        	Connection con = new DBConnect().getConnection();        	
            
            PreparedStatement ps = con.prepareStatement("select * from Account where user_account = ?"); 
            
            ps.setString(1, account);
            
            ResultSet rs = ps.executeQuery();  
            while(rs.next()){  
            	User e = new User();  
            	
                //e.setId(rs.getInt("donation_round_id"));  
                e.setAccount(rs.getString("user_account")); 
                e.setPass(rs.getString("password"));                           
                e.setRole(rs.getString("account_role"));
                e.setName(rs.getString("user_name"));
                e.setLastName(rs.getString("last_name"));
                e.setGender(rs.getString("gender"));
                e.setEmail(rs.getString("email"));
                e.setStatus(rs.getString("status"));
                e.setPhone(rs.getString("user_phone"));
                e.setPaypal(rs.getString("paypal_ID"));
                e.setBirthDay(rs.getDate("day_of_birth"));                
                
                list.add(e);  
            }  
            con.close();  
        }catch(Exception e){System.out.println(e);}  
        return list;  
    } 
	
	
	/*
	 * get an account (a record) way 2 => GET ROLE 
	 * 
	 */
	 @SuppressWarnings("null")
	public User get1Record (String account) {
	    	List<User> list = AccountDAO.getAllRecords4AdminUserJsp();
	    	User p = new User();
	    	for (User e:list) {
	    		if (e.getAccount().equals(account)) {
	    			 //p = e;??
	    			p.setRole(e.getRole());
	    			p.setName(e.getName());
	    			p.setLastName(e.getLastName());
	    			p.setStatus(e.getStatus());
	    			p.setAccount(e.getAccount());
	    			p.setEmail(e.getEmail());
	    		}
	    	}
	    	return p;
	    }
	
	
	
	
	
	/*
	 * Database operations methods (tasks from an admin)
	 */
	
	/*
	 * an account Updating from an admin
	 */
	public boolean update (String name, String lastName, String email, String role, String gender, String birthDay, String paypalId, String phone, String account) throws SQLException  {
		
		/* SAMPLE from asm3 (beans/Account.java) >:
		 */		
		
		try{  
        	Connection con = new DBConnect().getConnection();        	
            
        	//SAMPLE: String sql = "insert into Account (user_mail, password, account_role, user_name, user_address, user_phone) values (?, ?, ?, ?, ?, ?)";
        	
        	String sql = "UPDATE Account SET user_name = ?, last_name = ?, email = ?, account_role = ?, gender = ?, day_of_birth = ?, paypal_ID = ?, user_phone = ? WHERE user_account = ?";
        	
        	PreparedStatement ps = con.prepareStatement(sql);  
        	
        	
        	
        	// birh from String to java.sql.Date => not nessary
        	/*
        	Date birthD = null; //important
			try {
				birthD = new SimpleDateFormat("yyyy-MM-dd").parse(birthDay); 
			} catch (ParseException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
				return; //important
			}
			
			java.sql.Date birth = new java.sql.Date(birthD.getTime());
			*/
        	//
			
			
        	ps.setString(1, name);
        	ps.setString(2, lastName); 
        	ps.setString(3, email);
        	ps.setString(4, role);
        	ps.setString(5, gender);
        	ps.setString(6, birthDay);
        	ps.setString(7, paypalId);
        	ps.setString(8, phone);
        	ps.setString(9, account);
        	//ps.setLong(7, intId);
        	
        	ps.executeUpdate();
        	
            //ps.close();
        	con.close();  
        	return true;
        }catch(Exception e){System.out.println(e);}     
		return false;
	}
	
	/*
	 * an account Creating from an admin
	 */
	public boolean create(String name, String lastName, String email, String role, String gender, String birthDay, String paypalId, String phone, String account, String pass) throws SQLException {
	
		try {
			Connection con = new DBConnect().getConnection();
			
			String sql = "insert into Account (user_name, last_name, email, account_role, gender, day_of_birth, paypal_ID, user_phone, user_account, password, status) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

			PreparedStatement ps = con.prepareStatement(sql);
			
			String status = "Hoạt động";

			ps.setString(1, name);
        	ps.setString(2, lastName); 
        	ps.setString(3, email);
        	ps.setString(4, role);
        	ps.setString(5, gender);
        	ps.setString(6, birthDay);
        	ps.setString(7, paypalId);
        	ps.setString(8, phone);
        	ps.setString(9, account);	
        	ps.setString(10, pass);
        	ps.setString(11, status);

			ps.executeUpdate();

			// ps.close();
			con.close();
			return true;
		} catch (Exception e) {
			System.out.println(e);
		}
		return false;
	}
	
	/*
	 * an account Deleting
	 */
	public boolean delete(String account) throws SQLException {
	
		try {
			Connection con = new DBConnect().getConnection();
			
			String sql = "delete from Account WHERE user_account = ?";

			PreparedStatement ps = con.prepareStatement(sql);

			ps.setString(1, account);					

			ps.executeUpdate();

			// ps.close();
			con.close();
			return true;
		} catch (Exception e) {
			System.out.println(e);
		}
		return false;
	}
	
	
	
	/*
	 * is exists, the account?
	 */
	public boolean exists(String account) throws SQLException {
		int count =0;
		try {
			Connection con = new DBConnect().getConnection();
			
			String sql = "select count(*) as count from Account where user_account = ?";

			PreparedStatement ps = con.prepareStatement(sql);

			ps.setString(1, account);					
			
			ResultSet rs = ps.executeQuery();
			// will return ResultSet object

			
			
			if (rs.next()) {
				// if rsnext is true, mean khong rong at 16:5 of video Querying database - van tin data source (f3-bai9) :
				count = rs.getInt("count");	
			}
			
			rs.close();
			
	
			
			// ps.close();
			//con.close();
		} catch (Exception e) {
			System.out.println(e);
		}
		if (count == 0) {
			return false;
		} else {
			return true;
		}
		
	}

	
	
	/*
	 * checking for login 
	 */
	public boolean login(String account, String password) throws SQLException {
		int count =0;
		try {
			Connection con = new DBConnect().getConnection();
			
			String sql = "select count(*) as count from Account where user_account = ? and password = ?";

			PreparedStatement ps = con.prepareStatement(sql);

			ps.setString(1, account);	
			ps.setString(2, password);
			
			ResultSet rs = ps.executeQuery();
			// will return ResultSet object

			
			
			if (rs.next()) {
				// if rsnext is true, mean khong rong at 16:5 of video Querying database - van tin data source (f3-bai9) :
				count = rs.getInt("count");	
			}
			
			rs.close();
			
	
			
			// ps.close();
			//con.close();
		} catch (Exception e) {
			System.out.println(e);
		}
		if (count == 0) {
			return false;
		} else {
			return true;
		}		
	}
	
	
	
	
	
	/*
	 * then a deleting not success
	 */
	public void thenDeleteFailure(String account) {
		try{  
        	Connection con = new DBConnect().getConnection();        	
            
        	String sql = "UPDATE Account SET status = ? WHERE user_account = ?";
        	
        	PreparedStatement ps = con.prepareStatement(sql);  
        	
        	String status = "Không hoạt động";

        	ps.setString(1, status);
        	ps.setString(2, account); 
        	
        	ps.executeUpdate();
        	
            //ps.close();
        	con.close();  
        }catch(Exception e){System.out.println(e);} 		
	}
	
	
	
	
	
	// tasks from an User
	/*
	 * an account Updating from an User
	 */
	public boolean userUpdate(String name, String lastName, String email, String gender, String birthDay,
			String paypalId, String phone, String account) throws SQLException {

		/*
		 * SAMPLE from asm3 (beans/Account.java) >:
		 */

		try {
			Connection con = new DBConnect().getConnection();

			// SAMPLE: String sql = "insert into Account (user_mail, password, account_role,
			// user_name, user_address, user_phone) values (?, ?, ?, ?, ?, ?)";

			String sql = "UPDATE Account SET user_name = ?, last_name = ?, email = ?, gender = ?, day_of_birth = ?, paypal_ID = ?, user_phone = ? WHERE user_account = ?";

			PreparedStatement ps = con.prepareStatement(sql);


			ps.setString(1, name);
			ps.setString(2, lastName);
			ps.setString(3, email);
			
			ps.setString(4, gender);
			ps.setString(5, birthDay);
			ps.setString(6, paypalId);
			ps.setString(7, phone);
			ps.setString(8, account);
			// ps.setLong(7, intId);

			ps.executeUpdate();

			// ps.close();
			con.close();
			return true;
		} catch (Exception e) {
			System.out.println(e);
		}
		return false;
	}
	
	
	
	
	
	/*
	 * an account Creating from an User
	 */
	public boolean userCreate(String name, String lastName, String email, String gender, String birthDay, String paypalId, String phone, String account, String pass) throws SQLException {
	
		try {
			Connection con = new DBConnect().getConnection();
			
			String sql = "insert into Account (user_name, last_name, email, gender, day_of_birth, paypal_ID, user_phone, user_account, password, status, account_role) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

			PreparedStatement ps = con.prepareStatement(sql);
			
			String status = "Hoạt động";
			String role = "User";

			ps.setString(1, name);
        	ps.setString(2, lastName); 
        	ps.setString(3, email);
        	
        	ps.setString(4, gender);
        	ps.setString(5, birthDay);
        	ps.setString(6, paypalId);
        	ps.setString(7, phone);
        	ps.setString(8, account);	
        	ps.setString(9, pass);
        	ps.setString(10, status);
        	ps.setString(11, role);

			ps.executeUpdate();

			// ps.close();
			con.close();
			return true;
		} catch (Exception e) {
			System.out.println(e);
		}
		return false;
	}
	
	
	
	
	// tasks from an User
		/*
		 * an account password Updating from an User
		 */
		public boolean changePass(String pass, String account) throws SQLException {

			/*
			 * SAMPLE from asm3 (beans/Account.java) >:
			 */

			try {
				Connection con = new DBConnect().getConnection();

				// SAMPLE: String sql = "insert into Account (user_mail, password, account_role,
				// user_name, user_address, user_phone) values (?, ?, ?, ?, ?, ?)";

				String sql = "UPDATE Account SET password = ? WHERE user_account = ?";

				PreparedStatement ps = con.prepareStatement(sql);


				ps.setString(1, pass);
				ps.setString(2, account);				
				// ps.setLong(7, intId);

				ps.executeUpdate();

				// ps.close();
				con.close();
				return true;
			} catch (Exception e) {
				System.out.println(e);
			}
			return false;
		}
		
	
		
		
		/*
		 * is exists, the email ?
		 */
		public boolean existsEmail(String account, String email) throws SQLException {
			int count =0;
			try {
				Connection con = new DBConnect().getConnection();
				
				String sql = "select count(*) as count from Account where user_account = ? and email = ?";

				PreparedStatement ps = con.prepareStatement(sql);

				ps.setString(1, account);	
				ps.setString(2, email);
				
				ResultSet rs = ps.executeQuery();
				// will return ResultSet object

				
				
				if (rs.next()) {
					// if rsnext is true, mean khong rong at 16:5 of video Querying database - van tin data source (f3-bai9) :
					count = rs.getInt("count");	
				}
				
				rs.close();
				
		
				
				// ps.close();
				//con.close();
			} catch (Exception e) {
				System.out.println(e);
			}
			if (count == 0) {
				return false;
			} else {
				return true;
			}
			
		}	
		
		
		
		
		
		/*
		 * tasks then an user forgot password
		 */
		public boolean updatePass(String account, String pass) throws SQLException {

			try {
				Connection con = new DBConnect().getConnection();

				String sql = "UPDATE Account SET password = ? WHERE user_account = ?";

				PreparedStatement ps = con.prepareStatement(sql);


				ps.setString(1, pass);
				ps.setString(2, account);
				// ps.setLong(7, intId);

				ps.executeUpdate();

				// ps.close();
				con.close();
				return true;
			} catch (Exception e) {
				System.out.println(e);
			}
			return false;
		}
		
		
}
