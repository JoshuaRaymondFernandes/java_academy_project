package com.sql;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import com.google.gson.Gson;


@WebServlet("/FetchStudentByID")
public class FetchStudentByID extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String url = "jdbc:mysql://localhost:3306/academy";
		String user = "root";
		String dbPassword = "pass111";
		String query = "Select * FROM `students` WHERE id=? limit 1;";
		
		response.setContentType("application/json");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		JSONObject json = new JSONObject();
		
		try {
			String studentId = request.getParameter("studentId");
			
			System.out.println("Fetching data of Student  ");
			System.out.println(studentId);
			
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection(url, user, dbPassword);
			PreparedStatement st = con.prepareStatement(query);
			st.setString(1, studentId);
			
			
			ResultSet rs = st.executeQuery();
			Map<String,String> map = null;
			
			while(rs.next()) {
				map = new HashMap<>();
				map.put("ID", rs.getString("id"));
				map.put("StudentName", rs.getString("studentName"));
				map.put("Subject1", rs.getString("subject1"));
				map.put("Subject2", rs.getString("subject2"));
				map.put("Subject3", rs.getString("subject3"));
				System.out.println(map);
			}

			rs.close();
			
			String data = new Gson().toJson(map);
			
			System.out.println(data);
			
			json.put("status", "successful");
			json.put("data", data);
			
			out.print(json);
			out.flush();
	
		}
		catch(Exception e) {
			json.put("status", "failed");
			out.print(json);
			out.flush();
			e.printStackTrace();
		}

	}
}
