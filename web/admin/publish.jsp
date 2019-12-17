<%--
  Created by IntelliJ IDEA.
  User: weijieyang
  Date: 2019/12/12
  Time: 下午9:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>发布招领</title>

    <link type="text/css" href="../css/bootstrap.min.css" rel="stylesheet" />
    <link type="text/css" href="../font-awesome/css/font-awesome.css" rel="stylesheet" />
    <link type="text/css" href="../css/style.css" rel="stylesheet" />

    <link type="text/css" href="../css/plugins/iCheck/custom.css" rel="stylesheet"/>
    <link type="text/css" href="../css/plugins/footable/footable.core.css" rel="stylesheet"/>

</head>
<body>

<%
    String item_no = request.getParameter("item_no");
    String name = "请输入物品类别";
    String description = "请对物品进行一定的描述";
    if(item_no != null){
        name = request.getParameter("name");
        description = request.getParameter("description");
    }

    String start = request.getParameter("page");
    String mine = request.getParameter("mine");
%>

<div id="wrapper">
    <nav class="navbar-default navbar-static-side" role="navigation" th:include="nav :: navigation"></nav>
    <div id="page-wrapper" class="gray-bg">
        <div class="border-bottom" th:include="header :: headerTop"></div>
        <div class="row wrapper border-bottom white-bg page-heading" th:fragment="headerNav">
            <div class="col-lg-10">
                <h2>发布招领</h2>
                <ol class="breadcrumb">
                    <li>
                        <a href="${pageContext.request.contextPath}/admin/itemInfo.jsp?page=<%=start%>&mine=<%=mine%>" onclick="user.exit()">返回</a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/admin/itemInfo.jsp?page=0&mine=-1">失物展示</a>
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
                            <h5>填写物品信息</h5>
                            <div class="ibox-tools">
                                <a class="collapse-link">
                                    <i class="fa fa-chevron-up"></i>
                                </a>
                            </div>
                        </div>
                        <div class="ibox-content" style="display: block;">
                            <div class="row" text-align="center">
                                <form action="${pageContext.request.contextPath}/AdminServlet" method="post" class="form-inline">
                                    <% if(item_no != null){ %>
                                    <input type="hidden" name="item_no" value="<%=item_no%>">
                                    <% }%>
                                    <table style="width: 30%; margin:0 auto;" border="0">
                                        <tr>
                                            <div class="form-group">
                                                <th style="width: 28%;"><label for="name">&nbsp;&nbsp;失物名称：</label></th>
                                                <td style="width: 72%;"><input type="text" name="name" placeholder="<%=name%>" class="form-control" id="name" required/></td>
                                            </div>
                                        </tr>
                                        <tr>
                                            <td colspan="2">&nbsp;&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <div class="form-group">
                                                <th text-align="top"><label for="des">&nbsp;&nbsp;失物描述：</label></th>
                                                <td><textarea rows="5" name="des" placeholder="<%=description%>" class="form-control" id="des" required></textarea></td>
                                            </div>
                                        </tr>
                                    </table>
                                    <br>
                                    <div class="col-sm-offset-4 col-sm-3" style="margin-top: 15px;">
                                        <button class="btn btn-primary btn-block" type="submit"><i
                                                class="fa fa-search"></i>&nbsp;&nbsp;&nbsp;&nbsp;<strong>确认发布</strong>
                                        </button>
                                    </div>
                                </form>
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
