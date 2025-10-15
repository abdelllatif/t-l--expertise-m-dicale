package org.tele.expertise.demo;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.tele.expertise.demo.enums.StatutFileAttente;
import org.tele.expertise.demo.model.ActeTechnique;
import org.tele.expertise.demo.model.Consultation;
import org.tele.expertise.demo.model.Medecin;
import org.tele.expertise.demo.model.Patient;
import org.tele.expertise.demo.enums.StatutConsultation;
import org.tele.expertise.demo.enums.Acte;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import org.tele.expertise.demo.repository.ConsultationRepository;
import org.tele.expertise.demo.repository.FileAttenteRepository;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/consultation/store")
public class ConsultationController extends HttpServlet {

    private final EntityManagerFactory emf = Persistence.createEntityManagerFactory("tele_expertise");



@Override
public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {

    try {
        request.getRequestDispatcher("/WEB-INF/views/consultationsToday.jsp").forward(request, response);
    } catch (Exception e) {
        e.printStackTrace();
        response.getWriter().write("Erreur lors du chargement des consultations.");
    }
}

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long patientId = Long.parseLong(request.getParameter("patientId"));
        String observations = request.getParameter("observations");
        String motif = request.getParameter("motif");
        String[] actesSelected = request.getParameterValues("actes");

        EntityManager em = emf.createEntityManager();
        String errorMessage = null;

        try {
            em.getTransaction().begin();

            Patient patient = em.find(Patient.class, patientId);
            Medecin medecin = em.find(Medecin.class, 1L);

            ConsultationRepository repo = new ConsultationRepository();
            Consultation consultation = repo.saveConsultation(patient, medecin, motif, observations, actesSelected);

            em.getTransaction().commit();
            FileAttenteRepository fileRepo=new FileAttenteRepository();
            StatutFileAttente newStatusStr= StatutFileAttente.TERMINEE;
            boolean updated = fileRepo.updateStatus(patientId, newStatusStr.name());

            request.getSession().setAttribute("messageSuccess", "Consultation enregistrée avec succès !");

        } catch (Exception ex) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            ex.printStackTrace();
            errorMessage = ex.toString();
            request.getSession().setAttribute("messageError", "Échec de l'enregistrement de la consultation : " + errorMessage);

        } finally {
            em.close();
        }

        response.sendRedirect(request.getContextPath() + "/Dashebored/Medecin");
    }

}
