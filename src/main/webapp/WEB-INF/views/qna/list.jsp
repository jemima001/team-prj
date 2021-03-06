<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
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
				<sec:authorize access="hasRole('USER')">
					<sec:authentication property="principal" var="principal"/>
					<h1>${principal.username } 님의 문의 내역입니다.</h1>	
				</sec:authorize>
				<sec:authorize access="hasRole('ADMIN')">
					<h1>전체문의 내역입니다.</h1>	
				</sec:authorize>
				<table class="table">
					<thead>
						<tr>
							<th><i class="fa-solid fa-hashtag"></i></th>
							<th>제목</th>
							<th>닉네임</th>
							<th><i class="fa-solid fa-calendar"></i></th>
							<th>답변 여부</th>
						</tr>
					</thead>
					<tbody>
						<sec:authorize access="isAuthenticated()">
							<sec:authentication property="principal" var="principal"/>
								<c:forEach items="${queryList }" var="query">
									<c:if test="${principal.username == query.memberId }">
											<tr>
												<td>${query.id }</td>
												<td>
													<c:url value="/qna/get" var="getUrl">
														<c:param name="id" value="${query.id }"></c:param>
													</c:url>
													<a href="${getUrl }">
														<c:out value="${query.title }" />
													</a>
												</td>
												<td>${query.writerNickName }</td>
												<td>${query.prettyInserted }</td>
												<td>
													<c:choose>
														<c:when test="${query.numOfAnswer > 0 }">
															<span class="badge rounded-pill bg-success">답변 완료</span>
														</c:when>
														<c:otherwise>
															<span class="badge rounded-pill bg-warning">답변 대기</span>
														</c:otherwise>
													</c:choose>
												</td>
											</tr>
									</c:if>
								</c:forEach>
						</sec:authorize>
						<sec:authorize access="hasRole('ADMIN')">
							<sec:authentication property="principal" var="principal"/>
								<c:forEach items="${queryList }" var="query">
										<tr>
											<td>${query.id }</td>
											<td>
												<c:url value="/qna/get" var="getUrl">
													<c:param name="id" value="${query.id }"></c:param>
												</c:url>
												<a href="${getUrl }">
													<c:out value="${query.title }" />
												</a>
											</td>
											<td>${query.writerNickName }</td>
											<td>${query.prettyInserted }</td>
											<td>
												<c:choose>
													<c:when test="${query.numOfAnswer > 0 }">
														<span class="badge rounded-pill bg-success">답변 완료</span>
													</c:when>
													<c:otherwise>
														<span class="badge rounded-pill bg-warning">답변 대기</span>
													</c:otherwise>
												</c:choose>
											</td>
										</tr>
								</c:forEach>
						</sec:authorize>
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