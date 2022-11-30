<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
     
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:import url="/jsp/header.jsp"></c:import>


<div id="layoutSidenav_content"><%-- close div of this open div at footer jsp --%>
<main>

<div align="center"><br>
    <h1>Xác nhận trước khi chuyển khoản</h1>
    <form action="/QuyTuThienVanTinh/ExecutePaymentServlet" method="post"> <%-- action="execute_payment" --%>
    <table>
        <tr>
            <td colspan="2"><b>Transaction Details:</b></td>
            <td>
                <input type="hidden" name="paymentId" value="${param.paymentId}" />
                <input type="hidden" name="PayerID" value="${param.PayerID}" />
            </td>
        </tr>
        <tr>
            <td>Đợt quyên góp:</td>
            <td>${transaction.description}</td>
        </tr>
        
        <%-- 
        <tr>
            <td>Subtotal:</td>
            <td>${transaction.amount.details.subtotal} USD</td>
        </tr>
        <tr>
            <td>Shipping:</td>
            <td>${transaction.amount.details.shipping} USD</td>
        </tr>
        <tr>
            <td>Tax:</td>
            <td>${transaction.amount.details.tax} USD</td>
        </tr>
        --%>
        
        <tr>
            <td>Total:</td>
            <td>${transaction.amount.total} USD</td>
        </tr>
        <tr><td><br/></td></tr>
        <tr>
            <td colspan="2"><b>Thông tin tài khoản</b></td>
        </tr>
        <tr>
            <td>First Name:</td>
            <td>${payer.firstName}</td>
        </tr>
        <tr>
            <td>Last Name:</td>
            <td>${payer.lastName}</td>
        </tr>
        <tr>
            <td>Email:</td>
            <td>${payer.email}</td>
        </tr>
        <tr><td><br/></td></tr>
        
        <%-- 
        <tr>
            <td colspan="2"><b>Shipping Address:</b></td>
        </tr>
        <tr>
            <td>Recipient Name:</td>
            <td>${shippingAddress.recipientName}</td>
        </tr>
        <tr>
            <td>Line 1:</td>
            <td>${shippingAddress.line1}</td>
        </tr>
        <tr>
            <td>City:</td>
            <td>${shippingAddress.city}</td>
        </tr>
        <tr>
            <td>State:</td>
            <td>${shippingAddress.state}</td>
        </tr>
        <tr>
            <td>Country Code:</td>
            <td>${shippingAddress.countryCode}</td>
        </tr>
        <tr>
            <td>Postal Code:</td>
            <td>${shippingAddress.postalCode}</td>
        </tr>
        --%>
        
        <tr>
            <td colspan="2" align="center">
                <input type="submit" value="Chuyển khoản" />
            </td>
        </tr>    
    </table>
    </form><br>
</div>
</main>

<c:import url="/jsp/footer.jsp"></c:import>