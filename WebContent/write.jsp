<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.io.PrintWriter"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<!-- 뷰포트 -->
<meta name="viewport" content="width=device-width">

<!-- 스타일시트 참조  -->
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="mainstyle.css">
<title>Buk-web</title>
<style type="text/css">
.nav-item:nth-child(1) {
	background-color: lightseagreen;
}

.alpha a, .alpha a:hover {
	color: #000000;
	text-decoration: none;
}
</style>
</head>
<body>

	<%
		//로긴한사람이라면	 userID라는 변수에 해당 아이디가 담기고 그렇지 않으면 null값
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
	%>

	<!-- 네비게이션  -->
	<%
		if (userID == null) {
	%>
	<nav style="padding-top: 65px;">
		<ul class="nav-container">
			<li class="nav-item"><a href="BBS.jsp">건의함 </a></li>
			<li class="nav-item"><a href="NOTICE.jsp">공지사항 </a></li>
			<li class="nav-item"><a href="login.jsp">로그인</a></li>
		</ul>
		</nav>
		<%
			}else if(session.getAttribute("userID").equals("Admin")){
		%>
			<nav style="padding-top: 65px;">
		<ul class="nav-container">
			<li class="nav-item"><a href="BBSA.jsp">건의함 </a></li>
			<li class="nav-item"><a href="NOTICE.jsp">공지사항 </a></li>
			<li class="nav-item"><a href="logoutAction.jsp">로그아웃</a></li>
		</ul>
		</nav>
				<%
			} else {
		%>
		<nav style="padding-top: 65px;">
			<ul class="nav-container">
				<li class="nav-item"><a href="BBS.jsp">건의함 </a></li>
				<li class="nav-item"><a href="NOTICE.jsp">공지사항 </a></li>
				<li class="nav-item"><a href="logoutAction.jsp">로그아웃</a></li>
			</ul>
			</nav>
			<%
				}
			%>


	<!-- 게시판 -->
	<div class="container">
		<div class="row">
			<% 
		if(session.getAttribute("userID") != null && !session.getAttribute("userID").equals("Admin")){
		%>
			<form method="post" action="writeAction.jsp">
				<table class="table table-striped"
					style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="2"
								style="background-color: #eeeeee; text-align: center;">게시판
								글 쓰기</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><input type="text" class="form-control"
								placeholder="글 제목" name="bbsTitle" maxlength="50" /></td>
						</tr>
						<tr>
							<td><textarea class="form-control" placeholder="글 내용"
									name="bbsContent" maxlength="2048" style="height: 350px;"></textarea></td>
						</tr>
					</tbody>
				</table>
				<input type="submit" class="btn btn-primary pull-right" value="글쓰기" />
			</form>
			<%
		}
		if(session.getAttribute("userID").equals("Admin")){
		%>
			<form method="post" action="writeActionn.jsp">
				<table class="table table-striped"
					style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="2"
								style="background-color: #eeeeee; text-align: center;">공지사항
								글쓰기</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><input type="text" class="form-control"
								placeholder="글 제목" name="noticeTitle" maxlength="50" /></td>
						</tr>
						<tr>
							<td><textarea class="form-control" placeholder="글 내용"
									name="noticeContent" maxlength="2048" style="height: 350px;"></textarea></td>
						</tr>
					</tbody>
				</table>
				<input type="submit" class="btn btn-primary pull-right" value="글쓰기" />
			</form>
			<%
		}
			%>
		</div>
	</div>









	<!-- 애니매이션 담당 JQUERY -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>

	<!-- 부트스트랩 JS  -->
	<script src="js/bootstrap.js"></script>



</body>
</html>

