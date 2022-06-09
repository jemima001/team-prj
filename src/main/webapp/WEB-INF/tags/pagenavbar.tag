<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri ="http://java.sun.com/jsp/jstl/core"%>





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
          <a class="nav-link active" aria-current="page" href="/project/home">Home</a>
        </li>
      </ul>
      <ul class="nav bg-light">
        <!-- 오른쪽으로 밀기 -->
        <li class="nav-item">
          <a class="nav-link" href="/project/home/login">로그인</a>
        </li>
         
        <li class="nav-item">
          <a class="nav-link" href="#">회원가입</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">1:1문의</a>
        </li>
      </ul>
     <!--  <form action="/spr/Board/boardSearch" class="d-flex" role="search" method="post">
        <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search" name="Search">
        <button class="btn btn-outline-success" type="submit">Search</button>
      </form> -->
    </div>
  </div>
</nav>