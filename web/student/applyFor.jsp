<%@ page import="java.sql.SQLException" %>
<%@ page import="entity.ItemMgr" %><%--
  Created by IntelliJ IDEA.
  User: weijieyang
  Date: 2019/12/12
  Time: 上午1:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>申请认领</title>

    <link type="text/css" href="../css/bootstrap.min.css" rel="stylesheet" />
    <link type="text/css" href="../font-awesome/css/font-awesome.css" rel="stylesheet" />
    <link type="text/css" href="../css/style.css" rel="stylesheet" />

    <link type="text/css" href="../css/plugins/iCheck/custom.css" rel="stylesheet"/>
    <link type="text/css" href="../css/plugins/footable/footable.core.css" rel="stylesheet"/>

</head>
<body>

<%
    int item_no = Integer.parseInt(request.getParameter("item_no"));
    String[] info = new String[0];
    try {
        info = ItemMgr.getInfo(item_no);
    } catch (SQLException e) {
        e.printStackTrace();
    }
%>

<div id="wrapper">
    <nav class="navbar-default navbar-static-side" role="navigation" th:include="nav :: navigation"></nav>
    <div id="page-wrapper" class="gray-bg">
        <div class="border-bottom" th:include="header :: headerTop"></div>
        <div class="row wrapper border-bottom white-bg page-heading" th:fragment="headerNav">
            <div class="col-lg-10">
                <h2>认领申请</h2>
                <ol class="breadcrumb">
                    <li>
                        <a href="${pageContext.request.contextPath}/student/itemInfo.jsp?page=<%=request.getParameter("page")%>">返回</a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/student/itemInfo.jsp?page=0">失物展示</a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/student/userInfo.jsp?page=0&type=all">个人信息</a>
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
                            <h5>失物详情</h5>
                            <div class="ibox-tools">
                                <a class="collapse-link">
                                    <i class="fa fa-chevron-up"></i>
                                </a>
                            </div>
                        </div>
                        <div class="ibox-content" style="display: block;">
                            <div class="row">
                                <table width="100%">
                                    <tr>
                                        <td width="50%">
                                            <div class="form-group">
                                                <label>&nbsp;&nbsp;失物名称：</label><%=info[0]%>
                                            </div>
                                        </td>

                                        <td width="50%">
                                            <div class="form-group">
                                                <label>&nbsp;&nbsp;失物描述：</label><%=info[1]%>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div class="form-group">
                                                <label>&nbsp;&nbsp;发布时间：</label><%=info[2]%>
                                            </div>
                                        </td>

                                        <td>
                                            <div class="form-group">
                                                <label>&nbsp;&nbsp;发布地点：</label><%=info[3]%>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div class="form-group">
                                                <label>&nbsp;&nbsp;管理员姓名：</label><%=info[4]%>
                                            </div>
                                        </td>

                                        <td>
                                            <div class="form-group">
                                                <label>&nbsp;&nbsp;管理员电话：</label><%=info[5]%>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-12">
                    <div class="ibox float-e-margins">
                        <div class="ibox-title">
                            <h5>认领资料填写</h5>
                            <div class="ibox-tools">
                                <a class="collapse-link">
                                    <i class="fa fa-chevron-up"></i>
                                </a>
                            </div>
                        </div>
                        <div class="ibox-content">
                            <div class="table-responsive" text-align="center">
                                <form text-align="center" action="${pageContext.request.contextPath}/ApplyServlet?page=<%=request.getParameter("page")%>&type=<%=request.getParameter("type")%>" method="post">
                                    <input type="hidden" name="item_no" value="<%=request.getParameter("item_no")%>"><br>
                                    <br>
                                    <table style="width: 60%; margin:0 auto;" class=" table table-bordered table-hover" data-page-size="10">
                                        <tbody>
                                        <tr>
                                            <th style="width:10%;"><label for="des">认领描述：</label></th>
                                            <th style="width:20%;"><textarea rows="5" id="des" name="reason" placeholder="请对物品进行一定的描述" required></textarea></th>
                                        </tr>

                                        <tr>
                                            <th><label for="time">预计认领时间：</label></th>
                                            <th><input type="text" name="g_time" id="time" placeholder="xxxx-xx-xx xx:xx" onfocus="WdatePicker({dataFmt:'YYYY-MM-DD HH:mm'})" required><br><br></th>
    <%--                                        <th><label for="time">预计认领时间：</label></th>--%>
    <%--                                        <th><input type="text" name="g_time" id="time" placeholder="xxxx-xx-xx xx:xx" onfocus="WdatePicker({dataFmt:'YYYY-MM-DD HH:mm'})"></th>--%>
                                        </tr>
                                        </tbody>
                                    </table>
                                    <br>
                                    <div class="col-sm-offset-4 col-sm-3" style="margin-top: 15px;">
                                        <button class="btn btn-primary btn-block" type="submit"><i
                                                class="fa fa-search"></i>&nbsp;&nbsp;&nbsp;&nbsp;<strong>提交申请</strong>
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
