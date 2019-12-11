package servlet;

import entity.Item;
import entity.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;


@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
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
        String tel = request.getParameter("tel");
//        System.out.println("name" + name);
//        System.out.println("password" + password);
        HttpSession session = request.getSession();
        User user = new User();
        user.setName(name);
        user.setPassword(password);
        user.setTel(tel);

        if(user.register()){
            session.setAttribute("user", user);
            session.setAttribute("login", "1");
            session.setAttribute("admin", "0");

//            request.getRequestDispatcher("/student/itemInfo.jsp?page=0").forward(request, response);
            response.sendRedirect(((HttpServletRequest) request).getContextPath() + "/student/itemInfo.jsp?page=0");
        }else {
            session.setAttribute("login", "3");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
        System.out.println("no:" + user.getNo());
    }
}
