<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%
	request.setCharacterEncoding("utf-8");
%>
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
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
	crossorigin="anonymous"></script>
<script>
	$(document).ready(function() {
		$('#message').hide(2500);
		$('#message_error').hide(2500);

	});
</script>
<title>Insert title here</title>
</head>
<body>
	<svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
  <symbol id="check-circle-fill" fill="currentColor" viewBox="0 0 16 16">
    <path
			d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zm-3.97-3.03a.75.75 0 0 0-1.08.022L7.477 9.417 5.384 7.323a.75.75 0 0 0-1.06 1.06L6.97 11.03a.75.75 0 0 0 1.079-.02l3.992-4.99a.75.75 0 0 0-.01-1.05z" />
  </symbol>
  <symbol id="info-fill" fill="currentColor" viewBox="0 0 16 16">
    <path
			d="M8 16A8 8 0 1 0 8 0a8 8 0 0 0 0 16zm.93-9.412-1 4.705c-.07.34.029.533.304.533.194 0 .487-.07.686-.246l-.088.416c-.287.346-.92.598-1.465.598-.703 0-1.002-.422-.808-1.319l.738-3.468c.064-.293.006-.399-.287-.47l-.451-.081.082-.381 2.29-.287zM8 5.5a1 1 0 1 1 0-2 1 1 0 0 1 0 2z" />
  </symbol>
  <symbol id="exclamation-triangle-fill" fill="currentColor"
			viewBox="0 0 16 16">
    <path
			d="M8.982 1.566a1.13 1.13 0 0 0-1.96 0L.165 13.233c-.457.778.091 1.767.98 1.767h13.713c.889 0 1.438-.99.98-1.767L8.982 1.566zM8 5c.535 0 .954.462.9.995l-.35 3.507a.552.552 0 0 1-1.1 0L7.1 5.995A.905.905 0 0 1 8 5zm.002 6a1 1 0 1 1 0 2 1 1 0 0 1 0-2z" />
  </symbol>
</svg>

	<my:pagenavbar></my:pagenavbar>
	<!-- <div class="container">
		<div class="row">
			<div class="col"> -->


	<div style="background-color: #eae1d8">
		<!-- <form action="/market/product/list"> -->
			<div class="d-flex">
			<ul class="nav justify-content-center">
					<li class="nav-item">
						<a class="nav-link "
							href="${approot }/market/product/list?cat=0&search=" style="color: black;">전체상품</a>
					</li>
				<c:forEach items="${ m_category}" var="category">
					<li class="nav-item">
						<a class="nav-link "
							href="${approot }/market/product/list?cat=${category.product_Middle_Class}&search=" style="color: black;">${category.middle_Name }</a>
					</li>
				</c:forEach>
			</ul>
					<%-- <div class="btn-group" role="group"
						aria-label="Basic radio toggle button group" style="display:;">
						<div>
							<input type="radio" class="btn-check " name="cat" id="btnradio0"
								autocomplete="off" value="0">
							<label class="btn btn-outline-primary " for="btnradio0">전체보기</label>
							<c:forEach items="${ m_category}" var="category">
								<div class="form-check form-check-inline ">
									<input type="radio" class="btn-check " name="cat"
										id="btnradio${category.product_Middle_Class}"
										autocomplete="off" value="${category.product_Middle_Class}">
									<label class="btn btn-outline-primary"
										for="btnradio${category.product_Middle_Class}">${category.middle_Name }</label>
								</div>
							</c:forEach> --%>
							<div>
						<span>
							<sec:authorize access="hasRole('ADMIN')">
								<a href="${appRoot }/product/add" class="btn btn-outline-dark">게시물
									작성</a>
								<a href="${appRoot }/product/productlist"
									class="btn btn-outline-dark">상품 삭제</a>
							</sec:authorize>
						</span>
					</div>
							
						</div>
					</div>
					<%-- <div class="me-auto">
						<span class="input-group ">
							<input type="text" placeholder="검색어를 입력해 주세요"
								aria-describedby="button-addon2" name="search">
							<button class="btn btn-outline-secondary" id="button-addon2">검색</button>
						</span>
					</div> --%>
					 
			<!-- </div>
 -->

			<!-- <input type="text" name="search" />
			<input type="submit" value="검색">
		</form>
	</div> -->
	<div class="row justify-content-center">
		<div class="col-12 col-lg-10">


			<c:if test="${not empty message }">
				<div id="message" class="alert alert-success" role="alert">
					<!-- 여기있는 클래스 때문에 다시 나타남 -->
					<svg class="bi flex-shrink-0 me-2" width="24" height="24"
						role="img" aria-label="Success:">
						<use xlink:href="#check-circle-fill" /></svg>
					<div>${message}</div>
				</div>
			</c:if>
			<c:if test="${not empty message_error }">
				<div id="message_error" class="alert alert-danger" role="alert">
					<svg class="bi flex-shrink-0 me-2" width="24" height="24"
						role="img" aria-label="Danger:">
							<use xlink:href="#exclamation-triangle-fill" /></svg>
					<div>${message_error}</div>
				</div>
			</c:if>
			<c:if test="${cat==0 }">
			 전체 상품
			
			</c:if>

			<table class="table align-middle">
				<thead>
					<tr class="table-borderless">
						<th>
							<i class="fa-solid fa-hashtag"></i>
						</th>
						<th>상품 이미지</th>
						<th>판매 상품</th>
						<!-- <th>가격</th>
							<th>
								<i class="fa-solid fa-calendar"></i>
							</th> -->
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${boardlist }" var="pege">
						<tr>
							<td>${pege.id }</td>

							<td>

								<c:url value="/product/get" var="getUrl">
									<c:param name="id" value="${pege.id }"></c:param>
								</c:url>
								<a href="${getUrl}">

									<c:if test="${pege.fileName !=null}">

										<img style="width: 200px" class="img-thumbnail"
											src="${imageUrl }/project/${pege.id }/${pege.fileName}"
											alt="" />
									</c:if>
									<c:if test="${pege.fileName ==null}">

										<img style="width: 200px" class="img-thumbnail"
											src="${imageUrl }/project/noImage/noImage.png" alt="" />
									</c:if>
								</a>

							</td>
							<td>

								<c:url value="/product/get" var="getUrl">
									<c:param name="id" value="${pege.id }"></c:param>
								</c:url>

								<a href="${getUrl }">
									<c:out value="${pege.boardTitle }" />
								</a>
								<div>${pege.priceTopage }원</div>

								<%-- <c:if test="${board.hasFile }">
										<span class="babge rounded-pill bg-light text-dark">
											<i class="fa-solid fa-file"></i>
										</span>
									
									</c:if> --%>

								<%-- <c:if test="${board.numOfReply > 0 }">
										<span class="badge rounded-pill bg-light text-dark">
											<i class="fa-solid fa-comment-dots"></i>
											${board.numOfReply }
										</span>
									</c:if> --%>


							</td>
							<%-- <td>${pege.inserttime }</td> --%>
						</tr>
					</c:forEach>
				</tbody>

			</table>
			<!-- ---------- 페이지 네비게이터 ----------- -->
			<div class="row justify-content-center">
				<div class="col-12 col-lg-10">

					<nav aria-label="..." class="align-items-center">
						<ul class="pagination justify-content-center">

							<c:forEach var="i" begin="1" end="${paginationDto.endPage}">

								<li
									class="page-item  ${paginationDto.nowpage == i ? 'active' : '' }">
									<a class="page-link"
										href="${appRoot }/product/list?cat=${paginationDto.cat }&search=${paginationDto.search }&page=${i}">${i}</a>
								</li>


							</c:forEach>

						</ul>
					</nav>

				</div>
			</div>



			<!-- ----------------------------------- -->

		</div>
	</div>

</body>
</html>