<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
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
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
	crossorigin="anonymous"></script>
<style>
body{
	font-family: 나눔스퀘어, 'NanumSquare', sans-serif;
}
.page-link {
    color: black;
}
</style>
<title>작은 숲</title>
</head>
<body>
	<my:pagenavbar current="userorderlist"></my:pagenavbar>
	<my:mypagenavbar current="userorderlist"></my:mypagenavbar>

	<div class="container">
		<div class="row">
			<div class="col">


				<h1>주문 목록</h1>
				
				<h5> '우리 352-1234-5678-90 작은 숲'으로 입금해주세요.  </br>
				<i class="fa-solid fa-gift"></i> : 무통장 입금이 확인되면 구매가 확정됩니다.</h5>

				<table class="table align-middle">
					<thead>
						<tr>
							<th>주문번호</th>
							<th>상품사진</th>
							<th>상품</th>
							<th>수량</th>
							<th>가격</th>
							<th>수령인</th>
							<th>주소</th>
							<th>주문일시</th>
							<th>주문상태</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${orderList }" var="order">
							<tr>
								<td>${order.orderId }</td>
								<td>
									<img style="width: 100px" class="img-thumbnail"
										src="${imageUrl }/project/${order.boardId }/${order.fileName}"
										alt="" />
								</td>
								<td>${order.productName }</td>
								<td>${order.bookCount }</td>
								<td>${order.totalOrderPrice }</td>
								<td>${order.recipient }</td>
								<td>${order.address }</td>
								<td>${order.inserted }</td>
								<td>
									<c:if test="${order.orderState eq '0' }">
									승인 대기중
								</c:if>
									<c:if test="${order.orderState ne '0' }">
									승인 완료
								</c:if>
								</td>
								<td>
									<c:if test="${order.orderState ne '0' }">
										<a href="${appRoot }/product/get?id=${order.boardId }"
											class="btn btn-outline-success" role="button">리뷰 쓰기</a>
									</c:if>
									<c:if test="${order.orderState eq '0' }">
										<form action="${appRoot }/order/remove" method="post">
											<input type="hidden" name="orderId" value="${order.orderId }" />
											<button class="btn btn-outline-success">주문취소</button>
										</form>
										
									</c:if>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
		<div class="row justify-content-center">
			<nav aria-label="Page navigation example">
				<ul class="pagination justify-content-center">
					<c:forEach var="i" begin="1" end="${paginationDto.endPage}">
						<li
							class="page-item  ${paginationDto.nowpage == i ? 'active' : '' }">
							<a class="page-link"
								style="background-color: #608463; border: 0px;"
								href="${appRoot }/member/userorderlist?id=${id }&page=${i}">${i}</a>
						</li>
					</c:forEach>
				</ul>
			</nav>
		</div>
	</div>
</body>
</html>








