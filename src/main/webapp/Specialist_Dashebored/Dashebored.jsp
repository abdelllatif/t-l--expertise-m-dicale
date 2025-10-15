
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Tableau de Bord - Spécialiste</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 flex">

<!-- Sidebar -->
<aside class="w-64 bg-blue-900 text-white min-h-screen flex flex-col p-6 shadow-lg">
    <div class="mb-8 text-center">
        <img src="${pageContext.request.contextPath}/imgs/bloding.png" alt="Logo"
             class="mx-auto mb-4 w-32 h-24 object-contain rounded-lg shadow-md">
        <p class="text-lg font-semibold">Bonjour, Dr. Benali</p>
        <p class="text-sm text-purple-200">Spécialiste en Cardiologie</p>
    </div>
    <nav class="space-y-3">
        <button id="tabDashboard" class="w-full px-4 py-2 bg-purple-800 hover:bg-purple-700 rounded transition">
            📊 Tableau de Bord
        </button>
        <button id="tabProfile" class="w-full px-4 py-2 bg-purple-800 hover:bg-purple-700 rounded transition">
            ⚙️ Mon Profil
        </button>
        <button id="tabExpertiseRequests" class="w-full px-4 py-2 bg-purple-800 hover:bg-purple-700 rounded transition">
            📋 Demandes d'Expertise
        </button>
        <button id="tabStatistics" class="w-full px-4 py-2 bg-purple-800 hover:bg-purple-700 rounded transition">
            📈 Statistiques & Revenus
        </button>
    </nav>
    <div class="flex-1"></div>
    <div class="bg-red-500 hover:bg-red-600 text-white font-semibold px-4 py-2 rounded-lg text-center cursor-pointer transition"
         onclick="window.location.href='${pageContext.request.contextPath}/logout'">Déconnexion</div>
</aside>

<!-- Main Content -->
<main class="flex-1 p-8 space-y-8">
    <!-- Messages -->
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

    <!-- Dashboard Overview Section -->
    <section id="dashboardSection" class="space-y-6">
        <h1 class="text-3xl font-bold text-gray-800">📊 Vue d'ensemble</h1>

        <!-- Statistics Cards -->
        <div class="grid grid-cols-1 md:grid-cols-4 gap-6">
            <div class="bg-gradient-to-br from-blue-500 to-blue-600 text-white rounded-lg p-6 shadow-lg">
                <div class="flex justify-between items-start mb-2">
                    <div>
                        <p class="text-blue-100 text-sm">Demandes en attente</p>
                        <p class="text-3xl font-bold">12</p>
                    </div>
                    <i class="fas fa-clock text-3xl opacity-50"></i>
                </div>
                <p class="text-sm text-blue-100 mt-2">↑ 3 nouvelles aujourd'hui</p>
            </div>

            <div class="bg-gradient-to-br from-green-500 to-green-600 text-white rounded-lg p-6 shadow-lg">
                <div class="flex justify-between items-start mb-2">
                    <div>
                        <p class="text-green-100 text-sm">Expertises terminées</p>
                        <p class="text-3xl font-bold">147</p>
                    </div>
                    <i class="fas fa-check-circle text-3xl opacity-50"></i>
                </div>
                <p class="text-sm text-green-100 mt-2">Ce mois-ci</p>
            </div>

            <div class="bg-gradient-to-br from-purple-500 to-purple-600 text-white rounded-lg p-6 shadow-lg">
                <div class="flex justify-between items-start mb-2">
                    <div>
                        <p class="text-purple-100 text-sm">Revenus du mois</p>
                        <p class="text-3xl font-bold">47,250 DH</p>
                    </div>
                    <i class="fas fa-coins text-3xl opacity-50"></i>
                </div>
                <p class="text-sm text-purple-100 mt-2">↑ 12% vs mois dernier</p>
            </div>

            <div class="bg-gradient-to-br from-blue-500 to-purple-600 text-white rounded-lg p-6 shadow-lg">
                <div class="flex justify-between items-start mb-2">
                    <div>
                        <p class="text-orange-100 text-sm">Note moyenne</p>
                        <p class="text-3xl font-bold">4.8/5</p>
                    </div>
                    <i class="fas fa-star text-3xl opacity-50"></i>
                </div>
                <p class="text-sm text-orange-100 mt-2">⭐⭐⭐⭐⭐</p>
            </div>
        </div>

        <!-- Recent Activities -->
        <div class="bg-white shadow-lg rounded-lg p-6">
            <h2 class="text-xl font-semibold mb-4 text-gray-800">📌 Activités Récentes</h2>
            <div class="space-y-3">
                <div class="flex items-center justify-between p-3 bg-yellow-50 rounded border-l-4 border-yellow-500">
                    <div>
                        <p class="font-medium">Nouvelle demande d'expertise <span class="text-red-700 text-bold">urgente</span></p>
                        <p class="text-sm text-gray-600">Patient: Mohammed Tazi - Cas complexe de cardiologie</p>
                    </div>
                    <span class="text-xs text-gray-500">Il y a 5 min</span>
                </div>
                <div class="flex items-center justify-between p-3 bg-green-50 rounded border-l-4 border-green-500">
                    <div>
                        <p class="font-medium">Avis fourni - Cas pédiatrique</p>
                        <p class="text-sm text-gray-600">Patient: Sara Idrissi - Fièvre persistante</p>
                    </div>
                    <span class="text-xs text-gray-500">Il y a 2h</span>
                </div>
            </div>
        </div>
    </section>

    <!-- Profile Configuration Section -->
    <section id="profileSection" class="hidden bg-white shadow-lg rounded-lg p-6 border border-purple-200">
        <h2 class="text-2xl font-semibold mb-6 text-purple-900">⚙️ Configuration du Profil</h2>

        <form id="profileForm">
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <!-- Informations Personnelles -->
                <div class="space-y-4">
                    <h3 class="text-lg font-semibold text-gray-700 border-b pb-2">Informations Personnelles</h3>

                    <div>
                        <label class="block text-sm font-medium mb-2">Nom Complet</label>
                        <input type="text" class="w-full border border-gray-300 rounded px-3 py-2"
                               value="Dr. Ahmed Benali" readonly>
                    </div>

                    <div>
                        <label class="block text-sm font-medium mb-2">Email</label>
                        <input type="email" class="w-full border border-gray-300 rounded px-3 py-2"
                               value="ahmed.benali@hospital.ma">
                    </div>

                    <div>
                        <label class="block text-sm font-medium mb-2">Téléphone</label>
                        <input type="tel" class="w-full border border-gray-300 rounded px-3 py-2"
                               value="+212 6 12 34 56 78">
                    </div>

                    <div>
                        <label class="block text-sm font-medium mb-2">Adresse</label>
                        <textarea class="w-full border border-gray-300 rounded px-3 py-2" rows="2">Hôpital Ibn Sina, Rabat</textarea>
                    </div>
                </div>

                <!-- Informations Professionnelles -->
                <div class="space-y-4">
                    <h3 class="text-lg font-semibold text-gray-700 border-b pb-2">Informations Professionnelles</h3>

                    <div>
                        <label class="block text-sm font-medium mb-2">Spécialité Principale</label>
                        <select class="w-full border border-gray-300 rounded px-3 py-2">
                            <option selected>Cardiologie</option>
                            <option>Neurologie</option>
                            <option>Pédiatrie</option>
                            <option>Dermatologie</option>
                            <option>Radiologie</option>
                            <option>Orthopédie</option>
                        </select>
                    </div>

                    <div>
                        <label class="block text-sm font-medium mb-2">Sous-spécialités (optionnel)</label>
                        <select multiple class="w-full border border-gray-300 rounded px-3 py-2" size="3">
                            <option selected>Cardiologie interventionnelle</option>
                            <option>Électrophysiologie</option>
                            <option selected>Cardiologie pédiatrique</option>
                            <option>Insuffisance cardiaque</option>
                        </select>
                        <p class="text-xs text-gray-500 mt-1">Maintenez Ctrl pour sélectionner plusieurs</p>
                    </div>

                    <div>
                        <label class="block text-sm font-medium mb-2">Années d'Expérience</label>
                        <input type="number" class="w-full border border-gray-300 rounded px-3 py-2"
                               value="15" min="0">
                    </div>

                    <div>
                        <label class="block text-sm font-medium mb-2">Numéro d'Ordre</label>
                        <input type="text" class="w-full border border-gray-300 rounded px-3 py-2"
                               value="ORD-12345">
                    </div>
                </div>
            </div>

            <!-- Tarification -->
            <div class="mt-6 p-4 bg-green-50 rounded border border-green-200">
                <h3 class="text-lg font-semibold text-gray-700 mb-4">💰 Configuration des Tarifs</h3>
                <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                    <div>
                        <label class="block text-sm font-medium mb-2">Consultation en Cabinet</label>
                        <div class="flex items-center">
                            <input type="number" class="w-full border border-gray-300 rounded px-3 py-2"
                                   value="350" min="0">
                            <span class="ml-2 text-gray-600">DH</span>
                        </div>
                    </div>
                    <div>
                        <label class="block text-sm font-medium mb-2">Télé-Expertise</label>
                        <div class="flex items-center">
                            <input type="number" class="w-full border border-gray-300 rounded px-3 py-2"
                                   value="250" min="0">
                            <span class="ml-2 text-gray-600">DH</span>
                        </div>
                    </div>
                    <div>
                        <label class="block text-sm font-medium mb-2">Consultation Urgente</label>
                        <div class="flex items-center">
                            <input type="number" class="w-full border border-gray-300 rounded px-3 py-2"
                                   value="500" min="0">
                            <span class="ml-2 text-gray-600">DH</span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Disponibilité -->
            <div class="mt-6 p-4 bg-blue-50 rounded border border-blue-200">
                <h3 class="text-lg font-semibold text-gray-700 mb-4">📅 Disponibilité</h3>
                <div class="space-y-3">
                    <div class="flex items-center">
                        <input type="checkbox" id="lundi" checked class="mr-3">
                        <label for="lundi" class="flex-1 font-medium">Lundi</label>
                        <input type="time" value="09:00" class="border rounded px-2 py-1 mr-2">
                        <span class="mr-2">à</span>
                        <input type="time" value="17:00" class="border rounded px-2 py-1">
                    </div>
                    <div class="flex items-center">
                        <input type="checkbox" id="mardi" checked class="mr-3">
                        <label for="mardi" class="flex-1 font-medium">Mardi</label>
                        <input type="time" value="09:00" class="border rounded px-2 py-1 mr-2">
                        <span class="mr-2">à</span>
                        <input type="time" value="17:00" class="border rounded px-2 py-1">
                    </div>
                    <div class="flex items-center">
                        <input type="checkbox" id="mercredi" checked class="mr-3">
                        <label for="mercredi" class="flex-1 font-medium">Mercredi</label>
                        <input type="time" value="09:00" class="border rounded px-2 py-1 mr-2">
                        <span class="mr-2">à</span>
                        <input type="time" value="17:00" class="border rounded px-2 py-1">
                    </div>
                    <div class="flex items-center">
                        <input type="checkbox" id="jeudi" checked class="mr-3">
                        <label for="jeudi" class="flex-1 font-medium">Jeudi</label>
                        <input type="time" value="09:00" class="border rounded px-2 py-1 mr-2">
                        <span class="mr-2">à</span>
                        <input type="time" value="17:00" class="border rounded px-2 py-1">
                    </div>
                    <div class="flex items-center">
                        <input type="checkbox" id="vendredi" checked class="mr-3">
                        <label for="vendredi" class="flex-1 font-medium">Vendredi</label>
                        <input type="time" value="09:00" class="border rounded px-2 py-1 mr-2">
                        <span class="mr-2">à</span>
                        <input type="time" value="13:00" class="border rounded px-2 py-1">
                    </div>
                    <div class="flex items-center">
                        <input type="checkbox" id="samedi" class="mr-3">
                        <label for="samedi" class="flex-1 font-medium">Samedi</label>
                        <input type="time" value="09:00" class="border rounded px-2 py-1 mr-2" disabled>
                        <span class="mr-2">à</span>
                        <input type="time" value="13:00" class="border rounded px-2 py-1" disabled>
                    </div>
                </div>
            </div>

            <!-- Biography -->
            <div class="mt-6">
                <label class="block text-sm font-medium mb-2">Biographie / Présentation</label>
                <textarea class="w-full border border-gray-300 rounded px-3 py-2" rows="4"
                          placeholder="Présentez votre parcours, vos domaines d'expertise...">Cardiologue avec 15 ans d'expérience, spécialisé en cardiologie interventionnelle et électrophysiologie. Diplômé de la Faculté de Médecine de Rabat, j'ai effectué mes stages de spécialisation en France.</textarea>
            </div>

            <div class="mt-6 flex justify-end space-x-3">
                <button type="button" class="px-6 py-2 bg-gray-400 hover:bg-gray-500 text-white rounded">
                    Annuler
                </button>
                <button type="submit" class="px-6 py-2 bg-purple-600 hover:bg-purple-700 text-white rounded">
                    💾 Enregistrer les Modifications
                </button>
            </div>
        </form>
    </section>

    <!-- Expertise Requests Section -->
    <section id="expertiseRequestsSection" class="hidden space-y-6">
        <div class="flex justify-between items-center">
            <h1 class="text-3xl font-bold text-gray-800">📋 Demandes d'Expertise</h1>

            <!-- Filtres -->
            <div class="flex space-x-3">
                <select id="statusFilter" class="border border-gray-300 rounded px-4 py-2">
                    <option value="">Tous les statuts</option>
                    <option value="EN_ATTENTE">🟡 En attente</option>
                    <option value="EN_COURS">🔵 En cours</option>
                    <option value="TERMINEE">🟢 Terminée</option>
                    <option value="URGENT">🔴 Urgent</option>
                </select>
                <button onclick="applyFilters()" class="bg-purple-600 hover:bg-purple-700 text-white px-4 py-2 rounded">
                    Filtrer
                </button>
            </div>
        </div>

        <!-- Liste des Demandes -->
        <div class="space-y-4" id="expertiseList">
            <!-- Demande Urgente -->
            <div class="bg-white shadow-lg rounded-lg p-6 border-l-4 border-red-500 hover:shadow-xl transition">
                <div class="flex justify-between items-start mb-3">
                    <div class="flex-1">
                        <div class="flex items-center mb-2">
                            <h3 class="text-lg font-semibold text-gray-800">Cas Complexe de Cardiologie</h3>
                            <span class="ml-3 bg-red-500 text-white px-3 py-1 rounded-full text-xs font-semibold">
                                🔴 URGENT
                            </span>
                        </div>
                        <p class="text-sm text-gray-600">Demandé par: Dr. Samira El Fassi (Médecin Généraliste)</p>
                        <p class="text-sm text-gray-600">Patient: Mohammed Tazi (ID: 1234) - Homme, 65 ans</p>
                    </div>
                    <div class="text-right">
                        <p class="text-sm text-gray-500">15/10/2025 10:30</p>
                        <p class="text-lg font-bold text-green-600 mt-1">250 DH</p>
                    </div>
                </div>

                <div class="mb-3 p-3 bg-gray-50 rounded">
                    <p class="text-sm text-gray-700">
                        <span class="font-medium">Description:</span> Patient de 65 ans avec douleurs thoraciques récurrentes depuis 3 jours.
                        ECG anormal avec élévation du segment ST. Antécédents: HTA, diabète type 2...
                    </p>
                </div>

                <div class="flex justify-end space-x-3">
                    <button onclick="viewExpertiseDetail(1)"
                            class="bg-blue-500 hover:bg-blue-600 text-white px-4 py-2 rounded text-sm">
                        📄 Voir Détails Complets
                    </button>
                    <button onclick="provideExpertise(1)"
                            class="bg-green-500 hover:bg-green-600 text-white px-4 py-2 rounded text-sm">
                        ✍️ Fournir un Avis
                    </button>
                </div>
            </div>

            <!-- Demande En Attente -->
            <div class="bg-white shadow-lg rounded-lg p-6 border-l-4 border-yellow-500 hover:shadow-xl transition">
                <div class="flex justify-between items-start mb-3">
                    <div class="flex-1">
                        <div class="flex items-center mb-2">
                            <h3 class="text-lg font-semibold text-gray-800">Consultation Pédiatrique</h3>
                            <span class="ml-3 bg-yellow-500 text-white px-3 py-1 rounded-full text-xs font-semibold">
                                🟡 EN_ATTENTE
                            </span>
                        </div>
                        <p class="text-sm text-gray-600">Demandé par: Dr. Karim Benjelloun (Pédiatre)</p>
                        <p class="text-sm text-gray-600">Patient: Sara Idrissi (ID: 5678) - Fille, 5 ans</p>
                    </div>
                    <div class="text-right">
                        <p class="text-sm text-gray-500">14/10/2025 14:20</p>
                        <p class="text-lg font-bold text-green-600 mt-1">250 DH</p>
                    </div>
                </div>

                <div class="mb-3 p-3 bg-gray-50 rounded">
                    <p class="text-sm text-gray-700">
                        <span class="font-medium">Description:</span> Enfant de 5 ans avec fièvre persistante (39°C) depuis 5 jours.
                        Toux sèche, fatigue. Traitement antibiotique sans amélioration...
                    </p>
                </div>

                <div class="flex justify-end space-x-3">
                    <button onclick="viewExpertiseDetail(2)"
                            class="bg-blue-500 hover:bg-blue-600 text-white px-4 py-2 rounded text-sm">
                        📄 Voir Détails Complets
                    </button>
                    <button onclick="provideExpertise(2)"
                            class="bg-green-500 hover:bg-green-600 text-white px-4 py-2 rounded text-sm">
                        ✍️ Fournir un Avis
                    </button>
                </div>
            </div>

            <!-- Demande Terminée -->
            <div class="bg-white shadow-lg rounded-lg p-6 border-l-4 border-green-500 hover:shadow-xl transition opacity-75">
                <div class="flex justify-between items-start mb-3">
                    <div class="flex-1">
                        <div class="flex items-center mb-2">
                            <h3 class="text-lg font-semibold text-gray-800">Avis Dermatologique</h3>
                            <span class="ml-3 bg-green-500 text-white px-3 py-1 rounded-full text-xs font-semibold">
                                🟢 TERMINEE
                            </span>
                        </div>
                        <p class="text-sm text-gray-600">Demandé par: Dr. Nadia Alami (Dermatologue)</p>
                        <p class="text-sm text-gray-600">Patient: Amina Benzakour (ID: 9012) - Femme, 42 ans</p>
                    </div>
                    <div class="text-right">
                        <p class="text-sm text-gray-500">12/10/2025 09:15</p>
                        <p class="text-lg font-bold text-green-600 mt-1">250 DH</p>
                    </div>
                </div>

                <div class="mb-3 p-3 bg-green-50 rounded">
                    <p class="text-sm text-gray-700">
                        <span class="font-medium">Votre Avis:</span> Lésions cutanées compatibles avec un eczéma atopique modéré.
                        Recommandations: Dermocorticoïdes topiques classe II, émollients quotidiens...
                    </p>
                </div>

                <div class="flex justify-end space-x-3">
                    <button onclick="viewExpertiseDetail(3)"
                            class="bg-blue-500 hover:bg-blue-600 text-white px-4 py-2 rounded text-sm">
                        📄 Voir Détails
                    </button>
                </div>
            </div>
        </div>
    </section>

    <!-- Statistics Section -->
    <section id="statisticsSection" class="hidden space-y-6">
        <h1 class="text-3xl font-bold text-gray-800">📈 Statistiques & Revenus</h1>

        <!-- Period Filter -->
        <div class="bg-white shadow-lg rounded-lg p-4">
            <div class="flex items-center space-x-4">
                <label class="font-medium">Période:</label>
                <select class="border border-gray-300 rounded px-4 py-2">
                    <option>Ce mois</option>
                    <option>Mois dernier</option>
                    <option>3 derniers mois</option>
                    <option>6 derniers mois</option>
                    <option>Cette année</option>
                </select>
                <button class="bg-purple-600 hover:bg-purple-700 text-white px-4 py-2 rounded">
                    Appliquer
                </button>
            </div>
        </div>

        <!-- Revenue Statistics -->
        <div class="bg-white shadow-lg rounded-lg p-6">
            <h2 class="text-xl font-semibold mb-4">💰 Revenus</h2>
            <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                <div class="bg-gradient-to-br from-green-100 to-green-200 p-4 rounded-lg">
                    <p class="text-sm text-green-700 mb-1">Revenus du Mois</p>
                    <p class="text-3xl font-bold text-green-800">47,250 DH</p>
                    <p class="text-sm text-green-600 mt-2">↑ 12% vs mois dernier</p>
                </div>
                <div class="bg-gradient-to-br from-blue-100 to-blue-200 p-4 rounded-lg">
                    <p class="text-sm text-blue-700 mb-1">Revenus de l'Année</p>
                    <p class="text-3xl font-bold text-blue-800">485,600 DH</p>
                    <p class="text-sm text-blue-600 mt-2">↑ 8% vs année dernière</p>
                </div>
                <div class="bg-gradient-to-br from-purple-100 to-purple-200 p-4 rounded-lg">
                    <p class="text-sm text-purple-700 mb-1">Revenu Moyen/Expertise</p>
                    <p class="text-3xl font-bold text-purple-800">321 DH</p>
                    <p class="text-sm text-purple-600 mt-2">Basé sur 147 expertises</p>
                </div>
            </div>
        </div>

        <!-- Expertise Statistics -->
        <div class="bg-white shadow-lg rounded-lg p-6">
            <h2 class="text-xl font-semibold mb-4">📊 Statistiques des Expertises</h2>
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <div>
                    <h3 class="font-semibold text-gray-700 mb-3">Par Statut</h3>
                    <div class="space-y-2">
                        <div class="flex justify-between items-center p-2 bg-yellow-50 rounded">
                            <span class="text-sm">🟡 En attente</span>
                            <span class="font-bold">12</span>
                        </div>
                        <div class="flex justify-between items-center p-2 bg-blue-50 rounded">
                            <span class="text-sm">🔵 En cours</span>
                            <span class="font-bold">8</span>
                        </div>
                        <div class="flex justify-between items-center p-2 bg-green-50 rounded">
                            <span class="text-sm">🟢 Terminées</span>
                            <span class="font-bold">147</span>
                        </div>
                        <div class="flex justify-between items-center p-2 bg-red-50 rounded">
                            <span class="text-sm">🔴 Urgentes</span>
                            <span class="font-bold">5</span>
                        </div>
                    </div>
                </div>

                <div>
                    <h3 class="font-semibold text-gray-700 mb-3">Temps de Réponse Moyen</h3>
                    <div class="space-y-2">
                        <div class="flex justify-between items-center p-2 bg-gray-50 rounded">
                            <span class="text-sm">Expertises normales</span>
                            <span class="font-bold text-blue-600">4.2 heures</span>
                        </div>
                        <div class="flex justify-between items-center p-2 bg-gray-50 rounded">
                            <span class="text-sm">Expertises urgentes</span>
                            <span class="font-bold text-red-600">45 minutes</span>
                        </div>
                        <div class="flex justify-between items-center p-2 bg-gray-50 rounded">
                            <span class="text-sm">Satisfaction client</span>
                            <span class="font-bold text-green-600">96%</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Monthly Chart Placeholder -->
        <div class="bg-white shadow-lg rounded-lg p-6">
            <h2 class="text-xl font-semibold mb-4">📈 Evolution Mensuelle</h2>
            <div class="bg-gray-100 rounded-lg p-8 text-center">
                <p class="text-gray-500">Graphique des revenus et expertises mensuels</p>
                <p class="text-sm text-gray-400 mt-2">(Intégration Chart.js à venir)</p>
            </div>
        </div>

        <!-- Top Requesting Doctors -->
        <div class="bg-white shadow-lg rounded-lg p-6">
            <h2 class="text-xl font-semibold mb-4">👨‍⚕️ Médecins Demandeurs Fréquents</h2>
            <div class="space-y-3">
                <div class="flex justify-between items-center p-3 bg-gray-50 rounded">
                    <div>
                        <p class="font-medium">Dr. Samira El Fassi</p>
                        <p class="text-sm text-gray-600">Médecin Généraliste - Rabat</p>
                    </div>
                    <span class="font-bold text-purple-600">23 demandes</span>
                </div>
                <div class="flex justify-between items-center p-3 bg-gray-50 rounded">
                    <div>
                        <p class="font-medium">Dr. Karim Benjelloun</p>
                        <p class="text-sm text-gray-600">Pédiatre - Casablanca</p>
                    </div>
                    <span class="font-bold text-purple-600">18 demandes</span>
                </div>
                <div class="flex justify-between items-center p-3 bg-gray-50 rounded">
                    <div>
                        <p class="font-medium">Dr. Nadia Alami</p>
                        <p class="text-sm text-gray-600">Dermatologue - Marrakech</p>
                    </div>
                    <span class="font-bold text-purple-600">15 demandes</span>
                </div>
            </div>
        </div>
    </section>
</main>

<!-- Modal: Voir Détail d'une Demande d'Expertise -->
<div id="expertiseDetailModal" class="hidden fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
    <div class="bg-white rounded-lg p-6 w-11/12 md:w-4/5 lg:w-3/4 shadow-lg max-h-[90vh] overflow-y-auto">
        <h3 class="text-2xl font-semibold mb-4 text-purple-900">📋 Détail de la Demande d'Expertise</h3>

        <div class="space-y-6">
            <!-- Informations de la Demande -->
            <div class="bg-purple-50 p-4 rounded-lg">
                <h4 class="font-semibold text-purple-900 mb-3">📌 Informations de la Demande</h4>
                <div class="grid grid-cols-2 gap-3 text-sm">
                    <p><span class="font-medium">ID Demande:</span> #EXP-2025-001234</p>
                    <p><span class="font-medium">Date:</span> 15/10/2025 10:30</p>
                    <p><span class="font-medium">Médecin demandeur:</span> Dr. Samira El Fassi</p>
                    <p><span class="font-medium">Spécialité:</span> Médecine Générale</p>
                    <p><span class="font-medium">Urgence:</span> <span class="bg-red-500 text-white px-2 py-1 rounded text-xs">URGENT</span></p>
                    <p><span class="font-medium">Tarif:</span> 250 DH</p>
                </div>
            </div>

            <!-- Informations Patient -->
            <div class="bg-blue-50 p-4 rounded-lg">
                <h4 class="font-semibold text-blue-900 mb-3">👤 Dossier Patient Complet</h4>
                <div class="grid grid-cols-3 gap-3 text-sm mb-4">
                    <p><span class="font-medium">Nom:</span> Mohammed Tazi</p>
                    <p><span class="font-medium">Âge:</span> 65 ans</p>
                    <p><span class="font-medium">Sexe:</span> Homme</p>
                    <p><span class="font-medium">CNI:</span> AB123456</p>
                    <p><span class="font-medium">Téléphone:</span> +212 6 XX XX XX XX</p>
                    <p><span class="font-medium">Groupe sanguin:</span> O+</p>
                </div>

                <!-- Antécédents -->
                <div class="mb-3">
                    <p class="font-medium text-blue-900 mb-1">📝 Antécédents Médicaux:</p>
                    <ul class="list-disc ml-6 text-sm">
                        <li>Hypertension artérielle (depuis 10 ans)</li>
                        <li>Diabète type 2 (depuis 8 ans)</li>
                        <li>Hypercholestérolémie</li>
                        <li>Tabagisme actif (30 paquets-années)</li>
                    </ul>
                </div>

                <!-- Traitements en cours -->
                <div>
                    <p class="font-medium text-blue-900 mb-1">💊 Traitements en Cours:</p>
                    <ul class="list-disc ml-6 text-sm">
                        <li>Ramipril 10mg - 1x/jour</li>
                        <li>Metformine 1000mg - 2x/jour</li>
                        <li>Atorvastatine 40mg - 1x/soir</li>
                        <li>Aspirine 100mg - 1x/jour</li>
                    </ul>
                </div>
            </div>

            <!-- Signes Vitaux -->
            <div class="bg-green-50 p-4 rounded-lg">
                <h4 class="font-semibold text-green-900 mb-3">🩺 Signes Vitaux (Dernière Mesure)</h4>
                <div class="grid grid-cols-4 gap-3 text-sm">
                    <div class="bg-white p-2 rounded text-center">
                        <p class="text-gray-600 text-xs">Tension</p>
                        <p class="font-bold text-red-600">165/95 mmHg</p>
                    </div>
                    <div class="bg-white p-2 rounded text-center">
                        <p class="text-gray-600 text-xs">FC</p>
                        <p class="font-bold">92 bpm</p>
                    </div>
                    <div class="bg-white p-2 rounded text-center">
                        <p class="text-gray-600 text-xs">Température</p>
                        <p class="font-bold">37.2°C</p>
                    </div>
                    <div class="bg-white p-2 rounded text-center">
                        <p class="text-gray-600 text-xs">SpO2</p>
                        <p class="font-bold">96%</p>
                    </div>
                </div>
            </div>

            <!-- Description du Cas -->
            <div class="bg-yellow-50 p-4 rounded-lg">
                <h4 class="font-semibold text-yellow-900 mb-3">📋 Description du Cas</h4>
                <p class="text-sm leading-relaxed">
                    Patient de 65 ans, diabétique et hypertendu, consultant pour des douleurs thoraciques récurrentes
                    depuis 3 jours. Douleur rétrosternale constrictive, irradiant vers le bras gauche, déclenchée par
                    l'effort et soulagée au repos. Durée: 5-10 minutes par épisode. Pas de dyspnée, ni nausées, ni sueurs.<br><br>

                    <span class="font-medium">Examen clinique:</span><br>
                    - TA: 165/95 mmHg, FC: 92/min, régulière<br>
                    - Auscultation cardiaque: B1-B2 normaux, pas de souffle<br>
                    - Auscultation pulmonaire: normale<br>
                    - Pas d'œdème des membres inférieurs<br><br>

                    <span class="font-medium">ECG réalisé:</span><br>
                    Rythme sinusal, FC 90/min, élévation discrète du segment ST en DII, DIII, aVF.<br>
                    Ondes T négatives en V5-V6.
                </p>
            </div>

            <!-- Documents Joints -->
            <div class="bg-gray-50 p-4 rounded-lg">
                <h4 class="font-semibold text-gray-900 mb-3">📎 Documents Joints</h4>
                <div class="space-y-2">
                    <div class="flex items-center justify-between p-2 bg-white rounded border">
                        <div class="flex items-center">
                            <i class="fas fa-file-pdf text-red-500 text-xl mr-3"></i>
                            <div>
                                <p class="text-sm font-medium">ECG_Patient_Tazi.pdf</p>
                                <p class="text-xs text-gray-500">2.3 MB - 15/10/2025</p>
                            </div>
                        </div>
                        <button class="text-blue-600 hover:text-blue-800 text-sm">
                            <i class="fas fa-download"></i> Télécharger
                        </button>
                    </div>
                    <div class="flex items-center justify-between p-2 bg-white rounded border">
                        <div class="flex items-center">
                            <i class="fas fa-file-image text-blue-500 text-xl mr-3"></i>
                            <div>
                                <p class="text-sm font-medium">Radiographie_Thorax.jpg</p>
                                <p class="text-xs text-gray-500">1.8 MB - 15/10/2025</p>
                            </div>
                        </div>
                        <button class="text-blue-600 hover:text-blue-800 text-sm">
                            <i class="fas fa-download"></i> Télécharger
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <div class="mt-6 flex justify-end space-x-3">
            <button type="button" onclick="closeExpertiseDetailModal()"
                    class="px-6 py-2 bg-gray-400 hover:bg-gray-500 text-white rounded">
                Fermer
            </button>
            <button type="button" onclick="provideExpertise(1)"
                    class="px-6 py-2 bg-green-600 hover:bg-green-700 text-white rounded">
                ✍️ Fournir un Avis d'Expert
            </button>
        </div>
    </div>
</div>

<!-- Modal: Fournir un Avis d'Expert -->
<div id="provideExpertiseModal" class="hidden fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
    <div class="bg-white rounded-lg p-6 w-11/12 md:w-3/4 lg:w-2/3 shadow-lg max-h-[90vh] overflow-y-auto">
        <h3 class="text-2xl font-semibold mb-4 text-green-900">✍️ Fournir un Avis d'Expert</h3>

        <form id="expertiseForm">
            <!-- Résumé du Cas -->
            <div class="mb-4 p-3 bg-blue-50 rounded">
                <p class="text-sm"><span class="font-medium">Patient:</span> Mohammed Tazi (65 ans)</p>
                <p class="text-sm"><span class="font-medium">Cas:</span> Douleurs thoraciques récurrentes</p>
            </div>

            <!-- Diagnostic -->
            <div class="mb-4">
                <label class="block font-medium mb-2 text-gray-700">🔍 Diagnostic / Impression Clinique</label>
                <textarea class="w-full border border-gray-300 rounded px-3 py-2" rows="3"
                          placeholder="Indiquez votre diagnostic ou impression clinique..." required></textarea>
            </div>

            <!-- Analyse -->
            <div class="mb-4">
                <label class="block font-medium mb-2 text-gray-700">📋 Analyse Détaillée</label>
                <textarea class="w-full border border-gray-300 rounded px-3 py-2" rows="5"
                          placeholder="Fournissez une analyse détaillée du cas: symptômes, examens, facteurs de risque..." required></textarea>
            </div>

            <!-- Recommandations -->
            <div class="mb-4">
                <label class="block font-medium mb-2 text-gray-700">💡 Recommandations</label>
                <textarea class="w-full border border-gray-300 rounded px-3 py-2" rows="5"
                          placeholder="Vos recommandations thérapeutiques et de prise en charge..." required></textarea>
            </div>

            <!-- Examens Complémentaires -->
            <div class="mb-4">
                <label class="block font-medium mb-2 text-gray-700">🔬 Examens Complémentaires Suggérés</label>
                <textarea class="w-full border border-gray-300 rounded px-3 py-2" rows="3"
                          placeholder="Indiquez les examens complémentaires à réaliser (si nécessaire)..."></textarea>
            </div>

            <!-- Urgence de Prise en Charge -->
            <div class="mb-4">
                <label class="block font-medium mb-2 text-gray-700">⚠️ Niveau d'Urgence de la Prise en Charge</label>
                <select class="w-full border border-gray-300 rounded px-3 py-2" required>
                    <option value="">Sélectionner...</option>
                    <option value="IMMEDIATE">🔴 Immédiate (Urgence vitale - < 1h)</option>
                    <option value="URGENT">🟠 Urgente (< 24h)</option>
                    <option value="RAPIDE">🟡 Rapide (< 72h)</option>
                    <option value="NORMAL">🟢 Normale (consultation programmée)</option>
                </select>
            </div>

            <!-- Suivi -->
            <div class="mb-4">
                <label class="block font-medium mb-2 text-gray-700">📅 Suivi Recommandé</label>
                <input type="text" class="w-full border border-gray-300 rounded px-3 py-2"
                       placeholder="Ex: Consultation de contrôle dans 1 semaine">
            </div>

            <!-- Notes Additionnelles -->
            <div class="mb-4">
                <label class="block font-medium mb-2 text-gray-700">📝 Notes Additionnelles (Optionnel)</label>
                <textarea class="w-full border border-gray-300 rounded px-3 py-2" rows="2"
                          placeholder="Remarques ou informations complémentaires..."></textarea>
            </div>

            <!-- Pièces Jointes -->
            <div class="mb-4">
                <label class="block font-medium mb-2 text-gray-700">📎 Documents à Joindre (Optionnel)</label>
                <input type="file" multiple class="w-full border border-gray-300 rounded px-3 py-2">
                <p class="text-xs text-gray-500 mt-1">Formats: PDF, JPG, PNG (Max 10MB par fichier)</p>
            </div>

            <div class="flex justify-end space-x-3">
                <button type="button" onclick="closeProvideExpertiseModal()"
                        class="px-6 py-2 bg-gray-400 hover:bg-gray-500 text-white rounded">
                    Annuler
                </button>
                <button type="submit" class="px-6 py-2 bg-green-600 hover:bg-green-700 text-white rounded">
                    ✅ Envoyer l'Avis d'Expert
                </button>
            </div>
        </form>
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", () => {
        // Navigation entre sections
        const sections = {
            'tabDashboard': 'dashboardSection',
            'tabProfile': 'profileSection',
            'tabExpertiseRequests': 'expertiseRequestsSection',
            'tabStatistics': 'statisticsSection'
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

        // Profile Form Submit
        document.getElementById('profileForm')?.addEventListener('submit', (e) => {
            e.preventDefault();
            alert('✅ Profil mis à jour avec succès!\n(Backend à implémenter)');
        });

        // Filter Expertise Requests
        window.applyFilters = () => {
            const status = document.getElementById('statusFilter').value;
            alert(`Filtrage par statut: ${status || 'Tous'}\n(Logique de filtrage à implémenter)`);
        };

        // View Expertise Detail Modal
        window.viewExpertiseDetail = (expertiseId) => {
            document.getElementById('expertiseDetailModal').classList.remove('hidden');
        };

        window.closeExpertiseDetailModal = () => {
            document.getElementById('expertiseDetailModal').classList.add('hidden');
        };

        // Provide Expertise Modal
        window.provideExpertise = (expertiseId) => {
            document.getElementById('expertiseDetailModal')?.classList.add('hidden');
            document.getElementById('provideExpertiseModal').classList.remove('hidden');
        };

        window.closeProvideExpertiseModal = () => {
            document.getElementById('provideExpertiseModal').classList.add('hidden');
        };

        // Submit Expertise
        document.getElementById('expertiseForm')?.addEventListener('submit', (e) => {
            e.preventDefault();
            alert('✅ Avis d\'expert envoyé avec succès!\n(Backend à implémenter)');
            closeProvideExpertiseModal();
        });

        // Enable/Disable schedule inputs based on checkbox
        ['samedi'].forEach(day => {
            document.getElementById(day)?.addEventListener('change', (e) => {
                const inputs = e.target.parentElement.querySelectorAll('input[type="time"]');
                inputs.forEach(input => input.disabled = !e.target.checked);
            });
        });
    });
</script>

</body>
</html>