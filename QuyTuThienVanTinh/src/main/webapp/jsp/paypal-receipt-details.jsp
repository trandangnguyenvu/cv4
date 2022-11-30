<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
     
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:import url="/jsp/header.jsp"></c:import>


<div id="layoutSidenav_content"><%-- close div of this open div at footer jsp --%>
    <main>
    <div align="center"><br>
    <h1>Cảm ơn bạn đã dành lòng hảo tâm quyên góp cho dự án thiện nguyện của chúng tôi</h1>
    <br/>
    <h2>Receipt Details:</h2>
    <table>
        <tr>
            <td><b>Charity fund:</b></td>
            <td>Quỹ từ thiện Vạn tình.</td>
        </tr>
        <tr>
            <td><b>Payer:</b></td>
            <td>${payer.firstName} ${payer.lastName}</td>      
        </tr>
        <tr>
            <td><b>Đợt quyên góp:</b></td>
            <td>${transaction.description}</td>
        </tr>
        
        <%-- 
        <tr>
            <td><b>Subtotal:</b></td>
            <td>${transaction.amount.details.subtotal} USD</td>
        </tr>
        <tr>
            <td><b>Shipping:</b></td>
            <td>${transaction.amount.details.shipping} USD</td>
        </tr>
        <tr>
            <td><b>Tax:</b></td>
            <td>${transaction.amount.details.tax} USD</td>
        </tr>
        --%>
        
        <tr>
            <td><b>Total:</b></td>
            <td>${transaction.amount.total} USD</td>
        </tr>                   
    </table><br> 
    </div>
    </main>


<%-- TEST
<div>
	<p>result: ${kq }</p>
	<p>usr: ${usr }</p>
	<p>donation round: ${dr }
</div>
--%>

<c:import url="/jsp/footer.jsp"></c:import>