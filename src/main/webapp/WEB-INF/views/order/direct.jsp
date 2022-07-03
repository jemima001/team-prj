<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri ="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/gh/moonspam/NanumSquare@1.0/nanumsquare.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" integrity="sha512-GQGU0fMMi238uA+a/bdWJfpUGKUkBdgfFdgBm72SUQ6BeyWjoY/ton0tEjH+OSH9iP4Dfh+7HM0I9f5eR0L/4w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" referrerpolicy="no-referrer"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

<title> 주문서 작성 ▶ 스토어</title>

<script>
	//orderCompleteButton1 클릭 시(결제하기 버튼)
	$(document).ready(function() {

		//기존 암호, 작성 암호 일치 시에 주문하기 버튼 활성화
		let recipientOk = false;
		let addressOk = false;
		let check = $("#addressInput1").val();
		let check2 = $("#recipientInput1").val();
		if(check !=="" ){
			console.log("널 if")
			 addressOk = true;
		} else if (check =="" ){
			console.log("else if")
			addressOk = false;
		}
		
		
		const enableSubmit = function() {
			if (recipientOk && addressOk) {
				$("#error").empty();
				$("#orderCheckButton1").removeAttr("disabled");
			} else {
				$("#error").text("수령인과 주소를 확인해주세요");
				$("#orderCheckButton1").attr("disabled", "");
			}
		}
		
		$("#recipientInput1").keyup(function(){
			
			
			 check2 = $("#recipientInput1").val();
				if(check2 != "" ){
					console.log("널2 if")
					 recipientOk = true;
				} else{
					console.log("else2 if")
					recipientOk = false;
				}
			enableSubmit();
		});
		$("#addressInput1").keyup(function(){
		 check = $("#addressInput1").val();
			if(check != "" ){
				console.log("널 if")
				 addressOk = true;
			} else{
				console.log("else if")
				addressOk = false;
			}
		
			enableSubmit();
		}); 
		// 회원 닉네임
		const nickName = $("#nickNameInput1").val();

		//회원 이름
		const name = $("#nameInput1").val();

		//회원 기본 주소 (주소는 바뀔 수 있으니 상수로 두면 안되나?)
		const address = $("addressInput1").val();

		//주문하기 활성화 함수 (비밀번호 일치시에 주문하기 ?-뺄수도 있음)
		//$("#orderCheckButton1").click(function(e) {
		//if (passwordCheck) {
		//$("orderCheckButton1").removeAttr("disabled");
		//} else {
		//$("orderCheckButton1").attr("disabled","");
		//}	
		//});

		//function printName() {
		//var x = document.getElementById("recipientName").value;
		//document.getElementById("name").innerHTML = x;
		//}

		//주문하기 버튼 클릭 시
		$("#orderCheckButton1").click(function(e) {
			e.preventDefault();
			//const form9 = $("#form9")

			//submit
			// form9.submit();

			//input 값 옮기기
			$("#form10").find("[name=recipient]").val($("#recipientInput1").val());
			$("#form10").find("[name=address]").val($("#addressInput1").val());
			$("#form10").find($("#recipient9")).text($("#recipientInput1").val());
			$("#form10").find($("#address9")).text($("#addressInput1").val());
		});

		
	
		// 결제 버튼 클릭 시
		/* $("#orderCompleteButton1").click(function(e) {
			e.preventDefault();
			const form10 = $("#form10")

			// input 값 옮기기
			form10.find("[name=receiver]").val($("#receiverInput1").val());
			form10.find("[name=address]").val($("#addressInput1").val());

			// submit
			form10.submit();
		});
		*/
	});
</script>
<style>
a{
	text-decoration-line: none;
}
a:hover { color:black;}
body{
	font-family: 나눔스퀘어, 'NanumSquare', sans-serif;
}
.table>:not(caption)>*>* {
    padding: 12px;
}
</style>
</head>
<body>

	<!-- current 속성 추가하기(navbar) -->
	<my:pagenavbar current="info"></my:pagenavbar>


	<!--  
<p id ="theme"> 주문 결제 Order/ Payment </p>
-->
	<div class="row justify-content-center">
		<div class="col-12 col-lg-6">

			<h4>주문/결제</h4>

			<br>

			<div>
				<p>▶ 상품 정보</p>
			</div>

			<div>

				<div class="container">
					<div class="row">
						<div class="col">
							<h6>  ▼ 주문 목록  </h6>

							<table class="table">
								<thead>
									<tr class="table-success">
										<th><i class="fa-solid fa-cart-shopping"></i></th>
										<th>상품정보</th>
										<th>수량</th>
										<th>주문금액</th>
										<th>배송 정보</th>
									</tr>
								</thead>
								<tbody>

									

										<tr>
											<th><input type="hidden"  value="${order.orderId }" /></th>

											<td>${order.productName }</td>
											<td>${order.bookCount }개</td>
											<td>${order.totalOrderPrice }원</td>
											<td>무료</td>
										</tr>

								



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

										<th>총 주문 상품 1개</th>

									</tr>
								</thead>
								<tbody>
									<tr class="table-success">


										<td>총 주문 금액</td>
										<td>${order.totalOrderPrice }원</td>


									</tr>
								</tbody>
							</table>
						</div>
					</div>







					<br>


					<div>
						<p>▶ 수령 정보</p>
					</div>

				

						<label for="recipientInput1" class="form-label"> 수령인 이름 </label>
						<input name=recipient class="form-control" type="text" id="recipientInput1" value="" />
						
						<label for="addressInput1" class="form-label"> 기본 배송지 (수정 가능합니다.) </label>
						<input id="addressInput1" class="form-control" type="text" id="addressInput1" value="${member.address }" />

					

					
					<br>


					<div>
						<p>▶ 주문 정보</p>
					</div>



					<label for="nickNameInput1" class="form-label"> 닉네임 </label><input
						id="nickNameInput1" class="form-control" type="text"
						value="${member.id }" readonly /> <label for="nameInput1"
						class="form-label"> 이름 </label> <input id="nameInput1"
						class="form-control" type="text" value="${member.name }" readonly />








<br>
					<!-- 결제 전 정보 확인 Modal -->
					<!-- Button trigger modal -->
					<%-- <c:if test="$('#recipientInput1').val != null && $('#addressInput1').val != null"></c:if> --%>
					<button id="orderCheckButton1" type="button"
						class="btn btn-success" form="form9" type="submit"
						data-bs-toggle="modal" data-bs-target="#orderCheckModal1"
						id="confirm" disabled>주문 확인</button>
					<p id="error">수령인과 주소 작성이 완료되지 않았습니다.</p>
				</div>
			</div>
		</div>

		<!-- Modal -->
		<div class="modal fade" id="orderCheckModal1" tabindex="-1"
			aria-labelledby="orderCheckModal1Label" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="orderCheckModal1Label">주문 확인</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<form id="form10" action="${appRoot }/order/directComplete" method="post">
							<input type="hidden" value="${productId }" name="productId">
							<input type="hidden" value="${order.totalOrderPrice }" name="totalOrderPrice">
							<input type="hidden" value="${order.bookCount }" name="bookCount">
							<input type="hidden" value="${member.id }" name="id" readonly />
							<p>${member.id } 고객님!</p>

							<!-- <input id="recipientName"  type="text" name=recipient value="${recipientInput1}" -->

							<input type="hidden" name="recipient" readonly /> <span id="recipient9"></span> 고객님의 <br />
							<input type="hidden" name="address" readonly /> <span id="address9"></span>주소로 배송하시겠습니까?
							
						</form>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">수정하기</button>
						<button id="orderCompleteButton1" form="form10" type="submit"
							class="btn btn-primary">결제하기</button>
					</div>
				</div>
			</div>
		</div>







	
</body>

</html>