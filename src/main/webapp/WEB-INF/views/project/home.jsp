<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="principal" />
	<c:url value="/project/home" var="homeUrl">
		<c:param name="id" value="${principal.username }" />
	</c:url>
</sec:authorize>

<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="principal" />
	<c:url value="/order/cart" var="cartUrl">
		<c:param name="id" value="${principal.username }" />
		<c:param name="Purchase" value="1" />
	</c:url>
</sec:authorize>

<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="principal" />
	<c:url value="/order/info" var="orderUrl">
		<c:param name="id" value="${principal.username }" />
		<c:param name="Purchase" value="1" />
	</c:url>
</sec:authorize>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/gh/moonspam/NanumSquare@1.0/nanumsquare.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css"
	integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css"
	integrity="sha512-GQGU0fMMi238uA+a/bdWJfpUGKUkBdgfFdgBm72SUQ6BeyWjoY/ton0tEjH+OSH9iP4Dfh+7HM0I9f5eR0L/4w=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"
	referrerpolicy="no-referrer"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.3/font/bootstrap-icons.css">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
	crossorigin="anonymous"></script>
<title>?????? ???</title>
<style>
body{
	font-family: ???????????????, 'NanumSquare', sans-serif;
}
.row {
	text-align: center;
}
a{
	text-decoration-line: none;
}
a:hover { color:black;}
.table>:not(caption)>*>* {
    padding: 12px;
}
</style>
<script>
$(document).ready(
		function() {
			/* const container = document.querySelector('.img-thumbnail');
			container.addEventListener */
			/* $("#img1").onmouseover(function(){
				console.log("????????? ?????????");
				$(".imageText").removeClass("d-none");
			}); */
		});
</script>
</head>
<body style="background-color: #ffffff;">
	<my:pagenavbar current="home"></my:pagenavbar>
	<%-- <my:searchnavbar current="home"></my:searchnavbar> --%>
	<div class="container">
		<div class="row">
			<div class="col justify-content-center">
			<br />
				<p>
					<a href="${homeUrl }"> <img
						src="${appRoot }/resources/images/logo2.png"
						style="width: 300px; height: 190px;">
					</a>
				</p>
			</div>

			<!-- ?????? ??? -->
			<!-- <div class="col-md-9">
				<form action="#" class="d-flex" role="search" method="post">
					<input class="form-control me-auto" type="search"
						placeholder="Search" aria-label="Search" name="Search">
					<button class="btn btn-outline-success" type="submit">Search</button>
				</form>
			</div> -->

		</div>
	</div>
	<br />
	<div style="background-color: #608463;">
		<table class="table" style="background-color: #608463; margin: 0; padding: 10;">
			<thead>
				<tr>
					<th><a href="${appRoot }/product/list" style="color: #f4eedd;">ALL</a></th>
					<th><a href="${appRoot }/product/list?cat=1&search="
						style="color: #f4eedd;">????????????</a></th>
					<th><a href="${appRoot}/product/list?cat=2&search="
						style="color: #f4eedd;">????????????</a></th>
					<th><a href="${appRoot}/product/list?cat=3&search="
						style="color: #f4eedd;">???????????????</a></th>
					<th><a href="${appRoot}/product/list?cat=4&search="
						style="color: #f4eedd;">????????????</a></th>
					<%-- <th><a href="${appRoot}/product/list?cat=5&search="
						style="color: #f4eedd;">???</a></th> --%>
					<th><a href="${appRoot}/product/list?cat=6&search="
						style="color: #f4eedd;">??????</a></th>
				</tr>
			</thead>
		</table>
	</div>
		<div class="row">
			<img src="${appRoot }/resources/images/forest.jpg"/>
		</div> 
	<div class="container">
		<%-- <div id="carouselExampleCaptions" class="carousel slide"
			data-bs-ride="false">
			<div class="carousel-indicators">
				<button type="button" data-bs-target="#carouselExampleCaptions"
					data-bs-slide-to="0" class="active" aria-current="true"
					aria-label="Slide 1"></button>
				<button type="button" data-bs-target="#carouselExampleCaptions"
					data-bs-slide-to="1" aria-label="Slide 2"></button>
				<button type="button" data-bs-target="#carouselExampleCaptions"
					data-bs-slide-to="2" aria-label="Slide 3"></button>
			</div>
			<div class="carousel-inner">
				<div class="carousel-item active">
					<img src="${appRoot }/resources/images/main.JPG"
						class="d-block w-100" alt="...">
					<div class="carousel-caption d-none d-md-block">
						<h5>First slide label</h5>
						<p>Some representative placeholder content for the first
							slide.</p>
					</div>
				</div>
				<div class="carousel-item">
					<img src="${appRoot }/resources/images/main2.jpg"
						class="d-block w-100" alt="...">
					<div class="carousel-caption d-none d-md-block">
						<h5>Second slide label</h5>
						<p>Some representative placeholder content for the second
							slide.</p>
					</div>
				</div>
				<div class="carousel-item">
					<img src="${appRoot }/resources/images/main3.jpg"
						class="d-block w-100" alt="...">
					<div class="carousel-caption d-none d-md-block">
						<h5>Third slide label</h5>
						<p>Some representative placeholder content for the third
							slide.</p>
					</div>
				</div>
			</div>
			<button class="carousel-control-prev" type="button"
				data-bs-target="#carouselExampleCaptions" data-bs-slide="prev">
				<span class="carousel-control-prev-icon" aria-hidden="true"></span>
				<span class="visually-hidden">Previous</span>
			</button>
			<button class="carousel-control-next" type="button"
				data-bs-target="#carouselExampleCaptions" data-bs-slide="next">
				<span class="carousel-control-next-icon" aria-hidden="true"></span>
				<span class="visually-hidden">Next</span>
			</button>
		</div> --%>
		<hr />
		<div class="row">
			<h2><b>new</b></h2><br />
			<br />
			<br />
			<hr />
		</div>
		<div class="row">
			<c:forEach items="${boardlist1 }" var="pege" varStatus="status">
				<div class="col" style="position: relative; padding: 15px">
					<c:if test="${pege.fileName !=null}">
						<a href="${appRoot }/product/get?id=${pege.id}"><img style="width: 250px; height : 250px" class="img-thumbnail${status.index }"
							src="${imageUrl }/project/${pege.id }/${pege.fileName}" onmouseover="$('.imgtext${status.index }').removeClass('d-none'), this.style.opacity=0.5;" onmouseout="$('.imgtext${status.index }').addClass('d-none'), this.style.opacity=1;" /></a>
					</c:if>
					<c:if test="${pege.fileName ==null}">
						<a href="${appRoot }/product/get?id=${pege.id}"><img style="width: 250px; height : 250px" class="img-thumbnail"
							src="${imageUrl }/project/noImage/noImage.png" alt="" /></a>
					</c:if>
					<div class="imgtext${status.index } d-none" style="text-align: center; 
																	  position: absolute; 
																	  width: 100%; 
																	  top: 40%; 
																	  z-index: 0;
																	  pointer-events: none;
																	  "
					><h5>${pege.boardTitle }</h5><p>${pege.price }???</p></div>
				</div>
			</c:forEach>
		</div>
		<%-- <div class="row">
			<c:forEach items="${boardlist2 }" var="pege" varStatus="status">
				<div class="col" style="position: relative;">
					<c:if test="${pege.fileName !=null}">
						<a href="${appRoot }/product/get?id=${pege.id}"><img style="width: 250px; height : 250px" class="img-thumbnail${status.index }"
							src="${imageUrl }/project/${pege.id }/${pege.fileName}" onmouseover="$('.imgtext2${status.index }').removeClass('d-none'), this.style.opacity=0.5;" onmouseout="$('.imgtext2${status.index }').addClass('d-none'), this.style.opacity=1;" /></a>
					</c:if>
					<c:if test="${pege.fileName ==null}">
						<a href="${appRoot }/product/get?id=${pege.id}"><img style="width: 250px; height : 250px" class="img-thumbnail"
							src="${imageUrl }/project/noImage/noImage.png" alt="" /></a>
					</c:if>
					<c:if test="${pege.boardTitle.length() > 6 }">
						<h5 class="imgtext2${status.index } d-none" style="text-align: center; position: absolute; width: 100%; top: 50%; z-index: 999;">${pege.boardTitle.substring(0,7) }...</h5>
					</c:if>
					<c:if test="${pege.boardTitle.length() < 6 }">
						<h5 class="imgtext2${status.index } d-none" style="text-align: center; position: absolute; width: 100%; top: 50%; z-index: 999;">${pege.boardTitle }</h5>
					</c:if>
				</div>
			</c:forEach>
		</div> --%>
	</div>

</body>
</html>