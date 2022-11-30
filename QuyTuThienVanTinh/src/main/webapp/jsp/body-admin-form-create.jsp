<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
    
    
    <sql:setDataSource var="ds" dataSource="jdbc/DonationDB" />
    
    <!-- take data about Partner table from DB for list-dropdown of partners at item "5" -->
	<sql:query dataSource="${ds}" var="results"
		sql="select * from Partner">	
	</sql:query>
    
<script type="text/javascript" src="${pageContext.request.contextPath}/libraries/ckeditor5-build-classic/ckeditor.js">
</script>

	<div id="layoutSidenav_content"><%-- close div of this open div at footer jsp --%>
            <main>
                <div class="container-fluid px-4">
                    <h2 class="mt-4">Hệ thống quản lý các đợt quyên góp</h2>
                    <p>CREATE</p>
                    <ol class="breadcrumb mb-4">
                        <li class="breadcrumb-item"><a href="index.html">Trang chủ</a></li>
                        <!-- <li class="breadcrumb-item active"></li> -->
                    </ol>

                    <div class="card mb-4">
                        <div class="card-body">



                            <form id="admin-form" class="row g-3" action="/QuyTuThienVanTinh/QueryAtAdminForm?action=create" method="post">
                                <input type="hidden" name="action" value="create">
                                <h5>Tạo mới / Chỉnh sửa một đợt quyên góp</h5><br>
                                <div class="col-12">
                                 	<table>

                                        <tr>
                                            <td style="width: 100px"><button class="btn btn-primary" type="submit">Save</button></td>
                                            <td><button class="btn btn-primary" type="button" onclick="location.href='${pageContext.request.contextPath}/jsp/admin.jsp';">Cancel</button></td>
                                        </tr>

                                    </table>
                                </div>
                                <div>
                                	<h6 style='margin: 0px; padding: 0px;color:red;' class='nav-link'><i>
										<c:if test="${errormessage != null}">
											<c:out value="${errormessage}"></c:out> 
										</c:if>
									</i></h6>
										<%--  <%
										if (session.getAttribute("error-message") != null) {%>
											<%= session.getAttribute("error-message")%>
										<%}%>--%>
								</div>
								

                                <div class="mb-3">
                                    <label for="exampleFormControlTextarea1" class="form-label">1. Tiêu đề</label>
                                    <p>	                                    	
                                    	<c:if test="${stitle != null && stitle != '' }">
                                    		<i><c:out value="Bạn đã gõ: "></c:out></i>
											<c:out value="${stitle }"></c:out>
										</c:if>
                                    	<%-- <% if (session.getAttribute("stitle") != null) { %>
                                    		<%= session.getAttribute("stitle")%>
                                    	<% } %> --%>
                                    </p>
                                    <textarea name="title" maxlength="255" class="form-control" id="exampleFormControlTextarea1" rows="1"
                                        placeholder="Gõ vào đây tiêu đề của đợt quyên góp" ></textarea><!-- required -->
                                </div>

                                <div class="mb-3">
                                    <label for="exampleFormControlTextarea1" class="form-label">2. Tóm tắt nội
                                        dung</label>
                                    <p>	
                                    	<c:if test="${ssummary != null && ssummary != '' }">
                                    		<i><c:out value="Bạn đã gõ: "></c:out></i>
											<c:out value="${ssummary }"></c:out>
										</c:if>
                                    	<%-- <% if (session.getAttribute("ssummary") != null) { %>
                                    		<%= session.getAttribute("ssummary")%>
                                    	<% } %> --%>
                                    </p>
                                    <textarea name="summary" maxlength="255" class="form-control" id="exampleFormControlTextarea1" rows="2"
                                        placeholder="Gõ vào đây phần tóm tắt nội dung" ></textarea><!-- required -->
                                </div>

                                <div class="mb-3">
                                    <label for="exampleFormControlTextarea1" class="form-label">3. Nội dung</label>
                                    <p>	
                                    	<c:if test="${sstory != null && sstory != ''}">
                                    		<i><c:out value="Bạn đã gõ: "></c:out></i>
											<c:out value="${sstory }"></c:out>
										</c:if>
                                    	<%--<% if (session.getAttribute("sstory") != null) { %>
                                    		<%= session.getAttribute("sstory")%>
                                    	<% } %>--%>
                                    </p>
                                    <textarea name="story" maxlength="4000" class="form-control" id="exampleFormControlTextarea1" rows="8"
                                        placeholder="Gõ vào đây nội dung chi tiết" ></textarea><!-- required -->
                                </div>
                                <script>
                                	CKEDITOR.replace('exampleFormControlTextarea1');
                                </script>

                                <!-- uploading images -->
                                <div class="mb-3">
                                    <label class="form-label">4. Tải ảnh lên hệ thống</label>
                                    <input name="input41" maxlength="255" type="file" class="form-control" aria-label="file example">
                                    <div class="invalid-feedback">Example invalid form file feedback</div>
                                </div>

                                <div class="mb-3">
                                    <input type="file" name="input42" maxlength="255" class="form-control" aria-label="file example">
                                    <div class="invalid-feedback">Example invalid form file feedback</div>
                                </div>

                                <div class="mb-3">
                                    <input type="file" name="input43" maxlength="255" class="form-control" aria-label="file example">
                                    <div class="invalid-feedback">Example invalid form file feedback</div>
                                </div>

                                <div class="mb-3">
                                    <input type="file" name="input44" maxlength="255" class="form-control" aria-label="file example">
                                    <div class="invalid-feedback">Example invalid form file feedback</div>
                                </div>

                                <div class="mb-3">
                                    <input type="file" name="input45" maxlength="255" class="form-control" aria-label="file example">
                                    <div class="invalid-feedback">Example invalid form file feedback</div>
                                </div>

                                <div class="mb-3">
                                    <input type="file" name="input46" maxlength="255" class="form-control" aria-label="file example">
                                    <div class="invalid-feedback">Example invalid form file feedback</div>
                                </div>
                                <!-- 6/6 images -->



                                <!--
                                <div class="col-md-5 mb-3">
                                    <label for="validationDefault05" class="form-label">5. Đối tác đồng hành</label>
                                    <input type="number" class="form-control" id="validationDefault05" placeholder="Mã số của đối tác đồng hành" required>
                                </div>
                                -->


                                <div style="padding: 0px; margin: 0px; height: 0px;"></div>
                                <div class="col-md-6 mb-3">
                                    <label for="validationCustom04" class="form-label">5. Đối tác đồng hành</label>
                                    <select name="partnerid" class="form-select" id="validationCustom04" ><!-- required -->
                                    	<c:choose>
											<c:when test="${spartnerId == null || spartnerId == '' }">
												<option selected value="">Choose...</option>
												<!-- this is choose... disabled -->
											</c:when>
											<c:otherwise>
												<c:forEach var="partner" items="${results.rows}">
													<c:if test="${partner.partner_id == spartnerId}">
														<option selected value="${spartnerId }">
														<!-- disabled --> ${partner.partner_name}
														</option>
														<!-- this is "choose..." (selected option in options for showing at field) -->
													</c:if>
												</c:forEach>
											</c:otherwise>
										</c:choose>


										<c:forEach var="partner" items="${results.rows}">
											<option value="${partner.partner_id}">${partner.partner_name}</option> <!-- this is dropdown menu -->								
										</c:forEach>
                                    </select>
                                    <div class="invalid-feedback">
                                        Please select a valid state.
                                    </div>
                                </div>

                                <div style="padding: 0px; margin: 0px; height: 0px;"></div>
                                <div class="col-lg-4 col-sm-6 mb-3">
                                    <label for="startDate" class="form-label">6. Ngày bắt đầu nhận quyên góp</label>
                                    <input name="startdate" id="startDate" class="form-control" type="date"  value="${sstart }"/><!-- required --> <%-- %><%= session.getAttribute("sstart") %> --%>
                                    <span id="startDateSelected"></span>
                                </div>
                                <div style="padding: 0px; margin: 0px; height: 0px;"></div>
                                <div class="col-lg-4 col-sm-6 mb-3">
                                    <label for="endDate" class="form-label">7. Ngày kết thúc đợt quyên góp</label>
                                    <input name="enddate" id="endDate" class="form-control" type="date"  value="${send }"/><!-- required --> <%-- %><%= session.getAttribute("send") %>--%>
                                    <span id="endDateSelected"></span>
                                    <div class="form-text end-date-message "></div> 
                                </div>
                                
                                <div style="padding: 0px; margin: 0px; height: 0px;"></div>
                                <div class="col-lg-4 col-sm-6 mb-3">
                                    <label for="validationDefault03" class="form-label">8. Số tiền định mức</label>
                                    <c:choose>
                                    	<c:when test="${stargetmoney != null && stargetmoney != '' }">
                                    		<input name="targetmoney" type="number" class="form-control" id="validationDefault03" value="${stargetmoney }">
                                    	</c:when>
                                    	<c:otherwise>
                                    		<input name="targetmoney" type="number" class="form-control" id="validationDefault03" >
                                    	</c:otherwise>
                                    </c:choose> 
                                    <div class="form-text targetmoney-message "></div><%-- not yet js --%>                                   
                                </div>


                                <div class="col-12">
                                    <table>

                                        <tr>
                                            <td style="width: 100px"><button class="btn btn-primary" type="submit">Save</button></td>
                                            <td><button class="btn btn-primary" type="button" onclick="location.href='${pageContext.request.contextPath}/jsp/admin.jsp';">Cancel</button></td>
                                        </tr>

                                    </table>
                                </div>
								<div>
									<h6 style='margin: 0px; padding: 0px;color:red;' class='nav-link'><i>
										<c:if test="${errormessage != null }">
											<c:out value="${errormessage }"></c:out>
										</c:if>
										<%--  <%
										if (session.getAttribute("error-message") != null) {%>
											<%= session.getAttribute("error-message")%>
										<%}%>--%>
									</i></h6>
								</div>

					</form>




                        </div>
                    </div>




                </div>
            </main>