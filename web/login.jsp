<% boolean basePath; %><%--
  Created by IntelliJ IDEA.
  User: weijieyang
  Date: 2019/12/10
  Time: 上午10:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>登陆</title>
    <link type="text/css" href="./css/bootstrap.min.css" rel="stylesheet" />
<%--    <link type="text/css" href="./WEB-INF/font-awesome/css/font-awesome.css" rel="stylesheet" />--%>
    <link type="text/css" href="./css/font/font-awesome.css" rel="stylesheet" />

    <link type="text/css" href="./css/animate.css" rel="stylesheet" />
    <link type="text/css" href="./css/style.css" rel="stylesheet" />

    <!-- Sweet Alert -->
    <link type="text/css" href="./css/plugins/sweetalert/sweetalert.css" rel="stylesheet"/>
</head>
<body class="gray-bg">

<%
    String login = (String) session.getAttribute("login");
    if(login.equals("0")){
%>
<script>
    alert("请输入正确的用户名和密码");
</script>

<%    } %>

<div class="middle-box text-center loginscreen animated fadeInDown">
    <div>
        <div>
            <h2 class="logo-name">HNU</h2>
        </div>
        <!--<h3>Welcome to XXX</h3>-->
        <p>
            Lost And Found for HNU
        </p>
        <p>Login in. To see it in action.</p>
        <form class="m-t" role="form" action="LoginServlet" method="get">
            <div class="form-group">
                <input type="text" class="form-control" placeholder="userName" name="name" required="" />
            </div>
            <div class="form-group">
                <input type="password" class="form-control" placeholder="password" name="password" required="" />
            </div>
            <button type="submit" class="btn btn-primary block full-width m-b">Login</button>
            <a href="#"><small>Forgot password?</small></a>
            <p class="text-muted text-center">
                <small>Do not have an account?</small>
            </p>
            <a class="btn btn-sm btn-white btn-block" href="register.jsp">Create an account</a>
        </form>
        <p class="m-t">
            <small>we app framework base on Bootstrap 3 &copy; 2019</small>
        </p>
    </div>
</div>

<!-- Mainly scripts -->
<script src="./js/jquery-2.1.1.js"></script>
<script src="./js/bootstrap.min.js"></script>
<!-- Sweet alert -->
<script src="./js/plugins/sweetalert/sweetalert.min.js"></script>

</body>
</html>
