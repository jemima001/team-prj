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

<title>주문 완료</title>
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
<my:pagenavbar current="complete"></my:pagenavbar>

<div class="row justify-content-center">
<div class="col-12 col-lg-6">

<br>
<table class="table">
  <tr class="table-success">
    <th>Order Complete 주문 완료</th>
  </tr>
  <tr>
    <td>${member.id } 님! 주문 완료되었습니다. </td>
  </tr>
</table>

<br>

<table class="table">
<thead>
<tr>
<th>  Payment Info 결제 정보 </th>
</tr>
</thead>
</table>




<table class="table">

<thead>
  <tr class="table-info">
  	<th>결제 수량</th>
    <th>결제 금액</th>
    <th>입금 정보</th>
  </tr>
  </thead>
  
  <tbody>
  <tr>
  	<td>${b }개</td>
    <td> ${a } 원  </td>
    <td>우리 352-1234-5678-90 스토어이름 </td>
  </tr>
  </tbody>
</table>


<table class="table">
<thead>
<tr class="table-info">
<th> <i class="fa-solid fa-gift"></i> : 무통장 입금이 확인되면 구매가 확정됩니다.</th>
</tr>
</thead>
</table>


	
	<form action="${appRoot }/product/list" method="get">
	<button class="btn btn-success" id="submitButton11"> 상품 더 담기 </button>
	<!-- 상품 페이지로 이동하는 버튼 -->
	</form>
	
	
	
	
	
</div>
</div>



</body>
</html>