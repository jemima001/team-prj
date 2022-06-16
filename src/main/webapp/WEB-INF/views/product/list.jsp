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
<title>Insert title here</title>
</head>
<body>
	<my:pagenavbar></my:pagenavbar>
	<!-- <div class="container">
		<div class="row">
			<div class="col"> -->

				<form action="/market/product/list">
					<div class="form-check form-check-inline"></div>
					<input class="form-check-input" type="radio" name="cat"
						id="inlineRadio2" value="0">
					<label class="form-check-label" for="inlineRadio2">전체보기</label>
					<c:forEach items="${ m_category}" var="category">
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio" name="cat"
								id="inlineRadio2" value="${category.product_Middle_Class}">
							<label class="form-check-label" for="inlineRadio2">${category.middle_Name }</label>
						</div>
					</c:forEach>

					<input type="text" name="search" />
					<input type="submit" value="검색">
					<span>
						<sec:authorize access="hasRole('ADMIN')">
							<a href="${appRoot }/product/add" class="btn btn-outline-dark">게시물
								작성</a>
							<a href="${appRoot }/product/productlist"
								class="btn btn-outline-dark">상품 삭제</a>
						</sec:authorize>
					</span>

				</form>
<div class="container">
		<div class="row">
			<div class="col">
				<table class="table">
					<thead>
						<tr class="table-dark">
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
									<c:if test="${pege.fileName !=null}">

										<img style="width: 200px" class="img-thumbnail"
											src="${imageUrl }/project/${pege.id }/${pege.fileName}"
											alt="" />
									</c:if>
									<c:if test="${pege.fileName ==null}">

										<img style="width: 200px" class="img-thumbnail"
											src="${imageUrl }/project/noImage/noImage.png" alt="" />
									</c:if>

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
			</div>
		</div>
	</div>
</body>
</html>