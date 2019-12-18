package servlet;

import db.DBBean;
import entity.ItemMgr;
import entity.User;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebFilter("/admin/itemInfo.jsp")
public class AdmItemInfoFilter implements Filter {
    public void destroy() {
    }

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws ServletException, IOException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        System.out.println("getContextPath" + req.getContextPath());

        int pageNum = DBBean.PageNum;

        int page = Integer.parseInt(request.getParameter("page"));
        int mine = Integer.parseInt(request.getParameter("mine"));
        System.out.println("itemInfo filter:" + page);

        String item_no = request.getParameter("item_no");
        if(item_no != null) {
            ItemMgr.delete(Integer.parseInt(item_no));
        }

        String[][] items;
        try {
            items = ItemMgr.items(page, mine, user.getNo());
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
