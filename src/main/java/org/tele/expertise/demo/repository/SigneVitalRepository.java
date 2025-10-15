package org.tele.expertise.demo.repository;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import org.tele.expertise.demo.model.SigneVital;
import org.tele.expertise.demo.util.JpaUtil;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Collections;
import java.util.List;

public class SigneVitalRepository {

    EntityManager em = JpaUtil.getEntityManager();

    public Boolean addSigneVital(SigneVital signeVital) {

        EntityManager em = JpaUtil.getEntityManager();
        if (em == null) {
            return null;
        }
        EntityTransaction et = em.getTransaction();
        try {
            et.begin();
            em.persist(signeVital);
            et.commit();
            return true;
        } catch (Exception e) {
            if (et.isActive()) et.rollback();
            e.printStackTrace();
        }
        return null;
    }



    public List<SigneVital> getTodayByPatient(Long patientId) {
        if (em == null) return Collections.emptyList();

        LocalDate today = LocalDate.now();
        LocalDateTime startOfDay = today.atStartOfDay();
        LocalDateTime endOfDay = today.plusDays(1).atStartOfDay();

        return em.createQuery(
                        "SELECT s FROM SigneVital s WHERE s.patient.id = :pid " +
                                "AND s.dateMesure >= :start AND s.dateMesure < :end " +
                                "ORDER BY s.dateMesure DESC",
                        SigneVital.class)
                .setParameter("pid", patientId)
                .setParameter("start", startOfDay)
                .setParameter("end", endOfDay)
                .getResultList();
    }
}
