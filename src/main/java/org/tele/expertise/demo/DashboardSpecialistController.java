
package org.tele.expertise.demo;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/specialist/dashboard")
public class DashboardSpecialistController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    /*    HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        //Object user = session.getAttribute("user");
      //  request.setAttribute("specialistName", session.getAttribute("userName"));*/
        request.getRequestDispatcher("/Specialist_Dashebored/Dashebored.jsp").forward(request, response);
    }
}