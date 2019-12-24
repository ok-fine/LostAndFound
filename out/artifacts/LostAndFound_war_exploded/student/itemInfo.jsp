<%--
  Created by IntelliJ IDEA.
  User: weijieyang
  Date: 2019/12/12
  Time: 上午12:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="entity.User" %>
<%@ page import="db.DBBean" %>
<html>
<head>
    <title>湖南大学失物招领</title>

    <link type="text/css" href="../css/bootstrap.min.css" rel="stylesheet" />
    <link type="text/css" href="../font-awesome/css/font-awesome.css" rel="stylesheet" />

    <!-- Toastr style -->
    <link type="text/css" href="../css/plugins/toastr/toastr.min.css" rel="stylesheet"/>

    <link type="text/css" href="../css/style.css" rel="stylesheet" />

    <!-- summernote style -->
    <link type="text/css" href="../css/plugins/summernote/summernote.css" rel="stylesheet" />
    <link type="text/css" href="../css/plugins/summernote/summernote-bs3.css" rel="stylesheet" />
</head>
<body >

<%
    int pageNum = DBBean.PageNum;

    User user = (User) session.getAttribute("user");
    int start = Integer.parseInt(request.getParameter("page"));

    String[][] items = (String[][]) request.getAttribute("items");
    int length = Integer.parseInt(items[pageNum][0]);

    String login = (String) session.getAttribute("login");
    String admin = (String) session.getAttribute("admin");

    String apply_no = request.getParameter("apply_no");
    String alert = "";
%>

<%
    if(apply_no != null){
        if(apply_no.equals("0")){
            alert = "认领申请失败，请重新填写";
        }else {
            alert = "认领申请成功";
        } %>

<%--<%=alert%>--%>
    <script type="text/javascript" language="javascript">
        alert("<%=alert%>");
    </script>

<%  } %>

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
                        <a href="${pageContext.request.contextPath}/student/userInfo.jsp?page=0&type=all">个人信息</a>

                    </li>
                </ol>
            </div>
            <div class="col-lg-2">
            </div>
        </div>

        <div class="col-lg-12">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <h5>失物展示</h5>
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
                                <td style="width:10%;">失物名称</td>
                                <td style="width:20%;">失物描述</td>
                                <td style="width:15%;">发布时间</td>
                                <td style="width:15%;">发布地点</td>
                                <td style="width:10%;">管理员姓名</td>
                                <td style="width:15%;">管理员电话</td>
                                <td style="width:5%;">是否认领</td>
                            </tr>
                            </thead>

                            <tbody>
                            <% if(length == 0 && start == 0) { %>
                            <tr>
                                <td colspan="8">暂时还没有同学捡到了东西哦～</td>
                            </tr>
                            <% } else {
                                for(int i = 0 ; i < length ; i++){ %>
                            <tr>
                                <td><%=items[i][1]%></td>
                                <td><%=items[i][2]%></td>
                                <td><%=items[i][3]%></td>
                                <td><%=items[i][4]%></td>
                                <td><%=items[i][5]%></td>
                                <td><%=items[i][6]%></td>

                                <td><input class="btn btn-primary btn-block" type="button" onclick="window.location.href='applyFor.jsp?page=<%=request.getParameter("page")%>&type=<%=request.getParameter("type")%>&item_no=<%=items[i][0]%>'" value="认领"></td>
                                <%--        <td><a href="./applyFor.jsp?item_no=<%=items[i][0]%>&name=<%=items[i][1]%>&description=<%=items[i][2]%>">认领</a></td>--%>
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
                                <td colspan="6">
                                    <a href="${pageContext.request.contextPath}/student/itemInfo.jsp?page=<%=front%>">上一页</a>
                                    <a href="${pageContext.request.contextPath}/student/itemInfo.jsp?page=<%=next%>">下一页</a>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <div class="footer" th:include="footer :: copyright"></div>
    </div>
</div>

</body>
</html>
