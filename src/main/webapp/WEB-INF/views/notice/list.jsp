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
<link rel="stylesheet" type="text/css"
	href="https://cdn.jsdelivr.net/gh/moonspam/NanumSquare@1.0/nanumsquare.css">
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
<style>
a {
	text-decoration-line: none;
}

a {
	color: black;
}

a:hover {
	color: #608463;
}

body {
	font-family: 나눔스퀘어, 'NanumSquare', sans-serif;
}

.table>:not(caption)>*>* {
	padding: 12px;
}
.page-link {
    color: black;
    }
</style>
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
				<h1>공지사항</h1>
				<c:url value="/notice/write" var="writeUrl"></c:url>
				<sec:authorize access="hasRole('ADMIN')">
						<a href="${writeUrl }"
							class="nav-link ${current == 'write' ? 'active' : '' }"
							style="color: black;">▶ 공지작성</a>
				</sec:authorize>
				<table class="table">
					<thead>
						<tr>
							<th>번호</th>
							<th>제목</th>
							<th>관리자</th>
							<th>작성일</th>
							<th>조회수</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${noticeList }" var="notice">
							<tr>
								<td>${notice.id }</td>

								<td>
									<c:url value="/notice/get" var="getUrl">
										<c:param name="id" value="${notice.id }"></c:param>
									</c:url>
									<span class="badge bg-danger">[공지]</span>
									<a href="${getUrl }">
										<c:out value="${notice.title }" />
									</a>

								</td>
								<td>${notice.writerNickName }</td>
								<td>${notice.prettyInserted }</td>
								<td>${notice.viewCount }</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<div class="mt-3">
					<my:pagenation path="list"></my:pagenation>
				</div>
			</div>
		</div>
	</div>
</body>
</html>