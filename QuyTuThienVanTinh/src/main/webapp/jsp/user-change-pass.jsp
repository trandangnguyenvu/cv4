<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>



<sql:setDataSource var="ds" dataSource="jdbc/DonationDB" />

<!-- take data about Account table from DB -->
<sql:query dataSource="${ds}" var="results"
	sql="select * from Account where user_account=?">
	<sql:param>${param.account}</sql:param>
</sql:query>

<c:set scope="page" var="user" value="${results.rows[0]}"></c:set>


<c:set scope="page" var="acc" value="${user.user_account}"></c:set>
<c:set scope="page" var="pass" value="${user.password}"></c:set>




<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>Đổi mật khẩu</title>
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
                    <h2 class="mt-4">Trang thay đổi Mật khẩu</h2>
                    <ol class="breadcrumb mb-4">
                        <li class="breadcrumb-item"><a href="/QuyTuThienVanTinh/Controller">Trang chủ</a></li>
                        <!-- <li class="breadcrumb-item active"></li> -->
                    </ol>

                    <div class="card mb-4">
                        <div class="card-body">



                            <form class="row g-3" id="form" action="/QuyTuThienVanTinh/QueryAtUser?action=changepass&account=${acc}" method="post"><%-- &account=${acc} --%>
                            	<input type="hidden" name="action" value="changepass"> <%-- không có cái này => action sẽ null --%>
								<input type="hidden" name="account" value="${acc}">
                            
                                <div class="col-md-6">
                                    <label for="user" class="form-label">Tên tài khoản</label>
                                    <input disabled="disabled" type="text" id="us" name="usr" class="form-control" value="${acc }" > 
                                    <div class="form-text account-message"></div>
                                </div>
                                
                                
                                
                                <div style="padding: 0px; margin: 0px; height: 0px;"></div>
                                <div class="col-md-6">                                    
                                    <label for="password" class="form-label">Mật khẩu cũ</label>
                                    <c:choose>
                                    	<c:when test="${sOlderPass != null && sOlderPass != '' }">
                                    		<input value="${sOlderPass }" type="password" class="form-control" id="password" name="opsw"
                                        >
                                        <%-- required 
                                        pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*]).{8,}"
                                        title="Mật khẩu phải chứa ít nhất 1 chữ số, 1 chữ cái viết hoa, 1 chữ cái thường, 1 ký tự đặc biệt và ít nhất 8 ký tự trở lên"
                                        --%>
                                    	</c:when>
                                    	<c:otherwise>
                                    		<input placeholder="Nhập vào đây Mật khẩu của bạn" type="password" class="form-control" id="password" name="opsw"
                                        >
                                        <%-- required 
                                        pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*]).{8,}"
                                        title="Mật khẩu phải chứa ít nhất 1 chữ số, 1 chữ cái viết hoa, 1 chữ cái thường, 1 ký tự đặc biệt và ít nhất 8 ký tự trở lên"
                                        --%>
                                    	</c:otherwise>
                                    </c:choose>                                    
                                    <input type="checkbox" onclick="myFunctionX()"><span> </span>Hiện Mật khẩu cũ
                                    <div class="form-text pass-message"></div>
                                    <!-- id="psw" name="psw" //// id="inputPassword4"for toggle password -->
                                    <!--title="Must contain at least one number and one uppercase and lowercase letter, and at least 8 or more characters" //// pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" //// ????=> /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*]).{8,}$/;<=????////-->
                                </div>
                                
                                
                                <div style="padding: 0px; margin: 0px; height: 0px;"></div>
                                <div class="col-md-6">                                    
                                    <label for="newpassword" class="form-label">Mật khẩu mới</label>
                                    <c:choose>
                                    	<c:when test="${sNewPass != null && sNewPass != '' }">
                                    		<input value="${sNewPass }" type="password" class="form-control" id="newpassword" name="npsw"
                                        >
                                        <%-- required 
                                        pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*]).{8,}"
                                        title="Mật khẩu phải chứa ít nhất 1 chữ số, 1 chữ cái viết hoa, 1 chữ cái thường, 1 ký tự đặc biệt và ít nhất 8 ký tự trở lên"
                                        --%>
                                    	</c:when>
                                    	<c:otherwise>
                                    		<input placeholder="Nhập vào đây Mật khẩu mới của bạn" type="password" class="form-control" id="newpassword" name="npsw"
                                        >
                                        <%-- required 
                                        pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*]).{8,}"
                                        title="Mật khẩu phải chứa ít nhất 1 chữ số, 1 chữ cái viết hoa, 1 chữ cái thường, 1 ký tự đặc biệt và ít nhất 8 ký tự trở lên"
                                        --%>
                                    	</c:otherwise>
                                    </c:choose>                                    
                                    <input type="checkbox" onclick="myFunctionZ()"><span> </span>Hiện Mật khẩu mới
                                    <div class="form-text pass-message"></div>
                                    <!-- id="psw" name="psw" //// id="inputPassword4"for toggle password -->
                                    <!--title="Must contain at least one number and one uppercase and lowercase letter, and at least 8 or more characters" //// pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" //// ????=> /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*]).{8,}$/;<=????////-->
                                </div>
                                
                                
                                <div class="col-md-6">
                                    <label for="confirmpassword" class="form-label">Xác nhận</label>
                                    <c:choose>
                                    	<c:when test="${sConfirmNewPass != null && sConfirmNewPass != '' }">
                                    		<input value="${sConfirmNewPass }" type="password" name="ncpsw" class="form-control" id="confirmpassword" ><%-- required --%>
                                    	</c:when>
                                    	<c:otherwise>
                                    		<input placeholder="Nhập lại Mật khẩu" type="password" name="ncpsw" class="form-control" id="confirmpassword" ><%-- required --%>
                                    	</c:otherwise>
                                    </c:choose>                                    
                                    <input type="checkbox" onclick="myFunctionY()"><span> </span>Hiện Mật khẩu
                                    <div class="form-text confirm-message"></div>
                                </div>
                                
                                

                                
                                
                                
                                
                                
                                


                                
                                <div class="col-12">
                                    <table>

										<tr>
											<td style="width: 100px"><button class="btn btn-primary"
													type="submit" id="send">Lưu</button></td>
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