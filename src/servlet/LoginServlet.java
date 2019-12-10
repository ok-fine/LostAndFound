package servlet;

import entity.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException{
        String name = request.getParameter("name");
        String password = request.getParameter("password");
//        System.out.println("name" + name);
//        System.out.println("password" + password);
        HttpSession session = request.getSession();
        User user = new User();
        user.setName(name);
        user.setPassword(password);

        if(user.login()){
            System.out.println("login success");
            session.setAttribute("login", "1");
            request.getRequestDispatcher("/index.jsp").forward(request, response);
        }else {
            System.out.println("login failed");
            session.setAttribute("login", "0");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
}
