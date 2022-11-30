<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@page import="java.text.SimpleDateFormat"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- trang này chỉ hiển thị các đợt quyên góp, và trang cũng chỉ hiển thị các đợt đã nhận được ít nhất 1 lượt quyên góp mà lượt đó đã được xác nhận (không hiển thị đợt QG chưa triển khai--%>
<%-- bảng liệt kê chi tiết các lượt (đã được xác nhận cho trang này là trang detail-admin-donor.jsp --%>
<%-- trang hiển thị các đợt có các lượt đang chờ xác nhận là nobody-admin-donor-pending.jsp--%>
<c:set scope="session" var="action" value="${param.action}"></c:set> 
<%-- for 'Back' button at detail-admin-donor.jsp--%>


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
                    <h1 class="mt-4">Danh sách các đợt QG đã xác nhận lượt</h1>
                    <ol class="breadcrumb mb-4">
                        <li class="breadcrumb-item"><a href="index.html">Trang chủ</a></li>
                        <li class="breadcrumb-item active">Danh sách các đợt quyên góp</li>
                    </ol>
                    <div class="card mb-4">
                        <div class="card-body">                       
                            <table>
                                <tr>
                                    <th>Tổng số tiền đã được quyên góp</th>
                                    <td style="width: 12px;"></td>
                                    <td style="text-align: right;">
                                    	<%                                    	
                                    	float moneyTotal = 0;
                                    	for (DonorDetail d: ddList) {    
                                    		if (d.getStatus().equals("Confirmed")) {
                                    			moneyTotal = moneyTotal + d.getMoney(); 
                                    		}                                    			                                   		                                    		
                                    	}
                                    	out.print(String.format("%.2f",moneyTotal));
                                    	%>
                                    </td>
                                    <td style="width: 12px;"></td>
                                    <td>USD</td>
                                </tr>
                                
                                <tr>
                                	<td colspan="5" style="text-align: center;	"><i>Thống kê về các đợt QG đã có lượt quyên góp</i></td>
                                </tr>
                                <tr>
                                	<th>Tổng số đợt quyên góp đã nhận được ít nhất 1 lượt quyên góp đã được xác nhận <i>* * (DS chi tiết ở bên dưới) * *</i></th>
                                	<td style="width: 12px;"></td>
                                    <td style="text-align: right;">
                                		<%
                                		//Integer.toString() // 
                                		
                                		// temp List for removing elements
                                		List<DonorDetail> listTemp = new ArrayList<DonorDetail>();
                                    	for (DonorDetail d: ddList) {                                    		
                                    			listTemp.add(d);                                    		
                                    	}
                                    	session.setAttribute("listTemp", listTemp);
                                    	
                                    	// duyệt trong List, cái nào có money = 0 và status không phải là 'Confirmed' thì xóa đi                                    	
                                    	for (int i = 0; i < listTemp.size(); i++) {
                                    		if (listTemp.get(i).getMoney() == 0 || !listTemp.get(i).getStatus().equals("Confirmed") ) {
                                    			listTemp.remove(i);
                                    			i--;
                                    		}
                                    	}
                                    	
                                    	// 1) size of Arraylist automatically update after elements removing
                                    	// 2) j decrease '1' after an element removing
										// duyệt trong List, so phần tử trước với các phần tử ở đằng sau, nếu có cái đằng sau nào giống ID thì xóa cái đằng sau đó đi
                                    	for (int i = 0; i < listTemp.size(); i++) {
                                    		for (int j = i + 1; j < listTemp.size(); j++) {
                                    			if (listTemp.get(j).getdID().equals(listTemp.get(i).getdID()) ) {
                                    				listTemp.remove(j);
                                    				j--;
                                    			}
                                    		}
                                    	}
                                    	
                                    	
                                    	int sizeOfListTemp = listTemp.size();
                                    	out.print(sizeOfListTemp);                                    	
                                		%>                               		
                                	</td>
                                    <td style="width: 12px;"></td>
                                    <td>đợt</td>
                                </tr>
                                
                                
                                <tr>
                                    <th>Tổng số đợt QG đạt mục tiêu (bao gồm đã hết và chưa hết hạn)</th><%-- BAO GỒM CHƯA HẾT HẠN VÀ ĐÃ HẾT HẠN --%>
                                    <td style="width: 12px;"></td>
                                    <td style="text-align: right;">
                                    	<%
                                    	int countEnough = 0;
                                    	float moneyEnough = 0;                                    	
                                   		for (DonationRound e:list) {
                                       		if (e.getTotalMoney() >= e.getTargetMoney() ) {
                                       			countEnough++;
                                       			moneyEnough = moneyEnough + e.getTotalMoney();
                                       		}
                                       	}                                     	
                                    	out.print(countEnough);
                                    	%>
                                    </td>
                                    <td style="width: 12px;"></td>
                                    <td>đợt</td>
                                </tr>
                                <tr>
                                    <th>Tổng số đợt QG đạt mục tiêu nhưng chưa hết hạn</th>
                                    <td style="width: 12px;"></td>
                                    <td style="text-align: right;">
                                    	<%
                                    	int countEnoughButStillActive = 0;
                                    	float moneyEnoughButStillActive = 0;                                    	
                                   		for (DonationRound e:list) {
                                       		if (e.getTotalMoney() >= e.getTargetMoney() && e.getEndDate().after(dtDateNow)) {
                                       			countEnoughButStillActive++;
                                       			moneyEnoughButStillActive = moneyEnoughButStillActive + e.getTotalMoney();
                                       		}
                                       	}                                     	
                                    	out.print(countEnoughButStillActive);
                                    	%>
                                    </td>
                                    <td style="width: 12px;"></td>
                                    <td>đợt</td>
                                </tr>
                                
                                <tr>
                                    <th>Tổng số đợt QG đang nhận QG (đã nhận được quyên góp nhưng chưa đạt mục tiêu)</th>
                                    <td style="width: 12px;"></td>
                                    <td style="text-align: right;">
                                    	<%
                                    	int countActive = 0;
                                    	for (DonationRound e:list) { // không cần đk status... là "Confirmed" vì ở trên: có Confirm thì mới add money từ ddlist vào list
                                    		if (e.getEndDate().after(dtDateNow) && e.getTotalMoney() > 0 && e.getTotalMoney() < e.getTargetMoney() ) {
                                    			countActive++;
                                    		}
                                    	}                                    	
                                    	out.print(countActive);
                                    	%>
                                    </td>
                                    <td style="width: 12px;"></td>
                                    <td>đợt</td>
                                </tr>
                                
                                 <tr>
                                    <th>Tổng số đợt QG đã hết hạn (đã nhận được quyên góp nhưng chưa đạt mục tiêu)</th>
                                    <td style="width: 12px;"></td>
                                    <td style="text-align: right;">
                                    	<%
                                    	int countOverTime = 0;
                                    	for (DonationRound e:list) {
                                    		if (e.getEndDate().before(dtDateNow) && e.getTotalMoney() > 0 && e.getTotalMoney() < e.getTargetMoney() ) {
                                    			countOverTime++;
                                    		}
                                    	}                                    	
                                    	out.print(countOverTime);
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
                            Danh sách các đợt Quyên góp đã nhận được lượt QG (đã được xác nhận)
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
                                    	<th>Chi tiết</th>
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
                                    	<th>Chi tiết</th>
                                    </tr>
                                </tfoot>
                                <tbody>
                            	
								<%-- content of table --%> 
								<% int numericalOrder = 0; %>  	 
								<c:forEach var="donor" items="${listTemp }">
								<%-- không thêm bất cứ code nào can thiệp vào list (object) 'listTemp' ngoài những code tại mục 'Tổng số đợt quyên góp đã nhận được ít nhất 1 lượt quyên góp đã được xác nhận', nếu không thì giá trị của list này sẽ thay đổi --%>										
										<c:set scope="session" var="donationRoundID" value="${donor.getdID()}"></c:set>							
										<tr>
											<%-- STT --%>
											<td>
												<%
												numericalOrder++;
												out.print(numericalOrder);
												%>
											</td> 
											
											<%-- ID --%>
											<c:forEach var="donation" items="${list }">
												<c:if test="${donor.getdID().equals(Integer.toString(donation.getId())) }">
													<td>ID${donation.getId() } </td>
												</c:if>												
											</c:forEach>
											
											<%-- Đợt Quyên góp --%>
											<c:forEach var="donation" items="${list }">
												<c:if test="${donor.getdID().equals(Integer.toString(donation.getId())) }">
													<td>${donation.getTitle() }</td>
												</c:if>												
											</c:forEach>
											
											
											<%-- Số tiền đã quyên góp --%>
											<%	
											float moneyTotalPerDR = 0;
											for (DonorDetail d: ddList) {
												if (session.getAttribute("donationRoundID").equals(d.getdID())) {
													if (d.getStatus().equals("Confirmed") ) {
														moneyTotalPerDR = moneyTotalPerDR + d.getMoney();
													}													
												}
											}
											out.print("<td>" + moneyTotalPerDR + "</td>");
											%>											
											
											
											<%-- Số lượt quyên góp --%>
											<%
											int countDR = 0;
											for (DonorDetail d: ddList) {
												if (session.getAttribute("donationRoundID").equals(d.getdID()) && d.getMoney() > 0 && d.getStatus().equals("Confirmed")) {
													countDR++;
												}
											}
											out.print("<td>" + countDR + "</td>");
											%>
											
											
											<%-- Ngày hết hạn --%>
											<c:forEach var="donation" items="${list }">
												<c:if test="${donor.getdID().equals(Integer.toString(donation.getId())) }">
													<td>${donation.getEndDate() }</td>
												</c:if>												
											</c:forEach>
											
											
											<%-- tình trạng --%>
											<c:forEach var="donation" items="${list }">
												<c:if test="${donor.getdID().equals(Integer.toString(donation.getId())) }">
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
												</c:if>
											</c:forEach>
											<%-- end of 'Tình trạng' --%>
											
											<td><a href="/QuyTuThienVanTinh/Controller?action=detaildonor&iddonationround=${donor.getdID()}">Detail</a></td>										
											
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
