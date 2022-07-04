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
	$(document).ready(function() {
		const modalModifyButtonClickHadler = function() {
			let pid = $(this).attr("data-prodid");
			let newStock = $("#stockInput" + pid).val();
			let newprice = $("#priceInput" + pid).val();
			console.log("pid"+pid);
			console.log("newprice"+newStock);
			console.log(newprice);
			$("#modifyStockInput" + pid).val(newStock);
			$("#modifyPriceInput" + pid).val(newprice);
			/* console.log(newStock);
			console.log(newprice);
			console.log(pid);
			console.log("-------------------");
			console.log($("#modifyStockInput"+pid).val()); */

		};
		
		$(".modalModifyButton").click(modalModifyButtonClickHadler);
		
		$("#searchProduct").change(function(){
			
			
			let data = {search : $("#searchProduct").val() };
			$.ajax({
				url :"${appRoot}/product/productlist",
				type :"post",
				data :data,
				success:function(list){
					console.log(list)
					
					const productlistElement= $("#productlist");
					productlistElement.empty();
					
					
					for (let i =0; i<list.length; i++) {
						let sellButtonText = "";
						if (list[i].boardId == 0) {
							
							sellButtonText = `
								\${list[i].boardId}
								<form action="${appRoot }/product/add">
									<input type="hidden" value="\${list[i].productId }"
										name="productId" />
									<input type="hidden" value="\${list[i].productName }"
										name="productName" />
									<input type="hidden" value="\${list[i].stock }" name="stock" />
									<input type="hidden" value="\${list[i].price }" name="price" />
									<input type="hidden" value="addFormProductList" name="mod" />
									<button class="btn btn-outline-success modalModifyButton">판매글
										등록</button>
		
								</form>
							`
						} else {
							sellButtonText = `
								\${list[i].boardId}
									<form action="${appRoot }/product/modif">
										<input type="hidden" name="id" value="\${list[i].boardId }" />
										<button class="btn btn-outline-success modalModifyButton">판매글
											수정</button>
			
			
									</form>
							
							`
						}
						
						let showImg ="${imageUrl }/project/noImage/noImage.png";
						if(list[i].fileName != null){
							 showImg = "${imageUrl }/project/"+list[i].boardId+"/"+list[i].fileName;
						} 
						
						const productElement =$("<tr />");
						productElement.html(`<td>\${list[i].productId }</td>
								<td>
								
								
									
									<img style="width: 200px" class="img-thumbnail"
										src=\${showImg}
										alt="" />
								
								
								
							</td>
							<td>
								<p>\${list[i].productName }</p>
								<%-- <input class="form-control" id="productIdInput${product.productId }" type="text" value="${product.productName }" readonly="readonly" /> --%>
							</td>
							<td>
								<input class="form-control" id="stockInput\${list[i].productId }"
									type="text" value="\${list[i].stock }" />
							</td>
							<td>
								<input class="form-control" id="priceInput\${list[i].productId }"
									type="text" value="\${list[i].price }" />
							</td>
							<td>
								<div class="btn-group" role="group"
									aria-label="Basic outlined example">
									<button class="btn btn-outline-success modalModifyButton"
										data-bs-toggle="modal"
										data-bs-target="#modalModify\${list[i].productId }"
										data-prodid="\${list[i].productId }">수정</button>
									<button class="btn btn-outline-danger" data-bs-toggle="modal"
										data-bs-target="#modalRemove\${list[i].productId }">삭제</button>

										
									\${sellButtonText}

								</div>
							</td>`);
						productElement.find(".modalModifyButton").click(modalModifyButtonClickHadler); // 다시 불러와서 이벤트 추가 하는 부분
						productlistElement.append(productElement);
						
					}
				},
				
			})
	
		
		})
		
		

	});
</script>
</head>
<body>
	<my:pagenavbar current="productlist"></my:pagenavbar>
	<my:mypagenavbar current="produtlist"></my:mypagenavbar>
	<input id ="searchProduct" type="text" name="search" />
	<table class="table">
		<thead>
			<tr class="table-dark">
				<th>
					<i class="fa-solid fa-hashtag"></i>
				</th>
				<th>상품 사진</th>
				<th>상품 이름</th>
				<th>남은수량</th>
				<th>가격</th>
				<th>수정/삭제</th>
			</tr>
		</thead>
		<tbody id ="productlist">
			<c:forEach items="${productlist }" var="product">
				<tr>
					<td>${product.productId }</td>
					<td>
						<c:if test="${product.fileName !=null}">

							<img style="width: 200px" class="img-thumbnail"
								src="${imageUrl }/project/${product.boardId }/${product.fileName}"
								alt="" />
						</c:if>
						<c:if test="${product.fileName ==null}">

							<img style="width: 200px" class="img-thumbnail"
								src="${imageUrl }/project/noImage/noImage.png" alt="" />
						</c:if>
					</td>
					<td>
						<p>${product.productName }</p>
						<%-- <input class="form-control" id="productIdInput${product.productId }" type="text" value="${product.productName }" readonly="readonly" /> --%>
					</td>
					<td>
						<input class="form-control" id="stockInput${product.productId }"
							type="text" value="${product.stock }" />
					</td>
					<td>
						<input class="form-control" id="priceInput${product.productId }"
							type="text" value="${product.price }" />
					</td>
					<td>
						<div class="btn-group" role="group"
							aria-label="Basic outlined example">
							<button class="btn btn-outline-success modalModifyButton"
								data-bs-toggle="modal"
								data-bs-target="#modalModify${product.productId }"
								data-prodid="${product.productId }">수정</button>
							<button class="btn btn-outline-danger" data-bs-toggle="modal"
								data-bs-target="#modalRemove${product.productId }">삭제</button>

							<c:if test="${product.boardId == 0}">
							${product.boardId}
								<form action="${appRoot }/product/add">
									<input type="hidden" value="${product.productId }"
										name="productId" />
									<input type="hidden" value="${product.productName }"
										name="productName" />
									<input type="hidden" value="${product.stock }" name="stock" />
									<input type="hidden" value="${product.price }" name="price" />
									<input type="hidden" value="addFormProductList" name="mod" />
									<button class="btn btn-outline-success modalModifyButton">판매글
										등록</button>

								</form>
							</c:if>
							<c:if test="${product.boardId != 0}">
							${product.boardId}
								<form action="${appRoot }/product/modif">
									<input type="hidden" name="id" value="${product.boardId }" />
									<button class="btn btn-outline-success modalModifyButton">판매글
										수정</button>


								</form>

							</c:if>

						</div>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>

	<c:forEach items="${productlist }" var="product">
		<!-- 삭제 확인 Modal -->
		<div class="modal fade" id="modalRemove${product.productId }"
			tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel">삭제 하시겠습니까?</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>

					<form id="form${product.productId }"
						action="${appRoot }/product/productRemove" method="post">
						<input type="hidden" value="${product.productId }"name="productId" />
						<input type="hidden" value="${product.boardId }" name="boardId"/>
							
					</form>

					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">Close</button>
						<button form="form${product.productId }" type="submit"
							class="btn btn-danger">삭제</button>
					</div>
				</div>
			</div>
		</div>
	</c:forEach>

	<c:forEach items="${productlist }" var="product">
		<!-- 수정 확인 Modal -->
		<div class="modal fade" id="modalModify${product.productId }"
			tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel">수정 하시겠습니까?</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>

					<form id="modifyForm${product.productId }"
						action="${appRoot }/product/productModify" method="post">
						<input type="hidden" value="${product.productId }"
							name="productId" />
						<input id="modifyStockInput${product.productId }" type="hidden"
							value="" name="stock" />
						<input id="modifyPriceInput${product.productId }" type="hidden"
							value="" name="price" />
					</form>

					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">Close</button>
						<button form="modifyForm${product.productId }" type="submit"
							class="btn btn-danger">수정</button>

					</div>
				</div>
			</div>
		</div>
	</c:forEach>




</body>
</html>