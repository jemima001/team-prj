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
<title>Insert title here</title>
</head>
<body>
	<my:pagenavbar></my:pagenavbar>
	<h1>판매 페이지 테스트</h1>
	<form action="/market/product/list" method="get">
		<!-- 여기에 구매 페이지 주소 입력 -->
		<!-- 구매 버튼 연결 주소 입력 -->
		<!-- 판매글 아이디(29번째줄), 상품 아이디(30번쨰줄) , 상품 구매수량(28번째줄) 넘어 갑니다. -->
		<!-- 상품페이지 dto에 구매 수량 Purchase 추가 했습니다.(아직 사용한 곳은 없음...) -->
		<p>판매글 제목 : ${productboard.boardTitle }</p>
		<p>판매글 내용 : ${productboard.boardBody }</p>
		<p>판매 상품 : ${product.productname }</p>
		<p>가격 : ${product.price }</p>

		
		
		<c:forEach items="${productboard.fileList }" var="file">
			<%
			if(pageContext.getAttribute("file") != null){
					
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
		
		구매 수량
		<input type="number" name="Purchase" value="1" />
		<input type="hidden" value="${productboard.id }" />
		<input type="hidden" value="${productboard.productId }" />
		<button>구매 버튼</button>
	</form>
	<form action="/market/product/deleteBoard" method="post">
		<input type="hidden" name="id" value="${productboard.id }" />
		<input type="submit" value="판매글 삭제" />
	</form>





	<!-- 수정페이지 이동 -->
	<c:url value="/product/modif" var ="modifurl">
		
	</c:url>
	<form action="${ modifurl}" method="get">
	<input type="hidden" name = "id" value="${productboard.id }"/>
	<input type="submit" value="수정" />
	</form>


</body>
</html>