<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" integrity="sha512-GQGU0fMMi238uA+a/bdWJfpUGKUkBdgfFdgBm72SUQ6BeyWjoY/ton0tEjH+OSH9iP4Dfh+7HM0I9f5eR0L/4w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" referrerpolicy="no-referrer"></script>

<title>market</title>
</head>
<body>
<my:pagenavbar></my:pagenavbar>
<my:customercenternavbar current="notice"></my:customercenternavbar>

<div class="container">
	<div class="row">
		<div class="col">
			<table class="table">
				<thead>
					<tr>
						<th>분류</th>
						<th>제목</th>
						<th>닉네임</th>
						<th><i class="fa-solid fa-calendar"></i></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${noticeList }" var="notice">
							<tr>
								<td>
									<p style="color: red;">[공지]</p>
								</td>
													
								<td>
									<c:url value="/notice/get" var="getUrl">
										<c:param name="id" value="${notice.id }"></c:param>
									</c:url>
									
									<a href="${getUrl }">
										<c:out value="${notice.title }" />
									</a>
									
								</td>
								<td>${notice.writerNickName }</td>
								<td>${notice.prettyInserted }</td>
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