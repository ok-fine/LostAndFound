package servlet;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

import db.DBBean;
import entity.ItemMgr;

@WebFilter("/student/itemInfo.jsp")
public class StuItemInfoFilter implements Filter {
    public void destroy() {
    }

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws ServletException, IOException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpSession session = req.getSession();

        System.out.println("getContextPath" + req.getContextPath());

        int pageNum = DBBean.PageNum;

        int page = Integer.parseInt(request.getParameter("page"));
        String[][] items;

        System.out.println("itemInfo filter:" + page);

        try {
            //得到千古的item
            items = ItemMgr.items(page, 1, 0);
            request.setAttribute("items", items);

            System.out.println("filteritems" + items[pageNum][0]);
//            session.setAttribute("items", items);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        chain.doFilter(request, response);
    }

    public void init(FilterConfig config) throws ServletException {

    }

}
