<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri ="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ attribute name="current" %>

<c:url value="/member/login" var="loginUrl"></c:url>
<c:url value="/logout" var="logoutUrl"></c:url>
<c:url value="/member/signup" var="signupUrl" ></c:url>

<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="principal"/>
	<c:url value="/member/mypage" var="mypageUrl">
		<c:param name="id" value="${principal.username }" />
	</c:url>
</sec:authorize>

<nav class="navbar navbar-expand-lg navbar-light bg-light" ><!-- 색깔때문에 버튼 안보였음!! -->
  <div class="container">
    <a class="navbar-brand" href="/spr/Board/boardlist"></a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" 
    								data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse " id="navbarSupportedContent">
      <ul id="nav" class="nav me-auto bg-light">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="/market/project/home">Home</a>
        </li>
      </ul>
      <ul class="nav bg-light">
        <!-- 오른쪽으로 밀기 -->
        <sec:authorize access="not isAuthenticated()">
	        <li class="nav-item">
	        	<a href="${loginUrl }" class="nav-link">로그인</a>
	        </li>
        </sec:authorize>
        
        <sec:authorize access="isAuthenticated()">
        	<li class="nav-item">
        		<a href="${mypageUrl }" class="nav-link ${current == 'mypage' ? 'active' : '' }">마이페이지</a>
        	</li>
        </sec:authorize>
        
        <sec:authorize access="isAuthenticated()">
	        <li class="nav-item">
	        	<button class="btn btn-link nav-link" type="submit" form="logoutForm1">로그아웃</button>
	        </li>
        </sec:authorize>
         
        <sec:authorize access="not isAuthenticated()">
	        <li class="nav-item">
	        	<a href="${signupUrl }" class="nav-link ${current == 'signup' ? 'active' : '' }">회원가입</a>
	        </li>
        </sec:authorize>
        
        <li class="nav-item">
          <a class="nav-link" href="/market/project/cusCenter">고객센터</a>
        </li>
      </ul>
      
      <div class="d-none">
      	<form action="${logoutUrl }" id="logoutForm1" method="post"></form>
      </div>
     
    </div>
  </div>
</nav>