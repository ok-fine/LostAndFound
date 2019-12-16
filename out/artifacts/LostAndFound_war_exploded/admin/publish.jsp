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

<div id="wrapper">
    <nav class="navbar-default navbar-static-side" role="navigation" th:include="nav :: navigation"></nav>
    <div id="page-wrapper" class="gray-bg">
        <div class="border-bottom" th:include="header :: headerTop"></div>
        <div class="row wrapper border-bottom white-bg page-heading" th:fragment="headerNav">
            <div class="col-lg-10">
                <h2>发布招领</h2>
                <ol class="breadcrumb">
                    <li>
                        <a href="${pageContext.request.contextPath}/login.jsp" onclick="user.exit()">退出登陆</a>
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
                            <form action="${pageContext.request.contextPath}/AdminServlet" method="post" class="form-inline">
                                <div class="row">
                                    <div class="form-group">
                                        <label for="name">&nbsp;&nbsp;失物名称：</label>
                                        <input type="text" name="name" placeholder="请输入物品类别" class="form-control" id="name" required/>
                                    </div>
                                    <br>
                                    <br>
                                    <div class="form-group">
                                        <label for="des">&nbsp;&nbsp;失物描述：</label>
                                        <textarea name="des" placeholder="请对物品进行一定的描述" class="form-control" id="des" required></textarea>
                                    </div>
                                    <br>
                                    <br>
                                    <div class="col-sm-offset-4 col-sm-3" style="margin-top: 15px;">
                                        <button class="btn btn-primary btn-block" type="submit"><i
                                                class="fa fa-search"></i>&nbsp;&nbsp;&nbsp;&nbsp;<strong>确认发布</strong>
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
