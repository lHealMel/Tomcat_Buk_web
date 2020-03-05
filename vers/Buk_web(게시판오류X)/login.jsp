<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<title>Buk_web test site</title>

<link rel="stylesheet" href="style.css">
</head>

<body>
	<form class="box" action="loginAction.jsp" method="post">
		<h1>Login</h1>
		<input type="text" placeholder="Username" name="userID" maxlength="20">
		<input type="password" placeholder="Password" name="userPassword"
			maxlength="20"> <input type="submit" value="Login">
		<button type="button" onclick="location.href='join.jsp'">Sign Up</button>
	</form>
</body>

</html>