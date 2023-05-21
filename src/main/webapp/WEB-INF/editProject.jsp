<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- c:out ; c:forEach etc. -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- Formatting (dates) -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- form:form -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!-- for rendering errors on PUT routes -->
<%@ page isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Project</title>
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css">
<script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
</head>
<body>
	<nav class="navbar navbar-expand-xl navbar-dark bg-dark p-3">
		<div class="container-fluid gap-1">
			<a class="navbar-brand display-1" href="#" style="font-size: 24px;">Edit
				Project</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarBasic"
				aria-controls="navbarBasic" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarBasic">
				<ul class="navbar-nav me-auto gap-3">
					<li class="nav-item"><a class="nav-link" href="/project/home">Home</a></li>
					<li class="nav-item"><a class="nav-link"
						href="/project/show/yourProject/${user.id}">Your Projects</a></li>
					<li class="nav-item"><a class="nav-link" href="/project/new">Create
							Project</a></li>
					<li class="nav-item"><a class="btn btn-outline-danger h-100"
						href="/logout">Log Out</a></li>
				</ul>
			</div>
		</div>
	</nav>
	<div class="container mt-3">
		<h3 class="text-secondary">Edit Project</h3>
		<form:form action="/project/edit/${project.id}" method="post"
			modelAttribute="project">
			<input type="hidden" name="_method" value="put">
			<c:if test="${bindingResult.hasErrors() || dateError}">
				<div class="alert alert-danger mt-3 d-block ">
					<h5>
						<strong>Validation Error:</strong>
					</h5>
					<div class="mb-3">
						<form:errors path="title" class="text-danger" />
					</div>
					<div class="mb-3">
						<form:errors path="description" class="text-danger" />
					</div>
					<div class="mb-3">
						<form:errors path="dueDate" class="text-danger" />
					</div>
					<c:if test="${dateError}">
						<div class="mb-3">
							<p class="text-danger">
								<c:out value="${dateErrorMessage}" />
							</p>
						</div>
					</c:if>
				</div>
			</c:if>

			<c:forEach var="user" items="${project.users}">
				<form:hidden path="users" value="${user.id}" />
			</c:forEach>
			
			<div class="mb-3">
				<form:label path="title" class="form-label">Title:</form:label>
				<form:input path="title" class="form-control" type="text" />
			</div>
			<div class="mb-3">
				<form:label path="description" class="form-label">Description:</form:label>
				<form:textarea path="description" class="form-control" type="text" />
			</div>
			<div class="mb-3">
				<form:label path="dueDate" class="form-label">Due Date:</form:label>
				<form:input path="dueDate" class="form-control" type="date" />
			</div>
			<input type="submit" value="Submit" class="btn btn-outline-primary">
		</form:form>
	</div>
</body>
</html>