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
<title>All Projects</title>
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css">
<script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
</head>
<body>
    <nav class="navbar navbar-expand-xl navbar-dark bg-dark p-3">
        <div class="container-fluid gap-1">
            <a class="navbar-brand display-1" href="#" style="font-size: 24px;">All Project</a>
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
    	<h3 class="text-secondary">Projects that you can join:</h3>
        <table class="table table-striped table-hover mt-3">
            <thead class="table-dark">
                <tr>
                    <th scope="col">Project</th>
                    <th scope="col">Team Lead</th>
                    <th scope="col">Due Date</th>
                    <th scope="col">Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="project" items="${projects}">
                    <tr>
                        <td>
                        	<a href="/project/show/${project.id}">
                                <c:out value="${project.title}" />
                            </a>
                        </td>
                        <td>
                            <c:out value="${project.owner.userName}" />
                        </td>
                        <td>
                            <fmt:formatDate value="${project.dueDate}" pattern="MM/dd" />
                        </td>
                        <td>
                            <form action="/project/join/${project.id}" method="post">
                                <input type="submit" value="Join" class="btn btn-outline-success"/>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>