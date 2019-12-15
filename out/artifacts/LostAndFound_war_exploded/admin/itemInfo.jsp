<%@ page import="entity.User" %>
<%@ page import="org.omg.PortableInterceptor.INACTIVE" %><%--
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
</head>
<body>
<body class="gray-bg">

<%
    User user = (User) session.getAttribute("user");
    int start = Integer.parseInt(request.getParameter("page"));

    String[][] items = (String[][]) request.getAttribute("items");
    int length = Integer.parseInt(items[2][0]);

    String login = (String) session.getAttribute("login");
    String admin = (String) session.getAttribute("admin");
    int mine = (int) session.getAttribute("mine");
%>

欢迎来到湖南大学失物招领处<br>

<a href="${pageContext.request.contextPath}/login.jsp" onclick="user.exit()">退出</a><br>
<%--<a href="${pageContext.request.contextPath}/admin/manage.jsp">申请管理</a>--%>
<a href="${pageContext.request.contextPath}/admin/index.jsp">认领审核</a>
&nbsp;/&nbsp;
<a href="${pageContext.request.contextPath}/admin/itemInfo.jsp?page=0&mine=<%=-1 * mine%>">只看我的</a>

<table border="1">
    <thead>
    <tr>
        <td style="width:5%;">失物名称</td>
        <td style="width:15%;">失物描述</td>
        <td style="width:10%;">发布时间</td>
        <td style="width:10%;">发布地点</td>
        <td style="width:5%;">管理员姓名</td>
        <td style="width:10%;">管理员电话</td>
        <td style="width:5%;" colspan="2">操作</td>
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
            if(mine == 1 && !items[i][7].equals(String.valueOf(user.getNo()))){
                continue;
            } else {
    %>
            <tr>
                <td><%=items[i][1]%></td>
                <td><%=items[i][2]%></td>
                <td><%=items[i][3]%></td>
                <td><%=items[i][4]%></td>
                <td><%=items[i][5]%></td>
                <td><%=items[i][6]%></td>

                <% if(items[i][7].equals(String.valueOf(user.getNo()))){ %>
                        <td><input type="button" onclick="window.location.href='applyFor.jsp?item_no=<%=items[i][0]%>&name=<%=items[i][1]%>&description=<%=items[i][2]%>'" value="编辑"></td>
                        <td><input type="button" onclick="window.location.href='applyFor.jsp?item_no=<%=items[i][0]%>&name=<%=items[i][1]%>&description=<%=items[i][2]%>'" value="删除"></td>
                <% }else { %>
                <td colspan="2">无法操作</td>
        <%--                <td><input type="button" onclick="confirm('这不是您发布的物品～')" value="编辑"></td>--%>
        <%--                <td><input type="button" onclick="confirm('这不是您发布的物品～')" value="删除"></td>--%>
                <% } %>

            </tr>
    <% } } %>

    <tr>
        <%
            int front = start - 2;
            if(front < 0) front = 0;
            int next = start + 2;
            if(length < 2) next = start;
        %>
        <td>第<%=start / 2 + 1%>页</td>
        <td colspan="6">
            <a href="${pageContext.request.contextPath}/admin/itemInfo.jsp?page=<%=front%>&mine=<%=mine%>">上一页</a>
            <a href="${pageContext.request.contextPath}/admin/itemInfo.jsp?page=<%=next%>&mine=<%=mine%>">下一页</a>
        </td>
    </tr>
    </tbody>
</table>

</body>
</html>
