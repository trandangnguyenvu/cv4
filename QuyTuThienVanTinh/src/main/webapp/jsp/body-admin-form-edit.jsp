<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>


<script type="text/javascript" src="${pageContext.request.contextPath}/libraries/ckeditor5-build-classic/ckeditor.js">
</script>


<sql:setDataSource var="ds" dataSource="jdbc/DonationDB" />

<!-- take data about Donation_Round table from DB -->
<sql:query dataSource="${ds}" var="results"
	sql="select * from Donation_Round where donation_round_id=?">
	<sql:param>${param.iddonationround}</sql:param>
</sql:query>

<c:set scope="page" var="donation" value="${results.rows[0]}"></c:set>


<c:set scope="page" var="idDR" value="${donation.donation_round_id}"></c:set>
<c:set scope="page" var="title" value="${donation.title_of_story}"></c:set>
<c:set scope="page" var="summary" value="${donation.summary}"></c:set>
<c:set scope="page" var="story" value="${donation.story}"></c:set>
<c:set scope="page" var="start_date" value="${donation.start_date}"></c:set>
<c:set scope="page" var="end_date" value="${donation.end_date}"></c:set>

<c:set scope="page" var="partner_id_dr" value="${donation.partner_id}"></c:set>
<c:set scope="page" var="img_source_1" value="${donation.img_source_1}"></c:set>
<c:set scope="page" var="img_source_2" value="${donation.img_source_2}"></c:set>
<c:set scope="page" var="img_source_3" value="${donation.img_source_3}"></c:set>
<c:set scope="page" var="img_source_4" value="${donation.img_source_4}"></c:set>
<c:set scope="page" var="img_source_5" value="${donation.img_source_5}"></c:set>
<c:set scope="page" var="img_source_6" value="${donation.img_source_6}"></c:set>

<c:set scope="page" var="targetmoney" value="${donation.target_money}"></c:set>








<!-- take data about Partner table from DB for list-dropdown of partners at item "5" -->
<sql:query dataSource="${ds}" var="results2"
	sql="select * from Partner">	
</sql:query>





<div id="layoutSidenav_content"><%-- close div of this open div at footer jsp --%>
	<main>
		<div class="container-fluid px-4">
			<h2 class="mt-4">Hệ thống quản lý các đợt quyên góp</h2>
			<p>EDIT</p>
			<ol class="breadcrumb mb-4">
				<li class="breadcrumb-item"><a href="index.html">Trang chủ</a></li>
				<!-- <li class="breadcrumb-item active"></li> -->
			</ol>

			<div class="card mb-4">
				<div class="card-body">



					<form id="admin-form" class="row g-3" action="/QuyTuThienVanTinh/QueryAtAdminForm?action=update&iddonationround=${idDR}" method="post">
						<input type="hidden" name="action" value="update"> <!-- không có cái này => action sẽ null -->
						<input type="hidden" name="iddonationround" value="${idDR}">
						
						<h5>Tạo mới / Chỉnh sửa một đợt quyên góp</h5>
						<br>
						
						<div class="col-12">
							<table>

								<tr>
									<td style="width: 100px"><button class="btn btn-primary"
											type="submit">Save</button></td>
									<td><button class="btn btn-primary" type="button"
											onclick="location.href='${pageContext.request.contextPath}/jsp/admin.jsp';">Cancel</button></td>
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

						<script>
                        	CKEDITOR.replace('exampleFormControlTextarea1');
                        </script>

						<div class="mb-3">
							<label for="exampleFormControlTextarea1" class="form-label"><b>1.
								Tiêu đề</b></label>								
								<c:choose>
									<c:when test="${stitle == null || stitle == '' }">
										<i><c:out value="Nội dung hiện tại: "></c:out></i>
										<c:out value="${title }"></c:out>
									</c:when>
									<c:otherwise>
										<i><c:out value="Bạn đã gõ: "></c:out></i>
										<c:out value="${stitle }"></c:out>
									</c:otherwise>
								</c:choose>
							<textarea name="title" maxlength="255" class="form-control"
								id="exampleFormControlTextarea1" rows="1"
								placeholder="Gõ vào đây nội dung tiêu đề mới" ></textarea><!-- required -->
						</div>

						<div class="mb-3">
							<label for="exampleFormControlTextarea1" class="form-label"><b>2.
								Tóm tắt nội dung</b></label>
								<c:choose>
									<c:when test="${ssummary == null || ssummary == '' }">
										<i><c:out value="Nội dung hiện tại: "></c:out></i>
										<c:out value="${summary }"></c:out>
									</c:when>
									<c:otherwise>
										<i><c:out value="Bạn đã gõ: "></c:out></i>
										<c:out value="${ssummary }"></c:out>
									</c:otherwise>
								</c:choose>
							<textarea name="summary" maxlength="255" class="form-control"
								id="exampleFormControlTextarea1" rows="2"
								placeholder="Gõ vào đây nội dung mới của phần tóm tắt nội dung" ></textarea><!-- required -->
						</div>

						<div class="mb-3">
							<label for="exampleFormControlTextarea1" class="form-label"><b>3.
								Nội dung</b></label>
								<c:choose>
									<c:when test="${sstory == null || sstory == '' }">
										<i><c:out value="Nội dung hiện tại: "></c:out></i>
										<c:out value="${story }"></c:out>
									</c:when>
									<c:otherwise>
										<i><c:out value="Bạn đã gõ: "></c:out></i>
										<c:out value="${sstory }"></c:out>
									</c:otherwise>
								</c:choose>
							<textarea name="story" maxlength="4000" class="form-control"
								id="exampleFormControlTextarea1" rows="8"
								placeholder="Gõ vào đây nội dung mới" ></textarea><!-- required -->
						</div>

						<!-- uploading images -->
						<P><b>4. Tải ảnh lên hệ thống</b></P>
						<c:if test="${img_source_1 != null }">
							<div><img width="65%" style="border-radius:10px;display: block;margin-left: auto;margin-right: auto;"  alt="" src="${pageContext.request.contextPath}/${img_source_1}"></div>
						</c:if>
						<div class="mb-3">							
							<!--  <label class="form-label">4. Tải ảnh lên hệ thống</label> --> 
							<input name="input41" maxlength="255" type="file" class="form-control"
								aria-label="file example">
							<div class="invalid-feedback">Example invalid form file
								feedback</div>
						</div>
						
						
						<c:if test="${img_source_2 != null }">
							<div><img width="65%" style="border-radius:10px;display: block;margin-left: auto;margin-right: auto;"  alt="" src="${pageContext.request.contextPath}/${img_source_2}"></div>
						</c:if>
						<div class="mb-3">
							<input type="file" name="input42" maxlength="255"
								class="form-control" aria-label="file example">
							<div class="invalid-feedback">Example invalid form file
								feedback</div>
						</div>
						
						
						<c:if test="${img_source_3 != null }">
							<div><img width="65%" style="border-radius:10px;display: block;margin-left: auto;margin-right: auto;"  alt="" src="${pageContext.request.contextPath}/${img_source_3}"></div>
						</c:if>
						<div class="mb-3">
							<input type="file" name="input43" maxlength="255"
								class="form-control" aria-label="file example">
							<div class="invalid-feedback">Example invalid form file
								feedback</div>
						</div>
						
						
						<c:if test="${img_source_4 != null }">
							<div><img width="65%" style="border-radius:10px;display: block;margin-left: auto;margin-right: auto;"  alt="" src="${pageContext.request.contextPath}/${img_source_4}"></div>
						</c:if>
						<div class="mb-3">
							<input type="file" name="input44" maxlength="255"
								class="form-control" aria-label="file example">
							<div class="invalid-feedback">Example invalid form file
								feedback</div>
						</div>

						
						<c:if test="${img_source_5 != null }">
							<div><img width="65%" style="border-radius:10px;display: block;margin-left: auto;margin-right: auto;"  alt="" src="${pageContext.request.contextPath}/${img_source_5}"></div>
						</c:if>
						<div class="mb-3">
							<input type="file" name="input45" maxlength="255"
								class="form-control" aria-label="file example">
							<div class="invalid-feedback">Example invalid form file
								feedback</div>
						</div>

						
						<c:if test="${img_source_6 != null }">
							<div><img width="65%" style="border-radius:10px;display: block;margin-left: auto;margin-right: auto;"  alt="" src="${pageContext.request.contextPath}/${img_source_6}"></div>
						</c:if>
						<div class="mb-3">
							<input type="file" name="input46" maxlength="255"
								class="form-control" aria-label="file example">
							<div class="invalid-feedback">Example invalid form file
								feedback</div>
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
							<label for="validationCustom04" class="form-label">5. Đối
								tác đồng hành</label> 
							<select name="partnerid" class="form-select"
								id="validationCustom04" > <!-- required -->
								
								<c:choose>
									<c:when test="${spartnerId == null || spartnerId == ''}">
										<c:forEach var="partner" items="${results2.rows}">
											<c:if test="${partner.partner_id == partner_id_dr}">
												<option selected value="${partner_id_dr }">
													<!-- disabled --> ${partner.partner_name}
												</option>
												<!-- this is "choose..." (selected option in options for showing at field) -->
											</c:if>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<c:forEach var="partner" items="${results2.rows}">
											<c:if test="${partner.partner_id == spartnerId}">
												<option selected value="${spartnerId }">
													<!-- disabled --> ${partner.partner_name}
												</option>
												<!-- this is "choose..." (selected option in options for showing at field) -->
											</c:if>
										</c:forEach>
									</c:otherwise>
								</c:choose>

								<c:forEach var="partner" items="${results2.rows}">
									<option value="${partner.partner_id}">${partner.partner_name}</option> <!-- dropdown menu (options) -->								
								</c:forEach>
							</select>
							<div class="invalid-feedback">Please select a valid state.
							</div>
						</div>

						<div style="padding: 0px; margin: 0px; height: 0px;"></div>
						<div class="col-lg-4 col-sm-6 mb-3">
							<label for="startDate" class="form-label">6. Ngày bắt đầu
								nhận quyên góp</label>
							<c:choose>
								<c:when test="${sstart == null || sstart == '' }">
									<input name="startdate" id="startDate" class="form-control"
										type="date" value="${start_date}" />
									<span id="startDateSelected"></span>
									<!-- required -->
								</c:when>
								<c:otherwise>
									<input name="startdate" id="startDate" class="form-control"
										type="date" value="${sstart}" />
									<span id="startDateSelected"></span>
									<!-- required -->
								</c:otherwise>
							</c:choose>

						</div>
						<div style="padding: 0px; margin: 0px; height: 0px;"></div>
						<div class="col-lg-4 col-sm-6 mb-3">
							<label for="endDate" class="form-label">7. Ngày kết thúc
								đợt quyên góp</label>
							<c:choose>
								<c:when test="${send == null || send == '' }">
									<input name="enddate" id="endDate" class="form-control"
										type="date" value="${end_date}" />
									<span id="endDateSelected"></span>
									<!-- required -->
								</c:when>
								<c:otherwise>
									<input name="enddate" id="endDate" class="form-control"
										type="date" value="${send}" />
									<span id="endDateSelected"></span>
									<!-- required -->
								</c:otherwise>
							</c:choose>

							<div class="form-text end-date-message "></div> 
						</div>
						
						<div style="padding: 0px; margin: 0px; height: 0px;"></div>
                       	<div class="col-lg-4 col-sm-6 mb-3">
                        	<label for="validationDefault03" class="form-label">8. Số tiền định mức</label>
                            	<c:choose>
                                 	<c:when test="${stargetmoney == null || stargetmoney == '' }">
                                   		<input name="targetmoney" type="number" class="form-control" id="validationDefault03" value="${targetmoney }">
                                    </c:when>
                                    <c:otherwise>
                                    	<input name="targetmoney" type="number" class="form-control" id="validationDefault03" value="${stargetmoney }">
                                    </c:otherwise>
                              	</c:choose>   
                         	<div class="form-text targetmoney-message "></div><%-- not yet js --%>                                 
                      	</div>        
						

						<div class="col-12">
							<table>

								<tr>
									<td style="width: 100px"><button class="btn btn-primary"
											type="submit">Save</button></td>
									<td><button class="btn btn-primary" type="button" onclick="location.href='${pageContext.request.contextPath}/jsp/admin.jsp';">Cancel</button></td>
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