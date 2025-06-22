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
        <title>Create Project</title>
        <style>
            :root {
                --primary: #6366f1;
                --danger: #ef4444;
                --text: #1f2937;
                --bg-main: #f3f4f6;
                --glass-bg: rgba(255, 255, 255, 0.75);
                --glass-border: rgba(255, 255, 255, 0.2);
            }

            * {
                box-sizing: border-box;
                margin: 0;
                padding: 0;
                font-family: 'Poppins', sans-serif;
            }

            body {
                background: linear-gradient(135deg, #d0e8f2, #f9f9fb);
                min-height: 100vh;
                display: flex;
                justify-content: center;
                align-items: flex-start;
                padding: 40px 20px;
            }

            .container {
                width: 100%;
                max-width: 800px;
                background: var(--glass-bg);
                backdrop-filter: blur(12px);
                border: 1px solid var(--glass-border);
                border-radius: 20px;
                padding: 40px 50px;
                box-shadow: 0 12px 36px rgba(0, 0, 0, 0.08);
                animation: slideFade 0.6s ease;
            }

            @keyframes slideFade {
                from {
                    opacity: 0;
                    transform: translateY(20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            h2 {
                font-size: 28px;
                margin-bottom: 30px;
                color: var(--text);
                text-align: center;
                border-bottom: 2px solid var(--primary);
                padding-bottom: 10px;
            }

            label {
                display: block;
                margin-top: 18px;
                font-weight: 600;
                color: var(--text);
                font-size: 15px;
            }

            input[type="text"],
            input[type="date"],
            textarea,
            select {
                width: 100%;
                padding: 12px 14px;
                margin-top: 6px;
                border: 1px solid #cbd5e1;
                border-radius: 10px;
                font-size: 15px;
                background: #f8fafc;
                color: #1e293b;
                transition: 0.3s ease;
            }

            input:focus,
            textarea:focus,
            select:focus {
                border-color: var(--primary);
                outline: none;
                background-color: #ffffff;
            }

            .error {
                color: var(--danger);
                font-size: 13px;
                margin-top: 4px;
                display: block;
            }

            input[type="submit"] {
                width: 100%;
                padding: 12px;
                background-color: var(--primary);
                color: white;
                font-size: 15px;
                border: none;
                border-radius: 999px;
                cursor: pointer;
                margin-top: 30px;
                font-weight: 600;
                transition: all 0.3s ease;
            }

            input[type="submit"]:hover {
                background-color: #4f46e5;
                transform: scale(1.03);
            }

            .back-btn {
                display: inline-block;
                margin-bottom: 20px;
                background-color: #6b7280;
                color: white;
                padding: 8px 18px;
                border-radius: 999px;
                text-decoration: none;
                font-size: 13px;
                transition: all 0.3s ease;
            }

            .back-btn:hover {
                background-color: #4b5563;
                transform: scale(1.05);
            }

            @media (max-width: 640px) {
                .container {
                    padding: 30px 25px;
                }
                h2 {
                    font-size: 24px;
                }
            }
        </style>

        
    </head>
    <body>
        <div class="container">
            <a href="javascript:history.back()" class="back-btn">← Back</a>

            <h2>Startup Project</h2>

            <form action="MainController" method="get">
                <input type="hidden" name="action" value="${not empty startupProject ? 'update' : 'create'}">

                <label>Project Name:</label>
                <input type="text" name="projectName" value="${not empty startupProject ? startupProject.projectName : spError.projectName}" required>
                <c:if test="${not empty errorName}">
                    <span class="error">${errorName}</span>
                </c:if>

                <label>Description:</label>
                <textarea name="description" rows="3">${not empty startupProject ? startupProject.description : spError.description}</textarea>
                <c:if test="${not empty errorDescription}">
                    <span class="error">${errorDescription}</span>
                </c:if>

                <label>Status:</label>
                <c:set var="statusValue" value="${not empty startupProject ? startupProject.status : spError.status}" />
                <select name="status">
                    <option value="Ideation" ${statusValue == 'Ideation' ? 'selected' : ''}>Ideation</option>
                    <option value="Development" ${statusValue == 'Development' ? 'selected' : ''}>Development</option>
                    <option value="Launch" ${statusValue == 'Launch' ? 'selected' : ''}>Launch</option>
                    <option value="Scaling" ${statusValue == 'Scaling' ? 'selected' : ''}>Scaling</option>
                </select>

                <label>Launch Date:</label>
                <input type="date" name="launchDate" value="${not empty startupProject ? startupProject.estimatedLaunch : spError.estimatedLaunch}" required>
                <c:if test="${not empty errorDate}">
                    <span class="error">${errorDate}</span>
                </c:if>

                <c:if test="${not empty startupProject}">
                    <input type="hidden" name="projectId" value="${startupProject.projectId}">
                    <input type="hidden" name="oldLaunchDate" value="${startupProject.estimatedLaunch}">
                </c:if>
                <input type="submit" value="${not empty startupProject ? 'Update Project' : 'Create Project'}">
            </form>
        </div>
    </body>
</html>

