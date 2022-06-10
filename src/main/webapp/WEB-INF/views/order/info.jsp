<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri ="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" integrity="sha512-GQGU0fMMi238uA+a/bdWJfpUGKUkBdgfFdgBm72SUQ6BeyWjoY/ton0tEjH+OSH9iP4Dfh+7HM0I9f5eR0L/4w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" referrerpolicy="no-referrer"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

<title> 주문서 작성 ▶ 스토어</title>

<style type="text/css">
.tagA {
background-color: #D0936D;
}


</style>
</head>

<!-- 
<script type="text/javascript">
$(document).ready(function(){
	$("#theme").addClass("tagA");
});

</script>
-->

<body>

<!-- current 속성 추가하기(navbar) -->
<my:pagenavbar></my:pagenavbar>


<!--  
<p id ="theme"> 주문 결제 Order/ Payment </p>
-->

<h4>Order/Payment 주문/결제</h4> <br>


<form id="form10" action="${appRoot }/order/info" method="post">
	
	닉네임: ${member.nickName }  <br>
	
	주문자 성함: ${member.id } 님의 주문을 진행합니다. <br> <br>
	
	
	<h5>Recipient Info 수령자 정보</h5> <br> 
	
	
	수령인 성함: <input type="text" name="receiver"/>
	<!--<p id="receiverMessage10"></p>-->
	<br>
	
	수령 주소 : <input type="text" name="address"/>
	<!-- <p id="addressMessage10"></p> -->
	<br> <br>
	
	<h5>Product Info 상품 정보</h5> <br>
	
	
	상품 명 :${'aaaa' } <br>
	
	주문 수량 : <input type="number" > <br><br>
	
	
	<h5>Payment Info 결제 정보</h5> <br> 
	
	결제 금액 : ${123 } 원 <br><br>
	
	입금 정보 : 우리 352-1234-5678-90 스토어이름 <br>
	
	입금이 확인되면 구매가 확정됩니다. <br><br><br>
	
	<button id="submitButton10" disabled> 결제하기 </button>
	
</form>




</body>
</html>