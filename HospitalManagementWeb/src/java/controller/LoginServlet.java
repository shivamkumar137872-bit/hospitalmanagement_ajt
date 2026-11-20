package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String user = request.getParameter("username");
        String pass = request.getParameter("password");

        if ("admin".equals(user) && "admin123".equals(pass)) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            response.sendRedirect("patient?action=list");
        } else {
            request.setAttribute("error", "Username or password is wrong !");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}