package org.tele.expertise.demo;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.tele.expertise.demo.model.FileAttente;
import org.tele.expertise.demo.model.Patient;
import org.tele.expertise.demo.model.SigneVital;
import org.tele.expertise.demo.repository.FileAttenteRepository;
import org.tele.expertise.demo.repository.PatientRpository;
import org.tele.expertise.demo.repository.SigneVitalRepository;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

@WebServlet(name = "patient", value = "/patient")
public class PatientController extends HttpServlet {

    private final PatientRpository patientRpository;

    public PatientController() {
        this.patientRpository = new PatientRpository();
    }

    /**
     * Handle POST: new patient or existing patient + vitals
     */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse respo) throws IOException, ServletException {
        String patientType = req.getParameter("patientType");

        if ("new".equals(patientType)) {
            handleNewPatient(req, respo);
        } else if ("existing".equals(patientType)) {
            handleExistingPatient(req, respo);
        }
    }

    private void handleNewPatient(HttpServletRequest req, HttpServletResponse respo) throws ServletException, IOException {
        String nom = req.getParameter("nom");
        String prenom = req.getParameter("prenom");
        String ageString = req.getParameter("age");
        String cniNumero = req.getParameter("numCIN");
        String telephone = req.getParameter("telephone");
        String adresse = req.getParameter("adresse");

        // Champs des signes vitaux
        String tension = req.getParameter("tension");
        String frequenceCardiaque = req.getParameter("frequence");
        String temperature = req.getParameter("temperature");
        String frequenceRespiratoire = req.getParameter("frequenceResp");
        String poids = req.getParameter("poids");
        String taille = req.getParameter("taille");

        if (nom == null || prenom == null || cniNumero == null || ageString == null) {
            req.setAttribute("error", "Tous les champs obligatoires doivent être remplis !");
            req.getRequestDispatcher("/Infermier_Dashebored/Dahsebored.jsp").forward(req, respo);
            return;
        }

        int age = Integer.parseInt(ageString);
        Patient patient = new Patient();
        patient.setNom(nom.trim());
        patient.setPrenom(prenom.trim());
        patient.setAge(age);
        patient.setCniNumero(cniNumero.trim());
        patient.setTelephone(telephone != null ? telephone.trim() : null);
        patient.setAdresse(adresse != null ? adresse.trim() : null);
        patient.setCreatedAt(LocalDateTime.now());

        try {
            Patient savedPatient = patientRpository.addPatient(patient);
            if (savedPatient != null && savedPatient.getId() != null) {

                FileAttente fa = new FileAttente();
                fa.setPatient(savedPatient);
                fa.setDateArrivee(LocalDateTime.now());
                FileAttenteRepository faRepo=new FileAttenteRepository();
                Boolean added = faRepo.addFileAttente(fa);
                if (added == null || !added) {
                    req.setAttribute("error", "Erreur lors de l'ajout à la file d'attente !");
                    req.getRequestDispatcher("/Infermier_Dashebored/Dahsebored.jsp").forward(req, respo);
                    return;
                }
                // Now we can save the vital signs
                SigneVital signeVital = new SigneVital();
                signeVital.setTensionArt(Double.parseDouble(tension));
                signeVital.setFrequenceCardiaque(Integer.parseInt(frequenceCardiaque));
                signeVital.setTemperature(Double.parseDouble(temperature));
                signeVital.setFrequenceRespiratoire(Integer.parseInt(frequenceRespiratoire));
                signeVital.setPoids(Double.parseDouble(poids));
                signeVital.setTaille(Double.parseDouble(taille));
                signeVital.setPatient(savedPatient);

                new SigneVitalRepository().addSigneVital(signeVital);

                req.setAttribute("message", "Patient et signes vitaux ajoutés avec succès !");
            } else {
                req.setAttribute("error", "Erreur lors de l'ajout du patient !");
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Une erreur s'est produite lors de l'ajout du patient !");
        }

        req.getRequestDispatcher("/Infermier_Dashebored/Dahsebored.jsp").forward(req, respo);
    }

    private void handleExistingPatient(HttpServletRequest req, HttpServletResponse respo) throws ServletException, IOException {
        String patientIdStr = req.getParameter("patientId");
        if (patientIdStr == null || patientIdStr.trim().isEmpty()) {
            req.setAttribute("error", "Veuillez sélectionner un patient existant !");
            req.getRequestDispatcher("/Infermier_Dashebored/Dahsebored.jsp").forward(req, respo);
            return;
        }

        Long patientId = Long.parseLong(patientIdStr);


        // Champs vitaux
        String tension = req.getParameter("tension");
        String frequenceCardiaque = req.getParameter("frequence");
        String temperature = req.getParameter("temperature");
        String frequenceRespiratoire = req.getParameter("frequenceResp");
        String poids = req.getParameter("poids");
        String taille = req.getParameter("taille");

        Patient patient=new PatientRpository().finById(patientId);
        if (patient == null) {
            req.setAttribute("error", "Patient introuvable !");
            req.getRequestDispatcher("/Infermier_Dashebored/Dahsebored.jsp").forward(req, respo);
            return;
        }

        FileAttenteRepository faRepo = new FileAttenteRepository();
        if (faRepo.findByIdForToday(patientId)) {
            req.setAttribute("error", "Ce patient est déjà ajouté dans la file d'attente aujourd'hui !");
            req.getRequestDispatcher("/Infermier_Dashebored/Dahsebored.jsp").forward(req, respo);
            return;
        }
        FileAttente fa = new FileAttente();
        fa.setPatient(patient);
        fa.setDateArrivee(LocalDateTime.now());
        Boolean added = faRepo.addFileAttente(fa);
        if (added == null || !added) {
            req.setAttribute("error", "Erreur lors de l'ajout à la file d'attente !");
            req.getRequestDispatcher("/Infermier_Dashebored/Dahsebored.jsp").forward(req, respo);
            return;
        }

        SigneVital signeVital = new SigneVital();
        signeVital.setTensionArt(Double.parseDouble(tension));
        signeVital.setFrequenceCardiaque(Integer.parseInt(frequenceCardiaque));
        signeVital.setTemperature(Double.parseDouble(temperature));
        signeVital.setFrequenceRespiratoire(Integer.parseInt(frequenceRespiratoire));
        signeVital.setPoids(Double.parseDouble(poids));
        signeVital.setTaille(Double.parseDouble(taille));
        signeVital.setPatient(patient);

        new SigneVitalRepository().addSigneVital(signeVital);

        req.setAttribute("message", "Signes vitaux ajoutés avec succès !");
        req.getRequestDispatcher("/Infermier_Dashebored/Dahsebored.jsp").forward(req, respo);
    }

}
