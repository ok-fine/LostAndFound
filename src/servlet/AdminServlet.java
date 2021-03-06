package servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

import entity.ItemMgr;
import entity.User;

@WebServlet("/AdminServlet")
public class AdminServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        //发布商品
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
        String time = df.format(new Date());// new Date()为获取当前系统时间

        String item_no = request.getParameter("item_no");
        String name = request.getParameter("name");
        String des = request.getParameter("des");

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        int admin_no = user.getNo();
        int address_no = user.getAddress_no();

        try {
            if(item_no != null){
                //修改
                ItemMgr.edit(item_no, name, des, time);
            }else{
                //发布
                ItemMgr.publish(name, des, time, address_no, admin_no);
            }

            response.sendRedirect(request.getContextPath() + "/admin/itemInfo.jsp?page=0&mine=1&success=1");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //编辑商品信息
    }
}
