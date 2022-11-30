<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>



<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>Quên mật khẩu</title>
    <link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/resources/css/styles.css" rel="stylesheet" />
    <script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>


</head>

<body class="sb-nav-fixed">
    	<div class="container-fluid px-4" style="text-align: center;font-weight: bold;">
    		<br>
        	<a class="navbar-brand ps-3" href="index.html" >Quỹ từ thiện Vạn tình</a>
      	</div>  
            <main>
                <div class="container-fluid px-4">
                    <h2 class="mt-4">Quên mật khẩu?</h2>
                    <ol class="breadcrumb mb-4">
                        <li class="breadcrumb-item"><a href="/QuyTuThienVanTinh/Controller">Trang chủ</a></li>
                        <!-- <li class="breadcrumb-item active"></li> -->
                    </ol>

                    <div class="card mb-4">
                        <div class="card-body">



                            <form class="row g-3" id="form" action="/QuyTuThienVanTinh/QueryAtUser?action=forgotpass" method="post">
                            	<input type="hidden" name="action" value="forgotpass"> <%-- không có cái này => action sẽ null --%>
								
                            
                                <div class="col-md-6">
                                    <label for="us" class="form-label">Tên tài khoản</label>  
                                    <c:choose>
                                    	<c:when test="${saccount != null && saccount != '' }"> <!-- AdminForm servlet return "" of value of session attribute "saccount" ; QueryAtAdminUser servlet return value from database (assign to variable "acc" at body-admin-form-edit.jsp)   -->
                                    		<input type="text" id="us" name="usr" class="form-control" value="${saccount }" >
                                    	</c:when>   
                                    	<c:otherwise>
                                    		<input type="text" id="us" name="usr" class="form-control" placeholder="Nhập tên Tài khoản"><%-- required ; id="user" id must be different for locking javascript --%> 
                                    	</c:otherwise>                                 
                                    </c:choose>                                
                                    <div class="form-text account-message"></div>
                                </div>
                                
                                <div class="col-md-6">
                                    <label for="email" class="form-label">Email</label>
                                    <c:choose>
                                    	<c:when test="${semail != null && semail != '' }">
                                    		<input type="text" name="mail" class="form-control" id="email" value="${semail }" ><%-- required type="email" --%>
                                    	</c:when>
                                    	<c:otherwise>
                                    		<input type="text" name="mail" class="form-control" id="email" placeholder="Nhập địa chỉ email"><%-- required type="email" --%>
                                    	</c:otherwise>
                                    </c:choose>                                    
                                    <div class="form-text email-message"></div>
                                </div>
                                


                                
                                <div class="col-12">
                                    <table>

										<tr>
											<td style="width: 100px"><button class="btn btn-primary"
													type="submit" id="send">Gửi</button></td>
											<td><button class="btn btn-primary" type="button" onclick="location.href='/QuyTuThienVanTinh/Controller';">Hủy</button></td>
										</tr> <%-- ${pageContext.request.contextPath}/jsp/admin-user.jsp --%>

									</table>
                                </div>
                                <div>
									<h6 style='margin: 0px; padding: 0px; color: red;'
										class='nav-link'>
										<i> <c:if test="${errormessage != null}">
											<c:out value="${errormessage}"></c:out>
										</c:if>
										</i>
									</h6>
								</div>
                            </form>



                        </div>
                    </div>

                </div>
            </main>
            <footer class="py-4  mt-auto"> <%-- bg-light --%>
                
            </footer>
        </div>
    </div>
    <script
  src="https://code.jquery.com/jquery-3.6.1.min.js"
  integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ="
  crossorigin="anonymous"></script> <!-- JQUERY LIBRARY -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
        ></script> <!--crossorigin="anonymous"-->
    <script src="js/scripts.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest" crossorigin="anonymous"></script>
    <script src="js/datatables-simple-demo.js"></script>

    <!--<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>-->
    <!--<script src="${pageContext.request.contextPath}/resources/js/password-confirm-show.js"></script>-->
    <script src="${pageContext.request.contextPath}/resources/js/password-show.js"></script>
</body>

</html>