<%-- show screen of create/edit form about an user (intended for admin) --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>



<c:import url="/jsp/header.jsp?header=index"></c:import><%-- ?header=index => only  header of index has search input --%>

<c:choose>
	<c:when test="${sqlExcutionStatus == 'done' }">
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

<c:import url="/jsp/body-index.jsp"></c:import>
<c:import url="/jsp/footer.jsp"></c:import>