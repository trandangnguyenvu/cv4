<%-- show screen of users manager (intended for admin with an user create/edit/delete buttons) --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>



<!-- direct search bar of header.jsp to controller QueryAtAdminUser (account searching), not QueryAtAdminForm (donation round searching) -->
<c:set scope="session" var="psearchuser" value="ptrue"></c:set><!-- "page" not working => "session" -->
<c:import url="/jsp/header.jsp"></c:import>
<%-- <c:set scope="session" var="psearchuser" value=""> --%>





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
	
	<c:when test="${param.alert == 'admin' }"> <%-- this param was set as jsp body-admin-user --%>
		<script>
			alert("Bạn không thể xóa một Tài khoản là Admin");
		</script>
	</c:when>
</c:choose>

<c:import url="/jsp/body-admin-user.jsp"></c:import>
<c:import url="/jsp/footer.jsp"></c:import>