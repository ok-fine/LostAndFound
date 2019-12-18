package servlet;

import entity.AppMgr;
import entity.User;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebFilter("/student/userInfo.jsp")
public class UserInfoFilter implements Filter {
    public void destroy() {
    }

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws ServletException, IOException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpSession session = req.getSession();

        int page = Integer.parseInt(request.getParameter("page"));
        String type = request.getParameter("type");

        //删除物品
        String apply_no = request.getParameter("apply_no");
        if(apply_no != null){
            AppMgr.delete(Integer.parseInt(apply_no));
        }

        User user = (User) session.getAttribute("user");
        String[][] applications;
        System.out.println("admin filter:" + page);

        try {
            applications = AppMgr.applications(page, user.getNo(), type);
            request.setAttribute("applications", applications);

            //长度
            System.out.println("filter apps" + applications[2][0]);
//            session.setAttribute("items", items);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        chain.doFilter(request, response);
    }

    public void init(FilterConfig config) throws ServletException {

    }

}
