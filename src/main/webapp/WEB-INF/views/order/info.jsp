<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri ="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
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

<title>주문서 작성 ▶ 스토어</title>

<script>
//orderCompleteButton1 클릭 시(결제하기 버튼)
$(document).ready(function(){
	
	//기존 암호, 작성 암호 일치 시에 주문하기 버튼 활성화
	let passwordCheck = true;
	
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
	
	
	function printName() {
  	var x = document.getElementById("recipientName").value;
    document.getElementById("name").innerHTML = x;
}
	
	
	
	//주문하기 버튼 클릭 시
	$("#orderCheckButton1").click(function(e) {
		e.preventDefault();
		const form9 = $("#form9")
		
		//input 값 옮기기
		form9.find("[name=recipient]").val($("#recipientInput1").val());
		form9.find("[name=address]").val($("#addressInput1").val());
	});
	
	
	// 결제 버튼 클릭 시
	<!--$("#orderCompleteButton1").click(function(e) {
		e.preventDefault();
		const form10 = $("#form10")
	
		// input 값 옮기기
		form10.find("[name=receiver]").val($("#receiverInput1").val());
		form10.find("[name=address]").val($("#addressInput1").val());
	
		// submit
		form10.submit();
	});-->
});
	
</script>

</head>
<body>

	<!-- current 속성 추가하기(navbar) -->
	<my:pagenavbar current="info"></my:pagenavbar>


	<!--  
<p id ="theme"> 주문 결제 Order/ Payment </p>
-->
	<div class="row justify-content-center">
	<div class="col-12 col-lg-6">
	
	<h4>Order/Payment 주문/결제</h4>
	
	<br>
	
	<div>
		<p> ▶ 상품 정보</p>
			</div>
			
	<div>
	
		<div class="container">
		<div class="row">
			<div class="col">
				<h5>주문 목록</h5>
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
							name="cartIds" form="form21" /></th>
							
							<td>${cart.productName }</td>
							<td>${cart.bookCount }</td>
							<td>${cart.totalPrice }</td>
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
							
							<th>총 주문 상품 ${cartList.size() }개</th>
							
						</tr>
					</thead>
					<tbody>
						<tr>
						
						
							<td>총 주문 금액</td>
							<td> ${allTotalPrice }원</td>
							
							
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	
	
	
	
	
	
	
	
	<!--  
		<label for="productInput1" class="form-label">
		상품 이름
		</label>
		<input id="productInput1" class="form-control" type="text" value="${product.id }" readonly />
		
		<label for="productInput2" class="form-label">
		상품 수량 (일단 장바구니 아이디 몰라서 label 수정해야 함)
		</label>
		<input id="productInput2" class="form-control" type="number" value="${product.id }" readonly />
		
		
		<label for="totalPriceInput1" class="form-label">
		총 금액 (일단 장바구니 아이디 몰라서 label 수정해야 함)
		</label>
		<input id="totalPriceInput1" class="form-control" type="number" value="${product.id }" readonly />

	
	<!-- 주문 번호를 hidden으로 넣어야 하나? -->
	
	
	
	
	<br><br>
		
	
		<div>
		<p> ▶ 수령 정보</p>
		</div>
		
		<form id="form9">
		
		<label for="recipientInput1" class="form-label">
		수령인 이름
		</label>
		<input name=recipient class="form-control" type="text" 
		 id="recipientInput1" value="" >
	
		<label for="zipCodeInput1" class="form-label">
		우편번호 (新 주소) ▷ 
		<!-- modal로 구현해도 될듯 / 지금 문제 : 창이 우체국 창으로 바뀌어버림-->
		<a href="https://www.epost.go.kr/search.RetrieveIntegrationNewZipCdList.comm">우체국 검색</a>
		</label>
		<input id="zipCodeInput1" class="form-control" type="number" value="" min="01000" max="63644" />
		
		<label for="addressInput1" class="form-label">
		수령 주소
		</label>
		<input id="addressInput1" class="form-control" type="text" value=""/>
		
		</form>
		
	<br><br>
	
	
	<div>
		<p> ▶ 주문 정보</p>
			</div>
	
	
	
		<label for="nickNameInput1" class="form-label">
		닉네임
		</label>
		<input id="nickNameInput1" class="form-control" type="text" value="${member.id }" readonly />
	
		<label for="nameInput1" class="form-label">
		이름
		</label>
		<input id="nameInput1" class="form-control" type="text" value="${member.name }" readonly />
	
		
		
		
	<!--  
	<div class="center mt-3">
			<button type="button" class="btn btn-info" id="orderCheckButton1"
			data-bs-toggle="modal" data-bs-target="#modal2" disabled>주문 확인</button>
		</div> -->	
	
	
	

	
	
	<!-- 결제 전 정보 확인 Modal -->
	<!-- Button trigger modal -->
<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#orderCheckModal1">
  주문 확인
</button>

	</div>
	</div>
	</div>

<!-- Modal -->
<div class="modal fade" id="orderCheckModal1" tabindex="-1" aria-labelledby="orderCheckModal1Label" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="orderCheckModal1Label">결제하시겠습니까?</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form id="form10" action="${appRoot }/order/complete" method="get">
        	<input type="text" value= "${member.id }" name="id" readonly/> 고객님의 주문 <br><br>
	       
	        <!-- <input id="recipientName"  type="text" name=recipient value="${recipientInput1}" -->
	        
	        <input type="text" name="recipient" readonly/> 고객님의
	        
	        
	        <input type="text" name="address" readonly/> 주소로 배송됩니다.
	        
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">수정하기</button>
        <button id="orderCompleteButton1" form="form10" type="submit" class="btn btn-primary">결제하기</button>
      </div>
    </div>
  </div>
</div>
	
	
	
	
	


	<!-- <form id="form10" action="${appRoot }/order/info" method="post"> 

		닉네임: ${member.nickName } <br>
		주문자 성함: ${member.id } 님의 주문을 진행합니다. <br> <br>


		<h5> Recipient Info 수령자 정보</h5>
		<br> 수령인 성함: <input type="text" name="receiver" />
		<!--<p id="receiverMessage10"></p>
		<br> 수령 주소 : <input type="text" name="address" />
		<!-- <p id="addressMessage10"></p> 
		<br> <br>

		<h5>Product Info 상품 정보</h5>
		<br> 상품 명 :${'aaaa' } <br> 주문 수량 : <input type="number">
		<br> <br>


		<h5>Payment Info 결제 정보</h5>
		<br> 결제 금액 : ${123 } 원 <br> <br>

		<!--  
		<h5>비밀번호 확인</h5>
		<br> 결제 전, 비밀번호를 확인합니다. <br> 비밀번호 : <input
			id="passwordInput10" type="text" name="password" /> <br> 비밀번호 확인
		: <input id="passwordInput20" type="text" name="passwordConfirm" /> <br>
		<p id="passwordMessage10"></p> -->


		<!-- <button id="submitButton10" disabled>결제하기</button> 
	
	</form> -->
	
	
	
	


</body>
</html>