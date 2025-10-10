package org.tele.expertise.demo;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import org.mindrot.jbcrypt.BCrypt;
import org.tele.expertise.demo.model.Infirmier;
import org.tele.expertise.demo.repository.InfirmierRepository;
import org.tele.expertise.demo.repository.MedecinRepository;
import org.tele.expertise.demo.util.JpaUtil;

import java.io.IOException;

@WebServlet(name="login", value="/login")
public class LoginController extends HttpServlet {

    private InfirmierRepository infirmierRepository;
    private MedecinRepository medecinRepository;
    @Override
    public void init() throws ServletException {
        infirmierRepository = new InfirmierRepository();
        medecinRepository =new MedecinRepository();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        req.getRequestDispatcher("Login/login.jsp").forward(req, resp);
    }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String role = req.getParameter("role"); // <-- get the selected role from JSP
        if (!JpaUtil.isConnected()) {
            resp.sendRedirect("errors/disconnected.jsp");
            return;
        }
        try {
            Object user = null;

            if ("infirmier".equals(role)) {
                user = this.infirmierRepository.login(email, password);

            } else if ("medecin".equals(role)) {
                user = this.medecinRepository.login(email, password);
            }
            System.out.println("user nol or no" + user);
            System.out.println("Email from form: " + email);
            System.out.println("Password from form: " + password);
            System.out.println("Role from form: " + role);

            if (user != null) {
                HttpSession session = req.getSession();
                session.setAttribute(role, user);
                if ("infirmier".equals(role)) {
                    resp.sendRedirect(req.getContextPath() + "/Infermier_Dashebored/Dahsebored.jsp");
                } else if ("medecin".equals(role)) {
                    resp.sendRedirect(req.getContextPath() + "/Medecin_Dashboard/Dashebored.jsp");
                }

            }
            else {
                req.setAttribute("error", "Email or Password Fault!");
                req.getRequestDispatcher("Login/login.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Server error: " + e.getMessage());
            req.getRequestDispatcher("Login/login.jsp").forward(req, resp);
        }
    }

}
