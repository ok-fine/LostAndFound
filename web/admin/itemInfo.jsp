<%@ page import="entity.User" %>
<%@ page import="org.omg.PortableInterceptor.INACTIVE" %>
<%@ page import="db.DBBean" %>
<%--
  Created by IntelliJ IDEA.
  User: weijieyang
  Date: 2019/12/12
  Time: 下午9:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>管理员中心</title>

    <link type="text/css" href="../css/bootstrap.min.css" rel="stylesheet" />
    <link type="text/css" href="../font-awesome/css/font-awesome.css" rel="stylesheet" />
    <link type="text/css" href="../css/style.css" rel="stylesheet" />

    <link type="text/css" href="../css/plugins/iCheck/custom.css" rel="stylesheet"/>
    <link type="text/css" href="../css/plugins/footable/footable.core.css" rel="stylesheet"/>

</head>
<body>

<%
    User user = (User) session.getAttribute("user");
    int start = Integer.parseInt(request.getParameter("page"));

    int pageNum = DBBean.PageNum;

    String[][] items = (String[][]) request.getAttribute("items");
    int length = Integer.parseInt(items[pageNum][0]);

//    String login = (String) session.getAttribute("login");
//    String admin = (String) session.getAttribute("admin");
    int mine = Integer.parseInt(request.getParameter("mine"));
    //1 - 全部， -1 我的
    //在获取items的时候已经根据mine筛选过了

    String item_no = request.getParameter("item_no");
    if(item_no != null){
%>
<script>
    alert("删除成功")
</script>

<%  }

    String success = request.getParameter("success");
    if(success != null){
%>
<script>
    alert("发布成功")
</script>

<%  }  %>

<%--欢迎来到湖南大学失物招领处<br>--%>

<div id="wrapper">
    <nav class="navbar-default navbar-static-side" role="navigation" th:include="nav :: navigation"></nav>
    <div id="page-wrapper" class="gray-bg">
        <div class="border-bottom" th:include="header :: headerTop"></div>
        <div class="row wrapper border-bottom white-bg page-heading" th:fragment="headerNav">
            <div class="col-lg-10">
                <h2>失物展示</h2>
                <ol class="breadcrumb">
                    <li>
                        <a href="${pageContext.request.contextPath}/login.jsp" onclick="user.exit()">退出登陆</a>
                    </li>
                    <li class="active">
                        <strong>失物展示</strong>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/admin/index.jsp?page=0">认领审核</a>
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
                            <h5>欢迎管理员<%=user.getName()%></h5>
                        </div>

                        <div class="ibox-content" style="display: block;">
                            <div class="row">
                                <div class="col-sm-offset-4 col-sm-3" style="margin-top: 15px;">
                                    <button onclick="window.location.href = '${pageContext.request.contextPath}/admin/publish.jsp?page=<%=start%>&mine=<%=mine%>'"  class="btn btn-primary btn-block" type="submit">&nbsp;&nbsp;&nbsp;&nbsp;<strong>发布招领</strong>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-lg-12">
                    <div class="ibox float-e-margins">
                        <div class="ibox-title">
                            <h5>失物展示</h5>
                            &nbsp;&nbsp;
                            <% if(mine == 1){ %>
                            <a href="${pageContext.request.contextPath}/admin/itemInfo.jsp?page=0&mine=<%=-1 * mine%>">只看我的</a>
                            <% }else { %>
                            <strong><a href="${pageContext.request.contextPath}/admin/itemInfo.jsp?page=0&mine=<%=-1 * mine%>">只看我的</a></strong>
                            <% } %>

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
                                        <th style="width:7%;">失物名称</th>
                                        <th style="width:15%;">失物描述</th>
                                        <th style="width:10%;">发布时间</th>
                                        <th style="width:10%;">发布地点</th>
                                        <th style="width:7%;">管理员姓名</th>
                                        <th style="width:7%;">管理员电话</th>
                                        <th style="width:9%;" colspan="2">操作</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <% if(length == 0 && start == 0) { %>
                                    <tr>
                                        <td colspan="8">暂时还没有发布任何东西哦～</td>
                                    </tr>

                                    <%
                                    } else {
                                        for(int i = 0 ; i < length ; i++){
                                    %>
                                    <tr>
                                        <td><%=items[i][1]%></td>
                                        <td><%=items[i][2]%></td>
                                        <td><%=items[i][3]%></td>
                                        <td><%=items[i][4]%></td>
                                        <td><%=items[i][5]%></td>
                                        <td><%=items[i][6]%></td>

                                        <% if(items[i][7].equals(String.valueOf(user.getNo()))){ %>
                                        <td><input type="button" onclick="window.location.href='publish.jsp?item_no=<%=items[i][0]%>&name=<%=items[i][1]%>&description=<%=items[i][2]%>&page=<%=start%>&mine=<%=mine%>'" value="编辑"></td>
                                        <td><a href="${pageContext.request.contextPath}/admin/itemInfo.jsp?page=<%=start%>&mine=<%=mine%>&item_no=<%=items[i][0]%>"
                                               onclick="return window.confirm('确定删除吗？')">删除</a></td>
                                        <% }else { %>
                                        <td colspan="2">无法操作</td>
                                        <% } %>
                                    </tr>
                                    <% } } %>

                                    <tr>
                                        <%
                                            int front = start - pageNum;
                                            if(front < 0) front = 0;
                                            int next = start + pageNum;
                                            if(length < pageNum) next = start;
                                        %>
                                        <td>第<%=start / pageNum + 1%>页</td>
                                        <td colspan="7">
                                            <a href="${pageContext.request.contextPath}/admin/itemInfo.jsp?page=<%=front%>&mine=<%=mine%>">上一页</a>
                                            <a href="${pageContext.request.contextPath}/admin/itemInfo.jsp?page=<%=next%>&mine=<%=mine%>">下一页</a>
                                        </td>
                                    </tr>
                                    </tbody>
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

</body>
</html>
