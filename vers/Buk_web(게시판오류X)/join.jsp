<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<title>Buk_web Sign Up page</title>

<link rel="stylesheet" href="style.css">
</head>

<body>
	<form class="box" action="joinAction.jsp" method="post">
		<h1>Sign Up</h1>
		<input type="text" placeholder="UserID" name="userID" maxlength="20">
		<input type="password" placeholder="Password" name="userPassword" maxlength="20">
			 <input type="text" placeholder="Username" name="userName" maxlength="20"> 
			<input type="submit" value="Sign Up">
	</form>
</body>

</html>