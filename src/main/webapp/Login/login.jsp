<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Login - Télé-Expertise</title>
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f5f5;
        }
        .container {
            display: flex;
            height: 100vh;
            align-items: center;
            justify-content: center;
        }
        .login-box {
            background-color: white;
            width: 800px;
            display: flex;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
            overflow: hidden;
        }
        .login-left {
            flex: 1;
            padding: 50px;
        }
        .login-left h2 {
            margin-bottom: 40px;
            color: #333;
        }
        .login-left input[type="email"],
        .login-left input[type="password"] {
            width: 100%;
            padding: 15px;
            margin: 15px 0;
            border-radius: 8px;
            border: 1px solid #ccc;
            font-size: 16px;
        }
        .login-left button {
            width: 100%;
            padding: 15px;
            background-color: #e74c3c;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 18px;
            cursor: pointer;
            margin-top: 20px;
            transition: background 0.3s ease;
        }
        .login-left button:hover {
            background-color: #c0392b;
        }
        .login-right {
            flex: 1;
            background: url('blood-image.jpg') no-repeat center center;
            background-size: cover;
        }
        @media(max-width: 900px){
            .login-box {
                flex-direction: column;
                width: 90%;
            }
            .login-right {
                height: 200px;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="login-box">
        <div class="login-left">
            <h2>Connexion</h2>
            <form action="login" method="post">
                <c:if test="${not empty error}">
                    <div style="color: red; margin-top: 10px; font-weight: bold;">
                            ${error}
                    </div>
                </c:if>
                <input type="email" name="email" placeholder="Email" required>
                <input type="password" name="password" placeholder="Mot de passe" required>
                <div style="margin: 15px 0;">
                    <label>
                        <input type="radio" name="role" value="infirmier" required> Infirmier
                    </label>
                    <label style="margin-left: 20px;">
                        <input type="radio" name="role" value="medecin" required> Médecin
                    </label>
                </div>

                <button type="submit">Se connecter</button>
            </form>

        </div>
        <div class="login-right">
            <img src="${pageContext.request.contextPath}/imgs/Blode.jpg" alt="blood-image" height="110%" width="100%" style="object-fit: cover;">
        </div>
    </div>
</div>
</body>
</html>
