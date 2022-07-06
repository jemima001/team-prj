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
<link rel="stylesheet" type="text/css"
	href="https://cdn.jsdelivr.net/gh/moonspam/NanumSquare@1.0/nanumsquare.css">
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
	$(document).ready(
			function() {
				
				document.oncontextmenu=function(){return false;} // 우클릭 방지

			    document.onselectstart=function(){return false;} // 드래그 방지

			   
			   
				// $("#reviewform").hide();

				$("#purchaseButton").click(
						function() {
							let PurchaseNum = $("#PurchaseInput").val();
							let PurchaseInput = Number(PurchaseNum);

							let PurchaseInputMax = Number($("#PurchaseInput")
									.attr("max"));
							console.log("클릭!!")
							console.log(PurchaseInput + ">0 &&" + PurchaseInput
									+ "<=" + PurchaseInputMax);
							console.log(PurchaseInput > 0
									&& PurchaseInput <= PurchaseInputMax)
									console.log(PurchaseInput > 0
									)
									console.log(PurchaseInput <= PurchaseInputMax)
							//let purchaseNum = $("#PurchaseInput").val();
							//$("#purchaseInput").val(purchaseNum);
							//console.log(purchaseNum);
							if (
								0 < PurchaseInput && PurchaseInput <= PurchaseInputMax) {
								console.log("0<"+ PurchaseInput);
								
								console.log(PurchaseInput + "<="
										+ PurchaseInputMax);
								console.log("-----------------");
								console.log("0 < PurchaseInput  <=  PurchaseInputMax :"+ 0 < PurchaseInput  <=
										 PurchaseInputMax);
								
								console.log("0<"
										+ PurchaseInput + "<="
										+ PurchaseInputMax);

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
										console.log(data);
										$("#outInfo").empty();
										$("#outInfo").text(data);
										$("#cartInforModal1").modal('show');

									},
									error : function(error) {
										console.log("ajax 문제 발생");
										console.log($("#PurchaseInput").val());
										console.log($("#productId").val());
										console.log(error);
										$("#cartInforModal2").modal('show');

									},
									complete : function() {

										console.log("ajax 종료");
									}

								})
							} else if (PurchaseInput == 0) {
								console.log($("#PurchaseInput").val());
								$("#outInfo").empty();
								$("#outInfo").text("주문 수량이 0입니다.");
								$("#cartInforModal1").modal('show');

							}

							else if (PurchaseInput >= PurchaseInputMax) {
								console.log($("#PurchaseInput").val() + " <= "
										+ $("#PurchaseInput").attr("max"));
								$("#outInfo").empty();
								$("#outInfo").text("재고가 부족 합니다.");
								$("#cartInforModal1").modal('show');
							}

						})

			});
</script>
<style>
.row {
	text-align: center;
}

a {
	text-decoration-line: none;
}

a:hover {
	color: black;
}

body {
	font-family: 나눔스퀘어, 'NanumSquare', sans-serif;
}

.table>:not(caption)>*>* {
	padding: 12px;
}

.accordion-button:not(.collapsed) {
	color: #f4eedd;
	background-color: #608463;
	box-shadow: inset 0 -1px 0 rgb(0 0 0/ 13%);
	opacity: 1;
}

.accordion-button {
	color: #f4eedd;
	text-align: left;
	background-color: #608463;
	opacity: 0.7;
}

.accordion-button::after {
	flex-shrink: 0;
	width: 0rem;
	height: 1.25rem;
	margin-left: auto;
	content: "";
	background-repeat: no-repeat;
	background-size: 1.25rem;
	transition: transform .2s ease-in-out;
}

textarea {
	resize: none;
	overflow: visible;
}
</style>
<title>작은 숲</title>
</head>
<body>


	<sec:authorize access="isAuthenticated()">
		<sec:authentication property="principal" var="principal" />
		<c:url value="/order/cart" var="cartUrl">
			<c:param name="id" value="${principal.username }" />
		</c:url>
	</sec:authorize>
	<my:pagenavbar></my:pagenavbar>
	<br />
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
							<form id="buybutton" action="${appRoot }/order/direct"
								method="get">
								<!-- 여기에 구매 페이지 주소 입력 -->
								<!-- 구매 버튼 연결 주소 입력 -->
								<!-- 판매글 아이디(29번째줄), 상품 아이디(30번쨰줄) , 상품 구매수량(28번째줄) 넘어 갑니다. -->
								<!-- 상품페이지 dto에 구매 수량 Purchase 추가 했습니다.(아직 사용한 곳은 없음...) -->

								<!-- -------------------------------------------------------- -->




								<!-- --------------------------------------------------- -->

								<p>판매 상품 : ${product.productName }</p>
								<h2>${product.strPrice }원</h2>

								<c:if test="${product.stock != 0 }">
					구매 수량
					<input id="PurchaseInput" type="number" name="Purchase" value="1"
										min="1" max="${product.stock }" />
									<input type="hidden" value="${productboard.id }" name="id" />
									<input id="productId" type="hidden"
										value="${productboard.productId }" name="productId" />

								</c:if>
							</form>
							<br />
							<br />
							<br />
							<br />
							<br />
							<br />
							<c:if test="${product.stock != 0 }">
								<div class="btn-group" role="group" style="">
									<sec:authorize access="hasRole('USER')">
										<button class="buttonTobuy btn btn-outline-success"
											id="purchaseButton">장바구니</button>
									</sec:authorize>
									<button class="buttonTobuy btn btn-outline-success"
										form="buybutton">바로구매</button>
								</div>
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

			<br />
			<br />
			<!-- --------------------------------------------------- -->

			<h2 class="justify-content-center">상세 정보</h2>

			<textarea name="body" id="textarea1"
				style="text-align: center; outline-color: white; border: 0px; width: 100%; height: 70%;"
				readonly>${productboard.boardBody }</textarea>



			<sec:authorize access="hasRole('ADMIN')">
				<form id="deleteBoard" action="/market/product/deleteBoard"
					method="post">
					<input type="hidden" name="id" value="${productboard.id }" />
					<input type="hidden" name="deleteImg"
						value="${productboard.fileList }" style="display: inline-block;" />
				</form>

				<!-- 수정폼 -->
				<form id="deleteModif" action="/market/product/modif">
					<input type="hidden" value="${productboard.id }" name="id" />
				</form>

				<button form="deleteModif" class="btn btn-success">판매글 수정</button>
				<button form="deleteBoard" class="btn btn-danger">판매글 삭제</button>

			</sec:authorize>

			<c:if test="${not empty check && show}">

				<form action="${appRoot }/review/add" method="get">
					<input type="hidden" name="prodctPageid"
						value="${productboard.id }" />
					<button class="btn btn-success">리뷰 작성</button>
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

							<th scope="col">리뷰</th>


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
												<button class="accordion-button collapsed" type="button"
													data-bs-toggle="collapse"
													data-bs-target="#review${reviewlist.id }"
													aria-expanded="false"
													aria-controls="panelsStayOpen-collapseOne">

													<div class="col">${reviewlist.reviewTitle }</div>

												</button>
											</h2>
											<div id="review${reviewlist.id }"
												class="accordion-collapse collapse"
												aria-labelledby="panelsStayOpen-headingOne">
												<div class="accordion-body">
													<c:forEach items="${reviewlist.fileList}" var="reviewfile">

														<c:if test="${reviewfile != null }">

															<img style="width: 200px" class="img-thumbnail"
																src="${imageUrl }/project/reviewpage/${reviewlist.id }/${reviewfile}"
																alt="" />
														</c:if>

														<c:if test="${reviewfile == null }">
														</c:if>
													</c:forEach>
													<div class="row">
														<div class="col" style="text-align: end;">작성자
															:${reviewlist.memberId }</div>
														<textarea name="reviewbody" id="textarea1" rows="10"
															style="text-align: center; outline-color: white; border: 0px; width: 100%; resize: none; overflow: visible;"
															readonly>${reviewlist.reviewBody }</textarea>

													</div>
													<br />
													<div class="row">
														<sec:authorize access="isAuthenticated()">
															<sec:authentication property="principal" var="principal" />
															<c:if test="${not empty check && (reviewlist.memberId ==name || name =='admin' ) }">
															
																<form id="formForReviewDelete"
																	action="${appRoot }/product/deleteReview" method="post">
																	<input type="hidden" value="${productboard.id }"
																		name="productPage" />
																	<input type="hidden" value="${reviewlist.id} "
																		name="id" />
																	<!-- <input type="submit" value="리뷰 삭제" /> -->
																</form>
																<form id="formForReviewModif"
																	action="${appRoot }/review/modif" method="get">
																	<input type="hidden" name="id"
																		value="${reviewlist.id} " />
																	<input type="hidden" name="boardId"
																		value="${productboard.id }">
																	<input type="hidden" name = "memberId" value ="${name }" />
																	<!-- <input type="submit" value="리뷰 수정" /> -->

																</form>
																<div class="col" style="text-align: right;">
																	<button class="btn btn-success"
																		form="formForReviewModif">리뷰 수정</button>
																	<button class="btn btn-danger"
																		form="formForReviewDelete">리뷰 삭제</button>
																</div>

															</c:if>
														</sec:authorize>
													</div>
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
				<div id="outInfo" class="modal-body">
					<p>장바구니에 추가 했습니다.</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-success"
						data-bs-dismiss="modal">계속 쇼핑하기</button>
					<button form="cartForm" class="btn btn-success">장바구니로 이동</button>
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
					<button type="button" class="btn btn-success"
						data-bs-dismiss="modal">계속 쇼핑하기</button>
					<button form="cartForm" class="btn btn-success">장바구니로 이동</button>


				</div>
			</div>
		</div>
	</div>
</body>
</html>