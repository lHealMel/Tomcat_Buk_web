<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="NOTICE.NoticeDAO"%>
<%@ page import="NOTICE.Notice"%>
<%@ page import="java.util.ArrayList"%>


<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<!-- 뷰포트 -->
<meta name="viewport" content="width=device-width">

<!-- 스타일시트 참조  -->
<link rel="stylesheet" href="css/bootstrap.min.css">
<link rel="stylesheet" href="mainstyle.css">
<title>Buk-web</title>
<style type="text/css">
.nav-item:nth-child(2) {
	background-color: lightseagreen;
}
.alpha a, .alpha a:hover{
	color: #ff0000;
	text-decoration: none;
}
</style>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		int pageNumber = 1; //기본 페이지 넘버
		//페이지넘버값이 있을때
		if (request.getParameter("pageNumber") != null) {
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
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


   <!-- 게시판  -->
	<div class="container">
		<div class="row">
			<table class="table table-striped"
				style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th width="40%"
							style="backgorund-color: #eeeeee; text-align: center;">제목</th>
						<th width="30%"
							style="backgorund-color: #eeeeee; text-align: center;">작성자</th>
						<th width="30%"
							style="backgorund-color: #eeeeee; text-align: center;">작성일</th>
					</tr>
				</thead>
				<tbody>
					<%
						NoticeDAO noticeDAO = new NoticeDAO();
						ArrayList<Notice> list = noticeDAO.getList(pageNumber);
						for (int i = 0; i < list.size(); i++) {
					%>
					<tr>
						<td class="alpha" align="left" width="40%"><a
							href="viewn.jsp?noticeID=<%=list.get(i).getNoticeID()%>"><%=list.get(i).getNoticeTitle().replaceAll(" ", "&nbsp;")%></a></td>
						<td width="30%"><%=list.get(i).getUserID()%></td>
						<td width="30%"><%=list.get(i).getNoticeDate().substring(0, 11)%></td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>

			<!-- 페이지 넘기기 -->
			<%
				if (pageNumber != 1) {
			%>
			<a href="NOTICE.jsp?pageNumber=<%=pageNumber - 1%>"
				class="btn btn-success btn-arrow-left">이전</a>
			<%
				}
				if (noticeDAO.nextPage(pageNumber + 1)) {
			%>
			<a href="NOTICE.jsp?pageNumber=<%=pageNumber + 1%>"
				class="btn btn-success btn-arrow-left">다음</a>
			<%
				}
				if (session.getAttribute("userID") != null) {
					//만약 userID가 Admin이라면 글쓰기 버튼 노출
					if (session.getAttribute("userID").equals("Admin")) {
			%>
			<a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
			<%
				}
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