<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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

<title>Insert title here</title>
</head>
<body>
	<my:pagenavbar></my:pagenavbar>
	<my:customercenternavbar></my:customercenternavbar>

	<div class="container">
		<div class="row">
			<div class="col">
				<div class="card m-auto" style="width: 18rem;">
					<button id="closeBtn" class="d-none btn btn-light" type="button" onclick="closeSocket();">퇴장</button>
					<div>
						<div id="messages" class="d-none alert alert-success mb-0"></div>
					</div>
					<div class="alert alert-secondary mb-0">
						<div class="d-flex justify-content-center">
							<input type="hidden" id="sender" value="${nickName }" />
							<div class="input-group-append">
							<button id="openBtn" class="btn btn-light" type="button" onclick="openSocket();">입장</button>
							</div>
							<input type="text" class="d-none" id="messageinput"
								placeholder="하고싶은 말을 작성해주세요" />
							<div class="input-group-append">
								<button id="sendBtn" class="d-none btn btn-light" type="button" onclick="send();">보내기</button>
							</div>
						</div>
					</div>
				</div>


				<script type="text/javascript">
					var ws;
					var messages = document.getElementById("messages");
					function openSocket() {
						if (false) {
							writeResponse("WebSocket is already opened.");
							return;
						}
						// 웹소켓 객체 만드는 코드
						ws = new WebSocket(
								"ws://${pageContext.request.serverName}:${pageContext.request.serverPort}/market/comm/echo");

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
						$("#messages").removeClass("d-none");
						$("#sender").addClass("d-none");
						$("#messageinput").removeClass("d-none");
						$("#openBtn").addClass("d-none");
						$("#closeBtn").removeClass("d-none");
						$("#sendBtn").removeClass("d-none");
					}
					function send() {
						var text = document.getElementById("messageinput").value
								+ "," + document.getElementById("sender").value;
						var obj = document.getElementById("messageinput");
						if (obj.value.length >= 1) {
							ws.send(text);
							text = "";
							obj.value= "";						
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
					}
				</script>
			</div>
		</div>
	</div>
</body>
</html>