package org.tele.expertise.demo.util;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class JpaUtil {
    private static EntityManagerFactory emf;

    static {
        try {
            emf = Persistence.createEntityManagerFactory("tele_expertise");
            System.out.println("EMF created successfully!");

        } catch (Exception e) {
            System.err.println("Erreur lors de la création de l'EntityManagerFactory : ");
            e.printStackTrace();
            emf = null;
        }
    }

    public static EntityManager getEntityManager() {
        if (emf != null) {
            return emf.createEntityManager();
        }
        return null;
    }

    public static boolean isConnected() {
        return emf != null;
    }
}
