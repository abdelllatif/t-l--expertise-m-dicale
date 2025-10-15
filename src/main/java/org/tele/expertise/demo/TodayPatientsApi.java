package org.tele.expertise.demo;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.tele.expertise.demo.model.FileAttente;
import org.tele.expertise.demo.repository.FileAttenteRepository;
import org.w3c.dom.stylesheets.LinkStyle;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "todayPatientsApi", value = "/api/todayPatients")
public class TodayPatientsApi extends HttpServlet {

    private final FileAttenteRepository fileRepo = new FileAttenteRepository();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        List<FileAttente> todayList = fileRepo.listOfToday();

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        StringBuilder sb = new StringBuilder();
        sb.append("[");
        for (int i = 0; i < todayList.size(); i++) {
            FileAttente f = todayList.get(i);
            sb.append("{")
                    .append("\"id\":").append(f.getId()).append(",")
                    .append("\"nom\":\"").append(f.getPatient().getNom()).append("\",")
                    .append("\"prenom\":\"").append(f.getPatient().getPrenom()).append("\",")
                    .append("\"cni\":\"").append(f.getPatient().getCniNumero()).append("\",")
                    .append("\"dateArrivee\":\"").append(f.getDateArrivee()).append("\",")
                    .append("\"status\":\"").append(f.getStatus()).append("\"")
                    .append("}");
            if (i < todayList.size() - 1) sb.append(",");
        }
        sb.append("]");
        resp.getWriter().write(sb.toString());
    }
}
