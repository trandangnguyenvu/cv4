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
import model.Partner;
import model.Product;
import model.User;

/*
 * Take data from DB 
 */
public class ListOfDonationRoundDAO {

	/*
	 * Take data about Donation Rounds from DB for using at jsp 'Admin'
	 */
	public static List<DonationRound> getAllRecords4AdminJsp(){  
        List<DonationRound> list = new ArrayList<DonationRound>();  
        try{  
        	Connection con = new DBConnect().getConnection();        	
            
            PreparedStatement ps = con.prepareStatement("select * from Donation_Round");  
            ResultSet rs = ps.executeQuery();  
            while(rs.next()){  
            	DonationRound e = new DonationRound();  
            	
                e.setId(rs.getInt("donation_round_id"));  
                e.setTitle(rs.getString("title_of_story")); 
                e.setSummary(rs.getString("summary"));                                
                e.setStory(rs.getString("story"));
                e.setStartDate(rs.getDate("start_date"));
                e.setEndDate(rs.getDate("end_date"));
                e.setTargetMoney(rs.getFloat("target_money"));
                e.setTotalMoney(rs.getFloat("total_money"));
                e.setPartnerId(rs.getInt("partner_id"));
                e.setNumber(rs.getInt("number_of_donations"));
                e.setStatus(rs.getString("status"));
                
                list.add(e);  
            }  
            con.close();  
        }catch(Exception e){System.out.println(e);}  
        return list;  
    } 
	
	
	/*
	 * Take data about Partners from DB 
	 */
	public static List<Partner> getAllRecordsAboutPartner(){  
        List<Partner> list = new ArrayList<Partner>();  
        try{  
        	Connection con = new DBConnect().getConnection();        	
            
            PreparedStatement ps = con.prepareStatement("select * from Partner");  
            ResultSet rs = ps.executeQuery();  
            while(rs.next()){  
            	Partner e = new Partner();  
            	
                e.setId(rs.getInt("partner_id"));  
                e.setName(rs.getString("partner_name"));
                e.setInformation(rs.getString("information"));                              
                
                list.add(e);  
            }  
            con.close();  
        }catch(Exception e){System.out.println(e);}  
        return list;  
    } 
	 
	
	public static List<DonationRound> search(String characters) {
    	List<DonationRound> list = ListOfDonationRoundDAO.getAllRecords4AdminJsp();    	
    	
    	List<DonationRound> listSearch = new ArrayList<DonationRound>();
    	
    	for (DonationRound e:list) {
    		// not compareToIgnoreCase
    		if (e.getTitle().toLowerCase().contains(characters.toLowerCase()) || e.getSummary().toLowerCase().contains(characters.toLowerCase())) {
    			listSearch.add(e);
    		}
    	}
    	return listSearch;
    }
	

	
	
	 /**
     * for pagination
	 *     
     */
    public static List<DonationRound> getRecords4Pagination(int start,int total){  
        List<DonationRound> list=new ArrayList<DonationRound>();  
        try{  
        	Connection con = new DBConnect().getConnection();        	
            
//            PreparedStatement ps=con.prepareStatement("select * from Donation_Round order by donation_round_id, title_of_story "
//            		+ "offset " + start + " rows fetch next " + total + " rows only");  
            
        	// add filter => date of current  must be greater than or equal to date of start
        	PreparedStatement ps=con.prepareStatement("select * from Donation_Round where  GETDATE() >= start_date order by donation_round_id, title_of_story "
            		+ "offset " + start + " rows fetch next " + total + " rows only"); 
                    	
        	
        	ResultSet rs=ps.executeQuery();  
            while(rs.next()){  
            	DonationRound e=new DonationRound();  
            	
                e.setId(rs.getInt("donation_round_id"));       
                e.setTitle(rs.getString("title_of_story"));
                e.setSummary(rs.getString("summary"));
                e.setStory(rs.getString("story"));
                e.setImgSource1(rs.getString("img_source_1"));
                e.setTargetMoney(rs.getFloat("target_money"));
                e.setTotalMoney(rs.getFloat("total_money"));
                e.setPartnerId(rs.getInt("partner_id"));
                e.setNumber(rs.getInt("number_of_donations"));
                e.setStartDate(rs.getDate("start_date"));
                e.setEndDate(rs.getDate("end_date"));
                e.setStatus(rs.getString("status"));
                
                list.add(e);  
            }  
            con.close();  
        }catch(Exception e){System.out.println(e);}  
        return list;  
    }  

	
    
    
    
    /*
	 * count donations that getdate() must be greater or equals to date of start
	 */
	public int countDonations() throws SQLException {
		int count =0;
		try {
			Connection con = new DBConnect().getConnection();
			
			String sql = "select count(*) as count from Donation_Round where GETDATE() >= start_date";

			PreparedStatement ps = con.prepareStatement(sql);
			
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
		
		return count;
	}
    
    
	
	/**
     * for search + pagination
     * (searching at home page)
	 *     
     */
    public static List<DonationRound> getRecords4PaginationSearch(int start,int total, String search){  
        List<DonationRound> list=new ArrayList<DonationRound>();  
        try{  
        	Connection con = new DBConnect().getConnection();        	
            
//            PreparedStatement ps=con.prepareStatement("select * from Donation_Round order by donation_round_id, title_of_story "
//            		+ "offset " + start + " rows fetch next " + total + " rows only");  
            
        	// add filter => date of current  must be greater than or equal to date of start ; %?%
        	PreparedStatement ps=con.prepareStatement("select * from Donation_Round where GETDATE() >= start_date and (title_of_story like ? or donation_round_id like ? or target_money like ?) order by donation_round_id, title_of_story "
            		+ "offset " + start + " rows fetch next " + total + " rows only"); 
            
        	ps.setString(1, "%" + search + "%");
        	ps.setString(2, "%" + search + "%");
        	ps.setString(3, "%" + search + "%");
        	
        	ResultSet rs=ps.executeQuery();  
            while(rs.next()){  
            	DonationRound e=new DonationRound();  
            	
                e.setId(rs.getInt("donation_round_id"));       
                e.setTitle(rs.getString("title_of_story"));
                e.setSummary(rs.getString("summary"));
                e.setStory(rs.getString("story"));
                e.setImgSource1(rs.getString("img_source_1"));
                e.setTargetMoney(rs.getFloat("target_money"));
                e.setTotalMoney(rs.getFloat("total_money"));
                e.setPartnerId(rs.getInt("partner_id"));
                e.setNumber(rs.getInt("number_of_donations"));
                e.setStartDate(rs.getDate("start_date"));
                e.setEndDate(rs.getDate("end_date"));
                e.setStatus(rs.getString("status"));
                
                list.add(e);  
            }  
            con.close();  
        }catch(Exception e){System.out.println(e);}  
        return list;  
    }  
	
	
    
    
    /* 
     * Searching at home page
	 * count donations that getdate() must be greater or equals to date of start
	 */
	public int countDonationsSearch(String search) throws SQLException {
		int count =0;
		try {
			Connection con = new DBConnect().getConnection();
			
			String sql = "select count(*) as count from Donation_Round where GETDATE() >= start_date and (title_of_story like ? or donation_round_id like ? or target_money like ?) ";

			PreparedStatement ps = con.prepareStatement(sql);
			
			ps.setString(1, "%" + search + "%");
        	ps.setString(2, "%" + search + "%");
        	ps.setString(3, "%" + search + "%");
			
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
		
		return count;
	}
    
    
	
	// get one record of an donation round
	public static DonationRound getOneRecord(String iD){  
//      List<DonationRound> list=new ArrayList<DonationRound>();  
		DonationRound e=new DonationRound();
        try{  
        	Connection con = new DBConnect().getConnection();        	
            
        	PreparedStatement ps=con.prepareStatement("select * from Donation_Round where  donation_round_id = ?"); 
            
        	int iDInt = Integer.parseInt(iD);
        	
        	ps.setInt(1, iDInt);
        	        	
        	ResultSet rs=ps.executeQuery();  
            while(rs.next()){  
            	  
            	
                e.setId(rs.getInt("donation_round_id"));       
                e.setTitle(rs.getString("title_of_story"));
                e.setSummary(rs.getString("summary"));
                e.setStory(rs.getString("story"));
                e.setImgSource1(rs.getString("img_source_1"));
                e.setImgSource2(rs.getString("img_source_2"));
                e.setImgSource3(rs.getString("img_source_3"));
                e.setImgSource4(rs.getString("img_source_4"));
                e.setImgSource5(rs.getString("img_source_5"));
                e.setImgSource6(rs.getString("img_source_6"));
                e.setTargetMoney(rs.getFloat("target_money"));
                e.setTotalMoney(rs.getFloat("total_money"));
                e.setPartnerId(rs.getInt("partner_id"));
                e.setNumber(rs.getInt("number_of_donations"));
                e.setStartDate(rs.getDate("start_date"));
                e.setEndDate(rs.getDate("end_date"));
                e.setStatus(rs.getString("status"));
                
//              list.add(e);  
            }  
            con.close();  
        }catch(Exception ex){System.out.println(ex);}  
        return e;  
    }  
	
	
}
