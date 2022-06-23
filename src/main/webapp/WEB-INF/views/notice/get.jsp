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

<style type="text/css">
#form1 {
  border-width: 0.3ex 0ex 0.3ex;;
  border-style: solid;
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
<my:customercenternavbar current="notice"></my:customercenternavbar>
<div class="container">
	<div class="row">
		<div class="col">
			<div class="navbar pt-5 pb-4">
				<ul class="nav me-auto">
					<li>
						<h2 style="display: inline;">공지사항</h2>
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
					<label class="form-label mt-2" for="input1">제목</label>
					<input class="form-control mb-3" type="text" name="title" required
						id="input1" value="${notice.title }" readonly />
				</div>

				<div>
					<label class="form-label" for="textarea1">본문</label>
					<textarea class="form-control mb-3" name="body" id="textarea1"
						cols="30" rows="10" readonly style="border:none;">${notice.body }</textarea>
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
				<div class="mb-2">
					<button id="modify-submit1" class="btn btn-primary d-none">수정</button>
					<button id="delete-submit1" class="btn btn-danger d-none">삭제</button>
				</div>
			</form>
			<table class="table">
				<tbody>
					<c:forEach items="${noticeList }" var="nbid">
						<tr>
							<c:if test="${nbid.id < notice.id }">
								<c:url value="/notice/get" var="getUrl">
									<c:param name="id" value="${nbid.id }"></c:param>
								</c:url>
								<td>
									<i class="fa-solid fa-angle-down"></i>
								</td>
								<td>
									${nbid.id }
								</td>
								<td>
									<span class="badge bg-danger">[공지]</span>
									<a href="${getUrl }">
										${nbid.title }
									</a>
								</td>
								<td>
									${nbid.writerNickName }
								</td>
								<td>
									${nbid.prettyInserted }
								</td>
							</c:if>
							<c:if test="${nbid.id > notice.id }">
								<c:url value="/notice/get" var="getUrl">
									<c:param name="id" value="${nbid.id }"></c:param>
								</c:url>
								<td>
									<i class="fa-solid fa-angle-up"></i>
								</td>
								<td>
									${nbid.id }
								</td>
								<td>
									<span class="badge bg-danger">[공지]</span>
									<a href="${getUrl }">
										${nbid.title }
									</a>
								</td>
								<td>
									${nbid.writerNickName }
								</td>
								<td>
									${nbid.prettyInserted }
								</td>
							</c:if>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>	
	</div>
</div>		
			
</body>
</html>