package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import connect.DBConnect;
import model.DonationRound;
import model.DonorDetail;

/*
 * jobs with Donor_detail table
 */
public class DonorDetailDAO {

/*
 * Take data from DB 
 */
	
	/*
	 * get all records from Donor_detail
	 */
	public static List<DonorDetail> getAllRecords4AdminJsp(){  
        List<DonorDetail> list = new ArrayList<DonorDetail>();  
        try{  
        	Connection con = new DBConnect().getConnection();        	
            
            PreparedStatement ps = con.prepareStatement("select * from Donor_detail");  
            ResultSet rs = ps.executeQuery();  
            while(rs.next()){  
            	DonorDetail e = new DonorDetail();  
            	
                e.setiD(rs.getString("donor_id"));  
                e.setAcc(rs.getString("user_account")); 
                e.setdID(rs.getString("donation_round_id"));  
                e.setMoney(rs.getFloat("money"));
                e.setDate(rs.getDate("donation_date"));
                e.setStatus(rs.getString("status"));
                                
                
                list.add(e);  
            }  
            con.close();  
        }catch(Exception e){System.out.println(e);}  
        return list;  
    } 
	
	
	
	
	/*
	 * get all records from Donor_detail with a sort by (order by) donation round ID
	 */
	public static List<DonorDetail> getAllRecordsWithSortbyDRID(){  
        List<DonorDetail> list = new ArrayList<DonorDetail>();  
        try{  
        	Connection con = new DBConnect().getConnection();        	
            
            PreparedStatement ps = con.prepareStatement("select * from Donor_detail ORDER BY donation_round_id DESC, donation_date Desc");  
            ResultSet rs = ps.executeQuery();  
            while(rs.next()){  
            	DonorDetail e = new DonorDetail();  
            	
                e.setiD(rs.getString("donor_id"));  
                e.setAcc(rs.getString("user_account")); 
                e.setdID(rs.getString("donation_round_id"));  
                e.setMoney(rs.getFloat("money"));
                e.setDate(rs.getDate("donation_date"));
                e.setStatus(rs.getString("status"));
                                
                
                list.add(e);  
            }  
            con.close();  
        }catch(Exception e){System.out.println(e);}  
        return list;  
    } 
	
	
	
	/*
	 * admin x??c nh???n ti???n t??? m???t l?????t quy??n g??p ???? v??o t??i kho???n c???a qu??? 
	 */
	public boolean confirm (String donorID) throws SQLException {
		try {
			Connection con = new DBConnect().getConnection();

			String sql = "UPDATE Donor_detail SET status = 'Confirmed' WHERE donor_id = ?";

			PreparedStatement ps = con.prepareStatement(sql);


			ps.setString(1, donorID);			
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
	 * h??nh ?????ng h???y m???t l?????t quy??n g??p khi ti???n t??? l?????t ???? kh??ng v??o t??i kho???n c???a qu???
	 */
	public boolean reject (String donorID) throws SQLException {
		try {
			Connection con = new DBConnect().getConnection();

			String sql = "UPDATE Donor_detail SET status = 'Rejected' WHERE donor_id = ?";

			PreparedStatement ps = con.prepareStatement(sql);


			ps.setString(1, donorID);			
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
