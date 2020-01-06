<%--<jsp:useBean id="orders" scope="" type="java.util.List"/>--%>
<%@ page import="entity.User" %>
<%@ page import="db.DBBean" %>
<%@ page import="entity.SysAdmin" %><%--
  Created by IntelliJ IDEA.
  User: weijieyang
  Date: 2019/12/10
  Time: 下午3:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>认领审核</title>

    <link type="text/css" href="../css/bootstrap.min.css" rel="stylesheet" />
    <link type="text/css" href="../css/font/font-awesome.css" rel="stylesheet" />
    <link type="text/css" href="../css/style.css" rel="stylesheet" />

    <link type="text/css" href="../css/plugins/iCheck/custom.css" rel="stylesheet"/>
    <link type="text/css" href="../css/plugins/footable/footable.core.css" rel="stylesheet"/>
</head>
<body>

<%
    User user = (User) session.getAttribute("user");
    SysAdmin sysAdmin = (SysAdmin) session.getAttribute("sysAdmin");

    int start = Integer.parseInt(request.getParameter("page"));
    int pageNum = DBBean.PageNum;

    String[][] orders = (String[][]) request.getAttribute("orders");
    int length = Integer.parseInt(orders[pageNum][0]);

    String opt = request.getParameter("opt");
    if(opt != null){
%>
<script>
    alert("操作成功！");
</script>
<%  }  %>

<div id="wrapper">
    <nav class="navbar-default navbar-static-side" role="navigation" th:include="nav :: navigation"></nav>
    <div id="page-wrapper" class="gray-bg">
        <div class="border-bottom" th:include="header :: headerTop"></div>
        <div class="row wrapper border-bottom white-bg page-heading" th:fragment="headerNav">
            <div class="col-lg-10">
                <h2>认领审核</h2>
                <ol class="breadcrumb">
                    <li>
                        <a href="${pageContext.request.contextPath}/login.jsp" onclick="user.exit()">退出登陆</a>
                    </li>
                    <li >
                        <a href="${pageContext.request.contextPath}/admin/itemInfo.jsp?page=0&mine=1">失物展示</a>
                    </li>
                    <li class="active">
                        <strong>认领审核</strong>
                    </li>
<%--                    <%=sysAdmin.getIs_system()%>--%>
                    <% if(sysAdmin.getIs_system().equals("1")) { %>
                        <a class="collapse-link" href="sysAdmin.jsp">切换系统管理员</a>
                    <% } %>
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
                            <h5>申请列表</h5>
                            <div class="ibox-tools">
                                <a class="collapse-link">
                                    <i class="fa fa-chevron-up"></i>
                                </a>
                            </div>
                        </div>
                        <div class="ibox-content">
                            <div class="table-responsive">
                                <table class=" table table-bordered table-hover" data-page-size="10">
                                    <thead>
                                    <tr style="text-align: center">
                                        <th style="width:5%;">失物名称</th>
                                        <th style="width:15%;">失物描述</th>
                                        <th style="width:5%;">认领人</th>
                                        <th style="width:10%;">认领描述</th>
                                        <th style="width:10%;">预计认领时间</th>
                                        <th style="width:10%;">认领人电话</th>
                                        <th style="width:10%;" colspan="2">操作</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <% if(length == 0 && start == 0) { %>
                                    <tr>
                                        <td colspan="8">暂时没有认领申请</td>
                                    </tr>
                                    <% } else{
                                        for(int i = 0; i < length; i++){%>
                                    <tr>
                                        <td><%=orders[i][1]%></td>
                                        <td><%=orders[i][2]%></td>
                                        <td><%=orders[i][3]%></td>
                                        <td><%=orders[i][4]%></td>
                                        <td><%=orders[i][5]%></td>
                                        <td><%=orders[i][6]%></td>
                                        <td>
                                            &nbsp;&nbsp;
                                            <a href="${pageContext.request.contextPath}/ApplyServlet?apply_no=<%=orders[i][0]%>&opt=refuse" title="拒绝">
                                                <i class="glyphicon glyphicon-search"></i></a>
                                            &nbsp;&nbsp;
                                        </td>
                                        <td>
                                            &nbsp;&nbsp;
                                                <a href="${pageContext.request.contextPath}/ApplyServlet?apply_no=<%=orders[i][0]%>&opt=pass" title="通过">
                                                    <i class="glyphicon glyphicon-plus"></i></a>
                                            &nbsp;&nbsp;
                                        </td>
                                    </tr>
                                    <% }
                                    }
                                        int front = start - 2;
                                        if(front < 0) front = 0;
                                        int next = start + 2;
                                        if(length < 2) next = start;
                                    %>

                                    <td>第<%=start / 2 + 1%>页</td>
                                    <td colspan="7">
                                        <a href="${pageContext.request.contextPath}/admin/index.jsp?page=<%=front%>">上一页</a>
                                        <a href="${pageContext.request.contextPath}/admin/index.jsp?page=<%=next%>">下一页</a>
                                    </td>

                                    </tbody>
                                    <tfoot>
                                    <tr>
                                        <td colspan="8">
                                            <ul id="pageHTML" class="pagination pull-right"></ul>
                                        </td>
                                    </tr>
                                    </tfoot>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="footer" th:include="footer :: copyright"></div>
    </div>
</div>

<!-- Mainly scripts -->
<script src="../js/jquery-2.1.1.js"></script>
<script src="../js/bootstrap.min.js"></script>
<script src="../js/plugins/metisMenu/jquery.metisMenu.js"></script>
<script src="../js/plugins/slimscroll/jquery.slimscroll.min.js"></script>

<!-- Peity -->
<script src="../js/plugins/peity/jquery.peity.min.js"></script>

<!-- Custom and plugin javascript -->
<script src="../js/inspinia.js"></script>
<script src="../js/plugins/pace/pace.min.js"></script>

<!-- iCheck -->
<script src="../js/plugins/iCheck/icheck.min.js"></script>

<!-- Peity -->
<script src="../js/demo/peity-demo.js"></script>

<!-- FooTable -->
<script src="../js/plugins/footable/footable.all.min.js"></script>

<!-- common -->
<script src="../js/common.js"></script>

</body>
</html>
