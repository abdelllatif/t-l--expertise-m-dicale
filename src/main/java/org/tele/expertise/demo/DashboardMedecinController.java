package org.tele.expertise.demo;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.http.HttpServletRequest;
import org.tele.expertise.demo.enums.Acte;
import org.tele.expertise.demo.model.Consultation;
import org.tele.expertise.demo.model.FileAttente;
import org.tele.expertise.demo.model.Patient;
import org.tele.expertise.demo.model.SigneVital;
import org.tele.expertise.demo.repository.ConsultationRepository;
import org.tele.expertise.demo.repository.FileAttenteRepository;
import org.tele.expertise.demo.repository.PatientRpository;
import org.tele.expertise.demo.repository.SigneVitalRepository;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@WebServlet(name = "dashboardMedecin", value = "/Dashebored/Medecin")
public class DashboardMedecinController extends HttpServlet {




    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        FileAttenteRepository fileRepo = new FileAttenteRepository();
        SigneVitalRepository svRepo = new SigneVitalRepository();

        List<FileAttente> files = fileRepo.listAllPatientsToday();
        List<Consultation> consultations = new ConsultationRepository().getTodayConsultationsBasic();

        consultations.forEach(c -> {
            c.setActes(new ConsultationRepository().getActesByConsultation(c.getId()));
            c.getPatient().setSignesVitaux(
                    new ConsultationRepository().getSignesVitauxByPatient(c.getPatient().getId())
            );
        });
        files.forEach(f -> {
            Patient p = f.getPatient();
            List<SigneVital> todayVitals = svRepo.getTodayByPatient(p.getId());
            p.setSignesVitaux(todayVitals);
        });
        request.setAttribute("actes", Acte.values());
        request.setAttribute("consultations",consultations);
        request.setAttribute("files", files);
        request.getRequestDispatcher("/Medecin_Dashebored/Dashebored.jsp").forward(request, response);
    }





}

