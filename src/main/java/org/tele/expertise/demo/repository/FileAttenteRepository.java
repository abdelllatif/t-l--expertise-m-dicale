package org.tele.expertise.demo.repository;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import org.tele.expertise.demo.enums.StatutFileAttente;
import org.tele.expertise.demo.model.Consultation;
import org.tele.expertise.demo.model.FileAttente;
import org.tele.expertise.demo.model.SigneVital;
import org.tele.expertise.demo.util.JpaUtil;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Collections;
import java.util.List;
import java.util.Map;

public class FileAttenteRepository {

    EntityManager em = JpaUtil.getEntityManager();

    public Boolean addFileAttente(FileAttente fl) {

        if (em == null) {
            return null;
        }
        EntityTransaction et = em.getTransaction();
        try {
            et.begin();
            em.persist(fl);
            et.commit();
            System.out.println(" Patient ajouté à la file d'attente avec succès !");
            return true;
        } catch (Exception e) {
            if (et.isActive()) et.rollback();
            e.printStackTrace();
            System.err.println(" Erreur lors de l'ajout du patient à la file d'attente !");
            return false;
        }
    }

    public List<FileAttente> listOfToday() {

        LocalDate today = LocalDate.now();
        LocalDateTime startOfDay = today.atStartOfDay();
        LocalDateTime endOfDay = today.plusDays(1).atStartOfDay();

        List<FileAttente> list = em.createQuery(
                        "SELECT f FROM FileAttente f " +
                                "JOIN FETCH f.patient p " +
                                "WHERE f.dateArrivee >= :start AND f.dateArrivee < :end",
                        FileAttente.class
                )
                .setParameter("start", startOfDay)
                .setParameter("end", endOfDay)
                .getResultList();

        return list;
    }

    public Boolean findByIdForToday(Long patientId) {
        if (em == null) return null;

        LocalDate today = LocalDate.now();
        LocalDateTime startOfDay = today.atStartOfDay();
        LocalDateTime endOfDay = today.plusDays(1).atStartOfDay();

        List<FileAttente> list = em.createQuery(
                        "SELECT f FROM FileAttente f " +
                                "WHERE f.patient.id = :patientId " +
                                "AND f.dateArrivee >= :start AND f.dateArrivee < :end",
                        FileAttente.class)
                .setParameter("patientId", patientId)
                .setParameter("start", startOfDay)
                .setParameter("end", endOfDay)
                .getResultList();

        return !list.isEmpty();
    }


    public boolean updateStatus(Long patientId, String newStatus) {
        if (em == null) return false;
        EntityTransaction et = em.getTransaction();

        LocalDate today = LocalDate.now();
        LocalDateTime startOfDay = today.atStartOfDay();
        LocalDateTime endOfDay = today.plusDays(1).atStartOfDay();

        try {
            et.begin();

            List<FileAttente> list = em.createQuery(
                            "SELECT f FROM FileAttente f " +
                                    "WHERE f.patient.id = :pid " +
                                    "AND f.dateArrivee >= :startOfDay AND f.dateArrivee < :endOfDay",
                            FileAttente.class
                    )
                    .setParameter("pid", patientId)
                    .setParameter("startOfDay", startOfDay)
                    .setParameter("endOfDay", endOfDay)
                    .getResultList();

            if (list.isEmpty()) {
                System.err.println(" Aucun dossier trouvé pour le patient " + patientId + " aujourd'hui.");
                et.rollback();
                return false;
            }

            for (FileAttente f : list) {
                f.setStatus(Enum.valueOf(StatutFileAttente.class, newStatus));
                em.merge(f);
            }

            et.commit();
            System.out.println(" Statut mis à jour avec succès pour le patient " + patientId);
            return true;

        } catch (Exception e) {
            if (et.isActive()) et.rollback();
            e.printStackTrace();
            return false;
        }
    }



    public List<FileAttente> listAllPatientsToday() {
        if (em == null) return Collections.emptyList();

        LocalDate today = LocalDate.now();
        LocalDateTime startOfDay = today.atStartOfDay();
        LocalDateTime endOfDay = today.plusDays(1).atStartOfDay();

        String q = "SELECT DISTINCT f FROM FileAttente f " +
                "JOIN FETCH f.patient p " +
                "LEFT JOIN FETCH p.signesVitaux s " +
                "WHERE f.dateArrivee >= :startOfDay " +
                "AND f.dateArrivee < :endOfDay " +
                "ORDER BY f.dateArrivee DESC";

        return em.createQuery(q, FileAttente.class)
                .setParameter("startOfDay", startOfDay)
                .setParameter("endOfDay", endOfDay)
                .getResultList();
    }

    public List<Consultation> getTodayConsultations(Long patientId) {
        LocalDate today = LocalDate.now();
        LocalDateTime startOfDay = today.atStartOfDay();
        LocalDateTime endOfDay = today.plusDays(1).atStartOfDay();

        String q = "SELECT c FROM Consultation c " +
                "WHERE c.patient.id = :pid " +
                "AND c.dateConsultation >= :startOfDay " +
                "AND c.dateConsultation < :endOfDay";

        return em.createQuery(q, Consultation.class)
                .setParameter("pid", patientId)
                .setParameter("startOfDay", startOfDay)
                .setParameter("endOfDay", endOfDay)
                .getResultList();
    }

}
