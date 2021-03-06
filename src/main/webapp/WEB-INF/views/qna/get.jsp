<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
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
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.3/font/bootstrap-icons.css">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
	crossorigin="anonymous"></script>
<style>
body{
	font-family: 나눔스퀘어, 'NanumSquare', sans-serif;
}
a {
	text-decoration-line: none;
}

a {
	color: black;
}

a:hover {
	color: #608463;
}
</style>
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
			let actionAttr = "${appRoot}/qna/remove";
			form1.attr("action", actionAttr);

			form1.submit();
		}

	});
	
	$("#edit-button2").click(function() {
		$("#input11").removeAttr("readonly");
		$("#textarea11").removeAttr("readonly");
		$("#modify-submit2").removeClass("d-none");
		$("#delete-submit2").removeClass("d-none");
		$("#addFileInputContainer2").removeClass("d-none");
		$(".removeFileCheckbox2").removeClass("d-none");
	});

	$("#delete-submit2").click(function(e) {
		e.preventDefault();

		if (confirm("삭제하시겠습니까?")) {
			let form2 = $("#form2");
			let actionAttr = "${appRoot}/qna/adremove";
			form2.attr("action", actionAttr);

			form2.submit();
		}

	});
	
	$("#mes").hide(2000);
});
</script>
<title>작은 숲</title>
</head>
<body>

<my:pagenavbar></my:pagenavbar>
<div class="container">
		<br />
		<div class="row">
			<div class="col-3">
				<my:customercenternavbar current="notice"></my:customercenternavbar>
			</div>
			<div class="col-9">
			<div class="row">
				<div class="col-sm-6">
					<div>
						
						<h2>문의
						<sec:authorize access="isAuthenticated()">
								<sec:authentication property="principal" var="principal"/>
								<c:if test="${principal.username == query.memberId }">
									<button id="edit-button1" class="btn btn-secondary">
										<i class="fa-solid fa-pen-to-square"></i>
									</button>
								</c:if>
						</sec:authorize>
						</h2>
						
					</div>
					<c:if test="${not empty message }">
						<div id="mes" class="alert alert-primary">${message }</div>
					</c:if>
					<form id="form1" action="${appRoot }/qna/modify" method="post" enctype="multipart/form-data">
					<input type="hidden" name="id" value="${query.id }" />
						<div>
							<label class="form-label" for="input1">제목</label>
							<input class="form-control mb-3" type="text" name="title" required
								id="input1" value="${query.title }" readonly />
						</div>
		
						<div>
							<label class="form-label" for="textarea1">본문</label>
							<textarea class="form-control mb-3" name="body" id="textarea1"
								cols="30" rows="8" readonly style=" resize: none;">${query.body }</textarea>
						</div>
						
						<c:forEach items="${query.fileName }" var="file">
						<%
						String file = (String) pageContext.getAttribute("file");
						String encodedFileName = java.net.URLEncoder.encode(file, "utf-8");
						pageContext.setAttribute("encodedFileName", encodedFileName);
						%>
							<div class="row">
								<div class="col-lg-1 col-12 d-flex align-items-center">
									<div class="d-none removeFileCheckbox">
										<div class="form-check form-switch">
												<label class="form-check-label text-danger">
													<input class="form-check-input delete-checkbox" type="checkbox" name="removeFileList1" value="${file }"/>
													<i class="fa-solid fa-trash-can"></i>
												</label>
										</div>
									</div>
								</div>
								<div class="col-lg-11 col-12">
									<div>
										<img class="img-fluid img-thumbnail" src="${imageUrl }/project/query/${query.id }/${encodedFileName }" alt="" />
									</div>
								</div>
							</div>
						</c:forEach>
						
						<div>
							<label for="input3" class="form-label">작성자</label>
							<input id="input3" class="form-control mb-3" type="text"
								value="${query.writerNickName }" readonly />
						</div>
		
						<div id="addFileInputContainer1" class="my-3 d-none">
							<label for="fileInput1" class="form-label"></label>
							파일 추가
							<input id="fileInput1" class="form-control mb-3" type="file" accept="image/*" multiple="multiple" name="addFileList" />
						</div>
						
						<div>
							<label for="input2" class="form-label">작성일시</label>
							<input class="form-control mb-3" type="datetime-local"
								value="${query.inserted }" readonly />
						</div>
		
						<button id="modify-submit1" class="btn btn-primary d-none">수정</button>
						<button id="delete-submit1" class="btn btn-danger d-none">삭제</button>
					</form>
				</div>
				
				<div class="col-sm-6">
					<div class="">
						<ul class="nav me-auto">
							<li>
								<h2 style="display: inline;">답변</h2>
								<c:if test="${query.numOfAnswer > 0 }">
									<sec:authorize access="hasRole('ADMIN')">
										<button id="edit-button2" class="btn btn-secondary">
											<i class="fa-solid fa-pen-to-square"></i>
										</button>
									</sec:authorize>
								</c:if>
							</li>
						</ul>
					</div>
						<c:if test="${not empty message2 }">
							<div id="mes" class="alert alert-primary">${message2 }</div>
						</c:if>
					<c:if test="${query.numOfAnswer == 0 }">
						<sec:authorize access="hasRole('USER')">
							<div class="alert alert-warning" style="margin-top: 125px; text-align: center;">
								<h3 style="margin-top: 70px; margin-bottom: 70px;">
									답변 대기중
								</h3>
							</div>
						</sec:authorize>
						<sec:authorize access="hasRole('ADMIN')">
							<form action="${appRoot }/qna/answer" method="post" enctype="multipart/form-data">
								<input type="hidden" name="queryId" value="${query.id }" />
								<div>
									<label class="form-label" for="input11">제목</label>
									<input class="form-control" type="text" name="title" required id="input11" />
								</div>
								
								<div>
									<label class="form-label" for="textarea1">본문</label>
									<textarea class="form-control" name="body" id="textarea11" cols="30" rows="8" style=" resize: none;"></textarea>
								</div>
								<div>
									파일
									<input multiple="multiple" type="file" name="file" accept="image/*"/>
								</div>
								
								<button class="btn btn-success">작성</button>
							</form>
						</sec:authorize>
					</c:if>
					<c:if test="${query.numOfAnswer > 0 }">
						<form id="form2" action="${appRoot }/qna/admodify" method="post" enctype="multipart/form-data">
						<input type="hidden" name="id" value="${answer.id }" />
						<input type="hidden" name="queryId" value="${answer.queryId }" />
							<div>
								<label class="form-label" for="input11">제목</label>
								<input class="form-control mb-3" type="text" name="title" required
									id="input11" value="${answer.title }" readonly />
							</div>
			
							<div>
								<label class="form-label" for="textarea1">본문</label>
								<textarea class="form-control mb-3" name="body" id="textarea11"
									cols="30" rows="10" readonly style=" resize: none;">${answer.body }</textarea>
							</div>
							
							<c:forEach items="${answer.fileName }" var="file">
							<%
							String file = (String) pageContext.getAttribute("file");
							String encodedFileName = java.net.URLEncoder.encode(file, "utf-8");
							pageContext.setAttribute("encodedFileName", encodedFileName);
							%>
								<div class="row">
									<div class="col-lg-1 col-12 d-flex align-items-center">
										<div class="d-none removeFileCheckbox2">
											<div class="form-check form-switch">
													<label class="form-check-label text-danger">
														<input class="form-check-input delete-checkbox" type="checkbox" name="removeFileList2" value="${file }"/>
														<i class="fa-solid fa-trash-can"></i>
													</label>
											</div>
										</div>
									</div>
									<div class="col-lg-11 col-12">
										<div>
											<img class="img-fluid img-thumbnail" src="${imageUrl }/project/answer/${answer.queryId }/${encodedFileName }" alt="" />
										</div>
									</div>
								</div>
							</c:forEach>
							
							<div>
								<label for="input13" class="form-label">작성자</label>
								<input id="input13" class="form-control mb-3" type="text"
									value="${answer.writerNickName }" readonly />
							</div>
			
							<div id="addFileInputContainer2" class="my-3 d-none">
								<label for="fileInput11" class="form-label"></label>
								파일 추가
								<input id="fileInput11" class="form-control mb-3" type="file" accept="image/*" multiple="multiple" name="addFileList" />
							</div>
							
							<div>
								<label for="input12" class="form-label">작성일시</label>
								<input class="form-control mb-3" type="datetime-local"
									value="${answer.inserted }" readonly />
							</div>
			
							<button id="modify-submit2" class="btn btn-primary d-none">수정</button>
							<button id="delete-submit2" class="btn btn-danger d-none">삭제</button>
						</form>
					</c:if>
				</div>
			</div>
		</div>	
	</div>
</div>		
			
</body>
</html>