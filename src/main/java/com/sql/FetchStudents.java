package com.sql;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import com.google.gson.Gson;


@WebServlet("/FetchStudents")
public class FetchStudents extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String url = "jdbc:mysql://localhost:3306/academy";
		String user = "root";
		String dbPassword = "pass111";
		String query = "Select id, studentName, subject1, subject2, subject3, (s.subject1+s.subject2+s.subject3)/3 as `Average`, CASE WHEN (s.subject1+s.subject2+s.subject3)/3 > 30 THEN \"Pass\" ELSE \"Fail\" END as `Result` from students s;";

		response.setContentType("application/json");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		JSONObject json = new JSONObject();
		List<Map<String, String>> list = new ArrayList<>();

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection(url, user, dbPassword);
			Statement stmt = con.createStatement();

			ResultSet rs = stmt.executeQuery(query);
			
			// Extract data from result set
			while (rs.next()) {
				// Retrieve by column name
				
				Map<String,String> map = new HashMap<>();
				map.put("ID", rs.getString("id"));
				map.put("StudentName", rs.getString("studentName"));
				map.put("Subject1", rs.getString("subject1"));
				map.put("Subject2", rs.getString("subject2"));
				map.put("Subject3", rs.getString("subject3"));
				map.put("Average", rs.getString("Average"));
				map.put("Result", rs.getString("Result"));

				list.add(map);
			}
//			System.out.println(list);
			rs.close();
			
			String data = new Gson().toJson(list);
			
			json.put("status", "successful");
			json.put("data", data);
			
			out.print(json);
			out.flush();

		} catch (Exception e) {
			json.put("status", "failed");
			out.print(json);
			out.flush();
			e.printStackTrace();
		}
		
		
		
	}

}
