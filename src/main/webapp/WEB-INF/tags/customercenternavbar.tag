<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ attribute name="current"%>

<c:url value="/notice/list" var="noticeUrl"></c:url>
<c:url value="/notice/write" var="writeUrl"></c:url>
<c:url value="/qna/query" var="queryUrl"></c:url>
<c:url value="/qna/list" var="qnaUrl"></c:url>
<c:url value="/comm/chat" var="chatUrl"></c:url>
<c:url value="/comm/user" var="userUrl"></c:url>
<c:url value="/comm/admin" var="adminUrl"></c:url>

<style>
	.navbar{
		border-bottom: 1px solid #ffffff;
	}
	/* .div{
		display: block;
	} */
</style>

<nav class="navbar" style="background-color: #d3b7a1;">
	<div class="container">
		<div>
			<ul class="nav me-auto">
				<li>
					<h2 style="display: inline;">고객센터</h2>
				</li>
				<sec:authorize access="hasRole('ADMIN')">
					<li class="nav-item" style="background-color: #eae1d8;"><a
						href="${writeUrl }" class="nav-link ${current == 'write' ? 'active' : '' }" style="color: black;">공지작성</a>
					</li>
				</sec:authorize>
			</ul>
		</div>
		<ul class="nav">
			<li class="nav-item" >
				<a href="${noticeUrl }" class="nav-link ${current == 'notice' ? 'active' : '' }" style="color: black;">공지사항</a>
			</li>
			<li class="nav-item" >
				<a href="${queryUrl }" class="nav-link ${current == 'query' ? 'active' : '' }" style="color: black;">1:1문의하기</a>
			</li>
			<li class="nav-item" >
				<a href="${qnaUrl }" class="nav-link ${current == 'answer' ? 'active' : '' }" style="color: black;">1:1문의확인</a>
			</li>
			<li class="nav-item" >
				<a href="${chatUrl }" class="nav-link ${current == 'chat' ? 'active' : '' }"  style="color: black;">프리톡</a>
			</li>
			<sec:authorize access="hasRole('USER')">
				<li class="nav-item" style="background-color: #d3b7a1;">
					<a href="${userUrl }" class="nav-link ${current == 'chat' ? 'active' : '' }"  style="color: black;">문의톡</a>
				</li>
			</sec:authorize>
			<sec:authorize access="hasRole('ADMIN')">
				<li class="nav-item" style="background-color: #eae1d8;">
					<a href="${adminUrl }" class="nav-link ${current == 'chat' ? 'active' : '' }"  style="color: black;">문의톡</a>
				</li>
			</sec:authorize>
		</ul>
	</div>
</nav>