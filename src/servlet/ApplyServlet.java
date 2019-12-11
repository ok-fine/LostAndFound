package servlet;

import db.DBBean;
import entity.Application;
import entity.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.crypto.Data;
import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet("/ApplyServlet")
public class ApplyServlet extends HttpServlet {

    //用户提交申请
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
        String time = df.format(new Date());// new Date()为获取当前系统时间
        String reason = request.getParameter("reason");
        String g_time = request.getParameter("g_time");
        int item_no = Integer.parseInt(request.getParameter("item_no"));

        System.out.println(reason);
        System.out.println(g_time);
        System.out.println(time);

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        try {
            Application.apply(user.getNo(), item_no, time, g_time, reason);

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    //管理员
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DBBean db = new DBBean();

        String apply_no = request.getParameter("apply_no");
        String opt = request.getParameter("opt");
        HttpSession session = request.getSession();

        User user = (User) session.getAttribute("user");

        if(opt.equals("pass")){
            try {
                Application.pass(apply_no, user.getNo());
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }else if(opt.equals("refuse")){
            Application.refuse(apply_no, user.getNo());
        }

        request.getRequestDispatcher("/admin/index.js?page=0").forward(request, response);
    }
}
