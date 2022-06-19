<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

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
<script>
	$(document).ready(
			function() {
			
	});
</script>
</head>
<body>
	<my:pagenavbar current="setaddress"></my:pagenavbar>
	<my:mypagenavbar current="setaddress"></my:mypagenavbar>

	<div class="container">
		<div class="row justify-content-center">
			<div class="col-12 col-lg-6">
				<h1>현재 기본 배송지</h1>
					<div>
						<p>${message }</p>
					</div>
					<div>
						<label for="nameInput1" class="form-label"> 이름 </label>
						<input id="nameInput1" class="form-control" type="text"
							value="${member.name }" readonly />

						<input type="hidden" name="id" value="${member.id}" />

						<label for="addressInput1" class="form-label"> 주소 </label>
						<input class="form-control" id="addressInput1" type="text"
							name="address" value="${member.address }" readonly/>
					</div>
			</div>
		</div>
		<div class="row">
			<div class="col">
				<h1>배송지 목록</h1>
				<table class="table">
					<thead>
						<tr>
							<th>주소</th>
							<th></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${addressList }" var="address"
							varStatus="status">
							<tr>
								<td>${address.address }</td>
								<td align="right">
									<div class="btn-group" role="group" aria-label="Basic example">
										<button form="form${status.count }" type="submit" class="btn btn-outline-success">기본배송지로 설정</button>
										<form id="form${status.count }" action="${appRoot }/member/setOneAddress"
											method="post">
											<input type="hidden" value="${address.address }" name="address" />
										</form>

										<button form="formd${status.count }" type="submit" class="btn btn-outline-danger">삭제</button>
										<form id="formd${status.count }" action="${appRoot }/member/addressRemove"
											method="post">
											<input type="hidden" value="${address.address }"
												name="address" />
										</form>
									</div>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div class="col-12 col-lg-6">
				<h1>배송지 추가</h1>
				<form id="forms1" action="${appRoot }/member/setaddress"
					method="post">
					<div>
						<p>${message }</p>
					</div>
					<div>
						<label for="nameInput1" class="form-label"> 이름 </label>
						<input id="nameInput1" class="form-control" type="text"
							value="${member.name }" readonly />

						<input type="hidden" name="id" value="${member.id}" />

						<label for="addressInput1" class="form-label"> 주소 </label>
						<input class="form-control" id="addressInput1" type="text"
							name="address" value="" />
					</div>
					<div class="mt-3">
						<button class="btn btn-success" id="submitButton1">완료</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	
</body>
</html>