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
    <title>Đăng nhập</title>
    <link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/resources/css/styles.css" rel="stylesheet" />
    <script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>


</head>

<body class="sb-nav-fixed">

    <div>

        <div id="layoutSidenav_content">
            <main>
                <div class="container-fluid px-4">
                    <div style="width: 400px; margin-left: auto; margin-right: auto;"> <%--  --%>
                        <p class="mt-4 navbar-brand ps-3" style="font-weight: bold;color: blue;text-align: center;">Quỹ từ thiện Vạn tình</p>
                        <h2 class="mt-4" style="text-align: center;">Trang đăng nhập tài khoản</h2>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item"><a href="/QuyTuThienVanTinh/Controller">Trang chủ</a></li>
                            <li class="breadcrumb-item"><a href="/QuyTuThienVanTinh/Controller?action=register">Tạo một tài khoản mới</a></li>
                            <!-- <li class="breadcrumb-item active"></li> -->
                        </ol>
                    </div>

                    <div  class="card mb-4" style="width: 400px; margin-left: auto; margin-right: auto;"> <%-- class="card mb-4" --%>
                        <!-- CUSTOMER STYLE-->


                        <div class="card-body">

							<c:choose>
								<c:when test="${param.afteraction == 'useredit' }">
									<form class="row g-3" action="/QuyTuThienVanTinh/QueryAtUser?action=login&afteraction=useredit" method="post">
									<input type="hidden" name="afteraction" value="useredit">
								</c:when>
								
								<c:when test="${param.afteraction == 'aftchangepass' }">
									<form class="row g-3" action="/QuyTuThienVanTinh/QueryAtUser?action=login&afteraction=aftchangepass" method="post"><%-- &account=${saccount } --%>
									<input type="hidden" name="afteraction" value="aftchangepass">
									<%-- <input type="hidden" name="account" value="${saccount }"> --%>
								</c:when>
								
								<c:otherwise>
									<form class="row g-3" action="/QuyTuThienVanTinh/QueryAtUser?action=login" method="post">
								</c:otherwise>
							</c:choose>                            
                            	<input type="hidden" name="action" value="login">
                                <div class="col-md-12">
                                    <!-- col-md-6 -->
                                    <label for="inputEmail4" class="form-label">Tên tài khoản</label>
                                    <c:choose>
                                    	<c:when test="${saccount != null && saccount != '' }"> <!-- AdminForm servlet return "" of value of session attribute "saccount" ; QueryAtAdminUser servlet return value from database (assign to variable "acc" at body-admin-form-edit.jsp)   -->
                                    		<input type="text" id="us" name="usr" class="form-control" value="${saccount }" >
                                    	</c:when>   
                                    	<c:otherwise>
                                    		<input type="text" id="us" name="usr" class="form-control" placeholder="Nhập tên Tài khoản"><!--required ; id="user" id must be different for locking javascript--> 
                                    	</c:otherwise>                                 
                                    </c:choose>                                
                                    <div class="form-text account-message"></div>
                                </div>



                                <div class="col-md-12">
                                    <!-- col-md-6 -->
                                    <!--<label for="inputPassword4" class="form-label">Password</label>
                                    <input type="password" class="form-control" id="inputPassword4" required>
                                    -->
                                    <label for="password" class="form-label">Mật khẩu</label>
                                    <c:choose>
                                    	<c:when test="${spass != null && spass != '' }">
                                    		<input type="password" class="form-control" id="password" name="psw"
                                        >
                                        <%-- required 
                                        pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*]).{8,}"
                                        title="Mật khẩu phải chứa ít nhất 1 chữ số, 1 chữ cái viết hoa, 1 chữ cái thường, 1 ký tự đặc biệt và ít nhất 8 ký tự trở lên"
                                        --%>
                                    	</c:when>
                                    	<c:otherwise>
                                    		<input placeholder="Nhập vào đây Mật khẩu của bạn" type="password" class="form-control" id="password" name="psw"
                                        >
                                        <%-- required 
                                        pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*]).{8,}"
                                        title="Mật khẩu phải chứa ít nhất 1 chữ số, 1 chữ cái viết hoa, 1 chữ cái thường, 1 ký tự đặc biệt và ít nhất 8 ký tự trở lên"
                                        --%>
                                    	</c:otherwise>
                                    </c:choose>                                    
                                    <input type="checkbox" onclick="myFunctionX()"><span> </span>Hiện Mật khẩu
                                    <div class="form-text pass-message"></div>
                                    <!-- id="psw" name="psw" //// id="inputPassword4"for toggle password -->
                                    <!--title="Must contain at least one number and one uppercase and lowercase letter, and at least 8 or more characters" //// pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" //// ????=> /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*]).{8,}$/;<=????////-->
                                </div>


                                <div class="col-12">
                                    <button class="btn btn-primary" type="submit">Đăng nhập</button>
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
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
        crossorigin="anonymous"></script>
    <script src="js/scripts.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest" crossorigin="anonymous"></script>
    <script src="js/datatables-simple-demo.js"></script>




    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="js/password-show.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/password-show.js"></script>
	<%-- validate for login without java: just add 'required', no vali pass like registration --%>
</body>

</html>