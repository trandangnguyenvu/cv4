<%-- show screen of create/edit form about an user (intended for admin) --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>





<c:import url="/jsp/header.jsp"></c:import>

	<c:choose>
		<c:when test="${param.account == null || param.account == ''}"><!-- account là parameter => chạy admin-user-form.jsp thì sẽ chạy body-admin-form-create mà không phải phiên bản edit -->		
			<c:import url="/jsp/body-admin-user-form-create.jsp"></c:import>
		</c:when>

		<c:otherwise>
			<c:import url="/jsp/body-admin-user-form-edit.jsp"></c:import>
		</c:otherwise>
	</c:choose>

<c:import url="/jsp/footer.jsp"></c:import>
