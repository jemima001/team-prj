<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix = 'c' uri ="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
    <%request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" integrity="sha512-GQGU0fMMi238uA+a/bdWJfpUGKUkBdgfFdgBm72SUQ6BeyWjoY/ton0tEjH+OSH9iP4Dfh+7HM0I9f5eR0L/4w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" referrerpolicy="no-referrer"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<title>Insert title here</title>
</head>
<body>
<my:pagenavbar></my:pagenavbar>
<h1>판매 페이지 테스트</h1>
<p>판매글 제목 : ${productboard.boardTitle }</p>
<p>판매글 내용 : ${productboard.boardBody }</p>
<p>판매 상품 : ${product.productname }</p>
<p>가격 : ${product.price }</p>
<p>판매글 아이디 :${productboard.id }</p>
<form action="/market/product/deleteBoard"  method="post">
<input type="hidden" name="id" value="${productboard.id }" />
<<input type="submit" value ="판매글 삭제" />
</form>


<!-- 수정폼 -->
판매글 제목: <br />
<input type="text" name="boardTitle" value="${productboard.boardTitle }" /> <br />
판매글 내용 : <br />
<textarea rows="10" cols="100" name="boardBody">${productboard.boardBody }</textarea> <br />
판매 상품: <br />
<input type="text" value="${product.productname }"  /> <br />

가격 : <br />
<input type="number" name="price" value="${product.price }" /> <br />




</body>
</html>