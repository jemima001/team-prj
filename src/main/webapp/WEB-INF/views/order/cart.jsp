<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
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
	<my:pagenavbar current="cart"></my:pagenavbar>
	<div class="container">
		<div class="row">
			<div class="col">
				<h1>장바구니 목록</h1>
				<c:if test="${not empty message }">
					<div class="alert alert-primary">${message }</div>
				</c:if>

				<table class="table">
					<thead>
						<tr>
							<th><i class="fa-solid fa-hashtag"></i></th>
							<th>상품정보</th>
							<th>수량</th>
							<th>주문금액</th>
							<th>배송 정보</th>
						</tr>
					</thead>
					<tbody>
					
					<c:forEach items="${cartList }" var="cart">
					
						<tr>
							<th><input type="checkbox" value="${cart.cartId }"
							name="cartId" form="form21" /></th>
							
							<td>${cart.productName }</td>
							<td>${cart.bookCount }</td>
							<td>${cart.price }</td>
							<td>무료</td>
						</tr>
					
					</c:forEach>
						
						
						
					</tbody>
				</table>
			</div>
		</div>
		<div class="row">
			<div class="col">
				<hr />
				<table class="table">
					<thead>
						<tr>
							<th>총 주문 상품 #개</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>총 주문 금액</td>
							<td> ${10000} 원</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		
		

		<button class="btn btn-danger" form="form21" role="button" type="submit">선택 상품 삭제하기</button>
		
		 <a class="btn btn-success" href="${appRoot }/order/info" role="button"> 결제하기</a>
		<!-- <button class="btn btn-success" form="form22" role="button" type="submit" <a href="${appRoot }/order/info"</a> >선택 상품 결제하기</button>-->
	
	</div>
	
	<form id="form21" action="checked">
	</form>
	
	<!--<form id="form22" action="ordered" <a href="${appRoot }/order/info"</a> > </form>-->
	
	
	
</body>
</html>