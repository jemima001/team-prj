<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" integrity="sha512-GQGU0fMMi238uA+a/bdWJfpUGKUkBdgfFdgBm72SUQ6BeyWjoY/ton0tEjH+OSH9iP4Dfh+7HM0I9f5eR0L/4w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" referrerpolicy="no-referrer"></script>


<title>Insert title here</title>
</head>
<body>
	<div>
		<input type="text" id="sender" value="${sessionScope.member.m_id }" style="display: none;" />
		<input type="text" id="messageinput"/>
	</div>
	<div>
		<button type="button" onclick="openSocket();">Open</button>
		<button type="button" onclick="send();">Send</button>
		<button type="button" onclick="closeSocket();">Close</button>
	</div>
	
	<div id="messages"></div>
	
	<script type="text/javascript">
	var ws; 
	var messages = document.getElementById("messages");
	function openSocket() {
		if (false) {
			writeResponse("WebSocket is already opened.");
			return;
		}
		// 웹소켓 객체 만드는 코드
		ws = new WebSocket("ws://localhost:8080/market/echo.do");
		
		ws.onopen = function(event) {
			if (event.data === undefined) return;
			
			writeResponse(event.data);
		};
		ws.onmessage = function(event) {
			writeResponse(event.data);
		};
		ws.onclose = function(event) {
			writeResponse("Connection closed");
		}
	}
	function send() {
		var text = document.getElementById("messageinput").value+","+document.getElementById("sender").value; 
		ws.send(text);
		text="";
	}
	function closeSocket() {
		ws.close();
	}
	function writeResponse(text) {
		messages.innerHTML += "<br />" + text;
	}	
	</script>
</body>
</html>