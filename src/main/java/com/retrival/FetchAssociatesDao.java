package com.retrival;

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

@WebServlet("/FetchAssociates")
public class FetchAssociatesDao extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String url = "jdbc:mysql://localhost:3306/academy";
		String user = "root";
		String dbPassword = "pass111";
		String query = "select studentID, studentName, batchName from associate a inner join batches b on b.id = a.batchNo";

		response.setContentType("application/json");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		JSONObject json = new JSONObject();
		List<Map<String, String>> list = new ArrayList<>();
		
		System.out.println("Fetching Associates");

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection(url, user, dbPassword);
			Statement stmt = con.createStatement();

			ResultSet rs = stmt.executeQuery(query);
			
			// Extract data from result set
			while (rs.next()) {
				// Retrieve by column name
				
				Map<String,String> map = new HashMap<>();
				map.put("studentID", rs.getString("studentID"));
				map.put("studentName", rs.getString("studentName"));
				map.put("batchName", rs.getString("batchName"));
//				System.out.println(map);
				list.add(map);
			}
//			System.out.println(list);
			rs.close();
			
			String data = new Gson().toJson(list);
			
//			System.out.println(data);
			
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
