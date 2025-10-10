package org.tele.expertise.demo.repository;

import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import org.mindrot.jbcrypt.BCrypt;
import org.tele.expertise.demo.model.Infirmier;
import org.tele.expertise.demo.util.JpaUtil;

public class InfirmierRepository {

    public InfirmierRepository() {}

    public Infirmier login(String email, String password) {
        EntityManager em = JpaUtil.getEntityManager();

        if (em == null) {
            return null;
        }

        try {
            Infirmier infirmier = em.createQuery(
                            "SELECT i FROM Infirmier i WHERE i.email = :email", Infirmier.class)
                    .setParameter("email", email)
                    .getSingleResult();

            if (BCrypt.checkpw(password, infirmier.getPassword())) {
                System.out.println("Found Infirmier: " + infirmier.getEmail() + " / " + infirmier.getPassword());
                return infirmier;
            } else {
                return null;
            }

        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }
}
