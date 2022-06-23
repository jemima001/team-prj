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
<title>로    고</title>
<style>
.row {
	text-align: center;
}

</style>
<script>
</script>
</head>
<body>
	<my:pagenavbar current="home"></my:pagenavbar>
	<%-- <my:searchnavbar current="home"></my:searchnavbar> --%>
	<div class="container">
		<div class="row">
			<div class="col justify-content-center">
			<br />
				<p>
					<a href="${homeUrl }"> <img
						src="${appRoot }/resources/images/logo.jpg">
					</a>
				</p>
			</div>

			<!-- 검색 창 -->
			<!-- <div class="col-md-9">
				<form action="#" class="d-flex" role="search" method="post">
					<input class="form-control me-auto" type="search"
						placeholder="Search" aria-label="Search" name="Search">
					<button class="btn btn-outline-success" type="submit">Search</button>
				</form>
			</div> -->

		</div>
	</div>
		<hr />
		<table class="table">
			<thead>
				<tr>
					<th><a href="${appRoot }/product/list" style="color: black;">ALL</a></th>
					<th><a href="${appRoot }/product/list?cat=1&search="
						style="color: black;">화분식물</a></th>
					<th><a href="${appRoot}/product/list?cat=2&search="
						style="color: black;">행잉식물</a></th>
					<th><a href="${appRoot}/product/list?cat=3&search="
						style="color: black;">선인장식물</a></th>
					<th><a href="${appRoot}/product/list?cat=4&search="
						style="color: black;">대형식물</a></th>
					<th><a href="${appRoot}/product/list?cat=5&search="
						style="color: black;">꽃</a></th>
					<th><a href="${appRoot}/product/list?cat=6&search="
						style="color: black;">기타</a></th>
				</tr>
			</thead>
		</table>
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
		</div>
		<div class="row">
			<c:forEach items="${boardlist1 }" var="pege">
				<div class="col">
					<c:if test="${pege.fileName !=null}">
						<a href="${appRoot }/product/get?id=${pege.id}"><img style="width: 200px; height : 200px" class="img-thumbnail"
							src="${imageUrl }/project/${pege.id }/${pege.fileName}" alt="" /></a>
					</c:if>
					<c:if test="${pege.fileName ==null}">
						<a href="${appRoot }/product/get?id=${pege.id}"><img style="width: 200px; height : 200px" class="img-thumbnail"
							src="${imageUrl }/project/noImage/noImage.png" alt="" /></a>
					</c:if>
					<h5>${pege.boardTitle }</h5>
				</div>
			</c:forEach>
		</div>
		<div class="row">
			<c:forEach items="${boardlist2 }" var="pege">
				<div class="col">
					<c:if test="${pege.fileName !=null}">
						<a href="${appRoot }/product/get?id=${pege.id}"><img style="width: 200px; height : 200px" class="img-thumbnail"
							src="${imageUrl }/project/${pege.id }/${pege.fileName}" alt="" /></a>
					</c:if>
					<c:if test="${pege.fileName ==null}">
						<a href="${appRoot }/product/get?id=${pege.id}"><img style="width: 200px; height : 200px" class="img-thumbnail"
							src="${imageUrl }/project/noImage/noImage.png" alt="" /></a>
					</c:if>
					<c:if test="${pege.boardTitle.length() > 8 }">
						<h5>${pege.boardTitle.substring(0,9) }...</h5>
					</c:if>
					<c:if test="${pege.boardTitle.length() < 8 }">
						<h5>${pege.boardTitle }</h5>
					</c:if>
				</div>
			</c:forEach>
		</div>
	</div>

</body>
</html>