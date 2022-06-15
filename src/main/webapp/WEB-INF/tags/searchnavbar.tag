<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ attribute name="current"%>

<nav class="navbar" style="background-color: #eae1d8;">
	<div class="container">
			<ul class="nav">
				<li class="nav-item">
				</li>
			</ul>
			<ul class="nav">
				<li class="nav-item">
					<form action="#" class="d-flex" role="search" method="post">
					<div class="input-group">
						<input class="form-control me-auto" type="search"
							placeholder="Search" aria-label="Search" name="Search">
						<button class="btn btn-outline-success" type="submit">Search</button>
					</div>
					</form>
				</li>
			</ul>
	</div>
</nav>