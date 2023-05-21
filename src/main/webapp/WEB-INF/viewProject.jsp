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
<title>View Project</title>
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css">
<script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
</head>
<body>
    <nav class="navbar navbar-expand-xl navbar-dark bg-dark p-3">
        <div class="container-fluid gap-1">
            <a class="navbar-brand display-1" href="#" style="font-size: 24px;">View Project</a>
            <button class="navbar-toggler" type="button"
                data-bs-toggle="collapse" data-bs-target="#navbarBasic"
                aria-controls="navbarBasic" aria-expanded="false"
                aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarBasic">
                <ul class="navbar-nav me-auto gap-3">
                    <li class="nav-item"><a class="nav-link" href="/project/home">Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="/project/show/yourProject/${user.id}">Your Projects</a></li>
                    <li class="nav-item"><a class="nav-link" href="/project/new">Create Project</a></li>
                    <li class="nav-item"><a class="btn btn-outline-danger h-100" href="/logout">Log Out</a></li>
                </ul>
            </div>
        </div>
    </nav>
    <div class="container mt-3">
        <div class="row">
            <div class="col-12">
                <h1 class="display-3">Project Details</h1>
                <hr>
            </div>
        </div>
        <div class="row">
            <div class="col-12 gap-3">
                <h3>Project Title:</h3>
                <p class="lead">${project.title}</p>
                <hr>
            </div>
        </div>
        <div class="row">
            <div class="col-12 gap-3">
                <h3>Project Description:</h3>
                <p class="lead">${project.description}</p>
                <hr>
            </div>
        </div>
        <div class="row">
            <div class="col-12 gap-3">
                <h3>Project due date:</h3>
                <p class="lead"><fmt:formatDate value="${project.dueDate}" pattern="yyyy/MM/dd" /></p>
                <hr>
            </div>
        </div>
        <div class="row">
            <div class="d-flex gap-3">
	            <!-- Only the users that are in the project can see the tasks -->
                <c:if test="${project.users.contains(user)}">
                    <a href="/project/tasks/${project.id}" class="btn btn-outline-success">Create/View Tasks</a>
                </c:if>
                <c:if test="${project.owner.id == user.id}">
                    <a href="/project/edit/${project.id}" class="btn btn-outline-success">Edit Project</a>
                    <form action="/project/delete/${project.id}" method="post">
                        <input type="hidden" name="_method" value="delete">
                        <input type="submit" class="btn btn-outline-danger" value="Delete Project">
                    </form>
                </c:if>
            </div>
        </div>
    </div>
    
</body>
</html>