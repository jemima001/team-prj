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

<style> /* 여러 채팅창 간의 간격과 배열 위치*/
.float-left {
	float: left;
	margin: 20px;
}
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
			<div class="col-2">
				<my:customercenternavbar current="notice"></my:customercenternavbar>
			</div>
			<div class="col-9">
				<!-- 유저가 접속할 때마다 이 템플릿으로 채팅창을 생성한다. -->
				<div>
					<div class="template" style="display: none">
						<form>
							<!-- 메시지 텍스트 박스 -->
							<input type="hidden" id="sender" value="${nickName }" />
							<input type="text" class="message"
								onkeydown="if(event.keyCode === 13) return false;">
							<!-- 전송 버튼 -->
							<input value="Send" type="button" class="sendBtn">
						</form>
						<br />
						<!-- 서버와 메시지를 주고 받는 콘솔 텍스트 영역 -->
						<textarea rows="10" cols="50" class="console" disabled="disabled"></textarea>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- 소스를 간단하게 하기 위하 Jquery를 사용했습니다. -->
	<script type="text/javascript">
		// 서버의 admin의 서블릿으로 웹 소켓을 한다.
		var webSocket = new WebSocket(
				"ws://${pageContext.request.serverName}:${pageContext.request.serverPort}/market/comm/admin");
		// 운영자에서의 open, close, error는 의미가 없어서 형태만 선언
		webSocket.onopen = function(message) {
		};
		webSocket.onclose = function(message) {
		};
		webSocket.onerror = function(message) {
		};
		// 서버로 부터 메시지가 오면
		webSocket.onmessage = function(message) {
			// 메시지의 구조는 JSON 형태로 만들었다.
			let node = JSON.parse(message.data);
			// 메시지의 status는 유저의 접속 형태이다.
			// visit은 유저가 접속했을 때 알리는 메시지다.
			if (node.status === "visit") {
				// 위 템플릿 div를 취득한다.
				let form = $(".template").html();
				// div를 감싸고 속성 data-key에 unique키를 넣는다.
				form = $(
						"<div class='float-left'><div>" + node.userName
								+ "</div></div>").attr("data-key", node.key)
						.append(form);
				// body에 추가한다.
				$(".col-9").append(form);
				// message는 유저가 메시지를 보낼 때 알려주는 메시지이다.
			} else if (node.status === "message") {
				// key로 해당 div영역을 찾는다.
				let $div = $("[data-key='" + node.key + "']");
				// console영역을 찾는다.
				let log = $div.find(".console").val();
				// 아래에 메시지를 추가한다.
				$div.find(".console").val(
						log + "(" + node.nickName + ") => " + node.message
								+ "\n");
				// bye는 유저가 접속을 끊었을 때 알려주는 메시지이다.
			} else if (node.status === "bye") {
				// 해당 키로 div를 찾아서 dom을 제거한다.
				$("[data-key='" + node.key + "']").remove();
			}
		};
		// 전송 버튼을 클릭하면 발생하는 이벤트
		$(document).on("click", ".sendBtn", function() {
			// div 태그를 찾는다.
			let $div = $(this).closest(".float-left");
			// 메시지 텍스트 박스를 찾아서 값을 취득한다.
			let message = $div.find(".message").val();
			// 유저 key를 취득한다.
			let key = $div.data("key");
			// 어드민 nickName을 취득한다.
			let nickName = $("#sender").val();
			// console영역을 찾는다.
			let log = $div.find(".console").val();
			// 아래에 메시지를 추가한다.
			$div.find(".console").val(log + "(me) => " + message + "\n");
			// 텍스트 박스의 값을 초기화 한다.
			$div.find(".message").val("");
			// 웹소켓으로 메시지를 보낸다.
			webSocket.send(key + "#####" + message + "#####" + nickName);
		});
		// 텍스트 박스에서 엔터키를 누르면
		$(document).on(
				"keydown",
				".message",
				function() {
					// keyCode 13은 엔터이다.
					if (event.keyCode === 13) {
						// 버튼을 클릭하는 트리거를 발생한다.
						$(this).closest(".float-left").find(".sendBtn")
								.trigger("click");
						// form에 의해 자동 submit을 막는다.
						return false;
					}
					return true;
				});
	</script>
</body>
</html>