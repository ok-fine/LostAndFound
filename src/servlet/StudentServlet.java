package servlet;

import entity.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/StudentServlet")
public class StudentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException{
        String page = request.getParameter("page");
        String type = request.getParameter("type");
        System.out.println(page);
        System.out.println(type);

        int user_no = Integer.parseInt(request.getParameter("user_no"));
        String name = request.getParameter("name");
        String tel = request.getParameter("tel");
        String password = request.getParameter("password");

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        user.changeInfo(user_no, name, password, tel);
        session.setAttribute("user", user);

        response.sendRedirect(((HttpServletRequest) request).getContextPath() + "/student/userInfo.jsp?page=" + page + "&type=" + type);
    }
}
