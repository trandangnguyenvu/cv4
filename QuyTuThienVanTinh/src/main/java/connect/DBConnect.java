package connect;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnect {
	private final String serverName = "localhost";
	private final String dbName = "DonationDB";
	private final String portNumber = "1433";
	//private final String instance = "";
	private final String userID = "sa";
	private final String password = "12345";
	
	public Connection getConnection () /* throws Exception */ {		
		String url = "jdbc:sqlserver://" + serverName + ":" + portNumber + ";databaseName="+dbName + ";encrypt=false;";
		
		try {
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		
		
		
		Connection conn = null;
		try {			
			conn = DriverManager.getConnection(url, userID, password);
		} catch (Exception e) {
			e.printStackTrace();			
		}
		
		return conn;	
	}

}
