package servlet;

import db.DBBean;
import entity.AppMgr;
import entity.User;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebFilter("/admin/index.jsp")
public class AdminFilter implements Filter {
    public void destroy() {
    }

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws ServletException, IOException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpSession session = req.getSession();

        int page = Integer.parseInt(request.getParameter("page"));
        int pageNum = DBBean.PageNum;
        User user = (User) session.getAttribute("user");
        String[][] orders;

        System.out.println("admin filter:" + page);

        try {
            orders = AppMgr.orders(page, user.getNo());
            request.setAttribute("orders", orders);

            System.out.println("filteritems" + orders[pageNum][0]);
//            session.setAttribute("items", items);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        chain.doFilter(request, response);
    }

    public void init(FilterConfig config) throws ServletException {

    }

}
