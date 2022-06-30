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
		// $("#reviewform").hide();

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

	<div class="row justify-content-center">
		<div class="col-12 col-lg-10">
			<div class="container">
				<div class="row">


					<div id="carouselExampleControls" class="carousel slide col"
						data-bs-ride="carousel" style="float: left;">

						<div class="carousel-inner">
							<c:forEach items="${productboard.fileList }" var="file" begin="0"
								end="0">
								<%
									if (pageContext.getAttribute("file") != null) {

									String file = (String) pageContext.getAttribute("file");
									String encodedFileName = java.net.URLEncoder.encode(file, "utf-8");
									pageContext.setAttribute("encodedFileName", encodedFileName);
								}
								%>

								<div class="carousel-item active">
									<img
										src="${imageUrl }/project/${productboard.id}/${encodedFileName }"
										class="d-block w-100" alt="..." style="width: 200px">
								</div>
							</c:forEach>

							<c:forEach items="${productboard.fileList }" var="file" begin="1">
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
										class="d-block w-100" alt="..." style="width: 200px">
								</div>

							</c:forEach>






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


					<div class="justify-content-center  d-flex align-items-center col"
						style="border-style: solid; border: 3px;">
						<div class="row"></div>
						<div class="row m-5">
							<!-- -------------------------------------------------------------------------- -->
							<h1>${productboard.boardTitle }</h1>
							<!-- 장바구니 Form 보내는 값 설정 하는곳 -->
							<form id="cartForm" action="${cartUrl }" method="get"></form>

							<!-- 구매 페이지로 값 보내는 곳 -->
							<form id="buybutton" action="${appRoot }/order/info" method="get">
								<!-- 여기에 구매 페이지 주소 입력 -->
								<!-- 구매 버튼 연결 주소 입력 -->
								<!-- 판매글 아이디(29번째줄), 상품 아이디(30번쨰줄) , 상품 구매수량(28번째줄) 넘어 갑니다. -->
								<!-- 상품페이지 dto에 구매 수량 Purchase 추가 했습니다.(아직 사용한 곳은 없음...) -->

								<!-- -------------------------------------------------------- -->




								<!-- --------------------------------------------------- -->


								<p>판매 상품 : ${product.productName }</p>
								<h2>${product.price }원</h2>

								<c:if test="${product.stock != 0 }">
					구매 수량
					<input id="PurchaseInput" type="number" name="Purchase" value="1"
										min="0" />
									<input type="hidden" value="${productboard.id }" name="id" />
									<input id="productId" type="hidden"
										value="${productboard.productId }" name="productId" />

								</c:if>
							</form>
							<c:if test="${product.stock != 0 }">
								<sec:authorize access="hasRole('USER')">
									<button class="buttonTobuy btn btn-outline-success"
										id="purchaseButton">장바구니</button>
								</sec:authorize>
								<button class="buttonTobuy btn btn-outline-success"
									form="buybutton">구매</button>
							</c:if>
							<c:if test="${product.stock == 0 }">
						품절되었습니다.
					
					</c:if>
						</div>



					</div>
					<%-- <c:forEach items="${productboard.fileList }" var="file">
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

		</c:forEach> --%>

					<!-- -------------------------------------------------------- 사진 사용  -->



				</div>
			</div>

			<!-- --------------------------------------------------- -->

			<h2 class="justify-content-center">상세 정보</h2>

			<P>: ${productboard.boardBody }</p>



			<sec:authorize access="hasRole('ADMIN')">
				<form action="/market/product/deleteBoard" method="post">
					<input type="hidden" name="id" value="${productboard.id }" />
					<input type="hidden" name="deleteImg"
						value="${productboard.fileList }" />
					<input type="submit" value="판매글 삭제" />
				</form>

				<!-- 수정폼 -->
				<form action="/market/product/modif">
					<input type="hidden" value="${productboard.id }" name="id" />
					<input type="submit" value="판매글 수정" />
				</form>
			</sec:authorize>
			<c:if test="${check == true && checkNumReview == 0 }">
				<form action="${appRoot }/review/add" method="get">
					<input type="hidden" name="prodctPageid"
						value="${productboard.id }" />
					<input type="submit" value="리뷰 작성" />

				</form>
			</c:if>

			<div id="reviewform">
				<%-- <form action="${appRoot }/product/reviewpage" method="post"
					enctype="multipart/form-data">
					<input type="hidden" name="productPage" value="${productboard.id }" />
					리뷰 제목
					<br />
					<input type="text" name="reviewTitle" />
					<br />
					리뷰 내용
					<br />
					<textarea rows="10" cols="30" name="reviewBody"></textarea>
					<br />
					사진 추가
					<br />
					<input type="file" name="file" multiple="multiple" />
					<br />

					<input type="submit" value="작성" />

				</form> --%>
				 
				
				<table class="table">
					<thead>
						<tr>

							<th scope="col">리뷰 </th>


						</tr>
					</thead>
					<tbody>
						<c:forEach items="${reviewList }" var="reviewlist">

							<tr>

								<%-- <td>

									<c:if test="${reviewlist.revireFileName !=null}">

										<img style="width: 200px" class="img-thumbnail"
											src="${imageUrl }/project/reviewpage/${reviewlist.id }/${reviewlist.revireFileName}"
											alt="" />
									</c:if>
									<c:if test="${reviewlist.revireFileName ==null}">

										<img style="width: 200px" class="img-thumbnail"
											src="${imageUrl }/project/noImage/noImage.png" alt="" />
									</c:if>
								</td> --%>
								<td>

									<div class="accordion" id="accordionPanelsStayOpenExample">
										<div class="accordion-item">
											<h2 class="accordion-header" id="panelsStayOpen-headingOne">
												<button class="accordion-button" type="button"
													data-bs-toggle="collapse"
													data-bs-target="#review${reviewlist.id }"
													aria-expanded="false"
													aria-controls="panelsStayOpen-collapseOne">
													${reviewlist.reviewTitle }</button>
											</h2>
											<div id="review${reviewlist.id }"
												class="accordion-collapse collapse"
												aria-labelledby="panelsStayOpen-headingOne">
												<div class="accordion-body">
													id :${reviewlist.id }  ${reviewlist.reviewBody }
													<br />
											 		 <c:forEach items="${reviewlist.fileList}" var="reviewfile">
													
													 <img style="width: 200px" class="img-thumbnail"
														src="${imageUrl }/project/reviewpage/${reviewlist.id }/${reviewfile}"
														alt="" />

													</c:forEach>
													<c:if test="${check == true }">
													<form action="${appRoot }/product/deleteReview"
														method="post">
														<input type="hidden" value="${productboard.id }"
															name="productPage" />
														<input type="hidden" value="${reviewlist.id} " name="id" />
														<input type="submit" value="리뷰 삭제" />
													</form>

													<form action="${appRoot }/review/modif" method="get">
														<input type="hidden" name="id" value="${reviewlist.id} " />
														<input type="submit" value="리뷰 수정" />

													</form>
													</c:if>
												</div>
											</div>
										</div>
									</div>

								</td>
							</tr>

						</c:forEach>
					</tbody>
				</table>



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