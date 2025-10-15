<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Tableau de Bord - Médecin</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 flex">

<!-- Sidebar -->
<aside class="w-64 bg-blue-900 text-white min-h-screen flex flex-col p-6 shadow-lg">
    <div class="mb-8 text-center">
        <img src="${pageContext.request.contextPath}/imgs/bloding.png" alt="Logo"
             class="mx-auto mb-4 w-32 h-24 object-contain rounded-lg shadow-md">
        <p class="text-lg font-semibold">Bonjour, Dr. Ana</p>
    </div>
    <nav class="space-y-3">
        <button id="tabPatients" class="w-full px-4 py-2 bg-blue-800 hover:bg-blue-700 rounded transition">👥 Patients du jour</button>
        <button id="ConsultationsHistorice" class="w-full px-4 py-2 bg-blue-800 hover:bg-blue-700 rounded transition">🗒️ Consultations de jour</button>
        <button id="tabSpecialists" class="w-full px-4 py-2 bg-blue-800 hover:bg-blue-700 rounded transition">🔍 Rechercher Spécialistes</button>
        <button id="tabTeleExpertise" class="w-full px-4 py-2 bg-blue-800 hover:bg-blue-700 rounded transition">💬 Télé-Expertise</button>
    </nav>
    <div class="flex-1"></div>
    <div class="bg-red-500 hover:bg-red-600 text-white font-semibold px-4 py-2 rounded-lg text-center cursor-pointer transition"
         onclick="window.location.href='${pageContext.request.contextPath}/logout'">Déconnexion</div>
</aside>

<!-- Main Content -->
<main class="flex-1 p-8 space-y-8">
    <c:if test="${not empty sessionScope.messageSuccess}">
        <div class="bg-green-200 text-green-800 p-3 rounded mb-4">
                ${sessionScope.messageSuccess}
        </div>
        <c:remove var="messageSuccess" scope="session"/>
    </c:if>

    <c:if test="${not empty sessionScope.messageError}">
        <div class="bg-red-200 text-red-800 p-3 rounded mb-4">
                ${sessionScope.messageError}
        </div>
        <c:remove var="messageError" scope="session"/>
    </c:if>

    <section id="patientsSection" class="bg-white shadow-lg rounded-lg p-6 border border-blue-200">
        <h2 class="text-2xl font-semibold mb-6 text-blue-900">📋 Patients du jour</h2>

        <c:if test="${empty files}">
            <p class="text-red-600 font-medium"> Aucun patient trouvé.</p>
        </c:if>

        <c:forEach var="file" items="${files}">
            <div class="border-b border-gray-200 mb-4 pb-4">
                <div class="flex justify-between items-center mb-2">
                    <p class="font-semibold text-gray-800 text-lg">👤 ${file.patient.nom} ${file.patient.prenom}</p>
                    <span class="text-sm text-gray-500">CNI: ${file.patient.cniNumero}</span>
                </div>
                <p class="text-sm text-gray-600 mb-2">ID: ${file.patient.id} — Heure d'arrivée: ${file.dateArrivee}</p>

                <!-- Signes Vitaux -->
                <div class="mb-2">
                    <p class="font-medium text-blue-700 mb-1">🩺 Signes Vitaux:</p>
                    <c:choose>
                        <c:when test="${not empty file.patient.signesVitaux}">
                            <ul class="list-disc ml-6 text-sm text-gray-700">
                                <c:forEach var="sv" items="${file.patient.signesVitaux}">
                                    <li>
                                        🕒 ${sv.dateMesure} —
                                        <span class="text-blue-600">Tension:</span> ${sv.tensionArt},
                                        <span class="text-blue-600">FC:</span> ${sv.frequenceCardiaque},
                                        <span class="text-blue-600">Temp:</span> ${sv.temperature},
                                        <span class="text-blue-600">Resp:</span> ${sv.frequenceRespiratoire},
                                        <span class="text-blue-600">Poids/Taille:</span> ${sv.poids}/${sv.taille} cm
                                    </li>
                                </c:forEach>
                            </ul>
                        </c:when>
                        <c:otherwise>
                            <p class="text-gray-500 italic ml-4">Aucun signe vital enregistré.</p>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- Consultation -->
                <div class="mt-2">
                    <c:choose>
                        <c:when test="${file.status == 'EN_ATTENTE'}">
                            <button onclick="openConsultationModal(${file.patient.id}, '${file.patient.nom}')"
                                    class="bg-green-500 hover:bg-green-600 text-white px-4 py-1 rounded">
                                Créer Consultation
                            </button>
                        </c:when>
                        <c:otherwise>
                            <span class="text-gray-500 italic font-medium">Status: ${file.status}</span>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </c:forEach>
    </section>

    <section id="consultationsSection" class="hidden">
        <h1 class="text-3xl font-bold mb-6">📋 Consultations du jour</h1>

        <c:if test="${empty consultations}">
            <p class="text-red-600 font-medium">Aucune consultation pour aujourd'hui.</p>
        </c:if>

        <c:forEach var="c" items="${consultations}">
            <div class="bg-white shadow-lg rounded-lg p-6 mb-6 border border-blue-200">
                <div class="flex justify-between items-center mb-2">
                    <p class="font-semibold text-lg text-gray-800">
                        👤 ${c.patient.nom} ${c.patient.prenom} — ID: ${c.patient.id}
                    </p>
                    <span class="text-gray-500 text-sm">${c.dateConsultation}</span>
                </div>
                <p class="text-gray-700 mb-2"><span class="font-medium">Motif:</span> ${c.motif}</p>
                <p class="text-gray-700 mb-4"><span class="font-medium">Observations:</span> ${c.observations}</p>

                <!-- Signes Vitaux -->
                <div class="mb-4">
                    <p class="font-medium text-blue-700 mb-1">🩺 Signes Vitaux:</p>
                    <c:choose>
                        <c:when test="${not empty c.patient.signesVitaux}">
                            <ul class="list-disc ml-6 text-sm text-gray-700">
                                <c:forEach var="sv" items="${c.patient.signesVitaux}">
                                    <li>
                                        🕒 ${sv.dateMesure} —
                                        Tension: ${sv.tensionArt},
                                        FC: ${sv.frequenceCardiaque},
                                        Temp: ${sv.temperature},
                                        Resp: ${sv.frequenceRespiratoire},
                                        Poids/Taille: ${sv.poids}/${sv.taille} cm
                                    </li>
                                </c:forEach>
                            </ul>
                        </c:when>
                        <c:otherwise>
                            <p class="text-gray-500 italic ml-4">Aucun signe vital enregistré.</p>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- Actes Techniques -->
                <div class="mb-4">
                    <p class="font-medium text-green-700 mb-1">🧾 Actes Techniques:</p>
                    <c:choose>
                        <c:when test="${not empty c.actes}">
                            <ul class="list-disc ml-6 text-sm text-gray-700">
                                <c:forEach var="a" items="${c.actes}">
                                    <li>${a.type} — Cout: ${a.cout} DH</li>
                                </c:forEach>
                            </ul>
                        </c:when>
                        <c:otherwise>
                            <p class="text-gray-500 italic ml-4">Aucun acte technique.</p>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- Bouton pour voir le détail avec calcul de coût -->
                <button onclick="viewConsultationDetail(${c.id})"
                        class="bg-blue-500 hover:bg-blue-600 text-white px-4 py-2 rounded">
                    📊 Voir Détail & Coût
                </button>
            </div>
        </c:forEach>
    </section>

    <!-- Section: Recherche de Spécialistes -->
    <section id="specialistsSection" class="hidden bg-white shadow-lg rounded-lg p-6 border border-blue-200">
        <h2 class="text-2xl font-semibold mb-6 text-blue-900">🔍 Rechercher des Spécialistes</h2>

        <!-- Filtres de Recherche -->
        <div class="grid grid-cols-1 md:grid-cols-3 gap-4 mb-6 bg-gray-50 p-4 rounded">
            <div>
                <label class="block text-sm font-medium mb-2">Spécialité</label>
                <select id="specialtyFilter" class="w-full border border-gray-300 rounded px-3 py-2">
                    <option value="">Toutes les spécialités</option>
                    <option value="Cardiologie">Cardiologie</option>
                    <option value="Neurologie">Neurologie</option>
                    <option value="Pédiatrie">Pédiatrie</option>
                    <option value="Dermatologie">Dermatologie</option>
                    <option value="Radiologie">Radiologie</option>
                    <option value="Orthopédie">Orthopédie</option>
                </select>
            </div>
            <div>
                <label class="block text-sm font-medium mb-2">Tarif Maximum (DH)</label>
                <input type="number" id="priceFilter" class="w-full border border-gray-300 rounded px-3 py-2"
                       placeholder="Ex: 500" min="0">
            </div>
            <div class="flex items-end">
                <button onclick="searchSpecialists()"
                        class="w-full bg-blue-600 hover:bg-blue-700 text-white font-semibold px-4 py-2 rounded">
                    🔍 Rechercher
                </button>
            </div>
        </div>

        <!-- Résultats de Recherche -->
        <div id="specialistResults" class="space-y-4">
            <!-- Mock Data - Les résultats s'afficheront ici -->
            <div class="border border-gray-200 rounded-lg p-4 hover:shadow-md transition">
                <div class="flex justify-between items-start mb-3">
                    <div>
                        <h3 class="text-lg font-semibold text-gray-800">Dr. Ahmed Benali</h3>
                        <p class="text-sm text-blue-600">🩺 Cardiologie</p>
                    </div>
                    <div class="text-right">
                        <p class="text-lg font-bold text-green-600">350 DH</p>
                        <p class="text-xs text-gray-500">par consultation</p>
                    </div>
                </div>
                <p class="text-sm text-gray-600 mb-3">📍 Hôpital Ibn Sina, Rabat</p>
                <p class="text-sm text-gray-700 mb-3">
                    <span class="font-medium">Experience:</span> 15 ans |
                    <span class="font-medium">Note:</span> ⭐ 4.8/5
                </p>
                <button onclick="viewAvailableSlots(1, 'Dr. Ahmed Benali')"
                        class="bg-purple-500 hover:bg-purple-600 text-white px-4 py-2 rounded text-sm">
                    📅 Voir Créneaux Disponibles
                </button>
            </div>

            <div class="border border-gray-200 rounded-lg p-4 hover:shadow-md transition">
                <div class="flex justify-between items-start mb-3">
                    <div>
                        <h3 class="text-lg font-semibold text-gray-800">Dr. Fatima Zahra El Amrani</h3>
                        <p class="text-sm text-blue-600">🧠 Neurologie</p>
                    </div>
                    <div class="text-right">
                        <p class="text-lg font-bold text-green-600">450 DH</p>
                        <p class="text-xs text-gray-500">par consultation</p>
                    </div>
                </div>
                <p class="text-sm text-gray-600 mb-3">📍 Clinique Al Madina, Casablanca</p>
                <p class="text-sm text-gray-700 mb-3">
                    <span class="font-medium">Experience:</span> 12 ans |
                    <span class="font-medium">Note:</span> ⭐ 4.9/5
                </p>
                <button onclick="viewAvailableSlots(2, 'Dr. Fatima Zahra El Amrani')"
                        class="bg-purple-500 hover:bg-purple-600 text-white px-4 py-2 rounded text-sm">
                    📅 Voir Créneaux Disponibles
                </button>
            </div>

            <div class="border border-gray-200 rounded-lg p-4 hover:shadow-md transition">
                <div class="flex justify-between items-start mb-3">
                    <div>
                        <h3 class="text-lg font-semibold text-gray-800">Dr. Youssef Alaoui</h3>
                        <p class="text-sm text-blue-600">👶 Pédiatrie</p>
                    </div>
                    <div class="text-right">
                        <p class="text-lg font-bold text-green-600">300 DH</p>
                        <p class="text-xs text-gray-500">par consultation</p>
                    </div>
                </div>
                <p class="text-sm text-gray-600 mb-3">📍 Centre Médical Atlas, Marrakech</p>
                <p class="text-sm text-gray-700 mb-3">
                    <span class="font-medium">Experience:</span> 10 ans |
                    <span class="font-medium">Note:</span> ⭐ 4.7/5
                </p>
                <button onclick="viewAvailableSlots(3, 'Dr. Youssef Alaoui')"
                        class="bg-purple-500 hover:bg-purple-600 text-white px-4 py-2 rounded text-sm">
                    📅 Voir Créneaux Disponibles
                </button>
            </div>
        </div>
    </section>

    <!-- Section: Télé-Expertise -->
    <section id="teleExpertiseSection" class="hidden bg-white shadow-lg rounded-lg p-6 border border-blue-200">
        <h2 class="text-2xl font-semibold mb-6 text-blue-900">💬 Demandes de Télé-Expertise</h2>

        <button onclick="openTeleExpertiseModal()"
                class="mb-6 bg-green-500 hover:bg-green-600 text-white font-semibold px-6 py-3 rounded-lg">
            ➕ Créer une Nouvelle Demande
        </button>

        <!-- Liste des Demandes Existantes -->
        <div class="space-y-4">
            <h3 class="text-lg font-semibold text-gray-700 mb-3">Mes Demandes</h3>

            <div class="border border-gray-200 rounded-lg p-4 bg-yellow-50">
                <div class="flex justify-between items-start mb-2">
                    <div>
                        <p class="font-semibold text-gray-800">Cas Complexe de Cardiologie</p>
                        <p class="text-sm text-gray-600">Patient: Mohammed Tazi (ID: 1234)</p>
                    </div>
                    <span class="bg-yellow-500 text-white px-3 py-1 rounded text-sm">En attente</span>
                </div>
                <p class="text-sm text-gray-700 mb-2">
                    <span class="font-medium">Spécialiste demandé:</span> Dr. Ahmed Benali (Cardiologie)
                </p>
                <p class="text-sm text-gray-600 mb-2">
                    <span class="font-medium">Date:</span> 2025-10-14 10:30
                </p>
                <p class="text-sm text-gray-700">
                    Patient de 65 ans avec douleurs thoraciques récurrentes, ECG anormal...
                </p>
            </div>

            <div class="border border-gray-200 rounded-lg p-4 bg-green-50">
                <div class="flex justify-between items-start mb-2">
                    <div>
                        <p class="font-semibold text-gray-800">Consultation Pédiatrique</p>
                        <p class="text-sm text-gray-600">Patient: Sara Idrissi (ID: 5678)</p>
                    </div>
                    <span class="bg-green-500 text-white px-3 py-1 rounded text-sm">Répondue</span>
                </div>
                <p class="text-sm text-gray-700 mb-2">
                    <span class="font-medium">Spécialiste:</span> Dr. Youssef Alaoui (Pédiatrie)
                </p>
                <p class="text-sm text-gray-600 mb-2">
                    <span class="font-medium">Date:</span> 2025-10-13 15:00
                </p>
                <p class="text-sm text-gray-700 mb-3">
                    Fièvre persistante chez un enfant de 5 ans...
                </p>
                <button class="bg-blue-500 hover:bg-blue-600 text-white px-4 py-1 rounded text-sm">
                    📄 Voir la Réponse
                </button>
            </div>

            <div class="border border-gray-200 rounded-lg p-4 bg-blue-50">
                <div class="flex justify-between items-start mb-2">
                    <div>
                        <p class="font-semibold text-gray-800">Avis Dermatologique</p>
                        <p class="text-sm text-gray-600">Patient: Amina Benzakour (ID: 9012)</p>
                    </div>
                    <span class="bg-blue-500 text-white px-3 py-1 rounded text-sm">En cours</span>
                </div>
                <p class="text-sm text-gray-700 mb-2">
                    <span class="font-medium">Spécialiste:</span> Dr. Leila Mansouri (Dermatologie)
                </p>
                <p class="text-sm text-gray-600 mb-2">
                    <span class="font-medium">Date:</span> 2025-10-15 09:00
                </p>
                <p class="text-sm text-gray-700">
                    Lésions cutanées suspectes nécessitant un avis spécialisé...
                </p>
            </div>
        </div>
    </section>
</main>

<!-- Consultation Modal -->
<div id="consultationModal" class="hidden fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
    <div class="bg-white rounded-lg p-6 w-11/12 md:w-3/4 lg:w-1/2 shadow-lg max-h-[80vh] overflow-y-auto">
        <h3 id="consultationTitle" class="text-xl font-semibold mb-4 text-blue-900">Créer une Consultation</h3>

        <form id="consultationForm" action="${pageContext.request.contextPath}/consultation/store" method="post">
            <input type="hidden" id="patientId" name="patientId">

            <div class="mb-4">
                <label class="block font-medium mb-2">Observation</label>
                <textarea name="observations" id="observations" class="w-full border rounded p-2" rows="3" required></textarea>
            </div>
            <div class="mb-4">
                <label class="block font-medium mb-2">Motif</label>
                <textarea name="motif" class="w-full border rounded p-2" rows="3" required></textarea>
            </div>
            <div class="mb-4">
                <h4 class="text-lg font-semibold mb-2">Actes Techniques</h4>
                <c:forEach var="acte" items="${actes}">
                    <div class="flex items-center mb-2">
                        <input type="checkbox" name="actes" value="${acte}" class="mr-2">
                        <label class="font-medium">${acte}</label>
                    </div>
                </c:forEach>
            </div>

            <div class="flex justify-end space-x-3">
                <button type="button" id="cancelConsultation" class="px-4 py-2 bg-gray-400 text-white rounded">Annuler</button>
                <button type="submit" class="px-4 py-2 bg-blue-600 text-white rounded">Cloturer</button>
            </div>
        </form>
    </div>
</div>

<!-- Modal: Créneaux Disponibles -->
<div id="slotsModal" class="hidden fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
    <div class="bg-white rounded-lg p-6 w-11/12 md:w-3/4 lg:w-1/2 shadow-lg max-h-[80vh] overflow-y-auto">
        <h3 id="slotsTitle" class="text-xl font-semibold mb-4 text-blue-900">📅 Créneaux Disponibles</h3>

        <div class="mb-4 bg-gray-50 p-4 rounded">
            <p class="text-sm text-gray-600 mb-2">Sélectionnez une date:</p>
            <input type="date" id="slotDate" class="w-full border border-gray-300 rounded px-3 py-2">
        </div>

        <div id="slotsContent" class="space-y-3">
            <!-- Créneaux du matin -->
            <div>
                <h4 class="font-semibold text-gray-700 mb-2">🌅 Matin</h4>
                <div class="grid grid-cols-3 gap-2">
                    <button class="slot-btn bg-green-100 hover:bg-green-200 border border-green-300 rounded px-3 py-2 text-sm">
                        09:00 - 09:30
                    </button>
                    <button class="slot-btn bg-green-100 hover:bg-green-200 border border-green-300 rounded px-3 py-2 text-sm">
                        09:30 - 10:00
                    </button>
                    <button class="slot-btn bg-green-100 hover:bg-green-200 border border-green-300 rounded px-3 py-2 text-sm">
                        10:00 - 10:30
                    </button>
                    <button class="slot-btn bg-gray-200 border border-gray-300 rounded px-3 py-2 text-sm cursor-not-allowed" disabled>
                        10:30 - 11:00 ❌
                    </button>
                    <button class="slot-btn bg-green-100 hover:bg-green-200 border border-green-300 rounded px-3 py-2 text-sm">
                        11:00 - 11:30
                    </button>
                    <button class="slot-btn bg-green-100 hover:bg-green-200 border border-green-300 rounded px-3 py-2 text-sm">
                        11:30 - 12:00
                    </button>
                </div>
            </div>

            <!-- Créneaux de l'après-midi -->
            <div>
                <h4 class="font-semibold text-gray-700 mb-2">🌞 Après-midi</h4>
                <div class="grid grid-cols-3 gap-2">
                    <button class="slot-btn bg-green-100 hover:bg-green-200 border border-green-300 rounded px-3 py-2 text-sm">
                        14:00 - 14:30
                    </button>
                    <button class="slot-btn bg-green-100 hover:bg-green-200 border border-green-300 rounded px-3 py-2 text-sm">
                        14:30 - 15:00
                    </button>
                    <button class="slot-btn bg-gray-200 border border-gray-300 rounded px-3 py-2 text-sm cursor-not-allowed" disabled>
                        15:00 - 15:30 ❌
                    </button>
                    <button class="slot-btn bg-green-100 hover:bg-green-200 border border-green-300 rounded px-3 py-2 text-sm">
                        15:30 - 16:00
                    </button>
                    <button class="slot-btn bg-green-100 hover:bg-green-200 border border-green-300 rounded px-3 py-2 text-sm">
                        16:00 - 16:30
                    </button>
                    <button class="slot-btn bg-green-100 hover:bg-green-200 border border-green-300 rounded px-3 py-2 text-sm">
                        16:30 - 17:00
                    </button>
                </div>
            </div>
        </div>

        <div class="mt-6 flex justify-end space-x-3">
            <button type="button" onclick="closeSlotsModal()" class="px-4 py-2 bg-gray-400 text-white rounded">Fermer</button>
        </div>
    </div>
</div>

<!-- Modal: Créer Télé-Expertise -->
<div id="teleExpertiseModal" class="hidden fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
    <div class="bg-white rounded-lg p-6 w-11/12 md:w-3/4 lg:w-1/2 shadow-lg max-h-[80vh] overflow-y-auto">
        <h3 class="text-xl font-semibold mb-4 text-blue-900">💬 Créer une Demande de Télé-Expertise</h3>

        <form id="teleExpertiseForm">
            <div class="mb-4">
                <label class="block font-medium mb-2">Patient</label>
                <select class="w-full border border-gray-300 rounded px-3 py-2" required>
                    <option value="">Sélectionner un patient</option>
                    <option value="1234">Mohammed Tazi (ID: 1234)</option>
                    <option value="5678">Sara Idrissi (ID: 5678)</option>
                    <option value="9012">Amina Benzakour (ID: 9012)</option>
                </select>
            </div>

            <div class="mb-4">
                <label class="block font-medium mb-2">Spécialité Demandée</label>
                <select class="w-full border border-gray-300 rounded px-3 py-2" required>
                    <option value="">Sélectionner une spécialité</option>
                    <option value="Cardiologie">Cardiologie</option>
                    <option value="Neurologie">Neurologie</option>
                    <option value="Pédiatrie">Pédiatrie</option>
                    <option value="Dermatologie">Dermatologie</option>
                    <option value="Radiologie">Radiologie</option>
                    <option value="Orthopédie">Orthopédie</option>
                </select>
            </div>

            <div class="mb-4">
                <label class="block font-medium mb-2">Spécialiste (optionnel)</label>
                <select class="w-full border border-gray-300 rounded px-3 py-2">
                    <option value="">N'importe quel spécialiste</option>
                    <option value="1">Dr. Ahmed Benali</option>
                    <option value="2">Dr. Fatima Zahra El Amrani</option>
                    <option value="3">Dr. Youssef Alaoui</option>
                </select>
            </div>

            <div class="mb-4">
                <label class="block font-medium mb-2">Niveau d'Urgence</label>
                <select class="w-full border border-gray-300 rounded px-3 py-2" required>
                    <option value="URGENT">🔴 Urgent (< 24h)</option>
                    <option value="NORMAL" selected>🟡 Normal (< 72h)</option>
                    <option value="NON_URGENT">🟢 Non urgent (< 1 semaine)</option>
                </select>
            </div>

            <div class="mb-4">
                <label class="block font-medium mb-2">Objet de la Demande</label>
                <input type="text" class="w-full border border-gray-300 rounded px-3 py-2"
                       placeholder="Ex: Avis sur un cas complexe de cardiologie" required>
            </div>

            <div class="mb-4">
                <label class="block font-medium mb-2">Description Détaillée</label>
                <textarea class="w-full border border-gray-300 rounded px-3 py-2" rows="5"
                          placeholder="Décrivez le cas du patient, antécédents, symptômes, examens réalisés..." required></textarea>
            </div>

            <div class="mb-4">
                <label class="block font-medium mb-2">Documents Joints (optionnel)</label>
                <input type="file" multiple class="w-full border border-gray-300 rounded px-3 py-2">
                <p class="text-xs text-gray-500 mt-1">Formats acceptés: PDF, JPG, PNG (Max 10MB)</p>
            </div>

            <div class="flex justify-end space-x-3">
                <button type="button" onclick="closeTeleExpertiseModal()"
                        class="px-4 py-2 bg-gray-400 text-white rounded">Annuler</button>
                <button type="submit" class="px-4 py-2 bg-green-600 hover:bg-green-700 text-white rounded">
                    ✅ Envoyer la Demande
                </button>
            </div>
        </form>
    </div>
</div>

<!-- Modal: Détail Consultation avec Coût -->
<div id="consultationDetailModal" class="hidden fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
    <div class="bg-white rounded-lg p-6 w-11/12 md:w-3/4 lg:w-2/3 shadow-lg max-h-[80vh] overflow-y-auto">
        <h3 class="text-xl font-semibold mb-4 text-blue-900">📊 Détail de Consultation & Calcul des Coûts</h3>

        <div class="space-y-4">
            <!-- Informations Patient -->
            <div class="bg-blue-50 p-4 rounded">
                <h4 class="font-semibold text-blue-900 mb-2">👤 Informations Patient</h4>
                <div class="grid grid-cols-2 gap-2 text-sm">
                    <p><span class="font-medium">Nom:</span> Mohammed Tazi</p>
                    <p><span class="font-medium">CNI:</span> AB123456</p>
                    <p><span class="font-medium">Date de naissance:</span> 15/03/1985</p>
                    <p><span class="font-medium">Âge:</span> 40 ans</p>
                </div>
            </div>

            <!-- Informations Consultation -->
            <div class="bg-green-50 p-4 rounded">
                <h4 class="font-semibold text-green-900 mb-2">📋 Détails de la Consultation</h4>
                <div class="text-sm space-y-2">
                    <p><span class="font-medium">Date:</span> 15/10/2025 10:30</p>
                    <p><span class="font-medium">Durée:</span> 30 minutes</p>
                    <p><span class="font-medium">Motif:</span> Douleurs thoraciques</p>
                    <p><span class="font-medium">Observations:</span> Patient présente des douleurs thoraciques intermittentes depuis 3 jours...</p>
                </div>
            </div>

            <!-- Actes Techniques & Coûts -->
            <div class="bg-yellow-50 p-4 rounded">
                <h4 class="font-semibold text-yellow-900 mb-3">💰 Actes Techniques & Coûts</h4>
                <table class="w-full text-sm">
                    <thead class="bg-yellow-100">
                    <tr>
                        <th class="text-left p-2">Acte</th>
                        <th class="text-right p-2">Quantité</th>
                        <th class="text-right p-2">Prix Unitaire</th>
                        <th class="text-right p-2">Total</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr class="border-b">
                        <td class="p-2">Consultation Générale</td>
                        <td class="text-right p-2">1</td>
                        <td class="text-right p-2">200 DH</td>
                        <td class="text-right p-2 font-semibold">200 DH</td>
                    </tr>
                    <tr class="border-b">
                        <td class="p-2">Électrocardiogramme (ECG)</td>
                        <td class="text-right p-2">1</td>
                        <td class="text-right p-2">150 DH</td>
                        <td class="text-right p-2 font-semibold">150 DH</td>
                    </tr>
                    <tr class="border-b">
                        <td class="p-2">Analyse Sanguine</td>
                        <td class="text-right p-2">1</td>
                        <td class="text-right p-2">250 DH</td>
                        <td class="text-right p-2 font-semibold">250 DH</td>
                    </tr>
                    <tr class="bg-yellow-200 font-bold">
                        <td colspan="3" class="text-right p-2">TOTAL</td>
                        <td class="text-right p-2 text-lg">600 DH</td>
                    </tr>
                    </tbody>
                </table>
            </div>

            <!-- Prescription -->
            <div class="bg-purple-50 p-4 rounded">
                <h4 class="font-semibold text-purple-900 mb-2">💊 Prescription</h4>
                <ul class="list-disc ml-6 text-sm">
                    <li>Aspirine 100mg - 1 comprimé/jour pendant 30 jours</li>
                    <li>Atorvastatine 20mg - 1 comprimé/soir pendant 90 jours</li>
                    <li>Repos recommandé - 48 heures</li>
                </ul>
            </div>

            <!-- Rendez-vous de Suivi -->
            <div class="bg-red-50 p-4 rounded">
                <h4 class="font-semibold text-red-900 mb-2">📅 Suivi</h4>
                <p class="text-sm">Rendez-vous de contrôle prévu le <span class="font-semibold">22/10/2025 à 10:00</span></p>
            </div>
        </div>

        <div class="mt-6 flex justify-end space-x-3">
            <button type="button" onclick="closeConsultationDetailModal()"
                    class="px-4 py-2 bg-gray-400 text-white rounded">Fermer</button>
            <button type="button" class="px-4 py-2 bg-blue-600 hover:bg-blue-700 text-white rounded">
                🖨️ Imprimer
            </button>
        </div>
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", () => {
        // Navigation entre sections
        const sections = {
            'tabPatients': 'patientsSection',
            'ConsultationsHistorice': 'consultationsSection',
            'tabSpecialists': 'specialistsSection',
            'tabTeleExpertise': 'teleExpertiseSection'
        };

        Object.keys(sections).forEach(btnId => {
            document.getElementById(btnId)?.addEventListener('click', () => {
                // Masquer toutes les sections
                Object.values(sections).forEach(sectionId => {
                    document.getElementById(sectionId)?.classList.add('hidden');
                });
                // Afficher la section sélectionnée
                document.getElementById(sections[btnId])?.classList.remove('hidden');
            });
        });

        // Modal de consultation
        window.openConsultationModal = (patientId, patientNom) => {
            document.getElementById('consultationModal').classList.remove('hidden');
            document.getElementById('patientId').value = patientId;
            document.getElementById('consultationTitle').textContent = "Créer une Consultation pour " + patientNom;
        };

        document.getElementById('cancelConsultation')?.addEventListener('click', () => {
            document.getElementById('consultationModal').classList.add('hidden');
        });

        // Recherche de spécialistes
        window.searchSpecialists = () => {
            const specialty = document.getElementById('specialtyFilter').value;
            const price = document.getElementById('priceFilter').value;
            alert(`Recherche: Spécialité=${specialty}, Prix Max=${price}DH\n(Logique de filtrage à implémenter)`);
        };

        // Modal créneaux disponibles
        window.viewAvailableSlots = (specialistId, specialistName) => {
            document.getElementById('slotsModal').classList.remove('hidden');
            document.getElementById('slotsTitle').textContent = `📅 Créneaux Disponibles - ${specialistName}`;
        };

        window.closeSlotsModal = () => {
            document.getElementById('slotsModal').classList.add('hidden');
        };

        // Sélection de créneau
        document.querySelectorAll('.slot-btn:not([disabled])').forEach(btn => {
            btn.addEventListener('click', (e) => {
                document.querySelectorAll('.slot-btn').forEach(b => b.classList.remove('bg-blue-500', 'text-white'));
                e.target.classList.add('bg-blue-500', 'text-white');
                alert(`Créneau sélectionné: ${e.target.textContent}`);
            });
        });

        // Modal télé-expertise
        window.openTeleExpertiseModal = () => {
            document.getElementById('teleExpertiseModal').classList.remove('hidden');
        };

        window.closeTeleExpertiseModal = () => {
            document.getElementById('teleExpertiseModal').classList.add('hidden');
        };

        document.getElementById('teleExpertiseForm')?.addEventListener('submit', (e) => {
            e.preventDefault();
            alert('Demande de télé-expertise envoyée avec succès!');
            closeTeleExpertiseModal();
        });

        // Modal détail consultation
        window.viewConsultationDetail = (consultationId) => {
            document.getElementById('consultationDetailModal').classList.remove('hidden');
        };

        window.closeConsultationDetailModal = () => {
            document.getElementById('consultationDetailModal').classList.add('hidden');
        };
    });
</script>

</body>
</html>