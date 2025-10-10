package org.tele.expertise.demo.repository;

import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import org.mindrot.jbcrypt.BCrypt;
import org.tele.expertise.demo.model.Medecin;
import org.tele.expertise.demo.util.JpaUtil;

import java.sql.SQLException;

public class MedecinRepository {

    public MedecinRepository() {}

    public Medecin login(String email, String password) {
        EntityManager em = JpaUtil.getEntityManager();
        if(em==null){
            return null;
        }
        try {
            Medecin medecin =em.createQuery("select m from Medecin m where m.email=:email",Medecin.class).setParameter("email",email).getSingleResult();

        if(BCrypt.checkpw(password, medecin.getPassword())){
            return medecin;
        }
        else return null;
        }catch (NoResultException e){
            return null;
        }
    }
}
