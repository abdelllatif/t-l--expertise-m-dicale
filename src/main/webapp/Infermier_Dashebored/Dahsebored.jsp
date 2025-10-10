<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
    if (session == null || session.getAttribute("infirmier") == null) {
        response.sendRedirect("../login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Tableau de Bord - Infirmier</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
</head>
<body class="bg-gray-100 flex">

<!-- Sidebar -->
<aside class="w-64 bg-blue-900 text-white min-h-screen p-6 flex flex-col">
    <div class="mb-8 text-center">
        <img src="${pageContext.request.contextPath}/imgs/bloding.png" width="130px" height="100px" alt="Logo" class="mx-auto mb-4">
        <p class="text-lg font-semibold">Bonjour, Abdellatif Hissoune</p>
    </div>
    <nav class="flex flex-col space-y-3 mt-4">
        <a href="dashboard.jsp" class="px-4 py-2 rounded hover:bg-blue-800 transition">🏠 Tableau de Bord</a>
        <a href="#" class="px-4 py-2 rounded hover:bg-blue-800 transition">➕ Ajouter Patient / Recherche</a>
        <a href="#" class="px-4 py-2 rounded hover:bg-blue-800 transition">📋 Patients du Jour</a>
        <a href="../logout" class="mt-auto bg-red-500 px-4 py-2 rounded text-center hover:bg-red-600 transition">Déconnexion</a>
    </nav>
</aside>

<!-- Main Content -->
<main class="flex-1 p-8">

    <!-- Choix Nouveau / Ancien Patient -->
    <div class="bg-white shadow-lg rounded-xl p-6 mb-8">
        <h2 class="text-2xl font-semibold mb-4 text-blue-900">Patient</h2>
        <div class="flex space-x-4 mb-4">
            <button id="newPatientBtn" class="bg-blue-900 text-white py-2 px-4 rounded hover:bg-blue-800 transition">Nouveau Patient</button>
            <button id="existingPatientBtn" class="bg-gray-200 text-gray-800 py-2 px-4 rounded hover:bg-gray-300 transition">Patient Existants</button>
        </div>

        <!-- Formulaire Nouveau Patient -->
        <form id="newPatientForm" action="#" method="post" class="grid grid-cols-2 gap-4 mb-4 hidden">
            <input type="text" name="nom" placeholder="Nom" class="border rounded p-2">
            <input type="text" name="prenom" placeholder="Prénom" class="border rounded p-2">
            <input type="text" name="numSecu" placeholder="Numéro de Sécurité Sociale" class="border rounded p-2 col-span-2">
            <input type="text" name="telephone" placeholder="Téléphone" class="border rounded p-2">
            <input type="text" name="adresse" placeholder="Adresse (optionnel)" class="border rounded p-2">
        </form>

        <!-- Recherche Patient Existant -->
        <div id="existingPatientForm" class="mb-4 hidden">
            <input type="text" id="searchPatient" placeholder="Rechercher par nom " class="border rounded p-2 w-full mb-2">
            <select id="selectPatient" class="border rounded p-2 w-full">
                <option value=""> Selectionner un patient </option>
                <!-- Options via AJAX -->
            </select>
        </div>
    </div>

    <!-- Formulaire des Signes Vitaux (toujours affiché) -->
    <div class="bg-white shadow-lg rounded-xl p-6 mb-8">
        <h2 class="text-2xl font-semibold mb-4 text-blue-900"><img src="${pageContext.request.contextPath}/imgs/vital.png" width="40px"> Signes Vitaux</h2>
        <form id="signeVitalForm" action="#" method="post" class="grid grid-cols-2 gap-4">
            <input type="text" name="tension" placeholder="Tension Artérielle" class="border rounded p-2">
            <input type="text" name="frequence" placeholder="Fréquence Cardiaque" class="border rounded p-2">
            <input type="text" name="temperature" placeholder="Température Corporelle" class="border rounded p-2">
            <input type="text" name="frequenceResp" placeholder="Fréquence Respiratoire" class="border rounded p-2">
            <input type="text" name="poids" placeholder="Poids (kg)" class="border rounded p-2">
            <input type="text" name="taille" placeholder="Taille (cm)" class="border rounded p-2">

            <button type="submit" class="bg-blue-900 text-white py-2 px-4 rounded col-span-2 hover:bg-blue-800 transition">
                Enregistrer Signes Vitaux
            </button>
        </form>
    </div>

    <!-- Liste des patients du jour -->
    <div class="bg-white shadow-lg rounded-xl p-6">
        <h2 class="text-2xl font-semibold mb-4 text-blue-900">📋 Liste des Patients du Jour</h2>
        <table class="w-full text-left border">
            <thead class="bg-blue-100">
            <tr>
                <th class="p-2">Nom</th>
                <th class="p-2">Prénom</th>
                <th class="p-2">Heure d'arrivée</th>
                <th class="p-2">Tension</th>
                <th class="p-2">Température</th>
                <th class="p-2">Num. Sécu</th>
                <th class="p-2">Statut</th>
            </tr>
            </thead>
            <tbody id="todayPatients">
            <!-- Rempli via AJAX -->
            </tbody>
        </table>
    </div>
</main>

<script>
    $('#newPatientBtn').click(function() {
        $('#newPatientForm').show();
        $('#existingPatientForm').hide();
    });
    $('#existingPatientBtn').click(function() {
        $('#newPatientForm').hide();
        $('#existingPatientForm').show();
    });

    var selected = document.getElementById("selectPatient");
    selected.addEventListener("click",(e)=>{

    });


</script>
</body>
</html>
