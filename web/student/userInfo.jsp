<%@ page import="entity.User" %>
<%@ page import="entity.Application" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="org.omg.PortableInterceptor.INACTIVE" %><%--
  Created by IntelliJ IDEA.
  User: weijieyang
  Date: 2019/12/12
  Time: 下午11:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>

    <title>个人信息</title>

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
    String type = request.getParameter("type");
    String editInfo = request.getParameter("editInfo");
//    String editApply = request.getParameter("editApply");

    String[][] applications = (String[][]) request.getAttribute("applications");
    int length = Integer.parseInt(applications[2][0]);

    String apply_no = request.getParameter("apply_no");
    if(apply_no != null){
%>
<script>
    alert("删除成功")
</script>
<%  } %>

<div id="wrapper">
    <nav class="navbar-default navbar-static-side" role="navigation" th:include="nav :: navigation"></nav>
    <div id="page-wrapper" class="gray-bg">
        <div class="border-bottom" th:include="header :: headerTop"></div>
        <div class="row wrapper border-bottom white-bg page-heading" th:fragment="headerNav">
            <div class="col-lg-10">
                <h2>个人信息</h2>
                <ol class="breadcrumb">
                    <li>
                        <a href="${pageContext.request.contextPath}/login.jsp" onclick="user.exit()">退出登陆</a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/student/itemInfo.jsp?page=0">失物展示</a>
                    </li>
                    <li class="active">
                        <strong>个人信息</strong>
<%--                        <a href="${pageContext.request.contextPath}/student/userInfo.jsp?page=<%=start%>&type=<%=type%>&editInfo=1">编辑个人信息</a><br>--%>
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
                            <h5>用户个人信息</h5>
                            &nbsp;&nbsp;
                            <% if(editInfo != null){ %>
                                <a href="${pageContext.request.contextPath}/student/userInfo.jsp?page=<%=start%>&type=<%=type%>">取消</a>
<%--                                <strong>编辑个人信息</strong>--%>
                            <% }else { %>
                                <a href="${pageContext.request.contextPath}/student/userInfo.jsp?page=<%=start%>&type=<%=type%>&editInfo=1">编辑个人信息</a>
                            <% } %>

                            <div class="ibox-tools">
                                <a class="collapse-link">
                                    <i class="fa fa-chevron-up"></i>
                                </a>
                            </div>
                        </div>
                        <div class="ibox-content" style="display: block;">
                            <form action="${pageContext.request.contextPath}/StudentServlet" method="get"  class="form-inline">
                                <input type="hidden" name="page" value="<%=start%>">
                                <input type="hidden" name="type" value="<%=type%>">
                                <input type="hidden" name="user_no" value="<%=user.getNo()%>">

                                <div class="row">
                                    <div class="form-group">
                                        <label for="name">&nbsp;&nbsp;同户姓名：</label>
                                        <% if(editInfo != null){ %>
                                        <input id="name" type="text" placeholder="<%=user.getName()%>" name="name" class="form-control" required/>
                                        <% }else { %>
                                        <td style="width: 10%;"><%=user.getName()%></td>
                                        <% } %>
                                    </div>
                                    &nbsp;&nbsp;
<%--                                    <br>--%>
                                    <div class="form-group">
                                        <label for="tel">&nbsp;&nbsp;联系电话：</label>
                                        <% if(editInfo != null){ %>
                                        <input id="tel" type="text" placeholder="<%=user.getTel()%>" name="tel" class="form-control" required />
                                        <% }else { %>
                                        <td style="width: 10%;"><%=user.getTel()%></td>
                                        <% } %>
                                    </div>
                                    <% if(editInfo != null){ %>
                                    &nbsp;&nbsp;
<%--                                    <br>--%>
                                    <div class="form-group">
                                        <label for="pass">&nbsp;&nbsp;登陆密码：</label>
                                        <input id="pass" name="password" placeholder="<%=user.getPassword()%>" class="form-control" type="text" required/>
                                    </div>
                                    <br>
                                    <div class="col-sm-offset-4 col-sm-3" style="margin-top: 15px;">
                                        <button class="btn btn-primary btn-block" type="submit">&nbsp;&nbsp;&nbsp;&nbsp;<strong>确定</strong>
                                        </button>
                                    </div>
                                    <% }%>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="col-lg-12">
                    <div class="ibox float-e-margins">
                        <div class="ibox-title">
                            <% if(type.equals("all")){ %>
                            <strong><a href="${pageContext.request.contextPath}/student/userInfo.jsp?page=0&type=all">全部申请</a></strong>
                            &nbsp;/&nbsp;
                            <a href="${pageContext.request.contextPath}/student/userInfo.jsp?page=0&type=wait">待审核申请</a>
                            <% }else{  %>
                            <a href="${pageContext.request.contextPath}/student/userInfo.jsp?page=0&type=all">全部申请</a>
                            &nbsp;/&nbsp;
                            <strong><a href="${pageContext.request.contextPath}/student/userInfo.jsp?page=0&type=wait">待审核申请</a></strong>
                            <% }  %>

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
                                        <th style="width:15%;">认领描述</th>
                                        <th style="width:10%;">申请时间</th>
                                        <th style="width:5%;">管理员姓名</th>
                                        <th style="width:10%;">管理员电话</th>
                                        <th style="width:5%;">状态</th>
                                        <th style="width:10%;" colspan="2">操作</th>
                                    </tr>
                                    </thead>

                                    <tbody>
                                    <% if(length == 0 && start == 0) { %>
                                    <tr>
                                        <td colspan="9">暂时还没有认领东西哦～</td>
                                    </tr>

                                    <%} else {
                                        for(int i = 0 ; i < length ; i++){
                                    %>
                                    <tr>
                                        <td><%=applications[i][1]%></td>
                                        <td><%=applications[i][2]%></td>
                                        <td><%=applications[i][3]%></td>
                                        <td><%=applications[i][4]%></td>
                                        <td><%=applications[i][5]%></td>
                                        <td><%=applications[i][6]%></td>
                                        <td><%=applications[i][7]%></td>
                                        <% if(applications[i][7].equals("待审核")){%>

                                        <td><input type="button" onclick="window.location.href='applyFor.jsp?page=<%=start%>&type=<%=type%>&item_no=<%=applications[i][8]%>&name=<%=applications[i][1]%>&description=<%=applications[i][2]%>'" value="编辑"></td>
                                        <td><a href="${pageContext.request.contextPath}/student/userInfo.jsp?page=<%=start%>&type=<%=type%>&apply_no=<%=applications[i][0]%>"
                                               onclick="return window.confirm('确定删除吗？')">删除</a></td>
                                        <%--                <td><input type="button" onClick="deleteApp()" value="删除"></td>--%>
                                        <% }else { %>
                                        <td colspan="2">已完成</td>
                                        <%--                <td><input type="button" onclick="confirm('这不是您发布的物品～')" value="编辑"></td>--%>
                                        <%--                <td><input type="button" onclick="confirm('这不是您发布的物品～')" value="删除"></td>--%>
                                        <% } %>
                                    </tr>
                                    <%
                                            }
                                        }
                                    %>
                                    </tbody>
                                    <tfoot>
                                    <tr>
                                        <%
                                            int front = start - 2;
                                            if(front < 0) front = 0;
                                            int next = start + 2;
                                            if(length < 2) next = start;
                                        %>
                                        <td>第<%=start / 2 + 1%>页</td>
                                        <td colspan="8">
                                            <a href="${pageContext.request.contextPath}/student/userInfo.jsp?page=<%=front%>&type=<%=type%>">上一页</a>
                                            <a href="${pageContext.request.contextPath}/student/userInfo.jsp?page=<%=next%>&type=<%=type%>">下一页</a>
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

</body>
</html>