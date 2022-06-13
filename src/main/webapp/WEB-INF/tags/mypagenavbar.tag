<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ attribute name="current"%>

<c:url value="/member/login" var="loginUrl"></c:url>
<c:url value="/logout" var="logoutUrl"></c:url>
<c:url value="/member/signup" var="signupUrl"></c:url>
<c:url value="/project/home" var="homeUrl"></c:url>

<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="principal" />
	<c:url value="/member/mypage" var="mypageUrl">
		<c:param name="id" value="${principal.username }" />
	</c:url>
</sec:authorize>

<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="principal" />
	<c:url value="/member/setaddress" var="setaddressUrl">
		<c:param name="id" value="${principal.username }" />
	</c:url>
</sec:authorize>

<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="principal" />
	<c:url value="/order/cart" var="cartUrl">
		<c:param name="id" value="${principal.username }" />
	</c:url>
</sec:authorize>

<nav class="navbar" style="background-color: #ffffff;">
	<div class="container">
			<a href="${mypageUrl }"
				class="nav-link ${current == 'mypage' ? 'active' : '' }">개인정보수정</a>
			<a href="${setaddressUrl }"
				class="nav-link ${current == 'setaddress' ? 'active' : '' }">기본배송지설정</a>
			<a href="${cartUrl }"
				class="nav-link ${current == 'cart' ? 'active' : '' }">장바구니</a> 
			<a href="${mypageUrl }"
				class="nav-link ${current == 'mypage' ? 'active' : '' }">주문내역</a>
	</div>
</nav>