<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@page import="java.text.SimpleDateFormat"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- đây là trang quản lý tất cả các đợt quyên góp, kể cả các đợt chưa nhận được bất kỳ lượt quyên góp nào và kể cả đợt chưa triển khai --%>


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
	/*		
	for (DonationRound e : list) {
		if (dtDateNow.compareTo(e.getStartDate())<0) {
			out.print("<tr><td><a href='/QuyTuThienVanTinh/AdminForm?action=editofadminform&iddonationround=" + e.getId() + "'>Chỉnh sửa</a></td>");
		} else {
			out.print("<tr><td></td>");
		}
		
		out.print("<td>" + e.getTitle() + "</td><td>" + e.getSummary() + "</td><td>" + e.getStartDate() + "</td><td>" + e.getEndDate() + "</td>");
	
		if (dtDateNow.compareTo(e.getStartDate())<0) {									
			out.print("<td><form action='/QuyTuThienVanTinh/QueryAtAdminForm?action=delete&iddonationround=" + e.getId() + "' method='post'><input type='hidden' name='action' value='delete'><input type='hidden' name='iddonationround' value='" + e.getId() + "'></input><button onclick=\"return confirm('Bạn có chắc muốn xóa bản ghi này không?')\" type='submit' style='border-radius: 5.5px;'>Xóa</button></form></td></tr>");
		} else {
			out.print("<td></td></tr>");
		}		
	}
	*/
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
			if(Integer.toString(e.getId()).equals(d.getdID()) && d.getStatus().equals("Confirmed") && d.getMoney() > 0) {
				moneyTotalEachDR = moneyTotalEachDR + d.getMoney();
			}
		}
		e.setTotalMoney(moneyTotalEachDR);
	}							
	
	%>							
							



<div id="layoutSidenav_content"> <!-- CLOSE TAG OF THIS DIV TAG IS AT FOOTER.JSP -->
            <main>
                <div class="container-fluid px-4">
                    <h1 class="mt-4">Hệ thống quản lý các đợt quyên góp</h1>
                    <ol class="breadcrumb mb-4">
                        <li class="breadcrumb-item"><a href="index.html">Trang chủ</a></li>
                        <li class="breadcrumb-item active">Danh sách các đợt quyên góp</li>
                    </ol>
                    <div class="card mb-4">
                        <div class="card-body">
                        	<%-- 
                        	<%
                        	// position here to show at View for compare to Table below
							// add total of money into each donation round
							for (DonationRound e:list) {
								float moneyTotalEachDR = 0;
								for (DonorDetail d:ddList) {
									if(Integer.toString(e.getId()).equals(d.getdID())) {
										moneyTotalEachDR = moneyTotalEachDR + d.getMoney();
									}
								}
								e.setTotalMoney(moneyTotalEachDR);
								out.println("Đợt QG: " + e.getId() + "(" + e.getTitle() + ")" + " nhận được: " + e.getTotalMoney() + " USD<br><br>" );
							}							
							
							%>
							--%>
							
                            <table>
                                <tr>
                                    <th>Tổng số tiền đã quyên góp được</th>
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
                                    		if (d.getMoney() > 0) {
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
                                <%-- --%>
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
                                <tr>
                                	<td colspan="5" style="text-align: center;	"><i>*****</i></td>
                                </tr>                              
                                <tr>
                                    <th>Tổng số đợt QG đã và đang triển khai</th>
                                    <td style="width: 12px;"></td>
                                    <td style="text-align: right;">
                                    	<%
                                    	int countPassAndActive = 0;
                                    	float moneyPassAndActive = 0;                                    	
                                   		for (DonationRound e:list) {
                                       		if (e.getStartDate().before(dtDateNow)  ) {
                                       			countPassAndActive++;
                                       			moneyPassAndActive = moneyPassAndActive + e.getTotalMoney();
                                       		}
                                       	}                                     	
                                    	out.print(countPassAndActive);
                                    	%>
                                    </td>
                                    <td style="width: 12px;"></td>
                                    <td>đợt</td>
                                </tr>
                                 <tr>
                                	<td colspan="5" style="text-align: center;	"><i>Thống kê về các đợt QG đã và đang được triển khai</i></td>
                                </tr>
                                <tr>
                                	<th>Tổng số đợt quyên góp đã nhận được ít nhất 1 lượt quyên góp đã được xác nhận</th>
                                	<td style="width: 12px;"></td>
                                    <td style="text-align: right;">
                                		<%
                                		//Integer.toString() // 
                                		
                                		// temp List for removing elements
                                		List<DonorDetail> listTemp = new ArrayList<DonorDetail>();
                                    	for (DonorDetail d: ddList) {                                    		
                                    			listTemp.add(d);                                    		
                                    	}
                                    	//session.setAttribute("listTemp", listTemp);
                                    	
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
                                	<th>Tổng số đợt quyên góp (đã triển khai) chưa nhận được bất kỳ lượt quyên góp nào kể cả lượt đang chờ xác nhận</th>
                                	<td style="width: 12px;"></td>
                                    <td style="text-align: right;">
                                		<%
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
                                		%>                               		
                                	</td>
                                    <td style="width: 12px;"></td>
                                    <td>đợt</td>
                                </tr>
                                
                                 <tr>
                                	<th>Tổng số đợt quyên góp mà tất cả các lượt quyên góp đều chưa được xác nhận (kể cả bị hủy)</th>
                                	<td style="width: 12px;"></td>
                                    <td style="text-align: right;">
	                                	<%
	                                	// temp List for removing elements
                                		List<DonorDetail> listTemp2 = new ArrayList<DonorDetail>();
                                    	for (DonorDetail d: ddList) {                                    		
                                    			listTemp2.add(d);                                    		
                                    	}
                                    	
	                                	// duyệt trong List, cái nào có money > 0 và status là 'Confirmed' thì xóa đi, để còn lại sẽ là những lượt QG có status không phải Confirmed hoặc status là Confirmed nhưng money lại bằng 0                                     	
	                                	for (int i = 0; i < listTemp2.size(); i++) {
	                                		if (listTemp2.get(i).getMoney() > 0 && listTemp2.get(i).getStatus().equals("Confirmed") ) {
	                                			listTemp2.remove(i);
	                                			i--;
	                                		}
	                                	}
	                                	
	                                	// 1) size of Arraylist automatically update after elements removing
	                                	// 2) j decrease '1' after an element removing
										// duyệt trong List, so phần tử trước với các phần tử ở đằng sau, nếu có cái đằng sau nào giống ID thì xóa cái đằng sau đó đi
	                                	for (int i = 0; i < listTemp2.size(); i++) {
	                                		for (int j = i + 1; j < listTemp2.size(); j++) {
	                                			if (listTemp2.get(j).getdID().equals(listTemp2.get(i).getdID()) ) {
	                                				listTemp2.remove(j);
	                                				j--;	                                				
	                                			}
	                                		}
	                                	}
	                                	
	                                	
	                                	// duyệt trong list1 (mảng những lượt QG đã chuyển tiền vào tài khoản Quỹ, tức status là 'Confirmed'), tại từng phần tử của sẽ duyệt trong mảng list2 (mảng những lượt QG được xem như chưa quyên góp, tức status không phải là 'Confirmed') và so sánh về ID của đợt đang chọn, nếu giống thì sẽ loại bỏ phần tử đang dò duyệt tại list2. Mục đích để list2 không còn đợt nào có bất kỳ lượt nào có status là  'Confirmed'  => để tìm tổng số các đợt chưa từng nhận lượt QG nào
	                                	for (int i = 0; i < listTemp.size(); i++) {
	                                		for (int j = 0; j < listTemp2.size(); j++) {
	                                			if (listTemp.get(i).getdID().equals(listTemp2.get(j).getdID())) {
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
                                
                                <tr>
                                	<td colspan="5" style="text-align: center;	"><i>Các thống kê khác</i></td>
                                </tr>
                                <tr>
                                    <th>Tổng số đợt QG đã hết hạn (nhưng chưa đạt mục tiêu, bao gồm đợt QG chưa nhận được bất kỳ lượt QG nào, bao gồm cả đợt QG mà các lượt QG đều chưa được xác nhận)</th>
                                    <td style="width: 12px;"></td>
                                    <td style="text-align: right;">
                                    	<%
                                    	int countOverTime2 = 0;
                                    	for (DonationRound e:list) {
                                    		if (e.getEndDate().before(dtDateNow) && e.getTotalMoney() < e.getTargetMoney() ) {
                                    			countOverTime2++;
                                    		}
                                    	}                                    	
                                    	out.print(countOverTime2);
                                    	%>
                                    </td>
                                    <td style="width: 12px;"></td>
                                    <td>đợt</td>
                                </tr>
                                
                                <tr>
                                    <th>Tổng số đợt QG chưa triển khai</th>
                                    <td style="width: 12px;"></td>
                                    <td style="text-align: right;">
                                    	<%
                                    	int countPlan = 0;
                                    	for (DonationRound e:list) {
                                    		if (e.getStartDate().after(dtDateNow)) {
                                    			countPlan++;
                                    		}
                                    	}                                    	
                                    	out.print(countPlan);
                                    	%>
                                    </td>
                                    <td style="width: 12px;"></td>
                                    <td>đợt</td>
                                </tr>
                            </table>
                        </div>
                    </div>

                    <div class="card mb-4">
                        <div class="card-body">
                            <table style="width: 100%;">
                                <tr>
                                    <td><strong>Tạo mới một đợt quyên góp</strong></td>
                                    <td style="text-align: right;"><button class="btn-new csw-btn-button"  type="button" onclick="location.href='/QuyTuThienVanTinh/AdminForm?action=createofadminform';">Tạo mới</button></td> <!-- NOT GO DRIECTLY TO JSP, THROUGH THE SERVLET FOR SET VALUE OF ATTRIBUTE OF SESSION TO ""-->
                                    <!-- <td style="text-align: right;"><button class="btn-new csw-btn-button"  type="button" onclick="location.href='${pageContext.request.contextPath}/jsp/admin-form.jsp';">Tạo mới</button></td> this: there will not session.setAttribute("error-message", "")-->
                                </tr>
                            </table>
                        </div>
                    </div>

                    <div class="card mb-4">
                        <div class="card-header">
                            <i class="fas fa-table me-1"></i>
                            Danh sách các đợt quyên góp mà Admin đã tạo
                        </div>
                        <div class="card-body">
                            <table id="datatablesSimple">
                                <thead>
                                    <tr>
                                    	<th>STT</th>
                                        <th>Chỉnh sửa</th>
                                        <th>ID</th>
                                        <th>Tiêu đề</th>                                        
                                        <th>Ngày bắt đầu</th>
                                        <th>Ngày kết thúc</th>
                                        <th>Số tiền định mức</th>
                                        <th>Số lượt quyên góp</th>
                                        <th>Số tiền quyên góp</th>
                                        <th>Tình trạng</th>
                                        <th>Xóa</th>
                                    </tr>
                                </thead>
                                <tfoot>
                                    <tr>
                                    	<th>STT</th>
                                        <th>Chỉnh sửa</th>
                                        <th>ID</th>
                                        <th>Tiêu đề</th>                                        
                                        <th>Ngày bắt đầu</th>
                                        <th>Ngày kết thúc</th>
                                        <th>Số tiền định mức</th>
                                        <th>Số lượt quyên góp</th>
                                        <th>Số tiền quyên góp</th>
                                        <th>Tình trạng</th>
                                        <th>Xóa</th>
                                    </tr>
                                </tfoot>
                                <tbody>
                                
                                
                                                                                                
                            	<%-- content of title header --%>
                            	<% int numericalOrder = 0; %>
								<c:forEach var="donation" items="${list }">
									<c:set scope="session" var="totalMoneyEachDonation" value="${Integer.toString(donation.getId()) }" ></c:set>
									<tr>
									<%-- STT --%>
									<td>
										<%
										numericalOrder++;
										out.print(numericalOrder);
										%>
									</td>			                                              
			                        
									<%-- Chỉnh sửa button --%>
									<c:choose>
										<c:when test="${dtDateNow.compareTo(donation.getStartDate())<0 }"><%-- just show donation round that have start date <= date of now --%>
											<td><a href="/QuyTuThienVanTinh/AdminForm?action=editofadminform&iddonationround=${donation.getId() }" >Chỉnh sửa</a></td>
										</c:when>
										<c:otherwise>
											<td></td>
										</c:otherwise>									
									</c:choose>
									
									<%-- content --%>										
			                        <td>ID${donation.getId() }</td><%-- ID --%>  
									<td>${donation.getTitle() }</td>									
									<td>${donation.getStartDate() }</td>
									<td>${donation.getEndDate() }</td>
									<td>${String.format("%.2f", donation.getTargetMoney()) }</td>
									<td><%--Tổng số lượt quyên góp--%>										 
										<%
										int count = 0;
										 for (DonorDetail d : ddList) {
										 	if (session.getAttribute("totalMoneyEachDonation").equals(d.getdID())) {
										 		if (d.getStatus().equals("Confirmed") && d.getMoney() > 0) {
										 			count++;
										 		}										 		
										 	}
										 }
										 out.print(count);
										 %>
									</td>
									<td><%-- Tổng số tiền quyên góp --%>								 
										<%
										float totalMoney = 0;
										//String donationRound = session.getAttribute("totalMoneyEachDonation"); // this code does not work => cannot convert from Object to String
										for (DonorDetail d:ddList) {
											if (session.getAttribute("totalMoneyEachDonation").equals(d.getdID())) {
												if (d.getStatus().equals("Confirmed") ) {
													totalMoney = totalMoney + d.getMoney();
												}												
											}
										}
										out.print(String.format("%.2f", totalMoney)+" USD");
										%>																														
									</td>
									<%-- 'Tình trạng' --%>
									<c:choose>
										<c:when test="${dtDateNow.compareTo(donation.getStartDate())<0 }"><%-- just show donation round that have start date <= date of now --%>
											<td>Chưa triển khai</td>
										</c:when>
										<c:when test="${donation.getTotalMoney() < donation.getTargetMoney() && now.before(donation.getEndDate()) || now.equals(donation.getEndDate()) }"><%-- 'time left': vẫn chưa hết hạn (còn nhận $ tiền góp) --%>
                                      		<td><a href="/QuyTuThienVanTinh/Controller?action=donate&donationId=${donation.getId()}&donationName=${donation.getTitle() }">Còn nhận quyên góp</a></td>
                                      	</c:when>
                                      	<c:when test="${now.after(donation.getEndDate()) && donation.getTotalMoney() < donation.getTargetMoney() }"><%-- 'out of time': đã hết hạn --%>
                                      		<td>Hết thời hạn</td>
                                      	</c:when>
                                      	<c:when test="${donation.getTotalMoney() >= donation.getTargetMoney() }"><%-- 'enough': đợt QG đã đạt mục tiêu (đủ tiền) dù là chưa hết hạn, cũng sẽ khóa đợt QG này lại --%>
                                      		<td >Đạt mục tiêu</td>
                                      	</c:when>
										<c:otherwise>
											<td></td>
										</c:otherwise>									
									</c:choose>
									<%-- end of 'Tình trạng' --%>
									
									
									<%-- Xóa button --%>
									<c:choose>
										<c:when test="${dtDateNow.compareTo(donation.getStartDate())<0 }">
											<td style="text-align: center;">
											<form action="/QuyTuThienVanTinh/QueryAtAdminForm?action=delete&iddonationround=${donation.getId() }" method="post">
											<input type="hidden" name="action" value="delete"></input>
											<input type="hidden" name="iddonationround" value="${donation.getId() }"></input>
											<button onclick="return confirm('Bạn có chắc muốn xóa bản ghi này không?')" type="submit" style="border-radius: 5.5px;">Xóa</button>
											</form>
											</td>
										</c:when>
										<c:otherwise>
											<td></td>
										</c:otherwise>										
									</c:choose>
									</tr>
								</c:forEach>
								
								
                                    
                                    
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </main>
