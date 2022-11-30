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
    <title>Đăng ký</title>
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
                    <h2 class="mt-4">Trang đăng ký tài khoản</h2>
                    <ol class="breadcrumb mb-4">
                        <li class="breadcrumb-item"><a href="/QuyTuThienVanTinh/Controller">Trang chủ</a></li>
                        <!-- <li class="breadcrumb-item active"></li> -->
                    </ol>

                    <div class="card mb-4">
                        <div class="card-body">



                            <form class="row g-3" id="form" action="/QuyTuThienVanTinh/QueryAtUser?action=create" method="post">
                            	<input type="hidden" name="action" value="create"> <%-- không có cái này => action sẽ null --%>
								<%-- <input type="hidden" name="account" value="${acc}"> --%>
                            
                                <div class="col-md-6">
                                    <label for="us" class="form-label">Tên tài khoản</label>  
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
                                <div class="col-md-6">
                                    <label for="name" class="form-label">Tên</label>
                                    <c:choose>
                                    	<c:when test="${sname != null && sname != '' }">
                                    		<input type="text" name="nm" class="form-control" id="name" value="${sname }" >
                                    	</c:when>
                                    	<c:otherwise>
                                    		<input type="text" name="nm" class="form-control" id="name" placeholder="Nhập Tên" ><!-- required -->
                                    	</c:otherwise>
                                    </c:choose>                                    
                                    <div class="form-text name-message"></div>
                                </div>
                                <div class="col-md-6">
                                    <label for="last-name" class="form-label">Họ và tên đệm</label>
                                    	<c:choose>
                                    		<c:when test="${slastname != null && slastname != '' }">
                                    			<input type="text" name="lnm" class="form-control" id="last-name" value="${slastname }" ><!-- required -->
                                    		</c:when>
                                    		<c:otherwise>
                                    			<input type="text" name="lnm" class="form-control" id="last-name" placeholder="Nhập Họ và Tên đệm" ><!-- required -->
                                    		</c:otherwise>
                                    	</c:choose>                                    
                                    <div class="form-text last-name-message"></div>
                                </div>
                                
                                <!--<div></div>-->

								<%-- creating random pass --%>
                                <div class="col-md-6">
                                    <!--<label for="inputPassword4" class="form-label">Password</label>
                                    <input type="password" class="form-control" id="inputPassword4" required>
                                    -->
                                    <label for="password" class="form-label">Mật khẩu</label>
                                    <input disabled="disabled" type="password" class="form-control" id="password" name="psw"
                                        pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*]).{8,}"
                                        title="Mật khẩu phải chứa ít nhất 1 chữ số, 1 chữ cái viết hoa, 1 chữ cái thường, 1 ký tự đặc biệt và ít nhất 8 ký tự trở lên"
                                        placeholder="Một mật khẩu ngẫu nhiên sẽ được tạo ra"><%-- readonly="true" ; required --%>
                                        <div style="padding-top: 8px"><i>Mật khẩu sẽ được gửi tới email của bạn sau khi bạn đã hoàn tất việc gửi đầy đủ thông tin</i></div>                                
                                </div>
                                
                                

                                
                                
                                <fieldset>
                                    <!-- class="row mb-3" -->
                                    <legend class="col-form-label col-sm-2 pt-0">Giới tính</legend>
                                    <div class="col-sm-10">
                                    	<c:choose>
                                    		<c:when test="${sgender != null && sgender != '' }">
                                    			<c:choose>
                                    				<c:when test="${sgender == 'Nam' }">                                    				
                                    					<div class="form-check">
                                            				<input class="form-check-input" type="radio" name="gender"
                                                				id="gridRadios1" value="Nam" checked>
                                            				<label class="form-check-label" for="gridRadios1">
                                                				Nam
                                            				</label>
                                        				</div>
                                        				<div class="form-check">
                                            				<input class="form-check-input" type="radio" name="gender"
                                                				id="gridRadios2" value="Nữ">
                                            				<label class="form-check-label" for="gridRadios2">
                                                				Nữ
                                            				</label>
                                        				</div>                                        				
                                    				</c:when>
                                    				<c:otherwise>                                    					                                    					<div class="form-check">
                                            				<input class="form-check-input" type="radio" name="gender"
                                                				id="gridRadios1" value="Nam" >
                                            				<label class="form-check-label" for="gridRadios1">
                                                				Nam
                                            				</label>
                                        				</div>
                                        				<div class="form-check">
                                            				<input class="form-check-input" type="radio" name="gender"
                                                				id="gridRadios2" value="Nữ" checked>
                                            				<label class="form-check-label" for="gridRadios2">
                                                				Nữ
                                            				</label>
                                        				</div>
                                    				</c:otherwise>
                                    			</c:choose>                                   			
                                    		</c:when>
                                    		
                                    		
                                    		<c:otherwise>
                                    			<div class="form-check">
                                            		<input class="form-check-input" type="radio" name="gender"
                                                		id="gridRadios1" value="Nam" checked>
                                            		<label class="form-check-label" for="gridRadios1">
                                                		Nam
                                            		</label>
                                        		</div>
                                        		<div class="form-check">
                                            		<input class="form-check-input" type="radio" name="gender"
                                                		id="gridRadios2" value="Nữ">
                                            		<label class="form-check-label" for="gridRadios2">
                                                		Nữ
                                            		</label>
                                        		</div> 
                                    		</c:otherwise>
                                    	</c:choose>                                   	
                                    </div>
                                </fieldset>
                                
                                

                               
                                <div class="col-lg-4 col-sm-6 mb-3">
                                    <label for="birthDate" class="form-label">Ngày tháng năm sinh</label>
                                    <c:choose>
                                    	<c:when test="${sbirth != null && sbirth != '' }">
                                    		<input name="birthdate" id="birth-date" class="form-control" type="date"  value="${sbirth  }"/><!-- required -->
                                    	</c:when>
                                    	<c:otherwise>
                                    		<input name="birthdate" id="birth-date" class="form-control" type="date"/><!-- required -->
                                    	</c:otherwise>
                                    </c:choose>                                    
                                    <span id="birthDateSelected"></span>
                                    <div class="form-text birthdate-message"></div>
                                </div>

                                
                                <div class="col-md-6">
                                    <label for="validationDefault03" class="form-label">Số điện thoại</label>
                                    <c:choose>
                                    	<c:when test="${sphone != null && sphone != '' }">
                                    		<input name="phone" type="number" class="form-control" id="validationDefault03" value="${sphone }">
                                    	</c:when>
                                    	<c:otherwise>
                                    		<input name="phone" type="number" class="form-control" id="validationDefault03" placeholder="Nhập vào số điện thoại">
                                    	</c:otherwise>
                                    </c:choose>                                    
                                </div>
                                <div class="col-md-6">
                                    <label for="validationDefault03" class="form-label">Paypal ID</label>
                                    <c:choose>
                                    	<c:when test="${spaypal != null && spaypal != '' }">
                                    		<input name="paypal" type="text" class="form-control" id="validationDefault03" value="${spaypal }">
                                    	</c:when>
                                    	<c:otherwise>
                                    		<input name="paypal" type="text" class="form-control" id="validationDefault03" placeholder="Nhập vào paypal ID">
                                    	</c:otherwise>
                                    </c:choose>                                    
                                </div>


                                
                                <div class="col-12">
                                    <table>

										<tr>
											<td style="width: 100px"><button class="btn btn-primary"
													type="submit" id="send">Đăng ký</button></td>
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