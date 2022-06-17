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
<script type="text/javascript">
	$(document).ready(function() {
		$("#purchaseButton").click(function() {
			//let purchaseNum = $("#PurchaseInput").val();
			//$("#purchaseInput").val(purchaseNum);
			//console.log(purchaseNum);

			let data = {
				purchase : $("#PurchaseInput").val(),
				productId : $("#productId").val()
			}

			$.ajax({
				url : "${appRoot}/product/addcart",
				type : "post",
				data : data,
				success : function(data) {
					console.log("ajax 성공");
					console.log($("#PurchaseInput").val());
					console.log($("#productId").val());
					$("#cartInforModal1").modal('show');

				},
				error : function(dtat) {
					console.log("ajax 문제 발생");
					console.log($("#PurchaseInput").val());
					console.log($("#productId").val());
					$("#cartInforModal2").modal('show');

				},
				complete : function() {

					console.log("ajax 종료");
				}

			})

		})

	});
</script>
<title>Insert title here</title>
</head>
<body>


	<sec:authorize access="isAuthenticated()">
		<sec:authentication property="principal" var="principal" />
		<c:url value="/order/cart" var="cartUrl">
			<c:param name="id" value="${principal.username }" />
		</c:url>
	</sec:authorize>
	<my:pagenavbar></my:pagenavbar>
	<div class="container">
		<div class="row">
			<div class="col">

				<!-- -------------------------------------------------------------------------- -->
				<h1>구매 페이지</h1>
				<!-- 장바구니 Form 보내는 값 설정 하는곳 -->
				<form id="cartForm" action="${cartUrl }" method="get"></form>

				<!-- 구매 페이지로 값 보내는 곳 -->
				<form action="${appRoot }/order/info" method="get">
					<!-- 여기에 구매 페이지 주소 입력 -->
					<!-- 구매 버튼 연결 주소 입력 -->
					<!-- 판매글 아이디(29번째줄), 상품 아이디(30번쨰줄) , 상품 구매수량(28번째줄) 넘어 갑니다. -->
					<!-- 상품페이지 dto에 구매 수량 Purchase 추가 했습니다.(아직 사용한 곳은 없음...) -->
					<p>판매글 제목 : ${productboard.boardTitle }</p>
					<!-- -------------------------------------------------------- -->


					<div id="carouselExampleControls" class="carousel slide"
						data-bs-ride="carousel">
						<div class="carousel-inner">
							<div class="carousel-item active">
								<img src="..." class="d-block w-100" alt="...">
							</div>

						</div>
						<button class="carousel-control-prev" type="button"
							data-bs-target="#carouselExampleControls" data-bs-slide="prev">
							<span class="carousel-control-prev-icon" aria-hidden="true"></span>
							<span class="visually-hidden">Previous</span>
						</button>
						<button class="carousel-control-next" type="button"
							data-bs-target="#carouselExampleControls" data-bs-slide="next">
							<span class="carousel-control-next-icon" aria-hidden="true"></span>
							<span class="visually-hidden">Next</span>
						</button>
					</div>


					<!-- --------------------------------------------------- -->

					<p>상세 정보 : ${productboard.boardBody }</p>
					<p>판매 상품 : ${product.productName }</p>
					<p>가격 : ${product.price }</p>
					
					<c:if test="${product.stock != 0 }">
					구매 수량
					<input id="PurchaseInput" type="number" name="Purchase" value="1" />
					<input type="hidden" value="${productboard.id }" name="id" />
					<input id="productId" type="hidden"
						value="${productboard.productId }" name="productId" />
					<button class="buttonTobuy">구매 버튼</button>
					</c:if>
				</form>
				<c:if test="${product.stock != 0 }">
				<button class="buttonTobuy" id="purchaseButton">장바구니</button>
				</c:if>
				<c:if test="${product.stock == 0 }">
						품절되었습니다.
					
					</c:if>



				<c:forEach items="${productboard.fileList }" var="file">
					<%
						if (pageContext.getAttribute("file") != null) {

						String file = (String) pageContext.getAttribute("file");
						String encodedFileName = java.net.URLEncoder.encode(file, "utf-8");
						pageContext.setAttribute("encodedFileName", encodedFileName);
					}
					%>
					<div>
						<img
							src="${imageUrl }/project/${productboard.id}/${encodedFileName }"
							alt="" />
					</div>

				</c:forEach>

				<!-- -------------------------------------------------------- -->


				<div id="carouselExampleControls" class="carousel slide"
					data-bs-ride="carousel">
					<div class="carousel-inner">

						<c:forEach items="${productboard.fileList }" var="file">
							<%
								if (pageContext.getAttribute("file") != null) {

								String file = (String) pageContext.getAttribute("file");
								String encodedFileName = java.net.URLEncoder.encode(file, "utf-8");
								pageContext.setAttribute("encodedFileName", encodedFileName);
							}
							%>


							<div class="carousel-item ">
								<img
									src="${imageUrl }/project/${productboard.id}/${encodedFileName }"
									class="d-block w-100" alt="...">
							</div>

						</c:forEach>





						<div class="carousel-item active">
							<img src="..." class="d-block w-100" alt="...">
						</div>
					</div>
					<button class="carousel-control-prev" type="button"
						data-bs-target="#carouselExampleControls" data-bs-slide="prev">
						<span class="carousel-control-prev-icon" aria-hidden="true"></span>
						<span class="visually-hidden">Previous</span>
					</button>
					<button class="carousel-control-next" type="button"
						data-bs-target="#carouselExampleControls" data-bs-slide="next">
						<span class="carousel-control-next-icon" aria-hidden="true"></span>
						<span class="visually-hidden">Next</span>
					</button>
				</div>

				<!-- --------------------------------------------------- -->




				<sec:authorize access="hasRole('ADMIN')">
					<form action="/market/product/deleteBoard" method="post">
						<input type="hidden" name="id" value="${productboard.id }" />
						<input type="submit" value="판매글 삭제" />
					</form>





					<!-- 수정폼 -->
					<form action="/market/product/modif">
						<input type="hidden" value="${productboard.id }" name="id" />
						<input type="submit" value="판매글 수정" />
					</form>
				</sec:authorize>
			</div>
		</div>
	</div>



	<!-- 장바구니 추가 창 -->
	<div class="addcartModal modal fade" tabindex="-1" id="cartInforModal1"
		aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">장바구니 담기</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<p>장바구니에 추가 했습니다.</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary"
						data-bs-dismiss="modal">계속 쇼핑하기</button>
					<button form="cartForm" class="btn btn-primary">장바구니로 이동</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 장바구니 추가에러 창 -->
	<div class="addcarErrortModal modal fade" tabindex="-1"
		id="cartInforModal2" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">장바구니 담기</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<p>장바구니추가에 실패 했습니다.</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary"
						data-bs-dismiss="modal">계속 쇼핑하기</button>
					<button form="cartForm" class="btn btn-primary">장바구니로 이동</button>
				
					
				</div>
			</div>
		</div>
	</div>

</body>
</html>