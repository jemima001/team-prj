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
<style>
body{
	font-family: 나눔스퀘어, 'NanumSquare', sans-serif;
}
</style>
<title>Insert title here</title>
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
				<div>
					<form>
						<input type="hidden" id="sender" value="${nickName }" />
						<input id="textMessage" type="text" onkeydown="return enter()" placeholder="메세지입력하세요">
						<input onclick="sendMessage()" value="Send" type="button">
					</form>
					<br />
					<!-- 서버와 메시지를 주고 받는 콘솔 텍스트 영역 -->
					<!-- <div id="messageTextArea" style="overflow-y: scroll; height:200px;" ></div> -->
					<textarea id="messageTextArea" rows="10" cols="50" disabled="disabled"></textarea>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		// 서버의 broadsocket의 서블릿으로 웹 소켓을 한다.
		var webSocket = new WebSocket(
				"ws://${pageContext.request.serverName}:${pageContext.request.serverPort}/market/comm/user");
		// 콘솔 텍스트 영역
		var messageTextArea = document.getElementById("messageTextArea");
		// 접속이 완료되면
		webSocket.onopen = function(message) {
			// 콘솔에 메시지를 남긴다.
			/* messageTextArea.value += "Server connect...\n"; */
			messageTextArea.value += $("#sender").val() + "님이 입장하셨습니다.\n"
		};
		// 접속이 끝기는 경우는 브라우저를 닫는 경우이기 떄문에 이 이벤트는 의미가 없음.
		webSocket.onclose = function(message) {
		};
		// 에러가 발생하면
		webSocket.onerror = function(message) {
			// 콘솔에 메시지를 남긴다.
			messageTextArea.value += "error...\n";
		};
		// 서버로부터 메시지가 도착하면 콘솔 화면에 메시지를 남긴다.
		webSocket.onmessage = function(message) {
			messageTextArea.value += message.data + "\n";
		};
		// 서버로 메시지를 발송하는 함수
		function sendMessage() {
			let message = document.getElementById("textMessage");
			// 유저 nickName을 취득한다.
			let nickName = $("#sender").val();
			// 콘솔에 메세지를 남긴다.
			messageTextArea.value += "(me) => " + message.value + "\n";
			// 소켓으로 보낸다.
			webSocket.send(message.value + "#####" + nickName);
			// 텍스트 박스 추기화
			message.value = "";
		}
		function enter() {
			if (event.keyCode === 13) {
				sendMessage();
				return false;
			}
			return true;
		}
	</script>
</body>
</html>