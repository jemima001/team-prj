<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix = 'c' uri ="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
    <%request.setCharacterEncoding("utf-8"); %>
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
<my:pagenavbar></my:pagenavbar>
<div class="container">
	<div class="row">
		<div class="col">
			
				<form action="#" class="d-flex" role="search" method="post">
			        <p><img src="resources/images/a.png"></p>
			        <input class="form-control me-auto" type="search" placeholder="Search" aria-label="Search" name="Search">
			        <button class="btn btn-outline-success" type="submit">Search</button>
			    	<a class="btn btn-primary" href="${appRoot }/member/cart" role="button">장바구니</a>
				</form>
				<div class="col">
					<form action="#">
						<button id=1>asfa</button>
						<button id=2>asfa</button>
						<button id=3>asfa</button>
						<button id=4>asfa</button>
						<button id=5>asfa</button>
						<button id=6>asfa</button>
					</form>
				</div>
		</div>
	</div>
</div>

<a href="${appRoot }/product/list">상품전체보기</a>

</body>
</html>