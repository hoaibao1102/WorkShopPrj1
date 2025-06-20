<%-- 
    Document   : Dashboard
    Created on : Jun 21, 2025, 12:54:03 AM
    Author     : MSI PC
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<html>
<head>
    <title>Dashboard</title>
</head>
<body>
<h2>Welcome, ${sessionScope.user.name} (${sessionScope.user.role})</h2>

<nav>
    <a href="createProject.jsp">Create Project</a> |
    <a href="searchProject.jsp">Search Project</a> |
    <a href="MainController?action=Logout">Logout</a>
</nav>

<hr>

<h3>Startup Projects</h3>

<c:if test="${empty projects}">
    <p>No projects available.</p>
</c:if>

<c:if test="${not empty projects}">
    <table border="1" cellpadding="5">
        <tr>
            <th>ID</th><th>Name</th><th>Description</th><th>Status</th><th>Launch Date</th>
        </tr>
        <c:forEach var="p" items="${projects}">
            <tr>
                <td>${p.projectId}</td>
                <td>${p.projectName}</td>
                <td>${p.description}</td>
                <td>${p.status}</td>
                <td>${p.estimatedLaunch}</td>
            </tr>
        </c:forEach>
    </table>
</c:if>
</body>
</html>

