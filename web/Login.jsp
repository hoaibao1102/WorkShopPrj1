<%-- 
    Document   : Login
    Created on : Jun 21, 2025, 12:53:17 AM
    Author     : MSI PC
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
    <head>
        <title>Login</title>
    </head>
    <body>
        <%
            String error = request.getAttribute("errorNoti")+"";
        %>
        <h2>Startup Project Management - Login</h2>
        <form action="MainController" method="get">
            <input type="hidden" name="action" value="login">
            Username: <input type="text" name="username" required><br>
            Password: <input type="password" name="password" required><br>
            <input type="submit" value="Login">
        </form>
        <p><%=error.equals("null")?"":error%></p>
        
    </body>
</html>
