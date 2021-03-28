<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="BBS.BbsDAO"%>
<%@ page import="BBS.Bbs"%>
<%@ page import="java.util.ArrayList"%>
<%@ page contentType="text/html; charset=UTF-8" errorPage="error.jsp"%>


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

.alpha a, .alpha a:hover {
	color: #000000;
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
		/*if (userID != null && session.getAttribute("userID").equals("Admin")){	
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'BBSA.jsp'");
			script.println("</script>");
		}else*/
	%>

	<!-- 네비게이션  -->
	<nav style="padding-top: 65px;">
		<ul class="nav-container">
			<li class="nav-item"><a href="NOTICE.jsp">공지사항 </a></li>
			<%
				if(userID == null) {
			%>
			<li class="nav-item"><a href="BBS.jsp">건의함 </a></li>
			<li class="nav-item"><a href="login.jsp">로그인</a></li>
			<%
				}else if(userID != null && session.getAttribute("userID").equals("Admin")){
			%>
			<li class="nav-item"><a href="BBSA.jsp">건의함 </a></li>
			<li class="nav-item"><a href="logoutAction.jsp">로그아웃</a></li>
			<%
				}else if(userID != null){
			%>
			<li class="nav-item"><a href="BBS.jsp">건의함 </a></li>
			<li class="nav-item"><a href="logoutAction.jsp">로그아웃</a></li>
			<%
				}
			%>
			<li class="nav-item"><a href="JavaScript:window.location.reload()">새로고침</a></li>
		</ul>
	</nav>


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
					<tr>
						<td class="alpha" align="left" width="40%"><a
							href="viewn.jsp?noticeID=1" style="color: red"> ＜건의함 이용수칙＞ </a></td>
						<td width="30%">Admin</td>
						<td width="30%">2020-04-04</td>
					</tr>
					<%
						BbsDAO bbsDAO = new BbsDAO();
						ArrayList<Bbs> list = bbsDAO.getList(pageNumber, userID);
						for (int i = 0; i < list.size(); i++) {
					%>
					<tr>
						<td class="alpha" align="left" width="40%"><a
							href="view.jsp?bbsID=<%=list.get(i).getBbsID()%>"><%=list.get(i).getBbsTitle().replaceAll(" ", "&nbsp;")%></a></td>
						<td width="30%"><%=list.get(i).getUserID()%></td>
						<td width="30%"><%=list.get(i).getBbsDate().substring(0, 11)%></td>
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
			<a href="BBS.jsp?pageNumber=<%=pageNumber - 1%>"
				class="btn btn-success btn-arrow-left">이전</a>
			<%
				}
				if (bbsDAO.nextPage(pageNumber + 1)) {
			%>
			<a href="BBS.jsp?pageNumber=<%=pageNumber + 1%>"
				class="btn btn-success btn-arrow-left">다음</a>
			<%
				}
			%>

			<!-- 회원만넘어가도록 -->
			<%
				//if logined userID라는 변수에 해당 아이디가 담기고 if not null
				if (session.getAttribute("userID") != null) {
					if (session.getAttribute("userID").equals("Admin")) {
			%>
			<button class="btn btn-primary pull-right"
				onclick="if(alert('관리자 계정으로는 사용 불가능한 기능입니다.')); location.href='BBS.jsp';"
				type="button">글쓰기</button>
			<%
				} else {
			%>

			<a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
			<%
				}
				} else {
			%>
			<button class="btn btn-primary pull-right"
				onclick="if(alert('로그인 하세요')); location.href='login.jsp';"
				type="button">글쓰기</button>
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