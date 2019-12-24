package servlet;

import entity.SysAdmin;
import entity.SysAdminMgr;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/SystemServlet")
public class SystemServlet extends HttpServlet {
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

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String action = "无";
        HttpSession session = request.getSession();
        String type = request.getParameter("type");

        if(type.equals("address")){
            String address = request.getParameter("address");
            int admin_no = Integer.parseInt(request.getParameter("admin_no"));

            SysAdminMgr.addAddress(address, admin_no);

            action = "设置失物招领地址成功!";
            session.setAttribute("action", action);
            response.sendRedirect(request.getContextPath() + "/admin/sysAdmin.jsp");
//        request.getRequestDispatcher( "/admin/sysAdmin.jsp").forward(request, response);

        }else if(type.equals("admin")){
            String name = request.getParameter("name");
            String password = request.getParameter("password");
            String tel = request.getParameter("tel");

            SysAdmin sysAdmin = new SysAdmin(name, password, tel);
            sysAdmin.setNo(SysAdminMgr.addAdmin(sysAdmin));

            action = "添加管理员成功!";
            session.setAttribute("action", action);
            response.sendRedirect(request.getContextPath() + "/admin/sysAdmin.jsp");
//        request.getRequestDispatcher( "/admin/sysAdmin.jsp").forward(request, response);
        }

    }
}
