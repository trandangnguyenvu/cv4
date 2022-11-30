<%-- file back up, using by delete 'back-up' at the file name --%>
<%-- search of index --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<sql:setDataSource var="ds" dataSource="jdbc/DonationDB" />

<sql:query dataSource="${ds}" var="results2"
	sql="select * from Partner">	
</sql:query>

<c:import url="/jsp/header.jsp?header=index"></c:import>


<div id="layoutSidenav_content"><%-- close div of this open div at footer jsp --%>
            <div>
                <img src="${pageContext.request.contextPath}/resources/image/banner.jpg" width="100%">
            </div>
            <main>
                <div class="container-fluid px-4">
                    <h2 class="mt-4" style="text-align: center;">Các hoàn cảnh quyên góp</h2>
                    <ol class="breadcrumb mb-4">
                        <li class="breadcrumb-item active">Dashboard</li>
                    </ol>
                    
                               
                                 
            <%@ page import="java.util.*,model.*,dao.*"%>
            <%@page import="java.text.SimpleDateFormat"%>
            
			<%-- pagination --%>
			<%  
			String spageid=request.getParameter("page");  
			int pageid=Integer.parseInt(spageid);  
			int offset = 0;
			int total=6;
			
		
			if(pageid==1){}  
			else{
					// mySQL	
			    //pageid=pageid-1;  
			    //pageid=pageid*total+1; 
			    
					// sqlServer	
				offset = (pageid - 1)*total;		
			}
			
			// Donation_Round table with pagination
			List<DonationRound> list = ListOfDonationRoundDAO.getRecords4Pagination(offset, total);  
			  
			session.setAttribute("page", spageid);
			//out.print("<h5>Trang: "+spageid+"</h5>");  
			//TABLE out.print("<table border='1' cellpadding='4' width='60%'>");			
			//TABLE-TH : out.print("<tr><th>Id</th><th>Name</th><th>des</th><th>price</th><th>src</th><th>type</th><th>brand</th></tr>");  
			
			session.setAttribute("listpagination", list);
			// list is an object => mọi thay đổi từ bản sao đều làm thay đổi bản gốc (copies just is the paths)
			
			/*
			for(DonationRound e:list){  
				//class='product-image'-- style='display:block;width:auto;height:auto;margin-left: auto;margin-right: auto;' -- style='padding-left:50px'
			    out.print("<div class='col-12 col-sm-12 col-md-4 col-lg-4 p-3'><a href='Controller?action=image&image=" + e.getId() +"'><img  style='display:block;width:100%;height:auto;margin-left: auto;margin-right: auto;' src='" + e.getTitle() + "'/></a><div>" + "<p>" + e.getPartnerId() +"</p>"+  "<p>" + e.getStartDate() + "</p>" + "<p>$ " + e.getEndDate() +"</p></div></div>");  
			}  
			*/
			//TABLE out.print("</table>");  
			%>			
			<!--<c:set scope="page" var="user" value="${results.rows[0]}"></c:set>-->
			<%-- pagination --%> 
			
			
			<%-- kiểm tra xem đã tới lúc kích hoạt đợt quyên góp hay chưa (ngày bắt đầu <= ngày hiện tại) --%>
			<%-- nếu đủ điều kiện kích hoạt thì kiểm tra xem đã quá ngày kết thúc chưa, nếu chưa thì tính số ngày còn lại tính từ hiện tại đến ngày kết thúc --%>
			<%
			// now
			Date dateNow = new Date();
			SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd");
			
			String ftDateNow = ft.format(dateNow); // Date to String + to "yyyy/MM/dd" format (for "yyyy/MM/dd" => must be String first )
			Date dtDateNow	= ft.parse(ftDateNow); // String to Date
			session.setAttribute("now", dtDateNow); // for test				
			%>
			
			<%-- find the total of pages that shows all donations from the list --%>
			<%
			ListOfDonationRoundDAO a = new ListOfDonationRoundDAO();
			int countDonations = a.countDonations();
			int totalOfPages = 0;
			if (countDonations % 6 == 0) {
				totalOfPages = countDonations / 6;
			} else {
				totalOfPages = countDonations / 6 + 1;
			}
			session.setAttribute("totalOfPages", totalOfPages);
			%>
			
			
			
			<%
			// Donor_detail table
			List<DonorDetail> ddList = DonorDetailDAO.getAllRecords4AdminJsp();
			%>
			
			<%            
			// add total of money into each donation round
			for (DonationRound e:list) {
				float moneyTotalEachDR = 0;
				for (DonorDetail d:ddList) {
					if(Integer.toString(e.getId()).equals(d.getdID())) {
						moneyTotalEachDR = moneyTotalEachDR + d.getMoney();
					}
				}
				e.setTotalMoney(moneyTotalEachDR);
			}							
			
			%>
 
 			
            						<h5>Trang: ${page } / Tổng số ${totalOfPages } trang</h5>
                             
            						<div class="row"><%-- start of div class="row" 1  --%>
            							<c:forEach var="donation" items="${listpagination}">
            								<c:set scope="session" var="totalMoneyEachDonation" value="${Integer.toString(donation.getId()) }" ></c:set>
            								<%-- <c:if test="${now.after(donation.getStartDate()) || now.equals(donation.getStartDate()) }"> not filter at here cause filtered at DAO--%> 
						                        <div class="col-xl-3 col-md-6">
						                            <div class="card bg-primary text-white mb-4">
						                                <div ><%-- class="card-body" --%><img class="st-img"
						                                        src="${pageContext.request.contextPath}/${donation.getImgSource1() }"><%-- hiển thị 1 ảnh --%>
						                                </div>
						                                	<div class="card-footer d-flex align-items-center justify-content-between"><%-- 1.1 --%>
						            							
						            							
						            							<div>
						            							<div style="position: static;">
						            							<table >
							                                        <tr >
							                                            <td colspan="3" style="padding-bottom: 20px;"><strong>${donation.getTitle() }</strong></td>
							                                        </tr>
							                                        <tr>
							                                        	<%-- hiển thị đối tác đồng hành --%>
							                                            <td style="font-size: small;" width="60%">
							                                            	<c:forEach var="partner" items="${results2.rows}">
																				<c:if test="${partner.partner_id == donation.getPartnerId()}">
																					<c:out value="${partner.partner_name}"></c:out>																				
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
							                                            		<c:out value="Còn lại  ${timeRemaining } ngày"></c:out> 							                                            		
							                                            	</c:if>						                                            	
							                                            </td>
							                                        </tr>
							                              		</table>
							                              		</div>
							                              		
							                               		<div style="position: static;"><%-- div style="position: static;" => make each table be at 1 line  --%>
							                               		<table style="width:100%"><%-- để nút Quyên at right => tạo 5 table nối tiếp: 1 chứa Lượt QG, 2 trống, 3 chứa Đạt được, 4 trống, 5 chứa nút Quyên góp --%>
							                                        <tr>
							                                            <td colspan="3" style="padding-bottom: 20px;">							                                            	
							                                            	Đã quyên góp được: 
								                                            <%
																			float totalMoney = 0;
																			//String donationRound = session.getAttribute("totalMoneyEachDonation"); // this code does not work => cannot convert from Object to String
																			for (DonorDetail d:ddList) {
																				if (session.getAttribute("totalMoneyEachDonation").equals(d.getdID())) {
																					totalMoney = totalMoney + d.getMoney();
																				}
																			}
																			out.print(String.format("%.0f", totalMoney));
																			%>
							                                                USD<br>
							                                                Định mức: ${donation.getTargetMoney() }	USD							                                                
							                                         	</td>
							                                        </tr>							                                       
							                                        <tr >								                                        	
							                                            <td width="35%" style="font-size: small;">Lượt quyên góp</td>
							                                            <td width="25%" style="font-size: small;">Đạt được</td>
							                                            <%-- còn thời thời hạn thì hiển thị button Quyên góp, hết thời hạn thì thông báo Đã hết thời hạn hoặc Đã đạt mục tiêu nếu số tiền nhận được đã đạt định mức --%>
							                                            <c:choose>
							                                            	<c:when test="${donation.getTotalMoney() < donation.getTargetMoney() && now.before(donation.getEndDate()) || now.equals(donation.getEndDate()) }"><%-- 'time left': vẫn chưa hết hạn (còn nhận $ tiền góp) --%>
							                                            		<td style="text-align: right;" rowspan="2"><button class="btn-qg" onclick="location.href='/QuyTuThienVanTinh/Controller?action=donate&donationId=${donation.getId()}&donationName=${donation.getTitle() }';">Quyên góp</button></td>
							                                            	</c:when>
							                                            	<c:when test="${now.after(donation.getEndDate()) && donation.getTotalMoney() < donation.getTargetMoney() }"><%-- 'out of time': đã hết hạn --%>
							                                            		<td style="text-align: right;" rowspan="2"><button class="btn-dqg">Hết thời hạn</button></td>
							                                            	</c:when>
							                                            	<c:when test="${donation.getTotalMoney() >= donation.getTargetMoney() }"><%-- 'enough': đợt QG đã đạt mục tiêu (đủ tiền) dù là chưa hết hạn, cũng sẽ khóa đợt QG này lại --%>
							                                            		<td style="text-align: right;" rowspan="2"><button class="btn-dqg">Đạt mục tiêu</button></td>
							                                            	</c:when>							                                            	
							                                            </c:choose>						                                                                                                
							                                        </tr>
							                                        <tr>
							                                            <td><%-- giá trị của tiêu đề 'Lượt quyên góp' --%>
							                                            	<%
																			int count = 0;
																			 for (DonorDetail d : ddList) {
																			 	if (session.getAttribute("totalMoneyEachDonation").equals(d.getdID())) {
																			 		count++;
																			 	}
																			 }
																			 out.print(count);
																			 %>
							                                            </td>
							                                            <td><%-- giá trị của tiêu đề 'Đạt được' --%>
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
					                    	<%-- </c:if> --%>
            							</c:forEach>
            						</div><%-- end of div class="row" 1  --%>
            						
            						
            						
            						<%-- pagination --%>
            						<div style="text-align: center;">
	            						<% for (int i = 1; i < totalOfPages; i++) { 
	            							out.print("<a href='/QuyTuThienVanTinh/Controller?page="+ i +"'>"+ i +"</a><span> | </span>");
	            						}
	            						out.print("<a href='/QuyTuThienVanTinh/Controller?page="+ totalOfPages +"'>"+ totalOfPages +"</a>");
	            						%>
            						
            							<%-- 
										<a href="/QuyTuThienVanTinh/Controller?page=1">1</a><span> | </span>
										<a href="/QuyTuThienVanTinh/Controller?page=2">2</a><span> | </span>
										<a href="/QuyTuThienVanTinh/Controller?page=3">3</a>	
										--%>	
									</div>
            						
                                    
                    
                    <%-- --%>
                    <div class="row">
                        <div class="col-xl-6">
                            <div class="card mb-4">
                                <div class="card-header">
                                    <i class="fas fa-chart-area me-1"></i>
                                    Area Chart Example
                                </div>
                                <div class="card-body"><canvas id="myAreaChart" width="100%" height="40"></canvas></div>
                            </div>
                        </div>
                        <div class="col-xl-6">
                            <div class="card mb-4">
                                <div class="card-header">
                                    <i class="fas fa-chart-bar me-1"></i>
                                    Bar Chart Example
                                </div>
                                <div class="card-body"><canvas id="myBarChart" width="100%" height="40"></canvas></div>
                            </div>
                        </div>
                    </div>
                    <div class="card mb-4">
                        <div class="card-header">
                            <i class="fas fa-table me-1"></i>
                            DataTable Example
                        </div>

                    </div>
                </div>
            </main>
<c:import url="/jsp/footer.jsp"></c:import>