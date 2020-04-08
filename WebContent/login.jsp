<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
<title>Buk-web Login page</title>

<link rel="stylesheet" href="style.css">

</head>

<body>
	<form class="box" action="loginAction.jsp" method="post">
		<h1>로그인</h1>
		<input type="text" placeholder="아이디" name="userID" maxlength="20">
		<input type="password" placeholder="패스워드" name="userPassword"
			maxlength="20"> <input type="submit" value="로그인">
		<button type="button" onclick="location.href='join.jsp'">회원가입</button>
	</form>
</body>

</html>