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
	<script type="text/javascript">
	$(document).ready(function() {
		$("#purchaseButton").click(function() {
			let purchaseNum = $("#PurchaseInput").val();
			$("#purchaseInput").val(purchaseNum);
			console.log(purchaseNum);
			
			$("#purchaseForm").submit();
			
		})
		
		
	});
	
	</script>
<title>Insert title here</title>
</head>
<body>
	<my:pagenavbar></my:pagenavbar>
	<div class="container">
		<div class="row">
			<div class="col">
				<h1>구매 페이지</h1>
				<!-- 장바구니 Form 보내는 값 설정 하는곳 -->
				<form id="purchaseForm" action="${appRoot }/order/cart" method="get">
				<input type="hidden" value="${productboard.id }" name ="id" />
				<input type="hidden" value="${productboard.productId }" name ="productId"  />
				<input id ="purchaseInput" type="hidden" value ="" name="Purchase">
				</form>
				
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

					<p>판매글 내용 : ${productboard.boardBody }</p>
					<p>판매 상품 : ${product.productName }</p>
					<p>가격 : ${product.price }</p>
					<p>판매글 아이디 :${productboard.id }</p>
					구매 수량
					<input id="PurchaseInput" type="number" name="Purchase" value="1" />
					<input type="hidden" value="${productboard.id }" name="id" />
					<input type="hidden" value="${productboard.productId }" name="productId" />
					<button>구매 버튼</button>
				</form>
				<button id ="purchaseButton">장바구니</button>




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
							<img src="${imageUrl }/project/${productboard.id}/${encodedFileName }" class="d-block w-100" alt="...">
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





				<form action="/market/product/deleteBoard" method="post">
					<input type="hidden" name="id" value="${productboard.id }" />
					<input type="submit" value="판매글 삭제" />
				</form>





				<!-- 수정폼 -->
				<form action="/market/product/modif">
					<input type="hidden" value="${productboard.id }" name="id" />
					<input type="submit" value="판매글 수정" />
				</form>

			</div>
		</div>
	</div>

</body>
</html>