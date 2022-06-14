<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" integrity="sha512-GQGU0fMMi238uA+a/bdWJfpUGKUkBdgfFdgBm72SUQ6BeyWjoY/ton0tEjH+OSH9iP4Dfh+7HM0I9f5eR0L/4w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" referrerpolicy="no-referrer"></script>

<script>
$(document).ready(function() {
	$("#edit-button1").click(function() {
		$("#input1").removeAttr("readonly");
		$("#textarea1").removeAttr("readonly");
		$("#modify-submit1").removeClass("d-none");
		$("#delete-submit1").removeClass("d-none");
		$("#addFileInputContainer1").removeClass("d-none");
		$(".removeFileCheckbox").removeClass("d-none");
	});

	$("#delete-submit1").click(function(e) {
		e.preventDefault();

		if (confirm("삭제하시겠습니까?")) {
			let form1 = $("#form1");
			let actionAttr = "${appRoot}/notice/remove";
			form1.attr("action", actionAttr);

			form1.submit();
		}

	});
});
</script>
<title>Insert title here</title>
</head>
<body>

<my:pagenavbar></my:pagenavbar>
<div class="container">
	<div class="row">
		<div class="col">
			<div class="navbar">
				<ul class="nav me-auto">
					<li>
						<h2 style="display: inline;">고객센터</h2>
					</li>
				</ul>
				<sec:authorize access="hasRole('ADMIN')">
						<button id="edit-button1" class="btn btn-secondary">
							<i class="fa-solid fa-pen-to-square"></i>
						</button>
				</sec:authorize>
			</div>
			<c:if test="${not empty message }">
				<div class="alert alert-primary">${message }</div>
			</c:if>
			<form id="form1" action="${appRoot }/notice/modify" method="post" enctype="multipart/form-data">
				<input type="hidden" name="id" value="${notice.id }" />
				<div>
					<label class="form-label" for="input1">제목</label>
					<input class="form-control mb-3" type="text" name="title" required
						id="input1" value="${notice.title }" readonly />
				</div>

				<div>
					<label class="form-label" for="textarea1">본문</label>
					<textarea class="form-control mb-3" name="body" id="textarea1"
						cols="30" rows="10" readonly>${notice.body }</textarea>
				</div>
				
				<div>
					<label for="input3" class="form-label">작성자</label>
					<input id="input3" class="form-control mb-3" type="text"
						value="${notice.writerNickName }" readonly />
				</div>

				<div>
					<label for="input2" class="form-label">작성일시</label>
					<input class="form-control mb-3" type="datetime-local"
						value="${notice.inserted }" readonly />
				</div>

				<button id="modify-submit1" class="btn btn-primary d-none">수정</button>
				<button id="delete-submit1" class="btn btn-danger d-none">삭제</button>
			</form>
		</div>	
	</div>
</div>		
			
</body>
</html>