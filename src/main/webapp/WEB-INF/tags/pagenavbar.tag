<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri ="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ attribute name="current" %>

<c:url value="/member/login" var="loginUrl"></c:url>
<c:url value="/logout" var="logoutUrl"></c:url>
<c:url value="/member/signup" var="signupUrl" ></c:url>
<c:url value="/project/home" var="homeUrl" ></c:url>
<c:url value="/member/initpw" var="initPasswordUrl"></c:url>
<c:url value="/member/adminpage" var="adminpageUrl"></c:url>

<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="principal"/>
	<c:url value="/member/mypage" var="mypageUrl">
		<c:param name="id" value="${principal.username }" />
	</c:url>
</sec:authorize>

<nav class="navbar" style="background-color: #DEB887;">
  <div class="container">
    <a class="navbar-brand" href="${homeUrl }" style="color: black;"><i class="fa-solid fa-house"></i></a>
    
    <!-- button.navbar-toggler>span.navbar-toggler-icon -->
   <!--  <button class="navbar-toggler" 
            data-bs-toggle="collapse"
            data-bs-target="#navbarSupportedContent">
    	<span class="navbar-toggler-icon"></span>
    </button> -->
    
      <ul class="nav bg-light">
        <!-- 오른쪽으로 밀기 -->
        <sec:authorize access="not isAuthenticated()">
	        <li class="nav-item" style="background-color: #DEB887;">
	        	<a href="${loginUrl }" class="nav-link" style="color: black;">로그인</a>
	        </li>
        </sec:authorize>
        
        <sec:authorize access="isAuthenticated() and not hasRole('ADMIN')">
        	<li class="nav-item" style="background-color: #DEB887;">
        		<a href="${mypageUrl }" class="nav-link ${current == 'mypage' ? 'active' : '' }" style="color: black;">마이페이지</a>
        	</li>
        </sec:authorize>
        
        <sec:authorize access="hasRole('ADMIN')">
	        <li class="nav-item" style="background-color: #DEB887;">
	        	<a href="${adminpageUrl }" class="nav-link ${current == 'memberList' ? 'active' : '' }" style="color: black;">관리자페이지</a>
	        </li>
	        <div class="nav-item" style="background-color: #DEB887;">
	        	<a href="${initPasswordUrl }" class="nav-link" style="color: black;">암호초기화</a>
	        </div>
        </sec:authorize>
        
        <sec:authorize access="isAuthenticated()">
	        <li class="nav-item" style="background-color: #DEB887; color: black;">
	        	<button id="btn1" class="btn btn-link nav-link" type="submit" form="logoutForm1" >로그아웃</button>
	        </li>
        </sec:authorize>
         
        <sec:authorize access="not isAuthenticated()">
	        <li class="nav-item" style="background-color: #DEB887;">
	        	<a href="${signupUrl }" class="nav-link ${current == 'signup' ? 'active' : '' }" style="color: black;">회원가입</a>
	        </li>
        </sec:authorize>
        
        <li class="nav-item" style="background-color: #DEB887;">
          <a class="nav-link" href="/market/notice/list" style="color: black;">고객센터</a>
        </li>
      </ul>
      
      <div class="d-none">
      	<form action="${logoutUrl }" id="logoutForm1" method="post"></form>
      </div>
     
    </div>
</nav>