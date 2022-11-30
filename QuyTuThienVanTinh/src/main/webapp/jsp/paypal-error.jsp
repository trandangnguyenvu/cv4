<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
     
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:import url="/jsp/header.jsp"></c:import>


<div id="layoutSidenav_content"><%-- close div of this open div at footer jsp --%>
<main>
<div align="center"><br>
    <h1>Payment Error</h1>
    <br/>
    <h3>${paypalErrorMessage}</h3>
    <br/>
</div>
</main>

<c:import url="/jsp/footer.jsp"></c:import>