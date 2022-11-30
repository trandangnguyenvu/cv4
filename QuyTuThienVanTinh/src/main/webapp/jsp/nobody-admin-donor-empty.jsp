<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@page import="java.text.SimpleDateFormat"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- trang này hiển thị cấc đợt QG chưa có bất kỳ lượt QG nào kể cả lượt đang chờ xác nhận hoặc lượt đã bị hủy--%>
<%-- trang này không cần file body --%>
<%-- bảng liệt kê chi tiết các lượt QG cho trang này là trang detail-admin-donor.jsp --%>
<c:import url="/jsp/header.jsp"></c:import>



							<%@ page import="java.util.*,model.*,dao.*"%>   
							<% 
							// Donation_Round table
							List<DonationRound> list = ListOfDonationRoundDAO.getAllRecords4AdminJsp();
							Date dateNow = new Date();							
							
							SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd");
							
							String ftDateNow = ft.format(dateNow); // Date to String + to "yyyy/MM/dd" format (for "yyyy/MM/dd" => must be String first )
							Date dtDateNow	= ft.parse(ftDateNow); // String to Date 	
						
							session.setAttribute("list", list);
							session.setAttribute("dtDateNow", dtDateNow);							
							%>
							
							<%
							// Donor_detail table
							List<DonorDetail> ddList = DonorDetailDAO.getAllRecords4AdminJsp();
							session.setAttribute("ddList", ddList);
							%>
							<%                        	
							// add total of money into each donation round
							for (DonationRound e:list) {
								float moneyTotalEachDR = 0;
								for (DonorDetail d:ddList) {
									if(Integer.toString(e.getId()).equals(d.getdID()) && d.getStatus().equals("Confirmed") && d.getMoney() > 0 ) {
										moneyTotalEachDR = moneyTotalEachDR + d.getMoney();
									}
								}
								e.setTotalMoney(moneyTotalEachDR);
							}						
							%>
							
							
							<% 
							// get all records from Donor_detail with a sort by (order by) donation round ID
							List<DonorDetail> ddListWithSort = DonorDetailDAO.getAllRecordsWithSortbyDRID();
							session.setAttribute("ddListWithSort", ddListWithSort);
							%>
							



<div id="layoutSidenav_content"> <!-- CLOSE TAG OF THIS DIV TAG IS AT FOOTER.JSP -->
            <main>
                <div class="container-fluid px-4">
                    <h1 class="mt-4">DS các đợt Quyên góp chưa có bất cứ một lượt QG nào (kể cả đã bị hủy hoặc đang chờ xác nhận)</h1>
                    <ol class="breadcrumb mb-4">
                        <li class="breadcrumb-item"><a href="index.html">Trang chủ</a></li>
                        <li class="breadcrumb-item active">Danh sách các đợt quyên góp</li>
                    </ol>
                    <div class="card mb-4">
                        <div class="card-body">                       
                            <table>  
                                
                                <tr>
                                	<th>Tổng số đợt quyên góp (đã triển khai) chưa nhận được bất kỳ lượt quyên góp nào kể cả lượt đang chờ xác nhận</th>
                                	<td style="width: 12px;"></td>
                                    <td style="text-align: right;">
                                		<%
                                		/* cách 1: không có danh sách chi tiết, chỉ đếm tổng số
                                		int countNoneDonor = 0;
                                		for (DonationRound l:list) { 
                                			int countEqual = 0;
                                			if (l.getStartDate().before(dtDateNow)) { // những dự án đã và đang triển khai
                                				for (DonorDetail d:ddList) {                                				
                                    				if (Integer.toString(l.getId()).equals(d.getdID()) ) {
                                    					countEqual++;
                                    				}                                				
                                    			}
                                    			if (countEqual == 0) {
                                    				countNoneDonor++;
                                    			}
                                			}                                			
                                		}
                                		
                                    	out.print(countNoneDonor);  
                                    	*/
                                    	
                                    	
                                    	/*
                                    	 * cách 2: có danh sách chi tiết
                                    	 */
                                    	// temp List for removing elements
                                 		List<DonationRound> listTempEmpty = new ArrayList<DonationRound>();
                                     	for (DonationRound d: list) {                                    		
                                     		listTempEmpty.add(d);                                    		
                                     	}
                                     	session.setAttribute("listTempEmpty", listTempEmpty); 
                                     	
                                     	// loại bỏ đợt chưa triển khai
                                     	for (int i = 0; i < listTempEmpty.size(); i++) {                                  			
                                 			if (listTempEmpty.get(i).getStartDate().after(dtDateNow)) {
                                 				listTempEmpty.remove(i);
                             					i--;
                                 			}
                                     	}
                                     	
                                     	
                                    	int countNoneDonor = 0;
                                 		for (int i = 0; i < listTempEmpty.size(); i++) { 
                                 			int countEqual = 0;
                               				for (int j = 0; j < ddList.size(); j++) {                                				
                                   				if (Integer.toString(listTempEmpty.get(i).getId()).equals(ddList.get(j).getdID()) ) {
                                   					countEqual++;                                   					
                                   				}                                				
                                   			}
                                   			if (countEqual == 0) {
                                   				countNoneDonor++;
                                   			} else {
                                   				listTempEmpty.remove(i);
                               					i--;
                                   			}
                                 		}
                                 		
                                 		out.print(countNoneDonor);
                                		%>                               		
                                	</td>
                                    <td style="width: 12px;"></td>
                                    <td>đợt</td>
                                </tr>                                                            
                                                    
                            </table>
                        </div>
                    </div>



                    <%-- table 1 --%>
					<div class="card mb-4"><%-- div mother of all table --%>
                        <div class="card-header">
                            <i class="fas fa-table me-1"></i>
                            Danh sách các đợt Quyên góp chưa nhận được bất cứ lượt QG nào kể cả lượt đang chờ xác nhận
                        </div>
                        <div class="card-body">
                            <table id="datatablesSimple">
                                <thead>
                                    <tr>                                        
                                        <th>STT</th>
                                        <th>ID</th>
                                        <th>Đợt Quyên góp</th>                                        
                                        <th>Số tiền đã quyên góp</th> <%-- <th>Số lượt quyên góp</th>  --%>   
                                        <th>Số lượt quyên góp</th>                                    
                                    	<th>Ngày hết hạn</th>
                                    	<th>Tình trạng</th>                                    	
                                    </tr>
                                </thead>
                                <tfoot>
                                    <tr>
                                        <th>STT</th>
                                        <th>ID</th>
                                        <th>Đợt Quyên góp</th>                                        
                                        <th>Số tiền đã quyên góp</th>  
                                        <th>Số lượt quyên góp</th>                                    
                                    	<th>Ngày hết hạn</th>
                                    	<th>Tình trạng</th>                                    	
                                    </tr>
                                </tfoot>
                                <tbody>
                            	
								<%-- content of table --%> 
								<% int numericalOrder = 0; %>  	 
								<c:forEach var="donation" items="${listTempEmpty }">
								<%-- không thêm bất cứ code nào can thiệp vào list (object) 'listTempEmpty' ngoài những code tại mục liên quan, nếu không thì giá trị của list này sẽ thay đổi --%>										
										<c:set scope="session" var="donationRoundID" value="${donation.getId() }"></c:set>							
										<tr>
											<%-- STT --%>
											<td>
												<%
												numericalOrder++;
												out.print(numericalOrder);
												%>
											</td> 
											
											<%-- ID --%>										
											<td>ID${donation.getId() } </td>
											
											
											<%-- Đợt Quyên góp --%>											
											<td>${donation.getTitle() }</td>												
											
											
											<%-- Số tiền đã quyên góp --%>
											<%	
											// cách 1
											float moneyTotalPerDR = 0;
											for (DonorDetail d: ddList) {
												if (session.getAttribute("donationRoundID").equals(d.getdID())) {													
													moneyTotalPerDR = moneyTotalPerDR + d.getMoney();																										
												}
											}
											out.print("<td>" + moneyTotalPerDR + "</td>");
											/* cách 2
											<td>${donation.getTotalMoney() }</td>
											*/
											%>											
											
											
											<%-- Số lượt quyên góp --%>
											<%
											int countDR = 0;
											for (DonorDetail d: ddList) {
												if (session.getAttribute("donationRoundID").equals(d.getdID()) ) {
													countDR++;
												}
											}
											out.print("<td>" + countDR + "</td>");
											%>
											
											
											<%-- Ngày hết hạn --%>											
											<td>${donation.getEndDate() }</td>												
											
											
											<%-- tình trạng --%>										
											<c:choose>
                                            	<c:when test="${donation.getTotalMoney() < donation.getTargetMoney() && dtDateNow.before(donation.getEndDate()) || dtDateNow.equals(donation.getEndDate()) }"><%-- 'time left': vẫn chưa hết hạn (còn nhận $ tiền góp) --%>
                                            		<td><a href="/QuyTuThienVanTinh/Controller?action=donate&donationId=${donation.getId()}&donationName=${donation.getTitle() }">Còn nhận quyên góp</a></td>
                                            	</c:when>
                                            	<c:when test="${dtDateNow.after(donation.getEndDate()) && donation.getTotalMoney() < donation.getTargetMoney() }"><%-- 'out of time': đã hết hạn --%>
                                            		<td>Hết thời hạn</td>
                                            	</c:when>
                                            	<c:when test="${donation.getTotalMoney() >= donation.getTargetMoney() }"><%-- 'enough': đợt QG đã đạt mục tiêu (đủ tiền) dù là chưa hết hạn, cũng sẽ khóa đợt QG này lại --%>
                                            		<td>Đạt mục tiêu</td>
                                            	</c:when>							                                            	
                                            </c:choose>											
											<%-- end of 'Tình trạng' --%>	
											
										</tr>									
								</c:forEach>                           	
                                    
                                </tbody>
                            </table>
                        </div>
                    </div>               
					<%-- table 1  --%>


					
					<%-- table TEST: way 2 of table 1 --%>
                    	<%-- code here moved to 'body-user-donnor-jsp-table-test-way-2-for-table1' NOTEPAD FILE --%>              
                	<%-- table TEST: way 2 of table 1  --%>
                
                
                
            </main>
<c:import url="/jsp/footer.jsp"></c:import>
