<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
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

<script>
$(document).ready(function() {
	
	$('#middle_class').on('change', function() {
		const data = {
				Product_middle_class : $("#middle_class").val()
				} 
		$.ajax({
			url : "${appRoot}/product/get_low_class",
			type : "get",
			data : data,
			success : function(code) {
				
				// 소분류 셀렉터 그리기
				const low_class_show_Element = $("#low_class_categorylist_get");
				low_class_show_Element.empty();
				const select_low = $("<select name='Product_low_class' ></select>");
				low_class_show_Element.append(select_low);
				
				for(let i =0; i<code.length; i++){
					select_low.append(`
							<option value="\${code[i].product_low_class}">\${code[i].low_name }</option>
							`);
					console.log(code[i].product_low_class);
					console.log(code[i].low_name);
				}
				
				console.log("가져온 코드");
				console.log(code);
			},
			
			error: function (){
				console.log("ajax 문제 발생")
			},
			complete : function() {
				console.log("ajax 실행 종료");
			}
			
			
			
		});
		});
	
	/* const select_middle_class = function(){
		
		const data = {
				Product_middle_class : $("#middle_class").val()
				} 
		$.ajax({
			url : "",
			type : "get",
			data : data,
			success : function(code) {
				
				console.log("가져온 코드");
				console.log(code);
			},
			
			error: function (){
				console.log("ajax 문제 발생")
			},
			complete : function() {
				console.log("ajax 실행 종료");
			}
			
			
			
		});
	}
	 */
	
	
	
	// 마지막 괄호
});


</script>

<title>Insert title here</title>
</head>
<body>
<my:pagenavbar></my:pagenavbar>
	<p>상품 추가 페이지 ${m_category[1].middle_name },
		${m_category[1].product_middle_class}</p>
	<!-- <form action="/market/product/product_add" method="post"> -->
	<form action="/market/product/add" method="post"
		enctype="multipart/form-data">
		상품명 :
		<br />
		<input type="text" name="productname">
		상품 중 분류 :
		<select id="middle_class" name="Product_middle_class">
			<option value="0">분류 선택</option>
			<c:forEach items="${ m_category}" var="category">
				<option value="${category.product_middle_class}">${category.middle_name }</option>
			</c:forEach>
		</select>
		<div id="low_class_categorylist_get">

			상품 소 분류 :
			<select name="Product_low_class">
				<c:forEach items="${ l_category}" var="category_l">
					<option value="${category_l.product_low_class}">${category_l.low_name }</option>
				</c:forEach>
			</select>

		</div>
		<br />
		수량 :
		<input type="number" name="Stock" />
		<br />
		가격 :
		<input type="number" name="price" />
	<!-- 	<button>상품등록</button>
	</form> -->

		상품 게시글 제목 :
		<input type="text" name="boardTitle" />
		<br />
		게시글 내용
		<br />
		<textarea rows="10" cols="100" name="boardBody"></textarea>
		<br />
		사진 업로드
		<br />
		<input multiple="multiple" type="file" />

		<button>작성</button>
	</form>

</body>
</html>