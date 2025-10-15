package org.tele.expertise.demo;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.tele.expertise.demo.repository.FileAttenteRepository;

import java.io.IOException;

@WebServlet(name = "updateFileStatus", value = "/api/updateFileStatus")
public class UpdateFileStatusServlet extends HttpServlet {

    private final FileAttenteRepository fileRepo = new FileAttenteRepository();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            String idParam = req.getParameter("id");
            String status = req.getParameter("status");

            if (idParam == null || status == null) {
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                resp.getWriter().write(" Paramètres manquants !");
                return;
            }

            Long id = Long.parseLong(idParam);
            boolean ok = fileRepo.updateStatus(id, status);

            if (ok) {
                resp.setStatus(HttpServletResponse.SC_OK);
                resp.getWriter().write(" Statut mis à jour avec succès !");
            } else {
                resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                resp.getWriter().write(" Erreur lors de la mise à jour !");
            }

        } catch (NumberFormatException e) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            resp.getWriter().write(" ID invalide !");
        } catch (Exception e) {
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter().write(" Erreur serveur !");
            e.printStackTrace();
        }
    }
}
