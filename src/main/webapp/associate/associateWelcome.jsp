<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<h1>Associate Welcome</h1>
<h2>Welcome ${username}</h2>

	<%
		response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
		response.setHeader("Pragma", "no-cache");
		response.setHeader("Expires", "0");
		if(session.getAttribute("username") == null){
			response.sendRedirect("/training_platform/login.jsp");
		}
	%>

<form action="/training_platform/logout">
	<input type="submit" value="Logout">
</form>

</body>
</html>