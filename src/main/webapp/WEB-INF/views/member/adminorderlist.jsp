<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/gh/moonspam/NanumSquare@1.0/nanumsquare.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" integrity="sha512-GQGU0fMMi238uA+a/bdWJfpUGKUkBdgfFdgBm72SUQ6BeyWjoY/ton0tEjH+OSH9iP4Dfh+7HM0I9f5eR0L/4w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" referrerpolicy="no-referrer"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
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
<my:pagenavbar current="adminorderlist"></my:pagenavbar>
<my:mypagenavbar current="adminorderlist"></my:mypagenavbar>

<div class="container">
	<div class="row">
		<div class="col">
		
			<p>${message }</p>
			<h1>주문 목록</h1>
			
			<table class="table align-middle">
				<thead>
					<tr>
						<th>주문번호</th>
						<th>ID</th>
						<th>상품사진</th>
						<th>상품</th>
						<th>수량</th>
						<th>가격</th>
						<th>수령인</th>
						<th>주소</th>
						<th>주문일시</th>
						<th>주문 확정</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${orderList }" var="order">
						<tr>
							<td>${order.orderId }</td>
							<td>${order.memberId }</td>
							<td><img style="width: 100px" class="img-thumbnail"
							src="${imageUrl }/project/${order.boardId }/${order.fileName}" alt="" /></td>
							<td>${order.productName }</td>
							<td>${order.bookCount }</td>
							<td>${order.totalOrderPrice }</td>
							<td>${order.recipient }</td>
							<td>${order.address }</td>
							<td>${order.inserted }</td>
							<td>
								<c:if test="${order.orderState eq '0' }">
									<p>승인 대기중</p>
								</c:if>
								<c:if test="${order.orderState ne '0' }">
									<p>승인 완료</p>
								</c:if>
							</td>
							<td>
								<form action="${appRoot }/member/orderApprove" method="post">
									<input type="hidden" name="orderId" value="${order.orderId }" />
									<input type="hidden" name="bookCount" value="${order.bookCount }" />
									<input type="hidden" name="productName" value="${order.productName }" />
									<c:if test="${order.orderState eq '0' }">
										<button class="btn btn-outline-success" type="submit">승인</button>
									</c:if>
									<c:if test="${order.orderState ne '0' }">
										<button class="btn btn-outline-success" type="submit" disabled>승인</button>
									</c:if>
								</form>
								<c:if test="${order.orderState eq '0' }">
										<form action="${appRoot }/order/adminRemove" method="post">
											<input type="hidden" name="orderId" value="${order.orderId }" />
											<button class="btn btn-outline-danger">취소</button>
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
							<a class="page-link" style="background-color: #608463; border: 0px;" href="${appRoot }/member/adminorderlist?page=${i}">${i}</a>
						</li>
					</c:forEach>
				  </ul>
				</nav>
			</div>
</div>
</body>
</html>








