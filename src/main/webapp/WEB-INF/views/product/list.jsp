<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix = 'c' uri ="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
    <%request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" integrity="sha512-GQGU0fMMi238uA+a/bdWJfpUGKUkBdgfFdgBm72SUQ6BeyWjoY/ton0tEjH+OSH9iP4Dfh+7HM0I9f5eR0L/4w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" referrerpolicy="no-referrer"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<title>Insert title here</title>
</head>
<body>
<my:pagenavbar></my:pagenavbar>



	<table class="table">
					<thead>
						<tr class="table-dark">
							<th><i class="fa-solid fa-hashtag"></i></th>
							<th>판매 상품</th>
							<th>가격</th>
							<th><i class="fa-solid fa-calendar"></i></th>
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
									
									<a href="${getUrl }">
										<c:out value="${pege.boardTitle }" />
									</a>
									
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
								<td>${pege.priceTopage }</td>
								<td>${pege.inserttime }</td>
							</tr>
						</c:forEach>
					</tbody>
					
				</table>
				<a href="${appRoot }/product/add">게시물 작성</a>

</body>
</html>