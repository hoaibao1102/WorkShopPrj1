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
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: 'Poppins', sans-serif;
            }

            body {
                background: linear-gradient(135deg, #dfe9f3, #ffffff);
                min-height: 100vh;
                display: flex;
                justify-content: center;
                align-items: center;
                padding: 20px;
            }

            .login-box {
                width: 100%;
                max-width: 380px;
                background: var(--glass-bg);
                backdrop-filter: blur(12px);
                border: 1px solid var(--glass-border);
                border-radius: 16px;
                padding: 40px;
                box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
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
                font-weight: 600;
                border-bottom: 2px solid var(--primary);
                padding-bottom: 10px;
            }

            label {
                display: block;
                margin-top: 12px;
                font-size: 15px;
                color: var(--text);
            }

            input[type="text"],
            input[type="password"] {
                width: 100%;
                padding: 12px;
                margin-top: 6px;
                border: 1px solid #cbd5e1;
                border-radius: 10px;
                background-color: #f8fafc;
                font-size: 15px;
                color: #1e293b;
                transition: 0.3s ease;
            }

            input:focus {
                border-color: var(--primary);
                outline: none;
                background-color: #ffffff;
            }

            input::placeholder {
                color: #999;
            }

            input[type="submit"] {
                width: 100%;
                padding: 12px;
                background-color: var(--primary);
                color: white;
                font-weight: 600;
                border-radius: 999px;
                border: none;
                cursor: pointer;
                margin-top: 20px;
                transition: background-color 0.3s ease;
            }

            input[type="submit"]:hover {
                background-color: #4f46e5;
                transform: scale(1.03);
            }

            .error {
                color: var(--danger);
                text-align: center;
                margin-top: 15px;
                font-size: 14px;
            }

            @media (max-width: 640px) {
                .login-box {
                    padding: 30px 25px;
                }
                h2 {
                    font-size: 24px;
                }
            }
        </style>
    </head>
    <body>

        <div class="login-box">
            <h2>Login</h2>
            <form action="MainController" method="post">
                <input type="hidden" name="action" value="login">

                <label for="userName">Username:</label>
                <input type="text" id="userName" name="userName" required placeholder="Enter your username">

                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required placeholder="Enter your password">

                <input type="submit" value="Login">
            </form>

            <c:if test="${not empty errorNoti || not empty param.errorNoti}">
                <div class="error">
                    ${not empty errorNoti ? errorNoti : param.errorNoti}
                </div>
            </c:if>
        </div>

    </body>
</html>
