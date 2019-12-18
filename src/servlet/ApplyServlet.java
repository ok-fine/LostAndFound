package servlet;

import db.DBBean;
import entity.AppMgr;
import entity.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet("/ApplyServlet")
public class ApplyServlet extends HttpServlet {

    public ApplyServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    //用户提交申请
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
        String time = df.format(new Date());// new Date()为获取当前系统时间
        String reason = request.getParameter("reason");
        String g_time = request.getParameter("g_time");
        g_time += ":00";
        int item_no = Integer.parseInt(request.getParameter("item_no"));

        String start = request.getParameter("page");
        String type = request.getParameter("type");
        System.out.println("start:" +  start);

        System.out.println(reason);
        System.out.println(g_time);
        System.out.println(time);

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        try {
            int apply_no = AppMgr.apply(user.getNo(), item_no, time, g_time, reason);

            if( !type.equals("null")){
                response.sendRedirect(((HttpServletRequest) request).getContextPath() +  "/student/userInfo.jsp?page=" + start + "&type=" + type);
            }else {
                response.sendRedirect(((HttpServletRequest) request).getContextPath() +  "/student/itemInfo.jsp?page=" + start + "&apply_no=" + apply_no);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    //管理员
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DBBean db = new DBBean();
        HttpSession session = request.getSession();

        String apply_no = request.getParameter("apply_no");
        String opt = request.getParameter("opt");
        User user = (User) session.getAttribute("user");

        System.out.println("1:" + apply_no);
        System.out.println("2:" + opt);

        if(opt.equals("pass")){
            try {
                AppMgr.pass(apply_no, user.getNo());
                response.sendRedirect(((HttpServletRequest) request).getContextPath() +  "/student/index.jsp?page=0");
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }else if(opt.equals("refuse")){
            AppMgr.refuse(apply_no, user.getNo());
            response.sendRedirect(request.getContextPath() + "/admin/index.jsp?page=0");
        }

//        request.getRequestDispatcher("/admin/index.jsp?page=0").forward(request, response);
    }
}
