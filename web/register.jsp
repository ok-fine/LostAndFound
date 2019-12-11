<%--
  Created by IntelliJ IDEA.
  User: weijieyang
  Date: 2019/12/10
  Time: 上午10:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>注册</title>

    <link type="text/css" href="./css/bootstrap.min.css" rel="stylesheet"/>
    <link type="text/css" href="./css/font/font-awesome.css" rel="stylesheet" />
    <link type="text/css" href="./css/plugins/iCheck/custom.css" rel="stylesheet"/>
    <link type="text/css" href="./css/animate.css" rel="stylesheet"/>
    <link type="text/css" href="./css/style.css" rel="stylesheet"/>
</head>
<body class="gray-bg">

<%
    String login = (String) session.getAttribute("login");
    if( login == "3" ){
%>
<script>
    alert("注册失败，用户名不可用");
</script>

<%    } %>

<div class="middle-box text-center loginscreen animated fadeInDown">
    <div>
        <div>
            <h2 class="logo-name">HNU</h2>
        </div>
        <h3>Register to LAF</h3>
        <p>Create account to see it in action.</p>
        <form class="m-t" role="form"  action="RegisterServlet"   method="post" >
            <div class="form-group">
                <input type="text" class="form-control" placeholder="Name" name="name" required=""/>
            </div>
            <div class="form-group">
                <input type="password" class="form-control" placeholder="Password" name="password" required=""/>
            </div>
            <div class="form-group">
                <input type="text" class="form-control" placeholder="联系方式" name="tel" required=""/>
            </div>
            <div class="form-group">
                <div class="checkbox i-checks"><label> <input type="checkbox"/><i></i> Agree the terms and policy </label></div>
            </div>
            <button type="submit" class="btn btn-primary block full-width m-b">Register</button>

            <p class="text-muted text-center"><small>Already have an account?</small></p>
            <a class="btn btn-sm btn-white btn-block" href="login.jsp">Login</a>
        </form>
        <p class="m-t"> <small>we app framework base on Bootstrap 3 &copy; 2019</small> </p>
    </div>
</div>

</body>
</html>
