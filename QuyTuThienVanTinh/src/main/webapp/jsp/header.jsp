<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>Quỹ từ thiện Vạn Tình</title>
    <link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/resources/css/styles.css" rel="stylesheet" />
    <script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
    
    <%-- ckeditor.js 
	<script type="text/javascript" src="${pageContext.request.contextPath}/libraries/ckeditor5-build-classic/ckeditor.js">
	</script>
	--%>
	
	<%-- this just for Carousel Plugin of images at one.jsp --%>
	<c:if test="${param.header == 'one' }">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
	  	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	  	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
	</c:if>
	<%-- this just for Carousel Plugin of images at one.jsp --%>
</head>

<body class="sb-nav-fixed">
    <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
        <!-- Navbar Brand-->
        <img src="${pageContext.request.contextPath}/resources/image/logo-1.jpg" width="4%" style="margin-left: 5px;border-radius:50%;">
        <a class="navbar-brand ps-3" href="index.html">Quỹ từ thiện Vạn tình</a>
        <!-- Sidebar Toggle-->
        <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!"><i
                class="fas fa-bars"></i></button>
                
        
        <%@ page import="java.util.*,model.*,dao.*"%>
        <%        
        User loginAcc =  (User) session.getAttribute("loginAccount"); // for check the role
        session.setAttribute("loginAcc", loginAcc);
        %>
        
        
        <!-- Navbar Search -->
        <%-- 
		<c:choose>
			<c:when test="${psearchuser == 'ptrue' }">
				<form
					class="d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0"
					action="/QuyTuThienVanTinh/QueryAtAdminUser?action=search"
					method="post"><!-- search bar of admin-user (account searching) -->
			</c:when>
			<c:otherwise>
				<form
					class="d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0"
					action="/QuyTuThienVanTinh/QueryAtAdminForm?action=search"
					method="post"><!-- search bar of admin (donation round searching) -->
			</c:otherwise>
		</c:choose>
		--%>
		<c:choose><%-- only-header-of-index-has-search --%>
			<c:when test="${param.header == 'index' }">
				<form
					class="d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0"
					action="/QuyTuThienVanTinh/Controller?action=search" method="get">
					<div class="input-group">
						<input type="hidden" name="action" value="search"> <input
							name="characters" class="form-control" type="text"
							placeholder="Search for..." aria-label="Search for..."
							aria-describedby="btnNavbarSearch" />
						<button class="btn btn-primary" id="btnNavbarSearch" type="submit">
							<i class="fas fa-search"></i>
						</button>
					</div>
				</form>
			</c:when>
			<c:otherwise>
				<div class="input-group"></div>
			</c:otherwise>
		</c:choose>	
        
        
        
        <!-- Navbar-->
        <ul class="navbar-nav ms-auto ms-md-0 me-3 me-lg-4">
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown"
                    aria-expanded="false"><i class="fas fa-user fa-fw"></i></a>
                <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                    <li><a class="dropdown-item" href="#!">Settings</a></li>
                    <li><a class="dropdown-item" href="#!">Activity Log</a></li>
                    <li>
                        <hr class="dropdown-divider" />
                    </li> 
                    <c:if test="${loginAcc.getRole() == null || loginAcc.getRole() == ''}">                    
                    	<a class="dropdown-item" href="/QuyTuThienVanTinh/Controller?action=login">Đăng nhập</a>                    
                    </c:if>
                    <c:if test="${loginAcc.getRole() == 'Admin' || loginAcc.getRole() == 'User'}">
                    	<li><a class="dropdown-item" href="#">Xin chào, tài khoản: ${loginAcc.getAccount() }</a></li><%-- href="#!" --%>
                    	<li><a class="dropdown-item" href="/QuyTuThienVanTinh/Controller?action=logout">Đăng xuất</a></li><%-- href="#!" --%>
                    </c:if>                  
                </ul>
            </li>
        </ul>
    </nav>
    <div id="layoutSidenav"> <!-- CLOSE TAG OF THIS DIV TAG IS AT FOOTER.JSP -->
        <div id="layoutSidenav_nav">
            <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
                <div class="sb-sidenav-menu">
                    <div class="nav">
                        <div class="sb-sidenav-menu-heading">Core</div>
                        <a class="nav-link" href="/QuyTuThienVanTinh/Controller">
                            <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                            Dashboard
                        </a>
                        <div class="sb-sidenav-menu-heading">Interface</div>
                        <a class="nav-link collapsed" href="#" data-bs-toggle="collapse"
                            data-bs-target="#collapseLayouts" aria-expanded="false" aria-controls="collapseLayouts">
                            <div class="sb-nav-link-icon"><i class="fas fa-columns"></i></div>
                            Layouts
                            <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                        </a>
                        <div class="collapse" id="collapseLayouts" aria-labelledby="headingOne"
                            data-bs-parent="#sidenavAccordion">
                            <nav class="sb-sidenav-menu-nested nav">
                                <a class="nav-link" href="layout-static.html">Static Navigation</a>
                                <a class="nav-link" href="layout-sidenav-light.html">Light Sidenav</a>
                            </nav>
                        </div>
                        <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapsePages"
                            aria-expanded="false" aria-controls="collapsePages">
                            <div class="sb-nav-link-icon"><i class="fas fa-book-open"></i></div>
                            Chức năng
                            <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                        </a>
                        <div class="collapse" id="collapsePages" aria-labelledby="headingTwo"
                            data-bs-parent="#sidenavAccordion">
                            <nav class="sb-sidenav-menu-nested nav accordion" id="sidenavAccordionPages">
                            	<c:if test="${loginAcc.getRole() == 'Admin' && loginAcc.getStatus() == 'Hoạt động'}">
                            		<a class="nav-link collapsed" href="/QuyTuThienVanTinh/Controller?action=admindonation" >
                                    	Quản lý quyên góp
                                	</a>
                            		<a class="nav-link collapsed" href="/QuyTuThienVanTinh/Controller?action=adminuser" >
                                    	Quản lý Người dùng
                                	</a>
                                	<a class="nav-link collapsed" href="/QuyTuThienVanTinh/Controller?action=donnortableforadminfull" >
                                    	Danh sách các hoạt động quyên góp
                                	</a>
                                	<a class="nav-link collapsed" href="/QuyTuThienVanTinh/Controller?action=donnortableforadmin" >
                                    	Danh sách đợt đã xác nhận lượt QG
                                	</a>
                                	<a class="nav-link collapsed" href="/QuyTuThienVanTinh/Controller?action=donorpending" >
                                    	Chờ xác nhận (theo đợt QG)
                                	</a>
                                	<a class="nav-link collapsed" href="/QuyTuThienVanTinh/Controller?action=donornonedonor" >
                                    	Danh sách đợt chưa được QG 
                                	</a>
                                	<a class="nav-link collapsed" href="/QuyTuThienVanTinh/Controller?action=donorempty" >
                                    	Danh sách đợt chưa nhận lượt QG 
                                	</a>
                                	<a class="nav-link collapsed" href="/QuyTuThienVanTinh/Controller?action=donnortabledetailforadmin">
                                		Danh sách nhà hảo tâm
                                	</a>
                            	</c:if>
                            	<c:if test="${loginAcc.getStatus() == 'Hoạt động' && loginAcc.getRole() == 'User' || loginAcc.getRole() == 'Admin' }">
                            		<a class="nav-link collapsed" href="/QuyTuThienVanTinh/Controller?action=donnortableforuser" >
                                    	Danh sách Quyên góp của bạn
                                	</a>
                            	</c:if>   
                            	
                            	                        
                                <a class="nav-link collapsed" href="/QuyTuThienVanTinh/Controller?action=adminuser" data-bs-toggle="collapse"
                                    data-bs-target="#pagesCollapseAuth" aria-expanded="false"
                                    aria-controls="pagesCollapseAuth">
                                    Quản lý tài khoản
                                    <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                                </a>
                                <div class="collapse" id="pagesCollapseAuth" aria-labelledby="headingOne"
                                    data-bs-parent="#sidenavAccordionPages">
                                    <nav class="sb-sidenav-menu-nested nav"> 
                                    	<c:if test="${loginAcc.getRole() == null}">
                                    		<a class="nav-link" href="/QuyTuThienVanTinh/Controller?action=register">Đăng ký</a>
                                    		<a class="nav-link" href="/QuyTuThienVanTinh/Controller?action=forgotpass">Quên Mật khẩu</a>
                                    	</c:if>                                     
                                        <c:if test="${loginAcc.getStatus() == 'Hoạt động' && loginAcc.getRole() == 'Admin' ||  loginAcc.getRole() == 'User' }">
                                        	<a class="nav-link" href="/QuyTuThienVanTinh/Controller?action=login&afteraction=aftchangepass">Thay đổi Mật khẩu</a>
                                        	<a class="nav-link" href="/QuyTuThienVanTinh/Controller?action=login&afteraction=useredit">Chỉnh sửa thông tin tài khoản</a>
                                        </c:if>                                       
                                    </nav>
                                </div>
                                <a class="nav-link collapsed" href="#" data-bs-toggle="collapse"
                                    data-bs-target="#pagesCollapseError" aria-expanded="false"
                                    aria-controls="pagesCollapseError">
                                    Error
                                    <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                                </a>
                                <div class="collapse" id="pagesCollapseError" aria-labelledby="headingOne"
                                    data-bs-parent="#sidenavAccordionPages">
                                    <nav class="sb-sidenav-menu-nested nav">
                                        <a class="nav-link" href="401.html">401 Page</a>
                                        <a class="nav-link" href="404.html">404 Page</a>
                                        <a class="nav-link" href="500.html">500 Page</a>
                                    </nav>
                                </div>
                            </nav>
                        </div>
                        <div class="sb-sidenav-menu-heading">Addons</div>
                        <a class="nav-link" href="charts.html">
                            <div class="sb-nav-link-icon"><i class="fas fa-chart-area"></i></div>
                            Charts
                        </a>
                        <a class="nav-link" href="tables.html">
                            <div class="sb-nav-link-icon"><i class="fas fa-table"></i></div>
                            Tables
                        </a>
                    </div>
                </div>
                <div class="sb-sidenav-footer">
                	<c:if test="${loginAcc.getRole() == 'Admin'}">
                		<span>Quản trị viên: </span>
                	</c:if>
                	${loginAcc.getLastName() }<span> </span>${loginAcc.getName() }
                	  
                	<c:choose>
                		<c:when test="${loginAcc.getStatus() == 'Hoạt động' && loginAcc.getRole() == 'Admin' ||  loginAcc.getRole() == 'User' }">
                			<div class="small">đã đăng nhập</div>
                		</c:when>
                		
                		<c:when test="${loginAcc.getStatus() != 'Hoạt động' && loginAcc.getRole() == 'Admin' ||  loginAcc.getRole() == 'User' }">
                			<div class="small">đăng nhập không thành công, tài khoản của bạn không còn hoạt động</div>
                		</c:when>
                			
                		<c:otherwise>
                			<div class="small">Đăng nhập để sử dụng các chức năng</div>
                		</c:otherwise>
                	</c:choose>             	
                	                                       
                </div>
            </nav>
        </div>   
        
        <%
        loginAcc = null;
        %>
        