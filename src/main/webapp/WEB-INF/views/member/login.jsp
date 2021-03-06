<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/gh/moonspam/NanumSquare@1.0/nanumsquare.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" integrity="sha512-GQGU0fMMi238uA+a/bdWJfpUGKUkBdgfFdgBm72SUQ6BeyWjoY/ton0tEjH+OSH9iP4Dfh+7HM0I9f5eR0L/4w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" referrerpolicy="no-referrer"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<style>
</style>
<title>작은 숲</title>
</head>
<body>

	<my:pagenavbar current="login"></my:pagenavbar>
	
	<div class="container">
	
		
		<div class="row justify-content-center">
			<div class="col-6">
			<br /><br />
				<img 	src="${appRoot }/resources/images/logo2.png"
						style="width: 80%; margin: 5px">
			</div>
			<div class="col-6" style="">
			<br /><br /><br /><br />
				
				<form action="${appRoot }/login" method="post">
					<label for="usernameInput1" class="form-label">
						아이디 
					</label>
					<input id="usernameInput1" class="form-control" type="text" name="username" />
					
					<label for="passwordInput1" class="form-label">
						패스워드
					</label>
					<input class="form-control" id="passwordInput1" type="password" name="password" />
					
					<div class="form-check">
						<input class="form-check-input" type="checkbox" name="remember-me" id="rememberMeCheck1" />
						
						<label for="rememberMeCheck1" class="form-check-label">
							자동로그인
						</label>
					</div>
					<br />
					
					<input class="btn btn-outline-success" type="submit" value="로그인" />
				</form>
				<a href="${appRoot }/member/findId">아이디 찾기</a> <a href="${appRoot }/member/findPassword">비밀번호 찾기</a>
			
			</div>
		</div>
	</div>
	
</body>
</html>













