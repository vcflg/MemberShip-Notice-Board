<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>MemberShip Notice Board</title>
</head>
<body>
	<%
		session.invalidate();	
		
	%>
	
	<script>
		location.href = 'bbs.jsp';
	</script>

</body>
</html>





