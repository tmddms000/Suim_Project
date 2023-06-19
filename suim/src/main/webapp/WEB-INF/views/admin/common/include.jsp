<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap" rel="stylesheet">
    
    <!-- Icon Font Stylesheet -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Libraries Stylesheet -->
    <link href="/resources/js/admin/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="/resources/js/admin/lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" />

    <!-- Customized Bootstrap Stylesheet -->
    <!-- <link href="/resources/css/admin/bootstrap.min.css" rel="stylesheet"> -->
    <link href="/resources/css/admin/bootstrap.min.css" rel="stylesheet">

    <!-- Template Stylesheet -->
    <link href="/resources/css/admin/style.css" rel="stylesheet">
    
    <!-- toastr -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.css"/>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>

	
    <style>
        @font-face {
            font-family: 'maplestory';
            src: url(/resources/fonts/maple_light.ttf);
        }
        body{
            font-family: 'maplestory';
        }
    </style>

	<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
    
<c:if test="${ not empty alertMsg }">
	<script>
			alert("${ alertMsg }");
		</script>
	<c:remove var="alertMsg" scope="session" />
</c:if>

<c:if test="${ not empty toastError }">
	<script>
		toastr.error("${ toastError }");
		</script>
	<c:remove var="toastError" scope="session" />
</c:if>

<c:if test="${ not empty toastSuccess }">
	<script>
		toastr.success("${ toastSuccess }");
		</script>
	<c:remove var="toastSuccess" scope="session" />
</c:if>