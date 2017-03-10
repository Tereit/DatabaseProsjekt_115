package application.model;

import java.sql.*;

public class Database {
	static final String DRIVER = "com.mysql.jdbc.Driver";
	private String url;
	private String user;
	private String pass;
	private Connection conn = null;
	private Statement stmt = null;
	
	public Database(String url, String user, String pass) {
		this.url = url;
		this.user = user;
		this.pass = pass;
	}
	
	public boolean connect() {
		try {
			Class.forName(DRIVER);
			conn = DriverManager.getConnection(url, user, pass);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
			return false;
		}
		createStatement();
		return true;
	}
	
	public boolean isConnected() {
		if(conn != null) {
			return true;
		}
		return false;
	}
	
	public void disconnect() throws SQLException {
		try {
			conn.close();
			conn = null;
		} catch(SQLException e) {
			throw new SQLException(e);
		}
	}
	
	private void createStatement() {
		if(isConnected()) {
			try {
				this.stmt = conn.createStatement();
			} catch (SQLException e) {
				// TODO: change this to something useful
				e.printStackTrace();
			}
		}
	}
	
	public Statement getStatement() {
		return stmt;
	}
}
