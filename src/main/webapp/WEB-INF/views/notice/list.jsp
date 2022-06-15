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

<div class="container">
	<div class="row">
		<div class="col">
			<div class="navbar">
				<ul class="nav me-auto">
					<li>
						<h2 style="display: inline;">고객센터</h2>
					</li>
				</ul>
				<ul class="nav bg-light">
					<sec:authorize access="hasRole('ADMIN')">
						<li>
							<a href="/market/notice/write">글쓰기</a>
						</li>
					</sec:authorize>
				</ul>
			</div>
			<div class="container d-flex">
					<div class="row flex-fill" >
						<div class="col d-flex justify-content-center" style="background: silver; border: solid 1px;">
							<a href="/market/notice/list">
								<span>공지사항</span>	
							</a>
						</div>
						<div class="col d-flex justify-content-center" style="background: silver; border: solid 1px;">
							<a href="#">
								<span>1:1문의하기</span>
							</a>
						</div>
						<div class="col d-flex justify-content-center" style="background: silver; border: solid 1px;">
							<a href="#">
								<span>1:1문의확인</span>
							</a>
						</div>
						<div class="col d-flex justify-content-center" style="background: silver; border: solid 1px;">
							<a href="${appRoot }/comm/chat.do">
								<span>1:1톡</span>
							</a>
						</div>
					</div>
			</div>
			
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
		</div>
	</div>
</div>
</body>
</html>