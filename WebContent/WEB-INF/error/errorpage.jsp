<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="errorstyle.css">
<title>ERROR!</title>
</head>
<body>
    <div align="center"><h1>에러가 발생했습니다.</h1></div>
    <c:if test="${requestScope['javax.servlet.error.status_code'] == 400}">
        <div align="center"><p>400 에러가 발생했습니다. 관리자에게 문의해 주세요.</p></div>
    </c:if>
    <c:if test="${requestScope['javax.servlet.error.status_code'] == 403}">
        <div align="center"><p>403 에러가 발생했습니다. 관리자에게 문의해 주세요.</p></div>
    </c:if>
    <c:if test="${requestScope['javax.servlet.error.status_code'] == 404}">
        <div align="center"><p>404 에러가 발생했습니다. 관리자에게 문의해 주세요.</p></div>
    </c:if>
    <c:if test="${requestScope['javax.servlet.error.status_code'] == 405}">
        <div align="center"><p>405 에러가 발생했습니다. 관리자에게 문의해 주세요.</p></div>
    </c:if>
    <c:if test="${requestScope['javax.servlet.error.status_code'] == 500}">
        <div align="center"><p>500 에러가 발생했습니다. 관리자에게 문의해 주세요.</p></div>
    </c:if>
    <c:if test="${requestScope['javax.servlet.error.status_code'] == 503}">
        <div align="center"><p>503 에러가 발생했습니다. 관리자에게 문의해 주세요.</p></div>
    </c:if>

</body>
</html>