package com.sql;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;


@WebServlet("/UpdateStudentByID")
public class UpdateStudentByID extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


		String url = "jdbc:mysql://localhost:3306/academy";
		String user = "root";
		String dbPassword = "pass111";
		String query = "Update students set studentName= ?, subject1=?, subject2=?, subject3=? where ID = ?;";
		
		response.setContentType("application/json");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		JSONObject json = new JSONObject();
		
		try {
			String studentId = request.getParameter("studentId");
			String updatedStudentName = request.getParameter("updatedStudentName");
			String updatedSub1Marks = request.getParameter("updatedSub1Marks");
			String updatedSub2Marks = request.getParameter("updatedSub2Marks");
			String updatedSub3Marks = request.getParameter("updatedSub3Marks");
			

			
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection(url, user, dbPassword);
			PreparedStatement st = con.prepareStatement(query);
			st.setString(1, updatedStudentName);
			st.setString(2, updatedSub1Marks);
			st.setString(3, updatedSub2Marks);
			st.setString(4, updatedSub3Marks);
			st.setString(5, studentId);
			
			int rs = st.executeUpdate();
			
			if(rs == 1) {
				json.put("status", "success");
				out.print(json);
				out.flush();
			}
			else {
				json.put("status", "failed");
				out.print(json);
				out.flush();
			}
	
		}
		catch(Exception e) {
			json.put("status", "failed");
			out.print(json);
			out.flush();
			e.printStackTrace();
		}
		
	}

}
