package org.tele.expertise.demo;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import org.tele.expertise.demo.model.Infirmier;
import org.tele.expertise.demo.repository.InfirmierRepository;
import org.tele.expertise.demo.repository.MedecinRepository;
import org.tele.expertise.demo.util.JpaUtil;

import java.io.IOException;

@WebServlet(name = "login", value = "/login")
public class LoginController extends HttpServlet {

    private InfirmierRepository infirmierRepository;
    private MedecinRepository medecinRepository;

    @Override
    public void init() throws ServletException {
        infirmierRepository = new InfirmierRepository();
        medecinRepository = new MedecinRepository();
    }

    // Handle GET request (show login page or redirect if already logged in)
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false); // don’t create a new session
        if (session != null && session.getAttribute("role") != null) {
            String role = (String) session.getAttribute("role");

            if ("infirmier".equals(role)) {
                resp.sendRedirect(req.getContextPath() + "/Dashebored/Infermier");
                return;
            } else if ("medecin".equals(role)) {
                resp.sendRedirect(req.getContextPath() + "/Dashebored/Medecin");
                return;
            }
        }

        // Not logged in → show login page
        req.getRequestDispatcher("/Login/login.jsp").forward(req, resp);
    }

    // Handle POST request (process login)
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String role = req.getParameter("role"); // get the selected role from JSP

        // Check database connection
        if (!JpaUtil.isConnected()) {
            resp.sendRedirect("errors/disconnected.jsp");
            return;
        }

        try {
            Object user = null;

            // Authenticate based on role
            if ("infirmier".equals(role)) {
                user = this.infirmierRepository.login(email, password);
            } else if ("medecin".equals(role)) {
                user = this.medecinRepository.login(email, password);
            }

            System.out.println("User object: " + user);
            System.out.println("Email from form: " + email);
            System.out.println("Password from form: " + password);
            System.out.println("Role from form: " + role);

            if (user != null) {
                HttpSession session = req.getSession();
                session.setAttribute("user", user);   // store logged-in user
                session.setAttribute("role", role);   // store role for redirect checks

                // Redirect to dashboard based on role
                if ("infirmier".equals(role)) {
                    resp.sendRedirect(req.getContextPath() + "/Dashebored/Infermier");
                } else if ("medecin".equals(role)) {
                    resp.sendRedirect(req.getContextPath() + "/Medecin_Dashboard/Dashebored.jsp");
                }

            } else {
                // Invalid login
                req.setAttribute("error", "Email or Password Fault!");
                req.getRequestDispatcher("/Login/login.jsp").forward(req, resp);
            }

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Server error: " + e.getMessage());
            req.getRequestDispatcher("/Login/login.jsp").forward(req, resp);
        }
    }
}
