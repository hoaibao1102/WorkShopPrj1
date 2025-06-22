<%-- 
    Document   : CreateProject
    Created on : Jun 21, 2025, 1:36:56 AM
    Author     : MSI PC
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:if test="${empty sessionScope.user}">
    <c:redirect url="Login.jsp?errorNoti=You+must+log+in+first"/>
</c:if>

<html>
    <head>
        <title>Dashboard</title>
        <style>
            :root {
                --primary: #4f46e5;
                --danger: #e11d48;
                --success: #22c55e;
                --text: #1e293b;
                --bg-main: #f8fafc;
                --glass-bg: rgba(255, 255, 255, 0.25);
                --glass-border: rgba(255, 255, 255, 0.2);
            }

            * {
                box-sizing: border-box;
                margin: 0;
                padding: 0;
                font-family: 'Poppins', sans-serif;
            }

            body {
                background: linear-gradient(135deg, #c3e0f9, #e9e9f1);
                min-height: 100vh;
                display: flex;
                justify-content: center;
                align-items: flex-start;
                padding: 40px 20px;
            }

            .container {
                width: 100%;
                max-width: 1100px;
                background: var(--glass-bg);
                border: 1px solid var(--glass-border);
                border-radius: 24px;
                backdrop-filter: blur(14px);
                box-shadow: 0 16px 40px rgba(0, 0, 0, 0.1);
                padding: 40px 50px;
                animation: fadeIn 0.6s ease;
            }

            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 40px;
                border-bottom: 1px solid #e2e8f0;
                padding-bottom: 20px;
            }

            .header h2 {
                font-size: 32px;
                color: var(--text);
            }

            .user-info {
                text-align: right;
            }

            .user-info h3 {
                font-size: 16px;
                color: var(--text);
                margin-bottom: 8px;
            }

            .logout-btn {
                background-color: var(--danger);
                color: white;
                padding: 10px 18px;
                border: none;
                border-radius: 999px;
                font-size: 13px;
                cursor: pointer;
                transition: 0.3s ease;
            }

            .logout-btn:hover {
                background-color: #be123c;
                transform: scale(1.05);
            }

            .actions-bar {
                display: flex;
                justify-content: space-between;
                align-items: center;
                flex-wrap: wrap;
                margin-bottom: 30px;
                gap: 15px;
            }

            .create-btn {
                background-color: var(--success);
                color: white;
                padding: 10px 20px;
                border-radius: 999px;
                border: none;
                font-weight: 600;
                font-size: 14px;
                cursor: pointer;
                transition: all 0.3s ease;
            }

            .create-btn:hover {
                background-color: #16a34a;
                transform: scale(1.05);
            }

            .search-bar {
                display: flex;
                gap: 12px;
                flex: 1;
            }

            .search-bar input[type="text"] {
                flex: 1;
                padding: 12px 16px;
                border-radius: 999px;
                border: 1px solid #cbd5e1;
                font-size: 15px;
                background: #f1f5f9;
                color: #0f172a;
                outline: none;
            }

            .search-bar input[type="submit"] {
                background-color: var(--primary);
                color: white;
                padding: 10px 18px;
                border-radius: 999px;
                border: none;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
            }

            .search-bar input[type="submit"]:hover {
                background-color: #4338ca;
                transform: scale(1.05);
            }

            table {
                width: 100%;
                border-collapse: collapse;
                border-radius: 12px;
                overflow: hidden;
                box-shadow: 0 4px 16px rgba(0,0,0,0.05);
            }

            th, td {
                padding: 16px;
                text-align: left;
                font-size: 14px;
                color: #334155;
                background-color: rgba(255,255,255,0.8);
            }

            th {
                background-color: #f1f5f9;
                font-weight: 600;
            }

            tr:hover {
                background-color: #f0fdf4;
            }

            .update-form button {
                background-color: #facc15;
                border: none;
                border-radius: 999px;
                padding: 8px 16px;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
            }

            .update-form button:hover {
                background-color: #eab308;
                transform: scale(1.05);
            }

            h3 {
                color: var(--text);
                margin-top: 30px;
                font-size: 18px;
            }

            @media (max-width: 768px) {
                .actions-bar {
                    flex-direction: column;
                    align-items: stretch;
                }
            }
        </style>



    </head>
    <body>
        <c:if test="${not empty sessionScope.successMessage}">
            <script>
                alert("${sessionScope.successMessage}");
            </script>
            <c:remove var="successMessage" scope="session"/>
        </c:if>
        <div class="container">

            <!-- Top bar -->
            <div class="header">
                <h2>Startup Project Dashboard</h2>
                <div class="user-info">
                    <h3>Hello, ${sessionScope.user.name}</h3> 
                    <a href="MainController?action=logout" class="logout-btn">Logout</a>
                </div>
            </div>

            <!-- Action bar -->
            <div class="actions-bar">
                <form action="MainController" method="get" class="search-bar">
                    <input type="hidden" name="action" value="search">

                    <input type="text" name="searchTerm" value="${not empty param.searchTerm? param.searchTerm: ""}" placeholder="Search project by name...">
                    <input type="submit" value="Search">
                </form>
                <a href="CreateProject.jsp" class="create-btn">+ Create Project</a>
            </div>

            <!-- Project table -->
            <c:if test="${not empty projects and empty projectSearch}">
                <table>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Description</th>
                        <th>Status</th>
                        <th>Launch Date</th>
                        <th>Action</th>
                    </tr>
                    <c:forEach var="p" items="${projects}">
                        <tr>
                            <td>${p.projectId}</td>
                            <td>${p.projectName}</td>
                            <td>${p.description}</td>
                            <td>${p.status}</td>
                            <td>${p.estimatedLaunch}</td>
                            <td>
                                <form action="MainController" method="get" class="update-form">
                                    <input type="hidden" name="action" value="updateGetPage">
                                    <input type="hidden" name="projectId" value="${p.projectId}">
                                    <button type="submit">Update</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </c:if>

            <c:if test="${not empty param.searchTerm}">
                <c:choose>
                    <c:when test="${not empty projectSearch and empty projects}">
                        <h3>Information related to "${param.searchTerm}"</h3>
                        <table>
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Description</th>
                                <th>Status</th>
                                <th>Launch Date</th>
                                <th>Action</th>
                            </tr>
                            <c:forEach var="p" items="${projectSearch}">
                                <tr>
                                    <td>${p.projectId}</td>
                                    <td>${p.projectName}</td>
                                    <td>${p.description}</td>
                                    <td>${p.status}</td>
                                    <td>${p.estimatedLaunch}</td>
                                    <td>
                                        <form action="MainController" method="get" class="update-form">
                                            <input type="hidden" name="action" value="updateGetPage">
                                            <input type="hidden" name="projectId" value="${p.projectId}">
                                            <button type="submit">Update</button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <h3>No information related to your request.</h3>
                    </c:otherwise>
                </c:choose>
            </c:if>


        </div>
    </body>
</html>
