<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/gh/moonspam/NanumSquare@1.0/nanumsquare.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css"
	integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css"
	integrity="sha512-GQGU0fMMi238uA+a/bdWJfpUGKUkBdgfFdgBm72SUQ6BeyWjoY/ton0tEjH+OSH9iP4Dfh+7HM0I9f5eR0L/4w=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"
	referrerpolicy="no-referrer"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.3/font/bootstrap-icons.css">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
	crossorigin="anonymous"></script>
<style>
body{
	font-family: 나눔스퀘어, 'NanumSquare', sans-serif;
}
</style>
<title>작은 숲</title>
</head>
<body>
	<my:pagenavbar></my:pagenavbar>
	<div class="container">
	<br />
		<div class="row">
			<div class="col-3">
				<my:customercenternavbar current="notice"></my:customercenternavbar>
			</div>
			<div class="col-9">
				<div class="card m-auto" style="width: 18rem;">
					<button id="closeBtn" class="d-none btn btn-light" type="button" onclick="closeSocket();">퇴장</button>
					<div>	
						<div id="messages" style="overflow-y: scroll; height:300px; " class="alert alert-success mb-0"></div>
					</div>
					<div class="alert alert-secondary mb-0">
						<div class="d-flex justify-content-center">
							<input type="hidden" id="sender" value="${nickName }" />
							<div class="input-group-append">
							<button id="openBtn" class="btn btn-light" type="button" onclick="openSocket();">입장</button>
							</div>
							<input type="text" class="d-none" id="messageinput"
								placeholder="하고싶은 말을 작성해주세요" onkeydown="Enter_Check();" />
							<div class="input-group-append">
								<button id="sendBtn" class="d-none btn btn-light" type="button" onclick="send();">보내기</button>
							</div>
						</div>
					</div>
				</div>


				<script type="text/javascript">
					var ws;
					var messages = document.getElementById("messages");
					var name = document.getElementById("sender").value;
					function openSocket() {
						if (false) {
							writeResponse("WebSocket is already opened.");
							return;
						}
						
						var element = document.getElementById("messages");
						element.innerHTML = '';
						
						// 웹소켓 객체 만드는 코드
						ws = new WebSocket(
								"ws://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/comm/echo");

						ws.onopen = function(event) {
							if (event.data === undefined)
								return;
							writeResponse(event.data);
						};
						ws.onmessage = function(event) {
							writeResponse(event.data);
						};
						ws.onclose = function(event) {
							writeResponse("Connection closed");
						}
						$("#sender").addClass("d-none");
						$("#messageinput").removeClass("d-none");
						$("#openBtn").addClass("d-none");
						$("#closeBtn").removeClass("d-none");
						$("#sendBtn").removeClass("d-none");
					}
					function send() {
						var text = document.getElementById("messageinput").value
								+ "#####" + document.getElementById("sender").value;
						var obj = document.getElementById("messageinput");
						var regExp = /[\{\}:|\)\'\"\(\=]/gi;
						if (obj.value.length >= 1 && obj.value != " " && !regExp.test(obj.value)) {
							ws.send(text);
							text = "";
							obj.value= "";						
						} else {
							text = "";
							obj.value= "";
						}
					}
					
					function Enter_Check() {
						if(event.keyCode == 13){
							send();
							return;
						}
					}
					function closeSocket() {
						ws.close();
						$("#openBtn").removeClass("d-none");
						$("#closeBtn").addClass("d-none");
						$("#sendBtn").addClass("d-none");
						$("#messageinput").addClass("d-none");
						$("#sender").removeClass("d-none");
					}
					function writeResponse(text) {
						messages.innerHTML += "<br />" + text;
						messages.scrollTo(0, document.body.scrollHeight);
					}
				</script>
			</div>
		</div>
	</div>
</body>
</html>