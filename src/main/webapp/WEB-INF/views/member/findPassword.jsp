<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" integrity="sha512-GQGU0fMMi238uA+a/bdWJfpUGKUkBdgfFdgBm72SUQ6BeyWjoY/ton0tEjH+OSH9iP4Dfh+7HM0I9f5eR0L/4w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" referrerpolicy="no-referrer"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

<title>Insert title here</title>
</head>
<body>
	<my:pagenavbar current="findId"></my:pagenavbar>
	
	<div class="container">
	
		
		<div class="row justify-content-center">
			<div class="col-12 col-lg-6">
				<h1>비밀번호 찾기 </h1>
				<div>
					<p>${message }</p>
				</div>
				<form action="${appRoot }/member/findPassword" method="post">
					<label for="usernameInput1" class="form-label">
						아이디 
					</label>
					<input id="usernameInput1" class="form-control" type="text" name="id" />
				
					<label for="usereamilInput1" class="form-label">
						이메일 
					</label>
					<input id="usereamilInput1" class="form-control" type="email" name="email" />
					
					<input class="btn btn-primary" type="submit" value="비밀번호 초기화" />
				</form>
			
			</div>
		</div>
	</div>
</body>
</html>