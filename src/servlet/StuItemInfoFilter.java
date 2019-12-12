package servlet;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

import entity.Item;

@WebFilter("/admin/itemInfo.jsp")
public class IndexFilter implements Filter {
    public void destroy() {
    }

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws ServletException, IOException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpSession session = req.getSession();

        System.out.println("getContextPath" + req.getContextPath());

        int page = Integer.parseInt(request.getParameter("page"));
        String[][] items;

        System.out.println("itemInfo filter:" + page);

        try {
            items = Item.items(page);
            request.setAttribute("items", items);

            System.out.println("filteritems" + items[2][0]);
//            session.setAttribute("items", items);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        chain.doFilter(request, response);
    }

    public void init(FilterConfig config) throws ServletException {

    }

}
