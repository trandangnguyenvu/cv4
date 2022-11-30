package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import connect.DBConnect;
import context.DBContext;
import model.DonationRound;
import model.Product;
import model.User;

/*
 * Database operations about 1 Donation Round
 */
public class DatabaseOperationDonationRoundDAO {
	/*
	 * a donation round Updating
	 */
	public boolean update (String title, String summary, String story, String partner_id, String start_date, String end_date, String id, String targetmoney) throws SQLException  {
		
		/* SAMPLE from asm3 (beans/Account.java) >:
		 */		
		
		try{  
        	Connection con = new DBConnect().getConnection();        	
            
        	//SAMPLE: String sql = "insert into Account (user_mail, password, account_role, user_name, user_address, user_phone) values (?, ?, ?, ?, ?, ?)";
        	
        	String sql = "UPDATE Donation_Round SET title_of_story = ?, summary = ?, story = ?, partner_id = ?, start_date = ?, end_date = ?, target_money = ? WHERE donation_round_id = ?";
        	
        	PreparedStatement ps = con.prepareStatement(sql);  
        	
        	int intId =Integer.parseInt(id);
        	float flTargetMoney = Float.parseFloat(targetmoney);
        	
        	ps.setString(1, title);
        	ps.setString(2, summary);
        	ps.setString(3, story);
        	ps.setString(4, partner_id);
        	ps.setString(5, start_date);
        	ps.setString(6, end_date);
        	ps.setLong(7, (long) flTargetMoney);
        	ps.setLong(8, intId);
        	
        	ps.executeUpdate();
        	
            //ps.close();
        	con.close();  
        	return true;
        }catch(Exception e){System.out.println(e);}    
		return false;
	}
	
	/*
	 * a donation round Creating
	 */
	public boolean create(String title, String summary, String story, String partner_id, String start_date,
			String end_date, String targetmoney) throws SQLException {
	
		try {
			Connection con = new DBConnect().getConnection();
			
			String sql = "insert into Donation_Round (title_of_story, summary, story, partner_id, start_date, end_date, target_money) values (?, ?, ?, ?, ?, ?, ?)";

			PreparedStatement ps = con.prepareStatement(sql);
			float flTargetMoney = Float.parseFloat(targetmoney);

			ps.setString(1, title);
			ps.setString(2, summary);
			ps.setString(3, story);
			ps.setString(4, partner_id);
			ps.setString(5, start_date);
			ps.setString(6, end_date);	
			ps.setLong(7, (long) flTargetMoney);

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
	 * a donation round Deleting
	 */
	public boolean delete(String id) throws SQLException {
	
		try {
			Connection con = new DBConnect().getConnection();
			
			String sql = "delete from Donation_Round WHERE donation_round_id = ?";

			PreparedStatement ps = con.prepareStatement(sql);

			ps.setString(1, id);					

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
	 *  insert into donnor details table after donnor had done paypal successfully
	 */
	public void AnDonationDone (String acc, String donationID, float money) throws SQLException {
		try {
			Connection con = new DBConnect().getConnection();
			
			String sql = "insert into Donor_detail (user_account, donation_round_id, money, donation_date, status) values (?, ?, ?, GETDATE(),?)";

			PreparedStatement ps = con.prepareStatement(sql);	
			
			String status = "Pending";

			ps.setString(1, acc);
			ps.setString(2, donationID);
			ps.setLong(3, (long) money);
			ps.setString(4, status);
			

			ps.executeUpdate();

			// ps.close();
			con.close();			
		} catch (Exception e) {
			System.out.println(e);
		}
	}
	
	
}
