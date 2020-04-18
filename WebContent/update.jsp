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
<link rel="stylesheet" href="css/bootstrap.min.css">
<link rel="stylesheet" href="mainstyle.css">
<title>Buk-web</title>

<script>
function checkout(){
	event.returnValue = "수정하신 내용은 저장되지 않습니다. 정말 나가시겠습니까?";
}
</script>

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
<body onbeforeunload="checkout();">


 

	<%
		//로긴한사람이라면	 userID라는 변수에 해당 아이디가 담기고 그렇지 않으면 null값
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		if (userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인이 필요합니다.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
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
		if (!userID.equals(bbs.getUserID())) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href = 'BBS.jsp'");
			script.println("</script>");
		}
		
		
	%>

	<!-- 네비게이션  -->
		<%
			if(session.getAttribute("userID").equals("Admin")){
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
			<form method="post" action="updateAction.jsp?bbsID=<%= bbsID %>">
				<table class="table table-striped"
					style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="2"
								style="background-color: #eeeeee; text-align: center;">글 수정
								</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><input type="text" class="form-control"
								placeholder="글 제목" name="bbsTitle" maxlength="50" value = "<%= bbs.getBbsTitle().replaceAll(" ", "&nbsp;")%>"/></td>
						</tr>
						<tr>
							<td><textarea class="form-control" placeholder="글 내용"
									name="bbsContent" maxlength="2048" style="height: 350px;"><%= bbs.getBbsContent().replaceAll(" ", "&nbsp;")%></textarea></td>
						</tr>
					</tbody>
				</table>
				<input type="submit" class="btn btn-primary pull-right" value="글 수정" />
			</form>
		</div>
	</div>

	<!-- 애니매이션 담당 JQUERY -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>


	<!-- 부트스트랩 JS  -->
	<script src="js/bootstrap.js"></script>



</body>
</html>

