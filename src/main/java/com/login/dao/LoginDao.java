package com.login.dao;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class LoginDao {
	
	
	String url = "jdbc:mysql://localhost:3306/academy";
	String user = "root";
	String dbPassword = "pass111";
	String query = "Select * from users where username=? and role=? and password=AES_ENCRYPT(?, 'secret')";
	
	public static void main(String[] args) {
		LoginDao a = new LoginDao();
		
		System.out.println(a.checkAuthentication("f1", "faculty", "456"));
	}
	
	public boolean checkAuthentication(String username, String role, String password) {
		
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection(url, user, dbPassword);
			PreparedStatement st = con.prepareStatement(query);
			st.setString(1, username);
			st.setString(2, role);
			st.setString(3, password);
			
			ResultSet rs = st.executeQuery();
			
			if(rs.next()) {
				return true;
			}
	
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		return false;
	}
}
