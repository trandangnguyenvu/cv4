<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@page import="java.text.SimpleDateFormat"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- DANH SÁCH LIỆT KÊ HOẠT ĐỘNG QG CỦA TÀI KHOẢN ĐANG ĐĂNG NHẬP --%>


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
                    <h1 class="mt-4">Bảng danh sách hoạt động quyên góp của bạn</h1>
                    <ol class="breadcrumb mb-4">
                        <li class="breadcrumb-item"><a href="index.html">Trang chủ</a></li>
                        <li class="breadcrumb-item active">Danh sách các đợt quyên góp</li>
                    </ol>
                    <div class="card mb-4">
                        <div class="card-body">                       
                            <table>
                            	<tr>
                                    <th>Tổng số tiền đã quyên góp</th>
                                    <td style="width: 12px;"></td>
                                    <td style="text-align: right;">
                                    	<%
                                    	User loginAccount = (User) session.getAttribute("loginAccount");
                                    	float moneyTotal = 0;
                                    	for (DonorDetail d: ddList) {
                                    		if (loginAccount.getAccount().equals(d.getAcc())) {
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
                                    <th>Tổng số tiền đã quyên góp (đã được xác nhận)</th>
                                    <td style="width: 12px;"></td>
                                    <td style="text-align: right;">
                                    	<%
                                    	User loginAccount2 = (User) session.getAttribute("loginAccount");
                                    	float moneyTotal2 = 0;
                                    	for (DonorDetail d: ddList) {
                                    		if (loginAccount2.getAccount().equals(d.getAcc())) {
                                    			if (d.getStatus().equals("Confirmed")) {
                                    				moneyTotal2 = moneyTotal2 + d.getMoney();
                                    			}                                    			
                                    		}                                    		
                                    	}
                                    	out.print(String.format("%.2f",moneyTotal2));
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
                                    		if (loginAccount.getAccount().equals(d.getAcc()) && d.getMoney() > 0) {
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
                                    <th>Tổng số lượt quyên góp (đã được xác nhận)</th>
                                    <td style="width: 12px;"></td>
                                    <td style="text-align: right;">
                                    	<%
                                    	int countTotal3 = 0;
                                    	for (DonorDetail d: ddList) {
                                    		if (loginAccount.getAccount().equals(d.getAcc()) && d.getMoney() > 0 && d.getStatus().equals("Confirmed")) {
                                    			countTotal3++;
                                    		}
                                    	}
                                    	out.print(countTotal3);
                                    	%>
                                    </td>
                                    <td style="width: 12px;"></td>
                                    <td>lượt</td>
                                </tr>
                                <tr>
                                    <th>Tổng số đợt QG đã tham gia</th>
                                    <td style="width: 12px;"></td>
                                    <td style="text-align: right;">
                                    	<%                                    	
                                    	// for (int j = i; ... )                                    	                                    	
                                    	float moneyJoin = 0;
                                    	List<DonorDetail> listTemp = new ArrayList<DonorDetail>();
                                    	for (DonorDetail d: ddList) {
                                    		if (loginAccount.getAccount().equals(d.getAcc())) {
                                    			listTemp.add(d);
                                    		}
                                    	}
                                    	// show listTemp for test
                                    	//out.print("List chưa xóa: ");
                                    	//for (DonorDetail l:listTemp) {
                                    	//	out.print(l.getdID() + ", ");
                                    	//}
                                    	                                    	
                                    	
                                    	for (int i = 0; i < listTemp.size(); i++) {
                                    		for (int j = i + 1; j < listTemp.size(); j++) {
                                    			if (listTemp.get(j).getdID().equals(listTemp.get(i).getdID())) {
                                    				listTemp.remove(j);
                                    				j--;
                                    			}
                                    		}
                                    	}
                                    	// show listTemp for test
                                    	//out.print("List đã xóa: ");
                                    	//for (DonorDetail l:listTemp) {
                                    	//	out.print(l.getdID() + ", ");
                                    	//}
                                    	int sizeOfListTemp = listTemp.size();
                                    	out.print(sizeOfListTemp);
                                    	%>
                                    </td>
                                    <td style="width: 12px;"></td>
                                    <td>đợt</td>
                                </tr>  
                                
                                <tr>
                                    <th>Tổng số đợt QG đã tham gia (đã được xác nhận)</th>
                                    <td style="width: 12px;"></td>
                                    <td style="text-align: right;">                                   	
                                    	<%                                		
                                		// temp List for removing elements
                                		List<DonorDetail> listTemp2 = new ArrayList<DonorDetail>();
                                    	for (DonorDetail d: ddList) { 
                                    		if (loginAccount.getAccount().equals(d.getAcc())) {
                                    			listTemp2.add(d);
                                    		}                                    			                                    		
                                    	}                                    	
                                    	
                                    	// duyệt trong List, cái nào có money = 0 và status không phải là 'Confirmed' thì xóa đi                                    	
                                    	for (int i = 0; i < listTemp2.size(); i++) {
                                    		if (listTemp2.get(i).getMoney() == 0 || !listTemp2.get(i).getStatus().equals("Confirmed") ) {
                                    			listTemp2.remove(i);
                                    			i--;
                                    		}
                                    	}
                                    	                                    	
										// duyệt trong List, so phần tử trước với các phần tử ở đằng sau, nếu có cái đằng sau nào giống ID thì xóa cái đằng sau đó đi
                                    	for (int i = 0; i < listTemp2.size(); i++) {
                                    		for (int j = i + 1; j < listTemp2.size(); j++) {
                                    			if (listTemp2.get(j).getdID().equals(listTemp2.get(i).getdID()) ) {
                                    				listTemp2.remove(j);
                                    				j--;
                                    			}
                                    		}
                                    	}
                                    	
                                    	
                                    	int sizeOfListTemp2 = listTemp2.size();
                                    	out.print(sizeOfListTemp2);                                    	
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
                            Danh sách chi tiết các hoạt động Quyên góp
                        </div>
                        <div class="card-body">
                            <table id="datatablesSimple">
                                <thead>
                                    <tr> 
                                    	<th>STT</th>   
                                    	<th>ID đợt quyên góp</th>                                    
                                        <th>Đợt Quyên góp</th>                                        
                                        <th>Số tiền đã quyên góp</th> <%-- <th>Số lượt quyên góp</th>  --%>                                      
                                    	<th>Ngày thực hiện</th>
                                    	<th>Tình trạng</th>
                                    </tr>
                                </thead>
                                <tfoot>
                                    <tr>
                                    	<th>STT</th> 
                                    	<th>ID đợt quyên góp</th> 
                                        <th>Đợt Quyên góp</th>                                        
                                        <th>Số tiền đã quyên góp</th>                                     
                                    	<th>Ngày thực hiện</th>
                                    	<th>Tình trạng</th>
                                    </tr>
                                </tfoot>
                                <tbody>
                            	
								<%-- content of table --%> 
								<% int numericalOrder = 0; %>  	 
								<c:forEach var="donor" items="${ddListWithSort }">
									<c:if test="${loginAccount.getAccount().equals(donor.getAcc()) }">
										<tr>
											<%-- STT --%>
											<td>
												<%
												numericalOrder++;
												out.print(numericalOrder);
												%>
											</td>
											
											<td>ID${donor.getdID() }</td>
											
											<%-- Đợt Quyên góp --%>
											<c:forEach var="donation" items="${list }">
												<c:if test="${donor.getdID().equals(Integer.toString(donation.getId())) }">
													<td>${donation.getTitle() }</td>
												</c:if>												
											</c:forEach>
											
											<%-- Số tiền đã quyên góp --%>
											<td>${donor.getMoney() } USD</td>
											
											<%-- Ngày thực hiện --%>
											<td>${donor.getDate() }</td>
											
											<%-- Tình trạng --%>
											<td>${donor.getStatus() }</td>
										</tr>
									</c:if>
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
