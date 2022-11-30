<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
     
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:import url="/jsp/header.jsp"></c:import>


<%
// for AuthorizePaymentServlet will take
if (session.getAttribute("loginAccount") != null ) {
	session.setAttribute("loginAccount", session.getAttribute("loginAccount")); // for login if already login
}
%>

    

        <div id="layoutSidenav_content"><%-- close div of this open div at footer jsp --%>
            <main>
                <div class="container-fluid px-4">
                    <div style="width: 65%; margin-left: auto; margin-right: auto;"> <%--  --%>
                        <%-- <p class="mt-4 navbar-brand ps-3" style="font-weight: bold;color: blue;text-align: center;">Quỹ từ thiện Vạn tình</p> --%>
                        <h2 class="mt-4" style="text-align: center;">Kiểm tra thông tin quyên góp</h2>
                        <c:choose>
                        	<c:when test="${loginAccount != null }">
                        		<p>Người quyên góp: ${loginAccount.getAccount() } (${loginAccount.getLastName()} ${loginAccount.getName() })</p>
                        	</c:when>
                        	<c:otherwise>
                        		<p>Người quyên góp: anonymous</p>
                        	</c:otherwise>
                        </c:choose>  
                        
                        <%--                       
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item"><a href="index.html">Trang chủ</a></li>
                            <li class="breadcrumb-item"><a href="index.html">Tạo một tài khoản mới</a></li>
                            <!-- <li class="breadcrumb-item active"></li> -->
                        </ol>
                        --%>
                    </div>

                    <div  class="card mb-4" style="width: 65%; margin-left: auto; margin-right: auto;"> <%-- class="card mb-4" --%>
                        <!-- CUSTOMER STYLE-->


                        <div class="card-body">
							<form action="/QuyTuThienVanTinh/AuthorizePaymentServlet" method="post"> <%-- action="authorize_payment" --%>							                            
                            	<!--  <input type="hidden" name="action" value="login">  -->
                            	
                            	<input type="hidden" name="donationId" value="${param.donationId}">
                            	
                            	<input  type="hidden"  name="subtotal" class="form-control" value="0" >
                            	<input  type="hidden"  name="shipping" class="form-control" value="0" >
                            	<input  type="hidden"  name="tax" class="form-control" value="0" >
                            	
                                <div class="col-md-12">
                                    <!-- col-md-6 -->
                                    <label for="n" class="form-label"><b>Đợt quyên góp:</b></label>
                                    <p><strong><i>${param.donationName }</i></strong></p>
                                    <input  type="hidden"  name="donationName" class="form-control" value="${param.donationName }" >
                                                         
                                    <div class="form-text account-message"></div>
                                </div>
                                <br>



                                <div class="col-md-12">                                   
                                    <label for="m" class="form-label"><b>Số tiền quyên góp:</b></label>
                                    <input type="number" id="m" name="money" class="form-control" placeholder="Vui lòng chỉ nhập chữ số" >
                                    <div align="right"><span> USD</span></div>
                                    
                                    <div class="form-text pass-message"></div>
                                </div>
                                <br>


                                <div class="col-12">
                                    <button class="btn btn-primary" type="submit">Quyên góp</button>
                                </div>
                                
                                <!--  
                                <div>
									<h6 style='margin: 0px; padding: 0px; color: red;'
										class='nav-link'>
										<i> <c:if test="${errormessage != null}">
											<c:out value="${errormessage}"></c:out>
										</c:if>
										</i>
									</h6>
								</div>
								-->
								
                            </form>



                        </div>
                    </div>

                </div>
            </main>            
            
<c:import url="/jsp/footer.jsp"></c:import>