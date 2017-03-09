package application.model;

import java.sql.*;

public class Database {
	static final String DRIVER = "com.mysql.jdbc.Driver";
	static final String URL = "jdbc:mysql://localhost/treningsdagbok";

	static final String USER = "user";
	static final String PASS = "password";
	
	public static void main(String[] args) {
		Connection con = null;
		Statement stmt = null;
		try {
			Class.forName(DRIVER);
			System.out.println("Connecting to database");
			con = DriverManager.getConnection(URL, USER, PASS);
			stmt = con.createStatement();
			System.out.println("Success??");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
