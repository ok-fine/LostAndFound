<%--
  Created by IntelliJ IDEA.
  User: weijieyang
  Date: 2019/12/10
  Time: 上午10:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>湖南大学失物招领</title>
  </head>
  <body>
  <a href="login.jsp">
    <% String login = (String) session.getAttribute("login");
      if( login != "1" ){ %>
登陆
    <% } else {  %>
退出
    <% }  %>
  </a><br>

  欢迎来到湖南大学失物招领处<br>

  <a href=""

  </body>
</html>
