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
<c:set scope="page" var="role" value="${user.account_role}"></c:set>
<c:set scope="page" var="name" value="${user.user_name}"></c:set>
<c:set scope="page" var="gender" value="${user.gender}"></c:set>
<c:set scope="page" var="birth" value="${user.day_of_birth}"></c:set>

<c:set scope="page" var="phone" value="${user.user_phone}"></c:set>
<c:set scope="page" var="paypal" value="${user.paypal_ID}"></c:set>
<c:set scope="page" var="email" value="${user.email}"></c:set>
<c:set scope="page" var="lastname" value="${user.last_name}"></c:set>
<c:set scope="page" var="status" value="${user.status}"></c:set>




<div id="layoutSidenav_content"><%-- close div of this open div at footer jsp --%>
            <main>
                <div class="container-fluid px-4">
                    <h2 class="mt-4">Hệ thống quản lý Người dùng</h2>
                    <p>EDIT</p>
                    <ol class="breadcrumb mb-4">
                        <li class="breadcrumb-item"><a href="index.html">Trang chủ</a></li>
                        <!-- <li class="breadcrumb-item active"></li> -->
                    </ol>

                    <div class="card mb-4">
                        <div class="card-body">



                            <form class="row g-3" id="form" action="/QuyTuThienVanTinh/QueryAtAdminUser?action=update&account=${acc}" method="post">
                                <input type="hidden" name="action" value="update"> <!-- không có cái này => action sẽ null -->
								<input type="hidden" name="account" value="${acc}">
                                
                                <h5>Thêm / Chỉnh sửa một Người dùng</h5><br>
                                <div class="col-md-6">
                                    <label for="us" class="form-label">Tên tài khoản</label>                                    
                                    <input readonly="true" type="text" id="us" name="usr" class="form-control" value="${acc }" ><!--required ; id="user" id must be different for locking javascript--> 
                                    <div class="form-text account-message"></div>
                                </div>
                                <div class="col-md-6">
                                    <label for="email" class="form-label">Email</label>
                                    <c:choose>
                                    	<c:when test="${semail == null || semail == '' }">
                                    		<input type="text" name="mail" class="form-control" id="email" value="${email }" ><%-- required type="email" --%>
                                    	</c:when>
                                    	<c:otherwise>
                                    		<input type="text" name="mail" class="form-control" id="email" value="${semail }" ><%-- required type="email" --%>
                                    	</c:otherwise>
                                    </c:choose>                                    
                                    <div class="form-text email-message"></div>
                                </div>
                                <div class="col-md-6">
                                    <label for="name" class="form-label">Tên</label>
                                    <c:choose>
                                    	<c:when test="${sname == null || sname == '' }">
                                    		<input type="text" name="nm" class="form-control" id="name" value="${name }" >
                                    	</c:when>
                                    	<c:otherwise>
                                    		<input type="text" name="nm" class="form-control" id="name" value="${sname }" ><!-- required -->
                                    	</c:otherwise>
                                    </c:choose>                                    
                                    <div class="form-text name-message"></div>
                                </div>
                                <div class="col-md-6">
                                    <label for="last-name" class="form-label">Họ và tên đệm</label>
                                    	<c:choose>
                                    		<c:when test="${slastname == null || slastname == '' }">
                                    			<input type="text" name="lnm" class="form-control" id="last-name" value="${lastname }" ><!-- required -->
                                    		</c:when>
                                    		<c:otherwise>
                                    			<input type="text" name="lnm" class="form-control" id="last-name" value="${slastname}" ><!-- required -->
                                    		</c:otherwise>
                                    	</c:choose>                                    
                                    <div class="form-text last-name-message"></div>
                                </div>
                                
                                <!--<div></div>-->


                                <div class="col-md-6">
                                    <!--<label for="inputPassword4" class="form-label">Password</label>
                                    <input type="password" class="form-control" id="inputPassword4" required>
                                    -->
                                    <label for="password" class="form-label">Mật khẩu</label>
                                    <input readonly="true" type="password" class="form-control" id="password" name="psw"
                                        pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*]).{8,}"
                                        title="Mật khẩu phải chứa ít nhất 1 chữ số, 1 chữ cái viết hoa, 1 chữ cái thường, 1 ký tự đặc biệt và ít nhất 8 ký tự trở lên"
                                        value="${pass }"><!-- required -->
                                </div>
                                <div class="col-md-6">
                                </div>

                                <fieldset>
                                    <!-- class="row mb-3" -->
                                    <legend class="col-form-label col-sm-2 pt-0">Giới tính</legend>
                                    <div class="col-sm-10">
                                    	<c:choose>
                                    		<c:when test="${sgender == null || sgender == '' }">
                                    			<c:choose>
                                    				<c:when test="${gender == 'Nam' }">                                    				
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
                                    		</c:otherwise>
                                    	</c:choose>                                   	
                                    </div>
                                </fieldset>

                                <div style="padding: 0px; margin: 0px; height: 0px;"></div>
                                <div class="col-lg-4 col-sm-6 mb-3">
                                    <label for="birthDate" class="form-label">Ngày tháng năm sinh</label>
                                    <c:choose>
                                    	<c:when test="${sbirth == null || sbirth == '' }">
                                    		<input name="birthdate" id="birth-date" class="form-control" type="date"  value="${birth }"/><!-- required -->
                                    	</c:when>
                                    	<c:otherwise>
                                    		<input name="birthdate" id="birth-date" class="form-control" type="date"  value="${sbirth }"/><!-- required -->
                                    	</c:otherwise>
                                    </c:choose>                                    
                                    <span id="birthDateSelected"></span>
                                    <div class="form-text birthdate-message"></div>
                                </div>

                                <div style="padding: 0px; margin: 0px; height: 0px;"></div>
                                <div class="col-md-6">
                                    <label for="validationDefault03" class="form-label">Số điện thoại</label>
                                    <c:choose>
                                    	<c:when test="${sphone == null || sphone == '' }">
                                    		<input name="phone" type="number" class="form-control" id="validationDefault03" value="${phone }">
                                    	</c:when>
                                    	<c:otherwise>
                                    		<input name="phone" type="number" class="form-control" id="validationDefault03" value="${sphone }">
                                    	</c:otherwise>
                                    </c:choose>                                    
                                </div>
                                <div class="col-md-6">
                                    <label for="validationDefault03" class="form-label">Paypal ID</label>
                                    <c:choose>
                                    	<c:when test="${spaypal == null || spaypal == '' }">
                                    		<input name="paypal" type="text" class="form-control" id="validationDefault03" value="${paypal }">
                                    	</c:when>
                                    	<c:otherwise>
                                    		<input name="paypal" type="text" class="form-control" id="validationDefault03" value="${spaypal }">
                                    	</c:otherwise>
                                    </c:choose>                                    
                                </div>

						
						<%-- fieldset of 'role' --%>
						<fieldset>
							<%-- class="row mb-3" --%>
							<legend class="col-form-label col-sm-2 pt-0">Vai trò</legend>
							<c:choose><%--choose 1 --%>
								<c:when test="${srole == null || srole == '' }"><%-- when 1.1 srole null or ""--%>
									<c:choose><%-- choose 2 belong when 1: srole null --%>
										<c:when test="${role == 'Admin' }"><%-- when 2.1 --%>
											<p>Tài khoản này là một Admin. Bạn không được phép cập
												nhật Tài khoản là Admin thành User</p>
											<div class="col-sm-10">
												<div class="form-check">
													<input class="form-check-input" type="radio" name="role"
														id="gridRadios2" value="Admin" checked="checked"> <label
														class="form-check-label" for="gridRadios2"> Admin
													</label>
												</div>
											</div>											
										</c:when><%-- when 2.1 --%>
										<c:otherwise><%-- other 2 --%>
											<p>Tài khoản này là một User. Nếu muốn chuyển thành một
												Admin, hãy chọn mục "Admin" dưới đây</p>											
											<div class="col-sm-10">
												<div class="form-check">
													<input class="form-check-input" type="radio" name="role"
														id="gridRadios2" value="User" checked="checked"> <label
														class="form-check-label" for="gridRadios2"> User </label>
												</div>
												<div class="form-check">
													<input class="form-check-input" type="radio" name="role"
														id="gridRadios2" value="Admin"> <label
														class="form-check-label" for="gridRadios2"> Admin
													</label>
												</div>
											</div>
										</c:otherwise><%-- other 2 --%>
									</c:choose><%-- choose 2 --%>
								</c:when><%-- when 1.1 --%>
								<c:otherwise><%-- other 1 srole not null or not ""--%>
									<c:choose><%-- other choose 3, level = choose 2 --%>
										<c:when test="${srole == 'User' }"><%-- when 3.1 --%>
											<div class="col-sm-10">
												<div class="form-check">
													<input class="form-check-input" type="radio" name="role"
														id="gridRadios1" value="User" checked> <label
														class="form-check-label" for="gridRadios1"> User </label>
												</div>
												<div class="form-check">
													<input class="form-check-input" type="radio" name="role"
														id="gridRadios2" value="Admin"> <label
														class="form-check-label" for="gridRadios2"> Admin </label>
												</div>
											</div>
										</c:when><%-- when 3.1 --%>
										<c:otherwise><%-- other 3 --%>
											<div class="col-sm-10">
												<div class="form-check">
													<input class="form-check-input" type="radio" name="role"
														id="gridRadios1" value="User"> <label
														class="form-check-label" for="gridRadios1"> User </label>
													</div>
													<div class="form-check">
													<input class="form-check-input" type="radio" name="role"
														id="gridRadios2" value="Admin" checked> <label
														class="form-check-label" for="gridRadios2"> Admin </label>
												</div>
											</div>
										</c:otherwise><%-- other 3 --%>
									</c:choose><%-- other choose 3, level = choose 2 --%>										
								</c:otherwise><%-- other 1 --%>
							</c:choose><%--choose 1 --%>
						</fieldset>
						<%-- close of fieldset of 'role' --%>

						<div class="col-12">
                                    <table>

										<tr>
											<td style="width: 100px"><button class="btn btn-primary"
													type="submit">Lưu</button></td>
											<td><button class="btn btn-primary" type="button" onclick="location.href='${pageContext.request.contextPath}/jsp/admin-user.jsp';">Hủy</button></td>
										</tr>

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