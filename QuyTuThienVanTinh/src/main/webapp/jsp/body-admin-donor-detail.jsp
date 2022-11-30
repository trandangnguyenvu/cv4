<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@page import="java.text.SimpleDateFormat"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- trang này hiển thị danh sách các nhà hảo tâm đã tham gia quyên góp, liệt kê theo lượt bất kể lượt đó đã được admin xác nhận tiền đã vào tài khoản của quỹ hay chưa --%>


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
                    <h1 class="mt-4">Bảng danh sách các nhà hảo tâm</h1>
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
                                    <th>Tổng số lượt quyên góp</th>
                                    <td style="width: 12px;"></td>
                                    <td style="text-align: right;">
                                    	<%
                                    	int countTotal = 0;
                                    	for (DonorDetail d: ddList) {
                                    		if ( d.getMoney() > 0) {
                                    			countTotal++;
                                    		}
                                    	}
                                    	out.print(countTotal);
                                    	%>
                                    </td>
                                    <td style="width: 12px;"></td>
                                    <td>lượt</td>
                                </tr>
                                <tr>
                                    <th>Tổng số lượt quyên góp đã được xác nhận</th>
                                    <td style="width: 12px;"></td>
                                    <td style="text-align: right;">
                                    	<%
                                    	int countTotalConfir = 0;
                                    	for (DonorDetail d: ddList) {
                                    		if (d.getMoney() > 0 && d.getStatus().equals("Confirmed")) {
                                    			countTotalConfir++;
                                    		}
                                    	}
                                    	out.print(countTotalConfir);
                                    	%>
                                    </td>
                                    <td style="width: 12px;"></td>
                                    <td>lượt</td>
                                </tr>
                                <tr>
                                    <th>Tổng số lượt quyên góp đang chờ xác nhận</th>
                                    <td style="width: 12px;"></td>
                                    <td style="text-align: right;">
                                    	<%
                                    	int countTotalPending = 0;
                                    	for (DonorDetail d: ddList) {
                                    		if (d.getMoney() > 0 && d.getStatus().equals("Pending")) {
                                    			countTotalPending++;
                                    		}
                                    	}
                                    	out.print(countTotalPending);
                                    	%>
                                    </td>
                                    <td style="width: 12px;"></td>
                                    <td>lượt</td>
                                </tr>
                                <tr>
                                    <th>Tổng số lượt quyên góp đã bị hủy</th>
                                    <td style="width: 12px;"></td>
                                    <td style="text-align: right;">
                                    	<%
                                    	int countTotalReject = 0;
                                    	for (DonorDetail d: ddList) {
                                    		if (d.getMoney() > 0 && d.getStatus().equals("Rejected")) {
                                    			countTotalReject++;
                                    		}
                                    	}
                                    	out.print(countTotalReject);
                                    	%>
                                    </td>
                                    <td style="width: 12px;"></td>
                                    <td>lượt</td>
                                </tr>                                                                
                            </table>
                        </div>
                    </div>



                    <%-- table 1 --%>
					<div class="card mb-4"><%-- div mother of all table --%>
                        <div class="card-header">
                            <i class="fas fa-table me-1"></i>
                            Danh sách chi tiết các nhà hảo tâm
                        </div>
                        <div class="card-body">
                            <table id="datatablesSimple">
                                <thead>
                                    <tr> 
                                    	<th>STT</th>                                       
                                        <th>Đợt Quyên góp (ID)</th>                                        
                                        <th>Tên đợt quyên góp</th> 
                                        <th>Nhà hảo tâm</th>                                   
                                    	<th>Ngày quyên góp</th>
                                    	<th>Số tiền</th>
                                    	<th>Tình trạng</th>
                                    	<th>Xác nhận</th>
                                    	<th>Hủy</th>
                                    </tr>
                                </thead>
                                <tfoot>
                                    <tr>
                                    	<th>STT</th>
                                        <th>Đợt Quyên góp (ID)</th>                                        
                                        <th>Tên đợt quyên góp</th>  
                                        <th>Nhà hảo tâm</th>                                   
                                    	<th>Ngày quyên góp</th>
                                    	<th>Số tiền</th>
                                    	<th>Tình trạng</th>
                                    	<th>Xác nhận</th>
                                    	<th>Hủy</th>
                                    </tr>
                                </tfoot>
                                <tbody>
                            	
								<%-- content of table --%>
								<% int numericalOrder = 0; %>   	 
								<c:forEach var="donor" items="${ddListWithSort }"><%-- donation round ID unduplicated list --%>	
										<c:set scope="session" var="donationRoundID" value="${donor.getdID()}"></c:set>							
										<tr>
											<%-- STT --%>
											<td>
												<%
												numericalOrder++;
												out.print(numericalOrder);
												%>
											</td>
											
											<%-- Đợt Quyên góp --%>
											<c:forEach var="donation" items="${list }">
												<c:if test="${donor.getdID().equals(Integer.toString(donation.getId())) }">
													<td>ID${donation.getId() } </td>
												</c:if>												
											</c:forEach>
											
											
											<%--  Đợt Quyên góp (tên) --%>
											<c:forEach var="donation" items="${list }">
												<c:if test="${donor.getdID().equals(Integer.toString(donation.getId())) }">
													<td>ID${donation.getTitle() } </td>
												</c:if>												
											</c:forEach>									
											
											
											<%-- Nhà hảo tâm --%>
											<td>${donor.getAcc() }</td>
																						
											
											<%-- Ngày quyên góp --%>
											<td>${donor.getDate() }</td>
											
											
											<%-- Số tiền quyên góp --%>
											<td>${donor.getMoney() } USD</td>
											
											
											<%-- hiển thị status của 1 lượt QG  --%>
											<td>${donor.getStatus() }</td>
											
											
											<%-- comfirm rằng 1 lượt QG đã chuyển tiền vào tài khoản --%>
											<td style="text-align: center;">
												<c:if test="${donor.getStatus() == 'Pending' }">
													<form action="/QuyTuThienVanTinh/QueryAtAdminDonor?action=confirm&donorid=${donor.getiD() }" method="post">
													<input type="hidden" name="action" value="confirm"></input>
													<input type="hidden" name="donorid" value="${donor.getiD() }"></input>
													<button onclick="return confirm('Bạn có chắc muốn chấp nhận lượt quyên góp này không?')" type="submit" style="border-radius: 5.5px;">Confirm</button>
													</form>													
												</c:if>
											</td>
											
											
											<%-- reject (hủy) lượt QG đó --%>
											<td style="text-align: center;">
												<c:if test="${donor.getStatus() == 'Pending' }">
													<form action="/QuyTuThienVanTinh/QueryAtAdminDonor?action=reject&donorid=${donor.getiD() }" method="post">
													<input type="hidden" name="action" value="reject"></input>
													<input type="hidden" name="donorid" value="${donor.getiD() }"></input>
													<button onclick="return confirm('Bạn có chắc muốn hủy lượt quyên góp này không?')" type="submit" style="border-radius: 5.5px;">Reject</button>
													</form>													
												</c:if>
											</td>
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
