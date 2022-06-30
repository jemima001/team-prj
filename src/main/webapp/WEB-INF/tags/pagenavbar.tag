<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ attribute name="current"%>

<c:url value="/member/login" var="loginUrl"></c:url>
<c:url value="/logout" var="logoutUrl"></c:url>
<c:url value="/member/signup" var="signupUrl"></c:url>
<c:url value="/project/home" var="homeUrl"></c:url>
<c:url value="/member/initpw" var="initPasswordUrl"></c:url>
<c:url value="/member/adminpage" var="adminpageUrl"></c:url>

<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="principal" />
	<c:url value="/project/home" var="homeUrl">
		<c:param name="id" value="${principal.username }" />
	</c:url>
</sec:authorize>

<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="principal" />
	<c:url value="/member/mypage" var="mypageUrl">
		<c:param name="id" value="${principal.username }" />
	</c:url>
</sec:authorize>

<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="principal" />
	<c:url value="/order/cart" var="cartUrl">
		<c:param name="id" value="${principal.username }" />
	</c:url>
</sec:authorize>

<style>
	.navbar{
		/* border-bottom: 1px solid #ffffff;
		position: sticky;
		top: 0;
		z-index: 1000;
		height: auto;
		width: 100%; */
		/* opacity: 0.8; */
	}
	/* .div{
		display: block;
	} */
	.nav-link{
		color: #f4eedd;
		hover-color: black;
	}
	.nav-link:hover {
	color : black;
	}
</style>

<nav class="navbar navbar-expand-lg" style="background-color: #38653c; 
											opacity: 0.8;
											border-bottom: 1px solid #ffffff;
											position: sticky;
											top: 0;
											z-index: 1000;
											height: 58px;
											width: 100%;
">
	<div class="container-fluid">
			<ul class="nav">
				<li class="nav-item">
					<a class="navbar-brand" href="${homeUrl }" style="color: #f4eedd;">
					<img src="${appRoot }/resources/images/logo.jpg" width="120" height="30"></a>
				</li>
				<sec:authorize access="isAuthenticated() and not hasRole('ADMIN')">
					<li class="nav-item">
						<p style="color: #f4eedd;">${principal.username }님의 정원</p>
					</li>
				</sec:authorize>
			</ul>
			<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
		      <i class="fa-solid fa-list"></i>
		    </button>
			<div class="collapse navbar-collapse justify-content-end" id="navbarNavDropdown">
			<ul class="nav">
				<!-- 오른쪽으로 밀기 -->
				<sec:authorize access="not isAuthenticated()">
					<li class="nav-item" ><a
						href="${loginUrl }" class="nav-link" style="">로그인</a>
					</li>
				</sec:authorize>

				<sec:authorize access="isAuthenticated() and not hasRole('ADMIN')">
					<li class="nav-item" style="">
						<a href="${mypageUrl }" 
						class="nav-link ${current == 'mypage' ? 'active' : '' }"
						style="">마이페이지</a></li>
				</sec:authorize>

				<sec:authorize access="isAuthenticated()">
					<li class="nav-item" style=""><a
						href="${cartUrl }"
						class="nav-link ${current == 'cart' ? 'active' : '' }"
						style="">장바구니</a></li>
				</sec:authorize>

				<sec:authorize access="hasRole('ADMIN')">
					<li class="nav-item" style=""><a
						href="${adminpageUrl }"
						class="nav-link ${current == 'memberList' ? 'active' : '' }"
						style="">관리자페이지</a></li>
					<div class="nav-item" style="">
						<a href="${initPasswordUrl }" class="nav-link"
							style="">암호초기화</a>
					</div>
				</sec:authorize>

				<sec:authorize access="isAuthenticated()">
					<li class="nav-item"
						style=" ">
						<button id="btn1" class="btn btn-link nav-link" type="submit"
							form="logoutForm1">로그아웃</button>
					</li>
				</sec:authorize>

				<sec:authorize access="not isAuthenticated()">
					<li class="nav-item" style=""><a
						href="${signupUrl }"
						class="nav-link ${current == 'signup' ? 'active' : '' }"
						style="">회원가입</a></li>
				</sec:authorize>

				<li class="nav-item" style=""><a
					class="nav-link" href="/market/notice/list" style="">고객센터</a>
				</li>
				<li class="nav-item">
					<form action="${approot }/market/product/list" class="d-flex" role="search" method="get">
					<div class="input-group">
						<input class="form-control me-auto" type="search"
							placeholder="Search" aria-label="Search" name="search">
						<button class="btn btn-outline-light" type="submit">Search</button>
					</div>
					</form>
				</li>
			</ul>
</div>
			<div class="d-none">
				<form action="${logoutUrl }" id="logoutForm1" method="post"></form>
			</div>

	</div>

</nav>