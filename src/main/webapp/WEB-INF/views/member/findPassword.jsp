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
body{
	font-family: 나눔스퀘어, 'NanumSquare', sans-serif;
}
</style>
<title>Insert title here</title>
<script>
$(document).ready(
		function() {
			// 이메일 중복 확인 여부
			let emailCheck = true;
			
			// 기존 이메일
			const oldEmail = $("#emailInput1").val();
			
			// 인증번호전송 활성화 함수
			const enableConfirmButton = function() {
					$("#confirmNumberButton1").removeAttr("disabled");
			};
			
			// 비밀번호 초기화 활성화 함수
			const enablePassButton = function() {
					$("#initPass").removeAttr("disabled");
			};
			
			// 이메일 input 요소에 text 변경시 이메일중복확인버튼 활성화
			$("#emailInput1").keyup(function() {
				const newEmail = $("#emailInput1").val();

				if (oldEmail === newEmail) {
					$("#emailCheckButton1").attr("disabled", "");
					$("#emailMessage1").text("");
					emailCheck = true;
				} else {
					$("#emailCheckButton1").removeAttr("disabled");
					emailCheck = false;
				}

			});
			
			// 이메일중복버튼 클릭시 ajax 요청 발생
			$("#emailCheckButton1").click(
					function(e) {
						// 기본 이벤트 진행 중지
						e.preventDefault();
						const id = $("#usernameInput1").val();
						const data = {
								id : id,
							email : $("#emailInput1").val()
						};

						emailCheck = false;
						$.ajax({
							url : "${appRoot}/member/checkEmailById",
							type : "get",
							data : data,
							success : function(data) {
								switch (data) {
								case "ok":
									$("#emailMessage1").text(
											"맞는 이메일입니다.");
									emailCheck = true;
									enableConfirmButton();
									
									break;
								case "notOk":
									$("#emailMessage1").text(
											"맞지 않는 이메일입니다.");

									break;
								}
							},
							error : function() {
								$("#emailMessage1").text(
										"이메일 중복 확인 중 오류 발생, 다시 시도해주세요.");
							},
							complete : function() {
								console.log("이메일 확인 완료")
							}
						});
					});
			
			// 인증번호 전송 클릭시 ajax 요청 발생
			$("#confirmNumberButton1").click(
					function(e) {
						e.preventDefault();
						
						$("#confirmGroup").show();
						
						const data = {
							email : $("#emailInput1").val()
						};
						$.ajax({
							url : "${appRoot}/member/confirmEmail",
							type : "get",
							data : data,
							success : function(data) {
								switch (data) {
								case "ok":
									$("#confirmMessage1").text(
											"인증번호를 입력해주세요");
									break;
								case "notOk":
									$("#confirmMessage1").text(
											"맞지 않는 이메일입니다.");

									break;
								}
							},
							error : function() {
								$("#confirmMessage1").text(
										"인증번호 전송 중 오류 발생, 다시 시도해주세요.");
							},
							complete : function() {
								console.log("인증번호 전송 완료")
							}
						});
					});
			
			// 인증번호 입력 후 확인버튼 클릭시
			$("#confirmCheckButton1").click(
					function(e) {
						e.preventDefault();
						
						const data = {
								number : $("#confirmInput1").val()
						};
						$.ajax({
							url : "${appRoot}/member/confirmNumber",
							type : "get",
							data : data,
							success : function(data) {
								switch (data) {
								case "ok":
									$("#confirmMessage1").text(
											"인증번호를 입력해주세요");
									enablePassButton();
									break;
								case "notOk":
									$("#confirmMessage1").text(
											"맞지 않는 이메일입니다.");

									break;
								}
							},
							error : function() {
								$("#confirmMessage1").text(
										"인증번호 전송 중 오류 발생, 다시 시도해주세요.");
							},
							complete : function() {
								console.log("인증번호 전송 완료")
							}
						});
						
					});
		});
</script>
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
					<label for="usernameInput1" class="form-label"> 아이디 </label>
					<input id="usernameInput1" class="form-control" type="text" name="id"/>
				
					<label for="emailInput1" class="form-label"> 이메일 </label>
						<div class="input-group">
							<input class="form-control" id="emailInput1" type="email" value="" name="email"/>
							<button class="btn btn-secondary" id="emailCheckButton1" disabled>이메일 확인</button>
							<button class="btn btn-outline-secondary" id="confirmNumberButton1" disabled>인증번호 전송</button>
						</div>
						<p class="form-text" id="emailMessage1"></p>
					
					<div style="display:none" id="confirmGroup">
						<label for="emailInput1" class="form-label"> 인증번호 </label>
							<div class="input-group">
								<input class="form-control" id="confirmInput1" type="text" value="" />
								<button form="formPass" class="btn btn-secondary" id="confirmCheckButton1">확인</button>
							</div>
							<p class="form-text" id="confirmMessage1"></p>
					</div>
						
					<input id="initPass" class="btn btn-primary" type="submit" value="비밀번호 초기화" disabled/>
				</form>
			</div>
		</div>
	</div>
</body>
</html>