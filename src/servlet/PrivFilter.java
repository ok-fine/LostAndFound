package servlet;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;

import db.DBBean;
import entity.User;

//@WebFilter(filterName = "PrivFilter")
/**
 * PrivFilter implementation
 */
@WebFilter("/*")
public class PrivFilter implements Filter {
    public void destroy() {
    }

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws ServletException, IOException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpSession session = (req).getSession();
        String url = req.getRequestURI().substring(req.getContextPath().length());

//        session.setAttribute("pageNum", 2);

//        System.out.println("RequestURI:" + req.getRequestURI());
//        System.out.println("getContextPath:" + req.getContextPath());
        System.out.println("url：" + url);

        session.setAttribute("login", "-1");
        String login = (String) session.getAttribute("login");

//        if (login != "1" ) {
//            request.getRequestDispatcher("/login.jsp").forward(request, response);
//        }
//        for (int i = 0; i < dir.length; i++) {
//            if (url.startsWith(dir[i])) {
//                if (user == null) {
//                    request.getRequestDispatcher("/login.jsp")
//                            .forward(request, response);
//                }
//            }
//        }

        chain.doFilter(request, response);
    }

    public void init(FilterConfig config) throws ServletException {

    }

}
