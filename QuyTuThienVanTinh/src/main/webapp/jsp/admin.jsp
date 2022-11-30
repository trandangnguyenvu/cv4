<%-- show screen of donation rounds manager (intended for admin with a donation round create/edit/delete buttons) --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<c:import url="/jsp/header.jsp"></c:import>

<c:choose>
	<c:when test="${sqlExcutionStatus == 'done' }"> <%-- this attribute was set as servlet QueryAtAdminForm --%>
		<script>
			alert("Lệnh đã được thực thi thành công");
		</script>
	</c:when>
	
	<c:when test="${sqlExcutionStatus == 'fail' }">
		<script>
			alert("Việc thực thi yêu cầu của bạn đã thất bại, vui lòng thử lại");
		</script>
	</c:when>
</c:choose>

<c:import url="/jsp/body-admin.jsp"></c:import>
<c:import url="/jsp/footer.jsp"></c:import>
