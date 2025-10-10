<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Base de données déconnectée</title>
    <style>
        body {
            background-color: #f8f8f8;
            font-family: 'Segoe UI', sans-serif;
            text-align: center;
            margin-top: 100px;
        }
        img {
            width: 200px;
            margin-bottom: 20px;
        }
        h1 {
            color: #d50404;
        }
        p {
            color: #555;
        }
    </style>
</head>
<body>
<img src="${pageContext.request.contextPath}/imgs/db_dye.png" alt="Database Down">
<h1>Connexion à la base de données échouée </h1>
<p style="font-size: 23px;">Le serveur n'arrive pas à se connecter à MySQL.<br>Veuillez réessayer plus tard.</p>
</body>
</html>
