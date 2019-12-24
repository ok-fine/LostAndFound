<%@ page import="entity.SysAdmin" %>
<%@ page import="entity.SysAdminMgr" %><%--
  Created by IntelliJ IDEA.
  User: weijieyang
  Date: 2019/12/24
  Time: 上午11:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>系统管理员</title>

    <link type="text/css" href="../css/bootstrap.min.css" rel="stylesheet" />
    <link type="text/css" href="../font-awesome/css/font-awesome.css" rel="stylesheet" />
    <link type="text/css" href="../css/style.css" rel="stylesheet" />

    <link type="text/css" href="../css/plugins/iCheck/custom.css" rel="stylesheet"/>
    <link type="text/css" href="../css/plugins/footable/footable.core.css" rel="stylesheet"/>

</head>
<body>
<%
    SysAdmin sysAdmin = (SysAdmin) session.getAttribute("sysAdmin");

    String action = (String) session.getAttribute("action");
    String[][] admins = SysAdminMgr.getAdmins();
    int length = Integer.parseInt(admins[10][0]);

%>

<% if(action != null && !action.equals("无")){%>
<script>
    alert("<%=action%>");
</script>
<%=action%>
<% } %>

<div id="wrapper">
    <nav class="navbar-default navbar-static-side" role="navigation" th:include="nav :: navigation"></nav>
    <div id="page-wrapper" class="gray-bg">
        <div class="border-bottom" th:include="header :: headerTop"></div>
        <div class="row wrapper border-bottom white-bg page-heading" th:fragment="headerNav">
            <div class="col-lg-10">
                <h2>管理员控制中心</h2>
                <ol class="breadcrumb">
                    <li>
                        <a href="${pageContext.request.contextPath}/admin/itemInfo.jsp?page=0&mine=1">返回</a>
                    </li>
                    <li class="active">
                        <strong>欢迎系统管理员<%=sysAdmin.getName()%></strong>
                    </li>
                </ol>
            </div>
            <div class="col-lg-2">
            </div>
        </div>

        <div class="wrapper wrapper-content animated fadeInRight">
            <div class="row">
                <div class="col-lg-12">
                    <div class="ibox float-e-margins">
                        <div class="ibox-title">
                            <h5>添加管理员</h5>
                            <div class="ibox-tools">
                                <a class="collapse-link">
                                    <i class="fa fa-chevron-up"></i>
                                </a>
                            </div>
                        </div>
                        <div class="ibox-content" style="display: block;">
                            <form action="${pageContext.request.contextPath}/SystemServlet" class="form-inline" method="post">
                                <input type="hidden" name="type" value="admin">
                                <div class="row">
                                    <div class="form-group">
                                        <label for="name">&nbsp;&nbsp;姓&nbsp;&nbsp;名：</label>
                                        <input id="name" name="name" placeholder="输入姓名" style="width: 150px" class="form-control" type="text"/>
                                    </div>
                                    <div class="form-group">
                                        <label for="tel">&nbsp;&nbsp;联系电话：</label>
                                        <input id="tel" name="tel" placeholder="手机号码" class="form-control" type="text"/>
                                    </div>
                                    <div class="form-group">
                                        <label for="password">&nbsp;&nbsp;登陆密码：</label>
                                        <input id="password" name="password" placeholder="登陆密码" class="form-control" type="password"/>
                                    </div>
                                    <div class="col-sm-offset-4 col-sm-3" style="margin-top: 15px;">
                                        <button class="btn btn-primary btn-block" type="submit"><i
                                                class="fa fa-search"></i>&nbsp;&nbsp;&nbsp;&nbsp;<strong>确认添加</strong>
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <div class="col-lg-12">
                    <div class="ibox float-e-margins">
                        <div class="ibox-title">
                            <h5>添加失物招领地址</h5>
                            <div class="ibox-tools">
                                <a class="collapse-link">
                                    <i class="fa fa-chevron-up"></i>
                                </a>
                            </div>
                        </div>
                        <div class="ibox-content" style="display: block;">
                            <form action="${pageContext.request.contextPath}/SystemServlet" class="form-inline">
                                <input type="hidden" name="type" value="address">
                                <div class="row">
                                    <div class="form-group">
                                        <label for="address">&nbsp;&nbsp;具体地址：</label>
                                        <input id="address" name="address" placeholder="请输入具体地址" class="form-control" type="text"/>
                                    </div>
                                    <div class="form-group">
                                        <select name="admin_no" id="admin" class="form-control">
                                            <option value="5" selected>
                                                --请选择管理员--
                                            </option>
                                            <% for(int i = 0 ; i < length; i++) {%>
                                            <option value="<%=admins[i][0]%>" ><%=admins[i][1]%></option>
                                            <% }%>
                                        </select>
                                    </div><br>
                                    <div class="col-sm-offset-4 col-sm-3" style="margin-top: 15px;">
                                        <button class="btn btn-primary btn-block" type="submit"><i
                                                class="fa fa-search"></i>&nbsp;&nbsp;&nbsp;&nbsp;<strong>确认添加</strong>
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="footer" th:include="footer :: copyright"></div>
    </div>
</div>

</body>
</html>
