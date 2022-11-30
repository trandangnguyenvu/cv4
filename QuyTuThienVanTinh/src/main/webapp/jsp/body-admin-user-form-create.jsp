<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>








<div id="layoutSidenav_content"><%-- close div of this open div at footer jsp --%>
            <main>
                <div class="container-fluid px-4">
                    <h2 class="mt-4">Hệ thống quản lý Người dùng</h2>
                    <P>CREATE</P>
                    <ol class="breadcrumb mb-4">
                        <li class="breadcrumb-item"><a href="index.html">Trang chủ</a></li>
                        <!-- <li class="breadcrumb-item active"></li> -->
                    </ol>

                    <div class="card mb-4">
                        <div class="card-body">



                            <form class="row g-3" id="form" action="/QuyTuThienVanTinh/QueryAtAdminUser?action=create" method="post">
                                <input type="hidden" name="action" value="create"> <!-- không có cái này => action sẽ null -->
								
                                
                                <h5>Thêm / Chỉnh sửa một Người dùng</h5><br>
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


                                <div class="col-md-6">
                                    <!--<label for="inputPassword4" class="form-label">Password</label>
                                    <input type="password" class="form-control" id="inputPassword4" required>
                                    -->
                                    <label for="password" class="form-label">Mật khẩu</label>
                                    <input disabled="disabled" type="password" class="form-control" id="password" name="psw"
                                        pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*]).{8,}"
                                        title="Mật khẩu phải chứa ít nhất 1 chữ số, 1 chữ cái viết hoa, 1 chữ cái thường, 1 ký tự đặc biệt và ít nhất 8 ký tự trở lên"
                                        placeholder="Một mật khẩu ngẫu nhiên sẽ được tạo ra"><%-- readonly="true" ; required --%>
                                                                        
                                </div>
                                <div class="col-md-6">
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

                                <div style="padding: 0px; margin: 0px; height: 0px;"></div>
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

                                <div style="padding: 0px; margin: 0px; height: 0px;"></div>
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

                                <fieldset>
                                    <!-- class="row mb-3" -->
                                    <legend class="col-form-label col-sm-2 pt-0">Vai trò</legend>
                                    <c:choose>
                                    	<c:when test="${srole != null && srole != '' }">
                                    		<c:choose>
                                    			<c:when test="${srole == 'User' }">
                                    				<div class="col-sm-10">
                                        				<div class="form-check">
                                            				<input class="form-check-input" type="radio" name="role"
                                                				id="gridRadios1" value="User" checked>
                                            				<label class="form-check-label" for="gridRadios1">
                                                				User
                                            				</label>
                                        				</div>
                                        				<div class="form-check">
                                            				<input class="form-check-input" type="radio" name="role"
                                                				id="gridRadios2" value="Admin">
                                            				<label class="form-check-label" for="gridRadios2">
                                                				Admin
                                            				</label>
                                        				</div>                                     
                                    				</div>
                                    			</c:when>
                                    			<c:otherwise>
                                    				<div class="col-sm-10">
                                        				<div class="form-check">
                                            				<input class="form-check-input" type="radio" name="role"
                                                				id="gridRadios1" value="User" >
                                            				<label class="form-check-label" for="gridRadios1">
                                                				User
                                            				</label>
                                        				</div>
                                        				<div class="form-check">
                                            				<input class="form-check-input" type="radio" name="role"
                                                				id="gridRadios2" value="Admin" checked>
                                            				<label class="form-check-label" for="gridRadios2">
                                                				Admin
                                            				</label>
                                        				</div>                                     
                                    				</div>
                                    			</c:otherwise>
                                    		</c:choose>
                                    	</c:when>
                                    	<c:otherwise>
                                    		<div class="col-sm-10">
                                        		<div class="form-check">
                                            		<input class="form-check-input" type="radio" name="role"
                                                		id="gridRadios1" value="User" checked>
                                            		<label class="form-check-label" for="gridRadios1">
                                                		User
                                            		</label>
                                        		</div>
                                        		<div class="form-check">
                                            		<input class="form-check-input" type="radio" name="role"
                                                		id="gridRadios2" value="Admin">
                                            		<label class="form-check-label" for="gridRadios2">
                                                		Admin
                                            		</label>
                                        		</div>                                     
                                    		</div>
                                    	</c:otherwise>
                                    </c:choose>                                   
                                </fieldset>

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
                            </form><!-- /QuyTuThienVanTinh/AdminForm?action=editofadminuserform -->



                        </div>
                    </div>

                </div>
            </main>