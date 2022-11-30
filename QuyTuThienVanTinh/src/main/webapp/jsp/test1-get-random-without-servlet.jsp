<%@page import="model.RandomString"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%-- just run this jsp --%>
<%
RandomString r = new RandomString();

String rS = r.getSaltString();

out.print(rS);
%>

</body>
</html>
