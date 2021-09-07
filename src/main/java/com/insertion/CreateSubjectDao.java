package com.insertion;

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


@WebServlet("/CreateSubject")
public class CreateSubjectDao extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		String url = "jdbc:mysql://localhost:3306/academy";
		String user = "root";
		String dbPassword = "pass111";
		String query = "INSERT INTO `subjects` (`subjectName`, `Hours`) VALUES (?, ?)";
		
		response.setContentType("application/json");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		JSONObject json = new JSONObject();
		
		try {
			String subjectName = request.getParameter("subjectName");
			String hoursLength = request.getParameter("hoursLength");
			
			
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection(url, user, dbPassword);
			PreparedStatement st = con.prepareStatement(query);
			st.setString(1, subjectName);
			st.setString(2, hoursLength);
			
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
