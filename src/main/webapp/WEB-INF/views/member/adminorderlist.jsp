<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
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
<my:pagenavbar current="adminorderlist"></my:pagenavbar>
<my:mypagenavbar current="adminorderlist"></my:mypagenavbar>

<div class="container">
	<div class="row">
		<div class="col">
		

			<h1>주문 목록</h1>
			
			<table class="table">
				<thead>
					<tr>
						<th>주문번호</th>
						<th>ID</th>
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
									<c:if test="${order.orderState eq '0' }">
										<button class="btn btn-outline-success" type="submit">승인</button>
									</c:if>
									<c:if test="${order.orderState ne '0' }">
										<button class="btn btn-outline-success" type="submit" disabled>승인</button>
									</c:if>
								</form>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div>
</body>
</html>








