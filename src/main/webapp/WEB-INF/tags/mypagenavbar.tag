<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ attribute name="current"%>

<c:url value="/member/login" var="loginUrl"></c:url>
<c:url value="/logout" var="logoutUrl"></c:url>
<c:url value="/member/signup" var="signupUrl"></c:url>
<c:url value="/project/home" var="homeUrl"></c:url>
<c:url value="/member/adminpage" var="adminpageUrl"></c:url>

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

<nav class="navbar" style="background-color: #000000;">
	<div class="container">
		<sec:authorize access="hasRole('ADMIN')">
			<a href="${adminpageUrl }" class="nav-link ${current == 'adminpage' ? 'active' : '' }" style="color: white;">회원관리</a>
			<a href="${appRoot }/member/orderlist" class="nav-link ${current == 'orderlist' ? 'active' : '' }" style="color: white;">전체주문관리</a>
			<a href="${appRoot }/member/productlist" class="nav-link ${current == 'productlist' ? 'active' : '' }" style="color: white;">상품관리</a>
		</sec:authorize>
		<sec:authorize access="not hasRole('ADMIN')">
		<a href="${mypageUrl }"
			class="nav-link ${current == 'mypage' ? 'active' : '' }" style="color: white;">개인정보수정</a> <a
			href="${setaddressUrl }"
			class="nav-link ${current == 'setaddress' ? 'active' : '' }" style="color: white;">기본배송지설정</a>
		<a href="${cartUrl }"
			class="nav-link ${current == 'cart' ? 'active' : '' }" style="color: white;">장바구니</a> <a
			href="${mypageUrl }"
			class="nav-link ${current == 'mypage' ? 'active' : '' }" style="color: white;">주문내역</a>
		</sec:authorize>
	</div>
</nav>