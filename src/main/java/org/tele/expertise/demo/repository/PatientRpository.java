package org.tele.expertise.demo.repository;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import org.tele.expertise.demo.model.Infirmier;
import org.tele.expertise.demo.model.Patient;
import org.tele.expertise.demo.util.JpaUtil;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PatientRpository {

    public PatientRpository(){

    }


    public Patient addPatient(Patient patient) {
        EntityManager em = JpaUtil.getEntityManager();
        if (em == null) return null;

        EntityTransaction et = em.getTransaction();
        try {
            et.begin();
            em.persist(patient);
            et.commit();
            return patient; // now returns patient with generated ID
        } catch (Exception e) {
            if (et.isActive()) et.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
        return null;
    }



    public Map<Long,Patient> allPatient(){
        EntityManager em=JpaUtil.getEntityManager();
        Map<Long,Patient> listOfPatient=new HashMap<>();
        List<Patient> patients=em.createQuery("select p from Patient p",Patient.class).getResultList();
        for(Patient p: patients){
           listOfPatient.put(p.getId(),p);
        }
        return listOfPatient;
    }


    public Patient finById(Long id){
        EntityManager em=JpaUtil.getEntityManager();
       Patient patient=em.createQuery("select p from Patient p where p.id=:id",Patient.class).setParameter("id",id).getSingleResult();
       return patient;
    }


}
