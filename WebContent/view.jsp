<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="BBS.Bbs"%>
<%@ page import="BBS.BbsDAO"%>

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
		int bbsID = 0;
		if (request.getParameter("bbsID") != null) {
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		if (bbsID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글 입니다.')");
			script.println("location.href = 'BBS.jsp'");
			script.println("</script>");
		}
		Bbs bbs = new BbsDAO().getBbs(bbsID);
	%>

		<!-- 네비게이션  -->
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
			<table class="table table-striped"
				style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="3"
							style="background-color: #eeeeee; text-align: center;">게시판 글
							보기</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width: 20%;">글 제목</td>
						<td colspan="2"><%=bbs.getBbsTitle().replaceAll(" ", "&nbsp;")%></td>
					</tr>
					<tr>
						<td>작성자</td>
						<td colspan="2"><%=bbs.getUserID()%></td>
					</tr>
					<tr>
						<td>작성 일자</td>
						<td colspan="2"><%=bbs.getBbsDate().substring(0, 11) + bbs.getBbsDate().substring(11, 13) + "시"
					+ bbs.getBbsDate().substring(14, 16) + "분"%></td>
					</tr>
					<tr>
						<td>내용</td>
						<td colspan="2" style="min-height: 200px; text-align: left"><%=bbs.getBbsContent().replaceAll(" ", "&nbsp;").replaceAll("\n","<br>")%></td>
					</tr>
				</tbody>
			</table>
			<a href="BBS.jsp" class="btn btn-primary">목록</a>
			<%
				if (userID != null && userID.equals(bbs.getUserID())) {
			%>
			<a href="update.jsp?bbsID=<%=bbsID%>" class="btn btn-primary">수정</a>
			 <a onclick="return confirm('정말로 삭제하시겠습니까?')" href="deleteAction.jsp?bbsID=<%=bbsID%>" class="btn btn-primary">삭제</a>

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

