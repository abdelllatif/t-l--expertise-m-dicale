package org.tele.expertise.demo.repository;

import jakarta.persistence.EntityManager;
import org.tele.expertise.demo.model.*;
import org.tele.expertise.demo.enums.Acte;
import org.tele.expertise.demo.util.JpaUtil;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.*;

public class ConsultationRepository {

    private final EntityManager em;

    public ConsultationRepository() {
        this.em = JpaUtil.getEntityManager();
    }

    public Consultation saveConsultation(Patient patient, Medecin medecin, String motif, String observations, String[] actesSelected) throws Exception {
        if (patient == null) throw new Exception("Patient null !");
        if (medecin == null) throw new Exception("Médecin null !");
        if (motif == null || motif.isEmpty()) throw new Exception("Motif vide !");

        Consultation consultation = new Consultation();
        consultation.setPatient(patient);
        consultation.setMedecin(medecin);
        consultation.setMotif(motif);
        consultation.setObservations(observations);

        List<ActeTechnique> actesSet = new ArrayList<>();
        double totalActes = 0.0;

        if (actesSelected != null) {
            for (String acteName : actesSelected) {
                try {
                    Acte acteEnum = Acte.valueOf(acteName);

                    ActeTechnique acteTechnique = new ActeTechnique();
                    acteTechnique.setType(acteEnum);
                    acteTechnique.setConsultation(consultation);

                    double coutActe = getCoutParActe(acteEnum);
                    acteTechnique.setCout(coutActe);
                    totalActes += coutActe;

                    actesSet.add(acteTechnique);
                } catch (IllegalArgumentException e) {
                    throw new Exception("Acte invalide: " + acteName);
                }
            }
        }

        double total = Consultation.cout + totalActes;
        consultation.setCoutTotal(total);
        consultation.setActes(actesSet); // ✅ maintenant c’est un Set

        em.persist(consultation);

        return consultation;
    }

    private double getCoutParActe(Acte acte) {
        switch (acte) {
            case ECHOGRAPHIE: return 150.0;
            case ANALYSE_SANG: return 100.0;
            case IRM: return 500.0;
            case ANALYSE_URINE: return 800.0;
            case DERMATOLOGIQUE_LASER: return 200.0;
            case ELECTROCARDIOGRAMME: return 100.0;
            case FOND_D_OEIL: return 900.0;
            case RADIOGRAPHIE: return 400.0;
            default: return 0.0;
        }
    }

    public List<Consultation> getTodayConsultationsBasic() {
        if (em == null) return Collections.emptyList();

        LocalDate today = LocalDate.now();
        LocalDateTime startOfDay = today.atStartOfDay();
        LocalDateTime endOfDay = today.plusDays(1).atStartOfDay();

        String jpql = "SELECT DISTINCT c FROM Consultation c " +
                "JOIN FETCH c.patient p " +
                "WHERE c.dateConsultation >= :startOfDay AND c.dateConsultation < :endOfDay " +
                "ORDER BY c.dateConsultation DESC";

        return em.createQuery(jpql, Consultation.class)
                .setParameter("startOfDay", startOfDay)
                .setParameter("endOfDay", endOfDay)
                .getResultList();
    }


    public List<ActeTechnique> getActesByConsultation(Long consultationId) {
        return em.createQuery(
                        "SELECT a FROM ActeTechnique a WHERE a.consultation.id = :id", ActeTechnique.class)
                .setParameter("id", consultationId)
                .getResultList();
    }

    public List<SigneVital> getSignesVitauxByPatient(Long patientId) {
        return em.createQuery(
                        "SELECT s FROM SigneVital s WHERE s.patient.id = :id", SigneVital.class)
                .setParameter("id", patientId)
                .getResultList();
    }


}
