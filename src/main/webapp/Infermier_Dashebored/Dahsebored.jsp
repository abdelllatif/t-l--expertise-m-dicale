<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%
    String role = (String) session.getAttribute("role");
    if (session == null || !"infirmier".equals(role)) {
        response.sendRedirect("/login");
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
<!-- Sidebar -->
<!-- Sidebar -->
<aside class="w-64 bg-blue-900 text-white min-h-screen flex flex-col p-6 shadow-lg">
    <!-- Logo and User -->
    <div class="mb-8 text-center">
        <img src="${pageContext.request.contextPath}/imgs/bloding.png" alt="Logo"
             class="mx-auto mb-4 w-32 h-24 object-contain rounded-lg shadow-md">
        <p class="text-lg font-semibold">Bonjour, Abdellatif Hissoune</p>
    </div>

    <!-- Navigation -->
    <div>
        <div class="px-4 py-3 rounded-lg bg-blue-800 text-white font-medium text-center hover:bg-blue-700 transition">
            Tableau de Bord
        </div>
    </div>

    <!-- Spacer to push logout to bottom -->
    <div class="flex-1"></div>

    <!-- Logout at the bottom -->
    <div class="bg-red-500 hover:bg-red-600 text-white font-semibold px-4 py-2 rounded-lg text-center transition">
        Déconnexion
    </div>
</aside>


<!-- Main Content -->
<main class="flex-1 p-8">

    <!-- Choix Nouveau / Ancien Patient -->
    <div class="bg-white shadow-lg rounded-xl p-6 mb-8">
        <c:if test="${not empty message}">
            <div style="color: green; font-weight: bold;">
                    ${message}
            </div>
        </c:if>
        <c:if test="${not empty error}">
            <div style="color: red; font-weight: bold;">
                    ${error}
            </div>
        </c:if>
        <h2 class="text-2xl font-semibold mb-4 text-blue-900">Patient</h2>
        <div class="flex space-x-4 mb-4">
            <button id="newPatientBtn" class="bg-blue-900 text-white py-2 px-4 rounded hover:bg-blue-800 transition">
                Nouveau Patient
            </button>
            <button id="existingPatientBtn"
                    class="bg-gray-200 text-gray-800 py-2 px-4 rounded hover:bg-gray-300 transition">Patient Existants
            </button>
        </div>

        <!-- Formulaire Nouveau Patient -->
        <form id="newPatientForm" method="post" class="grid grid-cols-2 gap-4 mb-4 hidden">
            <input type="text" name="nom" placeholder="Nom" class="border rounded p-2">
            <input type="text" name="prenom" placeholder="Prénom" class="border rounded p-2">
            <input type="text" name="numCIN" placeholder="Numéro de carte national"
                   class="border rounded p-2 col-span-2">
            <input type="text" name="telephone" placeholder="Téléphone" class="border rounded p-2">
            <input type="number" min="1" max="120" name="age" placeholder="Age de patient " class="border rounded p-2">
            <input type="text" name="adresse" placeholder="Adresse" class="border rounded p-2">

        </form>

        <!-- Recherche Patient Existant -->
        <div id="existingPatientForm" class="mb-4 hidden">
            <input type="text" id="searchPatient" placeholder="Rechercher par nom "
                   class="border rounded p-2 w-full mb-2">
            <select id="selectPatient" class="border rounded p-2 w-full">
                <option value=""> Selectionner un patient</option>
                <c:forEach var="entry" items="${patients}">
                    <option value="${entry.key}">${entry.value.nom} ${entry.value.prenom}</option>
                </c:forEach>
            </select>
        </div>
    </div>

    <!-- Formulaire des Signes Vitaux (toujours affiché) -->
    <div class="bg-white shadow-lg rounded-xl p-6 mb-8">
        <h2 class="text-2xl font-semibold mb-4 text-blue-900"><img
                src="${pageContext.request.contextPath}/imgs/vital.png" width="40px"> Signes Vitaux</h2>
        <form id="signeVitalForm" action="${pageContext.request.contextPath}/patient" method="post"
              class="grid grid-cols-2 gap-4">
            <input type="number" name="tension" placeholder="Tension Artérielle" class="border rounded p-2">
            <input type="number" name="frequence" placeholder="Fréquence Cardiaque" class="border rounded p-2">
            <input type="number" name="temperature" placeholder="Température Corporelle" class="border rounded p-2">
            <input type="number" name="frequenceResp" placeholder="Fréquence Respiratoire" class="border rounded p-2">
            <input type="number" name="poids" placeholder="Poids (kg)" class="border rounded p-2">
            <input type="number" name="taille" placeholder="Taille (cm)" class="border rounded p-2">

            <button type="submit"
                    class="bg-blue-900 text-white py-2 px-4 rounded col-span-2 hover:bg-blue-800 transition">
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
                <th class="p-2">Num.CNI</th>
                <th class="p-2">Heure d'arrivée</th>
                <th class="p-2">Statut</th>
            </tr>
            </thead>
            <tbody id="todayPatients">
            <c:forEach var="fa" items="${listOftoday}">
                <tr class="<c:choose>
                      <c:when test='${fa.status == "EN_ATTENTE"}'>bg-blue-200</c:when>
                      <c:when test='${fa.status == "EN_COURS"}'>bg-green-200</c:when>
                      <c:otherwise>bg-gray-300</c:otherwise>
                   </c:choose>">
                    <td>${fa.patient.nom}</td>
                    <td>${fa.patient.prenom}</td>
                    <td>${fa.patient.cniNumero}</td>
                    <td>${fa.dateArrivee}</td>
                    <td>
                        <form action="${pageContext.request.contextPath}/api/updateFileStatus" method="POST" class="statusForm">
                            <input type="hidden" name="id" value="${fa.id}">
                            <select name="status" class="statusSelect">
                                <option value="EN_ATTENTE" ${fa.status == 'EN_ATTENTE' ? 'selected' : ''}>En Attente</option>
                                <option value="EN_COURS" ${fa.status == 'EN_COURS' ? 'selected' : ''}>En Cours</option>
                                <option value="TERMINEE" ${fa.status == 'TERMINEE' ? 'selected' : ''}>Terminée</option>
                            </select>
                        </form>


                    </td>

                </tr>
            </c:forEach>
            </tbody>


        </table>
    </div>
</main>
<script>
    document.addEventListener("DOMContentLoaded", function () {

        // 🔹 Toggle Nouveau / Patient Existant
        const newPatientBtn = document.getElementById("newPatientBtn");
        const existingPatientBtn = document.getElementById("existingPatientBtn");
        const newPatientForm = document.getElementById("newPatientForm");
        const existingPatientForm = document.getElementById("existingPatientForm");

        newPatientBtn.addEventListener("click", () => {
            newPatientForm.style.display = "grid";
            existingPatientForm.style.display = "none";
            console.log("🟢 Mode: Nouveau patient");
        });

        existingPatientBtn.addEventListener("click", () => {
            newPatientForm.style.display = "none";
            existingPatientForm.style.display = "block";
            console.log("🟣 Mode: Patient existant");
        });

        const signeVitalForm = document.getElementById("signeVitalForm");

        signeVitalForm.addEventListener("submit", function (e) {
            let valid = true;
            const newVisible = newPatientForm.style.display !== "none";
            const existingVisible = existingPatientForm.style.display !== "none";

            signeVitalForm.querySelectorAll('input[type="text"], input[type="number"]').forEach(input => {
                if (input.value.trim() === "") {
                    valid = false;
                    input.classList.add("border-red-500");
                } else {
                    input.classList.remove("border-red-500");
                }
            });

            if (newVisible) {
                newPatientForm.querySelectorAll("input").forEach(input => {
                    if (input.value.trim() === "") {
                        valid = false;
                        input.classList.add("border-red-500");
                    } else {
                        input.classList.remove("border-red-500");
                    }
                });
            }

            if (existingVisible) {
                const selectPatient = document.getElementById("selectPatient");
                if (selectPatient.value === "") {
                    valid = false;
                    selectPatient.classList.add("border-red-500");
                } else {
                    selectPatient.classList.remove("border-red-500");
                }
            }

            if (!valid) {
                e.preventDefault();
                alert("⚠️ Veuillez remplir tous les champs avant d'enregistrer !");
                return;
            }

            signeVitalForm.querySelectorAll('input[name="patientType"], input[name="patientId"]').forEach(input => input.remove());

            if (newVisible) {
                const inputType = document.createElement("input");
                inputType.type = "hidden";
                inputType.name = "patientType";
                inputType.value = "new";
                signeVitalForm.appendChild(inputType);

                newPatientForm.querySelectorAll("input").forEach(input => {
                    const hidden = document.createElement("input");
                    hidden.type = "hidden";
                    hidden.name = input.name;
                    hidden.value = input.value;
                    signeVitalForm.appendChild(hidden);
                });
            } else if (existingVisible) {
                const inputType = document.createElement("input");
                inputType.type = "hidden";
                inputType.name = "patientType";
                inputType.value = "existing";
                signeVitalForm.appendChild(inputType);

                const inputId = document.createElement("input");
                inputId.type = "hidden";
                inputId.name = "patientId";
                inputId.value = document.getElementById("selectPatient").value;
                signeVitalForm.appendChild(inputId);
            }
        });


        document.querySelectorAll(".statusSelect").forEach(select => {
            // نحفظ الحالة الأصلية في data attribute
            select.dataset.currentStatus = select.value;

            select.addEventListener("change", function () {
                const form = select.closest(".statusForm");
                const newStatus = select.value;
                const oldStatus = select.dataset.currentStatus;

                // 🔒 منع الرجوع إلى حالة سابقة
                if (
                    (oldStatus === "EN_COURS" && newStatus === "EN_ATTENTE") ||
                    (oldStatus === "TERMINEE" && (newStatus === "EN_ATTENTE" || newStatus === "EN_COURS"))
                ) {
                    alert("⚠️ Impossible de revenir à un statut précédent !");
                    select.value = oldStatus; // نرجع الحالة الأصلية
                    return;
                }

                // 🔄 منع أكثر من مريض EN_COURS في نفس الوقت
                if (newStatus === "EN_COURS") {
                    const alreadyInProgress = Array.from(document.querySelectorAll(".statusSelect")).some(
                        s => s.value === "EN_COURS" && s !== select
                    );
                    if (alreadyInProgress) {
                        alert("⚠️ Il y a déjà un patient EN_COURS !");
                        select.value = oldStatus;
                        return;
                    }
                }

                // ✅ تأكيد التغيير
                if (confirm("Souhaitez-vous vraiment changer le statut ?")) {
                    form.submit(); // إرسال الفورم
                } else {
                    select.value = oldStatus; // إلغاء التغيير
                }
            });
        });


    });
</script>
</body>
</html>
