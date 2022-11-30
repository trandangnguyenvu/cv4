<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div id="layoutSidenav_content"> <!-- CLOSE TAG OF THIS DIV TAG IS AT FOOTER.JSP -->
            <main>
                <div class="container-fluid px-4">
                    <h1 class="mt-4">Hệ thống quản lý các đợt quyên góp</h1>
                    <ol class="breadcrumb mb-4">
                        <li class="breadcrumb-item"><a href="index.html">Trang chủ</a></li>
                        <li class="breadcrumb-item active"><a href="${pageContext.request.contextPath}/jsp/admin.jsp">Danh sách các đợt quyên góp</a></li>
                    </ol>
                    <%@ page import="java.util.*,model.*,dao.*"%>
                    <%
                    String characters = request.getParameter("characters");
					
					List<DonationRound> list = ListOfDonationRoundDAO.search(characters);
					
					int amount = list.size();
					out.print("<h6 style='color:blue;'><i>Đã tìm được: " + amount + " kết quả<i></h6><br>");
                    %>
                    <div class="card mb-4">
                        <div class="card-body">
                            <table>
                                <tr>
                                    <th>Tổng số tiền đã quyên góp được</th>
                                    <td style="width: 12px;"></td>
                                    <td style="text-align: right;">12,500,000,000</td>
                                    <td style="width: 12px;"></td>
                                    <td>VNĐ</td>
                                </tr>
                                <tr>
                                    <th>Tổng số lượt quyên góp</th>
                                    <td style="width: 12px;"></td>
                                    <td style="text-align: right;">2</td>
                                    <td style="width: 12px;"></td>
                                    <td>lượt</td>
                                </tr>
                            </table>
                        </div>
                    </div>

                    <div class="card mb-4">
                        <div class="card-body">
                            <table style="width: 100%;">
                                <tr>
                                    <td><strong>Tạo mới một đợt quyên góp</strong></td>
                                    <td style="text-align: right;"><button class="btn-new csw-btn-button"  type="button" onclick="location.href='${pageContext.request.contextPath}/jsp/admin-form.jsp';">Tạo mới</button></td>
                                </tr>
                            </table>
                        </div>
                    </div>

                    <div class="card mb-4">
                        <div class="card-header">
                            <i class="fas fa-table me-1"></i>
                            Danh sách các đợt quyên góp
                        </div>
                        <div class="card-body">
                            <table id="datatablesSimple">
                                <thead>
                                    <tr>
                                        <th>Chỉnh sửa</th>
                                        <th>Tiêu đề</th>
                                        <th>Tóm tắt nội dung</th>
                                        <th>Ngày bắt đầu</th>
                                        <th>Ngày kết thúc</th>
                                        <th>Xóa</th>
                                    </tr>
                                </thead>
                                <tfoot>
                                    <tr>
                                        <th>Chỉnh sửa</th>
                                        <th>Tiêu đề</th>
                                        <th>Tóm tắt nội dung</th>
                                        <th>Ngày bắt đầu</th>
                                        <th>Ngày kết thúc</th>
                                        <th>Xóa</th>
                                    </tr>
                                </tfoot>
                                <tbody>
                                
                                
                                
                                <%-- <%@ page import="java.util.*,model.*,dao.*"%> --%>
							<% 														
							//String characters = request.getParameter("characters");
							
							//List<DonationRound> list = ListOfDonationRoundDAO.search(characters);
							Date dateNow = new Date();							
							
							SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd");
							
							String ftDateNow = ft.format(dateNow); 
							Date dtDateNow	= ft.parse(ftDateNow); 												
							
							for (DonationRound e : list) {
								if (dtDateNow.compareTo(e.getStartDate())<0) {
									out.print("<tr><td><a href='/QuyTuThienVanTinh/AdminForm?action=editofadminform&iddonationround=" + e.getId() + "'>Chỉnh sửa</a></td>");
								} else {
									out.print("<tr><td></td>");
								}
								
								out.print("<td>" + e.getTitle() + "</td><td>" + e.getSummary() + "</td><td>" + e.getStartDate() + "</td><td>" + e.getEndDate() + "</td>");
							
								if (dtDateNow.compareTo(e.getStartDate())<0) {									
									out.print("<td><a href='/QuyTuThienVanTinh/QueryAtAdminForm?action=delete&iddonationround=" + e.getId() + "' onclick=\"return confirm(" + "'Bạn có chắc muốn xóa bản ghi này không?'" + ")\">Xóa</a></td></tr>");
								} else {
									out.print("<td></td></tr>");
								}		
							}
							%>
							
                                    
                                    
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </main>

    
