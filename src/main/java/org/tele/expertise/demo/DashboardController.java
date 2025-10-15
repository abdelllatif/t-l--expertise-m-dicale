package org.tele.expertise.demo;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.tele.expertise.demo.model.FileAttente;
import org.tele.expertise.demo.model.Patient;
import org.tele.expertise.demo.repository.FileAttenteRepository;
import org.tele.expertise.demo.repository.PatientRpository;

import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet(name = "dashboard", value = "/Dashebored/Infermier")
public class DashboardController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {


        List<FileAttente> todayList = new FileAttenteRepository().listOfToday();
        req.setAttribute("listOftoday",todayList);
        Map<Long, Patient> patients = new PatientRpository().allPatient();
        req.setAttribute("patients", patients);
        req.getRequestDispatcher("/Infermier_Dashebored/Dahsebored.jsp").forward(req, resp);
    }
}
