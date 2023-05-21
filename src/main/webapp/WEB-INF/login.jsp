<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!-- c:out ; c:forEach etc. --> 
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!-- Formatting (dates) --> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>
<!-- form:form -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!-- for rendering errors on PUT routes -->
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css">
<script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
</head>
<body>
    <div class="container mt-3">
		<h1 class="text-secondary">Project Manager</h1>
		<p>A place for teams to manage projects.</p>
		<div class="d-flex justify-content-between gap-3">
			<div class="col-5 bg-secondary p-5 rounded">
				<h2 class="text-white">Register</h2>
				<form:form action="/register" method="post"
					modelAttribute="newUser">

					<c:if test="${regBindingResult.hasErrors()}">
						<div class="alert alert-danger mt-3 d-block ">
							<h5>
								<strong>Validation Error:</strong>
							</h5>
							<div class="mb-3">
								<form:errors path="userName" class="text-danger" />
							</div>
							<div class="mb-3">
								<form:errors path="email" class="text-danger" />
							</div>
							<div class="mb-3">
								<form:errors path="password" class="text-danger" />
							</div>
							<div class="mb-3">
								<form:errors path="confirm" class="text-danger" />
							</div>
						</div>
					</c:if>
					<div class="mb-3">
						<form:label path="userName" class="form-label text-white">User Name:</form:label>
						<form:input path="userName" class="form-control" type="text" />
					</div>
					<div class="mb-3">
						<form:label path="email" class="form-label text-white">Email:</form:label>
						<form:input path="email" class="form-control" type="email" />
					</div>
					<div class="mb-3">
						<form:label path="password" class="form-label text-white">Password:</form:label>
						<form:input path="password" class="form-control" type="password" />
					</div>
					<div class="mb-3">
						<form:label path="confirm" class="form-label text-white">Confirm Password:</form:label>
						<form:input path="confirm" class="form-control" type="password" />
					</div>
					<input type="submit" value="Register" class="btn btn-warning" />
				</form:form>
			</div>
			<div class="col-5 p-5 bg-primary rounded">
				<h2 class="text-white">Log in</h2>
				<form:form action="/login" method="post"
					modelAttribute="newLogin">
					<c:if test="${logBindingResult.hasErrors()}">
						<div class="alert alert-danger mt-3 d-block ">
							<h5>
								<strong>Validation Error:</strong>
							</h5>
							<div class="mb-3">
								<form:errors path="email" class="text-danger" />
							</div>
							<div class="mb-3">
								<form:errors path="password" class="text-danger" />
							</div>
						</div>
					</c:if>
					<div class="mb-3">
						<form:label path="email" class="form-label text-white">Email:</form:label>
						<form:input path="email" class="form-control" type="email" />
					</div>
					<div class="mb-3">
						<form:label path="password" class="form-label text-white">Password:</form:label>
						<form:input path="password" class="form-control" type="password" />
					</div>
					<input type="submit" value="Login" class="btn btn-warning">
				</form:form>
			</div>
		</div>
	</div>
</body>
</html>