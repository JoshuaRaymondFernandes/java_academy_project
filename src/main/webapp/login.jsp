<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login Page</title>

<script type="text/javascript">
	function Captcha() {
		var alpha = new Array('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J',
				'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V',
				'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h',
				'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't',
				'u', 'v', 'w', 'x', 'y', 'z');
		var i;
		for (i = 0; i < 6; i++) {
			var a = alpha[Math.floor(Math.random() * alpha.length)];
			var b = alpha[Math.floor(Math.random() * alpha.length)];
			var c = alpha[Math.floor(Math.random() * alpha.length)];
			var d = alpha[Math.floor(Math.random() * alpha.length)];
			var e = alpha[Math.floor(Math.random() * alpha.length)];
			var f = alpha[Math.floor(Math.random() * alpha.length)];
			var g = alpha[Math.floor(Math.random() * alpha.length)];
		}
		var code = a + ' ' + b + ' ' + ' ' + c + ' ' + d + ' ' + e + ' ' + f
				+ ' ' + g;
		document.getElementById("mainCaptcha").value = code
	}
	function ValidCaptcha() {
		var string1 = removeSpaces(document.getElementById('mainCaptcha').value);
		var string2 = removeSpaces(document.getElementById('txtInput').value);
		if (string1 == string2) {
			var bt = document.getElementById('submit_button');
			bt.disabled = false;
		} else {
			Captcha();
			document.getElementById('txtInput').value = "";
			alert("Invalid Captcha");
		}
	}
	function removeSpaces(string) {
		return string.split(' ').join('');
	}
</script>
</head>
<body onload="Captcha();">
	<h1>Login Page</h1>

	<form action="login" method="post">

		Enter Username : <input type="text" name="username"><br>
		Enter Password : <input type="password" name="password"><br>

		<p>User Type</p>
		<input type="radio" id="admin" name="user_type" value="admin">
		<label for="html">Admin</label><br> 
		<input type="radio" id="faculty" name="user_type" value="faculty"> 
		<label for="css">Faculty</label><br> 
		<input type="radio" id="associate" name="user_type" value="associate"> 
		<label for="javascript">Associate</label>
		
		<table>
		<tr>
			<td>Text Captcha<br />
			</td>
		</tr>
		<tr>
			<td><input type="text" id="mainCaptcha" disabled/> 
			<input type="button" id="refresh" value="Refresh" onclick="Captcha();" /></td>
		</tr>
		<tr>
			<td><input type="text" id="txtInput" /></td>
		</tr>
		<tr>
			<td><input id="Button1" type="button" value="Check"
				onclick="ValidCaptcha();" /></td>
		</tr>
		</table>
		
		<br>
		<input type="submit" value="Login" id="submit_button" >

	</form>



</body>
</html>