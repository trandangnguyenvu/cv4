<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>





 <div id="layoutSidenav_content"> <!-- CLOSE TAG OF THIS DIV TAG IS AT FOOTER.JSP -->
            <main>
                <div class="container-fluid px-4">
                    <h1 class="mt-4">Hệ thống quản lý Người dùng</h1>
                    <ol class="breadcrumb mb-4">
                        <li class="breadcrumb-item"><a href="index.html">Trang chủ</a></li>
                        <li class="breadcrumb-item active"><a href="/QuyTuThienVanTinh/Controller">Danh sách Người dùng</a></li>
                    </ol>
                    <div class="card mb-4">
                        <div class="card-body">
                            <table>
								<tr>
									<c:choose>
										<c:when test="${saction == 'search' }">
											<th>Đã tìm được : </th>
										</c:when>
										<c:otherwise>
											<th>Tổng số tài khoản :</th>
										</c:otherwise>
									</c:choose>									
																			
									<td style="width: 12px;"></td>
									<td style="text-align: right;">${ssize}</td>
									<td style="width: 12px;"></td>
									<c:choose>
										<c:when test="">
										</c:when>
										<c:otherwise>
										</c:otherwise>
									</c:choose>
									<td>Tài khoản</td>										
								</tr>
							</table>
                        </div>
                    </div>

                    <div class="card mb-4">
                        <div class="card-body">
                            <table style="width: 100%;">
                                <tr>
                                    <td><strong>Thêm Người dùng</strong></td>
                                    <td style="text-align: right;">
                                    	<button class="btn-new csw-btn-button"  type="button" onclick="location.href='/QuyTuThienVanTinh/AdminForm?action=createofadminuserform';">Thêm</button>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>

                    <div class="card mb-4">
                        <div class="card-header">
                            <i class="fas fa-table me-1"></i>
                            Danh sách Người dùng
                        </div>
                        <div class="card-body">
                            <table id="datatablesSimple">
                                <thead>
                                    <tr>
                                        <th>Chỉnh sửa</th>
                                        <th>Tên Tài khoản</th>
                                        <th>Email</th>
                                        <th>Tên</th>
                                        <th>Họ và tên đệm</th>
                                        <th>Giới tính</th>
                                        <th>Ngày tháng năm sinh</th>
                                        <th>Số điện thoại</th>
                                        <th>Paypal ID</th>
                                        <th>Vai trò</th>
                                        <th>Tình trạng</th>
                                        <th>Xóa</th>
                                    </tr>
                                </thead>
                                <tfoot>
                                    <tr>
                                        <th>Chỉnh sửa</th>
                                        <th>Tên Tài khoản</th>
                                        <th>Email</th>
                                        <th>Tên</th>
                                        <th>Họ và tên đệm</th>
                                        <th>Giới tính</th>
                                        <th>Ngày tháng năm sinh</th>
                                        <th>Số điện thoại</th>
                                        <th>Paypal ID</th>
                                        <th>Vai trò</th>
                                        <th>Tình trạng</th>
                                        <th>Xóa</th>
                                    </tr>
                                </tfoot>
                                <tbody>
                                
                                	<c:forEach var="user" items="${slist}">
								<tr>
									<td><a href="/QuyTuThienVanTinh/AdminForm?action=editofadminuserform&account=${user.account }">Chỉnh sửa</a></td>
									<td>${user.account }</td>
									<td>${user.email }</td>
									<td>${user.name }</td>
									<td>${user.lastName }</td>
									<td>${user.gender }</td>
									<td>${user.birthDay }</td>
									<td>${user.phone }</td>
									<td>${user.paypal }</td>
									<td>${user.role }</td>
									<td>${user.status }</td>
									<td>
										<c:choose>
											<c:when test="${user.role == 'User' }">											
												<form
													action="/QuyTuThienVanTinh/QueryAtAdminUser?action=delete&account=${user.account }" 
													method="post">
													<input type="hidden" name="action" value="delete"><input
														type="hidden" name="account"
														value="${user.account }"></input>
													<button onclick="return confirm('Bạn có chắc muốn xóa bản ghi này không?')" type="submit"
														style='border-radius: 5.5px;'>Xóa</button>
												</form>
											</c:when>
											<c:when test="${user.role == 'Admin' }">
												<form
													action="/QuyTuThienVanTinh/Controller?action=adminuser&alert=admin" 
													method="get">
													<input type="hidden" name="action" value="adminuser">
													<input type="hidden" name="alert" value="admin">
													<button style='border-radius: 5.5px;'>Xóa</button>
												</form>	
											</c:when>
										</c:choose>
									</td>
								</tr>
								</tr>                                
                                	</c:forEach>
                                
                                	
                                    
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </main>