<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ attribute name="current"%>

<c:url value="/notice/list" var="noticeUrl"></c:url>
<c:url value="/qna/query" var="queryUrl"></c:url>
<c:url value="/qna/list" var="qnaUrl"></c:url>
<c:url value="/comm/chat" var="chatUrl"></c:url>
<c:url value="/comm/user" var="userUrl"></c:url>
<c:url value="/comm/admin" var="adminUrl"></c:url>

<style>
	.navbar{
		border: 3px solid #d1e7dd;
		border-radius: 10px;
	}
	/* .div{
		display: block;
	} */
	#cuscenter>.nav-item{
		width: 100%;
	}
</style>

<nav class="navbar" style="">
	<div class="container">
		<div>
			<ul class="nav me-auto">
				<li>
					<h4 style="display: inline;">고객센터</h4>
				</li>
			</ul>
		</div>
		<ul class="nav" id="cuscenter">
			<li class="nav-item" >
				<a href="${noticeUrl }" class="nav-link ${current == 'notice' ? 'active' : '' }" style="color: black;">▶ 공지사항</a>
			</li>
			<li class="nav-item" >
				<a href="${queryUrl }" class="nav-link ${current == 'query' ? 'active' : '' }" style="color: black;">▶ 1:1문의하기</a>
			</li>
			<li class="nav-item" >
				<a href="${qnaUrl }" class="nav-link ${current == 'answer' ? 'active' : '' }" style="color: black;">▶ 1:1문의확인</a>
			</li>
			<li class="nav-item" >
				<a href="${chatUrl }" class="nav-link ${current == 'chat' ? 'active' : '' }"  style="color: black;">▶ 프리톡</a>
			</li>
			<sec:authorize access="hasRole('USER')">
				<li class="nav-item" style="">
					<a href="${userUrl }" class="nav-link ${current == 'chat' ? 'active' : '' }"  style="color: black;">▶ 문의톡</a>
				</li>
			</sec:authorize>
			<sec:authorize access="hasRole('ADMIN')">
				<li class="nav-item" style="">
					<a href="${adminUrl }" class="nav-link ${current == 'chat' ? 'active' : '' }"  style="color: black;">▶ 문의톡</a>
				</li>
			</sec:authorize>
		</ul>
	</div>
</nav>