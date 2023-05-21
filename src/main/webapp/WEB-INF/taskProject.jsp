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
<title>Tasks for Project</title>
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css">
<script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
</head>
<body>
    <nav class="navbar navbar-expand-xl navbar-dark bg-dark p-3">
        <div class="container-fluid gap-1">
            <a class="navbar-brand display-1" href="#" style="font-size: 24px;">Tasks for your Project</a>
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
            <h2>
                Project: <c:out value="${project.title}" />
            </h2>
            <h5>
                Lead: <c:out value="${project.owner.userName}" />
            </h5>
        </div>
        <div class="row gap-3">
            <div class="col-5 mt-3">
                <form:form action="/project/create/tasks/${project.id}" method="post" modelAttribute="task">
                    <c:if test="${bindingResult.hasErrors()}">
                        <div class="alert alert-danger mt-3 d-block ">
                            <h5>
                                <strong>Validation Error:</strong>
                            </h5>
                            <div class="mb-3">
                                <form:errors path="taskDetail" class="text-danger" />
                            </div>
                        </div>
                    </c:if>
                    <div class="mb-3">
                        <label for="taskDetail" class="form-label">Task:</label>
                        <form:input type="text" class="form-control" path="taskDetail" />
                    </div>
                    <div class="mb-3">
                        <button type="submit" class="btn btn-primary">Create Task</button>
                    </div>
                </form:form>
            </div>
            <div class="col-6">
                <h3>Tasks:</h3>
                <!-- Create a card to show all tasks -->
                <c:forEach var="task" items="${project.tasks}">
                    <div class="card mt-3">
                        <div class="card-header">
                            <h5>
                                Added by <c:out value="${task.user.userName}" /> at <fmt:formatDate value="${task.createdAt}" pattern="MM/dd/yyyy" />
                            </h5>
                        </div>
                        <div class="card-body">
                            <p>
                                <strong>Task:</strong>
                            </p>
                            <p class="card-text">
                                <c:out value="${task.taskDetail}" />
                            </p>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</body>
</html>