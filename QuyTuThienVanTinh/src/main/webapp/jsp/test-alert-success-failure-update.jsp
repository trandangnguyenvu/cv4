<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<%-- function "update" (at QueryAtUser.java servlet controller) will come here --%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%= session.getAttribute("alert-update") %>
<br>

<%
if (session.getAttribute("fail") != null) {
out.print("thất bại");
} else {
out.print("thành công");	
}
%>
<br>

<c:choose>
<c:when test="${fail != null }">
<c:out value="THẤT BẠI"></c:out>
</c:when>
<c:otherwise>
<c:out value="THÀNH CÔNG"></c:out>
</c:otherwise>
</c:choose>

<br>
<c:out value="${alert-update }"></c:out>

</body>
</html>()