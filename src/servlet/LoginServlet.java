package servlet;

import entity.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;


@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        String name = request.getParameter("name");
        String password = request.getParameter("password");
        String admin = request.getParameter("admin");
//        System.out.println("name" + name);
//        System.out.println("password" + password);
        System.out.println("admin" + admin);

        HttpSession session = request.getSession();
        User user = new User();
        user.setName(name);
        user.setPassword(password);

//        HttpServletRequest req = (HttpServletRequest) request;
//        System.out.println("RequestURI:" + req.getRequestURI());
//        System.out.println("getContextPath:" + req.getContextPath());

        if(user.login(admin)){
            //admin用on和null来表示
            if(admin != null) {
                session.setAttribute("admin", "1");
            }else {
                session.setAttribute("admin", "0");
            }

            System.out.println("login success");
            session.setAttribute("login", "1");
            session.setAttribute("user", user);

            session.setAttribute("length", 100);

//            request.getRequestDispatcher("/student/itemInfo.jsp?page=-1").forward(request, response);
            response.sendRedirect(((HttpServletRequest) request).getContextPath() +  "/student/itemInfo.jsp?page=0");
        }else {
            System.out.println("login failed");
            session.setAttribute("login", "0");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
}
