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
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/gh/moonspam/NanumSquare@1.0/nanumsquare.css">
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

		let nameOk = false;
		let classOk = false;
		let stockOk = false;
		let priceOk = false;

		const enableSubmit = function() {
			if (nameOk && classOk && stockOk && priceOk) {
				$("#addSubmit").removeAttr("disabled");
			} else {
				$("#addSubmit").attr("disabled", "");
			}
		}

		let mod = $("#formAddforList").attr("data_mod");
		console.log(mod);

		enableSubmit();
		$("#low_class_categorylist_get").hide();
		$("#addProductNameMessage").hide();
		$("#addProductClassMessage").hide();
		$("#addProductStockMessage").hide();
		$("#addProductPriceMessage").hide();

		$("#addProductName").change(function() {
			let newname = $("#addProductName").val();
			//console.log("키업");
			console.log(newname);
			let data = {
				name : $("#addProductName").val()
			}
			$.ajax({
				url : "${appRoot}/product/cheekProductName",
				type : "post",
				data : data,
				success : function(ok) {

					console.log(ok);
					if (!ok) {

						$("#addProductNameMessage").text("이미 존재하는 상품입니다.");
						$("#addProductNameMessage").show();
						nameOk = false
						// 여기 실행 이면 false
					}
					if (ok) {
						$("#addProductNameMessage").hide();
						nameOk = true;
					}
				},
				error : function() {
					console.log("ajax 오류");
				},
				complete : function() {
					enableSubmit();
					console.log("ajax 실행 완료");
				}

			});

		})

		$("#selectProductClass").change(function() {
			enableSubmit();
			console.log("값변화");
			let ok2 = $("#selectProductClass").val();
			if (ok2 == 0) {
				$("#addProductClassMessage").text("분류를 선택해 주세요.")
				$("#addProductClassMessage").show();
				classOk = false;
				enableSubmit();
			} else {
				$("#addProductClassMessage").hide();
				classOk = true;
				enableSubmit();
			}

		})

		$("#priductStockInput").change(function() {
			console.log("값변화");
			let stock = $("#priductStockInput").val();
			if (stock == 0) {
				stockOk = false;
				$("#addProductStockMessage").text("수량을 입력해 주세요.")
				$("#addProductStockMessage").show();
				enableSubmit();
			} else {
				$("#addProductStockMessage").hide();
				console.log("stock !=0");
				stockOk = true;
				enableSubmit();
			}

		})

		$("#priductPriceInput").change(function() {
			let Price = $("#priductPriceInput").val();
			if (Price == 0) {
				console.log("price =0");
				priceOk = false;
				$("#addProductPriceMessage").text("가격을 입력해 주세요.")
				$("#addProductPriceMessage").show();
				enableSubmit();
			} else {
				$("#addProductPriceMessage").hide();
				console.log("price !=0");
				priceOk = true;
				enableSubmit();
			}

		})

		console.log(nameOk);
		console.log(classOk);
		console.log(stockOk);
		console.log(priceOk);
		enableSubmit();

		/* $('#middle_class').on('change', function() {
			const data = {
					Product_Middle_Class : $("#middle_class").val()
					} 
			$.ajax({
				url : "${appRoot}/product/get_low_class",
				type : "get",
				data : data,
				success : function(code) {
					
					// 소분류 셀렉터 그리기
					const low_class_show_Element = $("#low_class_categorylist_get");
					low_class_show_Element.empty();
					const select_low = $("<select name='Product_Low_class' ></select>");
					low_class_show_Element.append(select_low);
					
					for(let i =0; i<code.length; i++){
						select_low.append(`
								<option value="\${code[i].Product_Low_class}">\${code[i].low_name }</option>
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
			}); */

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

<style>
body{
	font-family: 나눔스퀘어, 'NanumSquare', sans-serif;
}
</style>
<title>작은 숲</title>
</head>
<body>
	<my:pagenavbar current="addproduct"></my:pagenavbar>
	<my:mypagenavbar current="addprodut"></my:mypagenavbar>
	
	<div class="container">
	<form action="${appRoot }/product/addProduct" method="post">
		<label for="productName" class="form-label">상품명</label>
		<span>
			<div id="addProductNameMessage" class="alert alert-danger"
				role="alert"></div>
		</span>
		<input id="addProductName" type="text" name="productName"
			class="form-control" id="productNameInput">

		상품 중 분류 :
		<span>
			<div id="addProductClassMessage" class="alert alert-danger"
				role="alert"></div>
		</span>
		<select id="selectProductClass"
			class="form-select form-select-lg mb-3"
			aria-label=".form-select-lg example" name="Product_Middle_Class">
			<option value="0">분류 선택</option>
			<c:forEach items="${ m_category}" var="category">
				<option value="${category.product_Middle_Class}">${category.middle_Name }</option>
			</c:forEach>
		</select>


		<div id="low_class_categorylist_get">

			상품 소 분류 :
			<select name="Product_low_class">
				<c:forEach items="${ l_category}" var="category_l">
					<option value="${category_l.product_Low_Class}">${category_l.low_Name }</option>
				</c:forEach>
			</select>

		</div>

		<br />
		수량 :
		<span>
			<div id="addProductStockMessage" class="alert alert-danger"
				role="alert"></div>
		</span>
		<input id="priductStockInput" type="number" name="stock" min="0" />
		<br />



		가격 :
		<span>
			<div id="addProductPriceMessage" class="alert alert-danger"
				role="alert"></div>
		</span>
		<input id="priductPriceInput" type="number" name="price" min="0" />

		<input id="addSubmit" type="submit" value="상품추가" disabled />

	</form>
	</div>
	</div>

</body>
</html>