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
</style>
<title>작은 숲</title>
<script>
	$(document).ready(
			function() {
				
			});
</script>
</head>
<body>
	<my:pagenavbar current="productlist"></my:pagenavbar>
	<my:mypagenavbar current="produtlist"></my:mypagenavbar>
	<form action="${appRoot}/product/productlist">
		<input type="text" name="search" />
		<input type="submit" name="검색" />
	</form>
	<table class="table">
		<thead>
			<tr class="table-dark">
				<th><i class="fa-solid fa-hashtag"></i></th>
				<th>상품 이름</th>
				<th>남은수량</th>
				<th>가격</th>
				<th>수정/삭제</th>
			</tr>
		</thead>
		<tbody>
		
			<c:forEach items="${productlist }" var="product">
				<tr>
					<td>${product.productId }</td>
					<td>
							<input class="form-control" id="productIdInput1" type="text" value="${product.productName }" />
					</td>
					<td>
						<input class="form-control" id="stockInput1" type="text" value="${product.stock }" />
					</td>
					<td>
						<input class="form-control" id="priceInput1" type="text" value="${product.price }" />
					</td>
					<td>
						<div class="btn-group" role="group" aria-label="Basic outlined example">
							<button class="btn btn-outline-success" id="modifySubmitButton${product.productId }" 
							data-bs-toggle="modal" data-bs-target="#modalModify${product.productId }">수정</button>
							<button class="btn btn-outline-danger" 
							data-bs-toggle="modal" data-bs-target="#modalRemove${product.productId }">삭제</button>
						</div>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	
	<c:forEach items="${productlist }" var="product">
		<!-- 삭제 확인 Modal -->
		<div class="modal fade" id="modalRemove${product.productId }" tabindex="-1"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel">삭제 하시겠습니까?</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					
					<form id="form1" action="${appRoot }/member/productRemove" method="post">
						<input type="hidden" value="${product.productId }" name="id" />
					</form>
					
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">Close</button>
						<button form="form1" type="submit" class="btn btn-danger">삭제</button>
					</div>
				</div>
			</div>
		</div>
		
		<!-- 수정(modify) 확인 Modal -->
		<div class="modal fade" id="modalModify${product.productId }" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel2">수정 하시겠습니까?</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				
				<form id="form2" action="${appRoot }/member/productModify" method="post">
						<input type="hidden" value="${product.productId }" name="id" />
					</form>
				
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Close</button>
					<button form="form2" type="submit" class="btn btn-danger">수정</button>
				</div>
			</div>
		</div>
	</div>
	</c:forEach>

</body>
</html>