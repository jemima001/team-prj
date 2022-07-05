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
<style>
body{
	font-family: 나눔스퀘어, 'NanumSquare', sans-serif;
}
</style>
<title>작은 숲</title>
</head>
<body>
	<my:pagenavbar></my:pagenavbar>



	<form action="${appRoot }/review/modif" method="post"
		enctype="multipart/form-data">
		<input type="hidden" name="productPage" value="${review.productPage }" />
		<input type="hidden" name ="id"  value="${review.id }"/>
		${review.id }
		${review.productPage }
		<div class="mb-3">
			<label for="reviewAddTitle" class="form-label">리뷰 제목</label>
			<input type="text" class="form-control" id="reviewAddTitle"
				name="reviewTitle" value="${review.reviewTitle }">
		</div>
		<div class="mb-3">
			<label for="reviewAddBody" class="form-label">내용</label>
			<textarea class="form-control" id="reviewAddBody" rows="3"
				name="reviewBody">${review.reviewBody }</textarea>
		</div>
		<input type="file" name="file" multiple="multiple" />
		<input type="hidden" name ="memberId" value ="${review.memberId }" />
		<input type="submit" value="작성" />
<br />
		<c:forEach items="${review.fileList }" var="file">
			<%
				if (pageContext.getAttribute("file") != null) {

				String file = (String) pageContext.getAttribute("file");
				String encodedFileName = java.net.URLEncoder.encode(file, "utf-8");
				pageContext.setAttribute("encodedFileName", encodedFileName);
			}
			%>
	<img style="width: 200px" src="${imageUrl }/project/reviewpage/${review.id}/${encodedFileName}" alt="" />
	<input type="checkbox" name = "deleteimg" value="${file}" />
	<input type="hidden" name = "productPage" value="${review.productPage }" />

		</c:forEach>


	</form>
</body>
</html>