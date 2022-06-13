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
				low_class_show_Element.empty();// 전에 있는거 다 지움  안지우면 새로 불러 올때마다 계속 추가됨
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
});
</script>

<title>Insert title here</title>
</head>
<body>
<my:pagenavbar></my:pagenavbar>
<p>수정 페이지</p>

<form action="/market/product/modif" method="post">
		상품명 :
		<br />
		<input value ="${product.productname }" type="text" name="productname" readonly="readonly">
		<input type="hidden" name="productId" value="${product.productId }" />
	제품 아이디 :${product.productId }
		상품 중 분류 :
		<select id="middle_class" name="Product_middle_class">
			<option value="0">분류 선택</option>
			<c:forEach items="${ m_category}" var="category">
				<option value="${category.product_middle_class}">${category.middle_name }</option>
			</c:forEach>
		</select>
		
		
		<div id="low_class_categorylist_get" >

			상품 소 분류 :
			<select name="Product_low_class">
				<c:forEach items="${ l_category}" var="category_l">
					<option value="${category_l.product_low_class}">${category_l.low_name }</option>
				</c:forEach>
			</select>

		</div>
		
		
		<input type="number" name = "Stock" value="${product.stock }"/>
		<br />
	제목 : <br />
	<input type="text" value="${productpage.boardTitle}" /> <br />
	 본문 : <br />
	 <textarea rows="15" cols="100">${productpage.boardBody}</textarea>
	
	<c:forEach items="${productpage.fileList }" var="file">
			<%
			if(pageContext.getAttribute("file") != null){
					
				String file = (String) pageContext.getAttribute("file");
				String encodedFileName = java.net.URLEncoder.encode(file, "utf-8");
				pageContext.setAttribute("encodedFileName", encodedFileName);
			}
			%>
			
			
			
			<div>
				<img
					src="${imageUrl }/project/${productpage.id}/${encodedFileName }"
					alt="" />
			</div>
		</c:forEach>
		
		
		
		
	<input type="submit" value="전송" />
	
</form>
</body>
</html>