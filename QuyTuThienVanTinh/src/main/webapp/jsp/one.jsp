<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@page import="java.text.SimpleDateFormat"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- show nội dung chi tiết của 1 đợt quyên góp --%>

<c:import url="/jsp/header.jsp?header=one"></c:import><%-- just for one.jsp: there are new bootstraps at header.jsp --%>

<sql:setDataSource var="ds" dataSource="jdbc/DonationDB" />

<sql:query dataSource="${ds}" var="results2"
	sql="select * from Partner">	
</sql:query>


		<%@ page import="java.util.*,model.*,dao.*"%>
	    <%@page import="java.text.SimpleDateFormat"%>
	          
		
		<%  
		String iD = request.getParameter("id");
		// Donation_Round table with pagination
		DonationRound donation = ListOfDonationRoundDAO.getOneRecord(iD); 
		session.setAttribute("donation", donation);
		%>			
		
		
		<%
		// now
		Date dateNow = new Date();
		SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd");
		
		String ftDateNow = ft.format(dateNow); // Date to String + to "yyyy/MM/dd" format (for "yyyy/MM/dd" => must be String first )
		Date dtDateNow	= ft.parse(ftDateNow); // String to Date
		session.setAttribute("now", dtDateNow); // for test				
		%>
				
		
		<%
		// Donor_detail table
		List<DonorDetail> ddList = DonorDetailDAO.getAllRecords4AdminJsp();
		session.setAttribute("ddList", ddList);
		%>
		
		<%
		// Account table
		List<User> listAcc = AccountDAO.getAllRecords4AdminUserJsp();	
		session.setAttribute("listAcc", listAcc);
		%>
		
		<%            
		// add total of money into the donation round (just one donation round)
		float moneyTotal = 0;
		for (DonorDetail d:ddList) {
			if(iD.equals(d.getdID()) && d.getStatus().equals("Confirmed")) {
				moneyTotal = moneyTotal + d.getMoney();
			}
		}
		donation.setTotalMoney(moneyTotal);							
		%>


<div id="layoutSidenav_content"><%-- close div of this open div at footer jsp --%>
            
            <main>
                <div class="container-fluid px-4">
                    <h2 class="mt-4" >${donation.getTitle() }</h2>
                    <h4>(ID: ${donation.getId() })</h4>	
                    <p><a style="font-size: 20px" href="/QuyTuThienVanTinh/Controller">Trang chủ</a></p>                   
                    
                    <p style="font-size: 22px;">${donation.getSummary() }</p>
					<p style="font-size: 22px;"><i>Ngày bắt đầu dự án: ${donation.getStartDate() }</i></p>
                           
                             
                             
            						<div class="row" ><%-- start of div class="row" 1 --%>
            							
				                        <div > <%-- class="col-xl-3 col-md-6" --%>
				                        	
				                        	
				                        	

											<%-- Carousel Plugin of images --%>				                        	
											<div id="myCarousel" class="carousel slide " data-ride="carousel" >
											  <%-- 										  
											  <!-- Indicators -->
											  <ol class="carousel-indicators">
											    <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
											    <li data-target="#myCarousel" data-slide-to="1"></li>
											    <li data-target="#myCarousel" data-slide-to="2"></li>
											  </ol>
											  --%>	
											
											  <!-- Wrapper for slides -->
											  <div class="carousel-inner " >
											    <div class="item active " >
											      <img style="border-radius: 5px" src="${pageContext.request.contextPath}/${donation.getImgSource1() }">
											    </div>
											
											    <c:if test="${donation.getImgSource2() != null }">
												    <div class="item " >
												      <img style="border-radius: 5px" src="${pageContext.request.contextPath}/${donation.getImgSource2() }">
												    </div>
											    </c:if>
											
											    <c:if test="${donation.getImgSource3() != null }">
												    <div class="item" >
												      <img style="border-radius: 5px" src="${pageContext.request.contextPath}/${donation.getImgSource3() }">
												    </div>
											    </c:if>
											    
											     <c:if test="${donation.getImgSource4() != null }">
												    <div class="item" >
												      <img style="border-radius: 5px" src="${pageContext.request.contextPath}/${donation.getImgSource4() }">
												    </div>
											    </c:if>
											    
											    <c:if test="${donation.getImgSource5() != null }">
												    <div class="item" >
												      <img style="border-radius: 5px" src="${pageContext.request.contextPath}/${donation.getImgSource5() }">
												    </div>
											    </c:if>
											    
											    <c:if test="${donation.getImgSource6() != null }">
												    <div class="item" >
												      <img style="border-radius: 5px" src="${pageContext.request.contextPath}/${donation.getImgSource6() }">
												    </div>
											    </c:if>
											  </div>
											
											  <!-- Left and right controls -->
											  <a style="border: none;" class="left carousel-control card" href="#myCarousel" data-slide="prev"><%-- class card for border-radius --%>
											    <span class="glyphicon glyphicon-chevron-left"></span>
											    <span class="sr-only">Previous</span>
											  </a>
											  <a style="border: none;" class="right carousel-control card" href="#myCarousel" data-slide="next">
											    <span class="glyphicon glyphicon-chevron-right"></span>
											    <span class="sr-only">Next</span>
											  </a>
											</div>
											<%-- Carousel Plugin of images --%>
				                        	
				                        	
			                                
			                                <br>
				                            <div class="card bg-primary text-white mb-4">
				                                <div class="card-body"><%--  --%>	
				                                	<h3>Thông tin quyên góp</h3>					                                
				                                </div>
				                                
			                                	<div class="card-footer d-flex align-items-center justify-content-between" style="width:100%"><%-- 1.1 --%>
			            							<div style="width:100%">
			            							<div style="position: static; width:100%">
			            							<table style="width:100%">
				                                        <tr>
				                                        	<%-- hiển thị đối tác đồng hành --%>
				                                            <td style="font-size: small;" width="60%">
				                                            	<c:forEach var="partner" items="${results2.rows}">
																	<c:if test="${partner.partner_id == donation.getPartnerId()}">
																		<h6>Đồng hành cùng dự án</h6>
																		<span style="font-size:20px"><strong><c:out value="${partner.partner_name}"></c:out></strong></span>																				
																	</c:if>
																</c:forEach>
				                                            </td>
				                                            
				                                            
				                                            
				                                            <%-- nếu còn hạn thì hiển thị số ngày còn lại --%>
				                                            <c:set scope="session" var="endDate" value="${donation.getEndDate() }" ></c:set>	
				                                            	<%
				                                            	// tính số ngày còn lại cho đến khi hết hạn
					                                        	Calendar c1 = Calendar.getInstance();
					                                        	Calendar c2 = Calendar.getInstance();
					                                        	
					                                        	c1.setTime(dtDateNow);
					            								
					                                        	Object endO = session.getAttribute("endDate");
					                                        	
					                                        	//SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd"); // this variable has already exist above
					                                			
					                                			String endS = ft.format(endO); // to String		
					                                			Date endD = ft.parse(endS); // to Date		
				            									//Date timeRemaining 
				            									c2.setTime(endD);								            									
				            									long timeRemaining = (c2.getTime().getTime() - c1.getTime().getTime()) / (24 * 3600 * 1000);
				            									session.setAttribute("timeRemaining", timeRemaining); // số ngày còn lại 					
					            								%>
				                                            <td style="text-align: right;"><%-- colspan="2" --%>
				                                            	<c:if test="${donation.getTotalMoney() < donation.getTargetMoney() && now.before(donation.getEndDate()) || now.equals(donation.getEndDate()) }">
				                                            		<p style="font-size: 20px"><c:out value="Còn lại  ${timeRemaining } ngày"></c:out> </p>						                                            		
				                                            	</c:if>						                                            	
				                                            </td>
				                                        </tr>
				                              		</table>
				                              		</div>
				                              		
				                               		<div style="position: static;"><%-- div style="position: static;" => make each table be at 1 line  --%>
				                               		<table style="width:100%"><%-- để nút Quyên at right => tạo 5 table nối tiếp: 1 chứa Lượt QG, 2 trống, 3 chứa Đạt được, 4 trống, 5 chứa nút Quyên góp --%>
				                                        <tr>
				                                            <td colspan="3" style="padding-bottom: 20px; font-size:20px">							                                            	
				                                            	Đã quyên góp được: 
					                                            <%
					                                            out.print("<span style='font-size:25px'><strong>" + String.format("%.1f",moneyTotal) + "</strong></span>");
																%>
				                                                USD / ${donation.getTargetMoney() }	USD							                                                
				                                         	</td>
				                                        </tr>							                                       
				                                        <tr >								                                        	
				                                            <td width="50%" style="font-size: 22px;">Lượt quyên góp</td>
				                                            <td width="20%" style="font-size: 22px;">Đạt được</td>
				                                            <%-- còn thời thời hạn thì hiển thị button Quyên góp, hết thời hạn thì thông báo Đã hết thời hạn hoặc Đã đạt mục tiêu nếu số tiền nhận được đã đạt định mức --%>
				                                            <c:choose>
				                                            	<c:when test="${donation.getTotalMoney() < donation.getTargetMoney() && now.before(donation.getEndDate()) || now.equals(donation.getEndDate()) }"><%-- 'time left': vẫn chưa hết hạn (còn nhận $ tiền góp) --%>
				                                            		<td style="text-align: right;" rowspan="2"><button class="btn-qg-one" onclick="location.href='/QuyTuThienVanTinh/Controller?action=donate&donationId=${donation.getId()}&donationName=${donation.getTitle() }';">Quyên góp</button></td>
				                                            	</c:when>
				                                            	<c:when test="${now.after(donation.getEndDate()) && donation.getTotalMoney() < donation.getTargetMoney() }"><%-- 'out of time': đã hết hạn --%>
				                                            		<td style="text-align: right;" rowspan="2"><button class="btn-dqg-one">Hết thời hạn</button></td>
				                                            	</c:when>
				                                            	<c:when test="${donation.getTotalMoney() >= donation.getTargetMoney() }"><%-- 'enough': đợt QG đã đạt mục tiêu (đủ tiền) dù là chưa hết hạn, cũng sẽ khóa đợt QG này lại --%>
				                                            		<td style="text-align: right;" rowspan="2"><button class="btn-dqg-one">Đạt mục tiêu</button></td>
				                                            	</c:when>							                                            	
				                                            </c:choose>						                                                                                                
				                                        </tr>
				                                        <tr>
				                                            <td style="font-size: 22px;"><%-- giá trị của tiêu đề 'Lượt quyên góp' --%>
				                                            	<%
				                                            	int countTotal = 0;
				                                            	for (DonorDetail d: ddList) {
				                                            		if (iD.equals(d.getdID()) && d.getMoney() > 0 && d.getStatus().equals("Confirmed")) {
				                                            			countTotal++;
				                                            		}
				                                            	}
				                                            	out.print(countTotal);
																 %>
				                                            </td>
				                                            <td style="font-size: 22px;"><%-- giá trị của tiêu đề 'Đạt được' --%>
				                                            	${String.format("%.0f", donation.getTotalMoney() * 100 / donation.getTargetMoney()) } %
				                                            </td>
				                                        </tr>
				                                        <!--<div class="small text-white"><i class="fas fa-angle-right"></i></div>-->
			                                    	</table>
			                                    	</div>
			                                    	</div>
			                                    	
			                                    	
			            						</div><%-- 1.1 ? --%>
				                            </div>
				                            
				                            
				                            
				                            
				                        </div>					                        
					                    	
            						</div><%-- end of div class="row" 1  --%>
            						
                                    
                    
                    <%-- --%>
                    <div class="row">
                        <div class="col-xl-6">
                            <div class="card mb-4">
                                <div class="card-header">
                                    <i class="fas fa-chart-area me-1"></i>
                                    Câu chuyện
                                </div>
                                <div class="card-body" style="font-size: 20px">${donation.getStory() }</div>
                            </div>
                        </div>
                        <div class="col-xl-6">
                            <div class="card mb-4">
                                <div class="card-header">
                                    <i class="fas fa-chart-bar me-1"></i>
                                    Đối tác đồng hành cùng dự án
                                </div>
                                <div class="card-body">
                                	<c:forEach var="partner" items="${results2.rows}">
										<c:if test="${partner.partner_id == donation.getPartnerId()}">											
											<p style="font-size:22px"><strong><c:out value="${partner.partner_name}"></c:out></strong></p>	
											<br>
											<p style="font-size:20px"><c:out value="${partner.information }"></c:out></p>																			
										</c:if>
									</c:forEach>
                                </div>
                            </div>
                        </div> 
                        
                        
                        <div class="col-xl-6">
                        <%-- table 1 --%>
						<div class="card mb-4"><%-- div mother of all table --%>
	                        <div class="card-header">
	                            <i class="fas fa-table me-1"></i>
	                            Các nhà hảo tâm
	                        </div>
	                        <div class="card-body" >
	                            <table id="datatablesSimple" style="font-size: 18px;">
	                                <thead>
	                                    <tr> 
	                                    	<th>STT</th>
	                                        <th>Nhà hảo tâm</th>                                        
	                                        <th style="text-align: center;">Số tiền đã quyên góp</th> <%-- <th>Số lượt quyên góp</th>  --%>                                      
	                                    	<th style="text-align: center;">Ngày thực hiện</th>	                                    	
	                                    </tr>
	                                </thead>
	                                <tfoot>
	                                    <tr>
	                                    	<th>STT</th> 
	                                        <th>Nhà hảo tâm</th>                                        
	                                        <th style="text-align: center;">Số tiền đã quyên góp</th>                                     
	                                    	<th style="text-align: center;">Ngày thực hiện</th>	                                    	
	                                    </tr>
	                                </tfoot>
	                                <tbody>
	                            	
									<%-- content of table --%> 
									<% int numericalOrder = 0; %>  	 
									<c:forEach var="donor" items="${ddList }">
										<c:if test="${Integer.toString(donation.getId()).equals(donor.getdID()) && donor.getMoney() > 0 && donor.getStatus().equals('Confirmed')  }">
											<tr>
												<%-- STT --%>
												<td>
													<%
													numericalOrder++;
													out.print(numericalOrder);
													%>
												</td>
												
												<%-- Nhà hảo tâm --%>
												<td>
													<c:choose>
														<c:when test="${donor.getAcc() != 'anonymous' }">
															<c:forEach var="acc" items="${listAcc }">
																<c:if test="${donor.getAcc().equals(acc.getAccount()) }">
																	<p>${acc.getLastName()} ${acc.getName()}</p>
																</c:if>
															</c:forEach>
														</c:when>
														<c:otherwise>
															<p>Nhà hảo tâm</p>
														</c:otherwise>
													</c:choose>													
												</td>
																								
												<%-- Số tiền đã quyên góp --%>
												<td style="text-align: right;">${donor.getMoney() } USD</td>
												
												<%-- Ngày thực hiện --%>
												<td style="text-align: right;">${donor.getDate() }</td>												
											</tr>
										</c:if>
									</c:forEach>                           	
	                                    
	                                </tbody>
	                            </table>
	                        </div>
	                    </div>               
						<%-- table 1  --%>
                        </div>
                            
                                              
                    </div>                  
                </div>
            </main>

<c:import url="/jsp/footer.jsp"></c:import>