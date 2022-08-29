<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="/resources/member/style.css" rel="stylesheet" type="text/css">
</head>
<body>
	<br />
	<h1 align="center"> Main page </h1>
	
	<sec:authorize access="isAnonymous()">
	<table>
		<tr>
			<td><button onclick="window.location='/board/list'">게시판</button></td>
		</tr>
		<tr>
			<td><button onclick="window.location='/common/login'">로그인</button></td>
		</tr>
		<tr>
			<td><button onclick="window.location='/common/signup'">회원가입</button></td>
		</tr>
	</table>
	</sec:authorize>
	
	<sec:authorize access="isAuthenticated()">
	<table>
		<tr>
			<td><button onclick="window.location='/board/list'">게시판</button></td>
		</tr>
		<tr>
			<td><button onclick="window.location='/member/logout'">로그아웃</button></td>
		</tr>
		<tr>
			<td><button onclick="window.location='/member/mypage'">마이페이지</button></td>
		</tr>
	</table>
	</sec:authorize>
	
	<br /><br />
	<div align="center">
		<img src="/resources/member/imgs/beach.jpg" width="500" />
	</div>
	<br /><br />
	
</body>
</html>