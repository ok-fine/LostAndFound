<%--
  Created by IntelliJ IDEA.
  User: weijieyang
  Date: 2019/12/12
  Time: 上午12:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="entity.User" %>
<html>
<head>
    <title>湖南大学失物招领</title>
</head>
<body class="gray-bg">

<%
    User user = (User) session.getAttribute("user");
    int start = Integer.parseInt(request.getParameter("page"));

    String[][] items = (String[][]) request.getAttribute("items");
    int length = Integer.parseInt(items[2][0]);

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

<%=alert%>
    <script type="text/javascript" language="javascript">
        alert("<%=alert%>");
    </script>

<%  } %>


欢迎来到湖南大学失物招领处<br>

<a href="${pageContext.request.contextPath}/login.jsp" onclick="user.exit()">退出</a>
<a href="${pageContext.request.contextPath}/student/userInfo.jsp?page=0&type=all" onclick="user.exit()">个人信息</a>

<%--<% if(admin.equals("1")){ %>--%>
<%--<a href="${pageContext.request.contextPath}/admin/index.jsp?page=0">切换管理员</a><br>--%>
<%--<% }  %>--%>

<table border="1">
    <thead>
    <tr>
        <td style="width:5%;">失物名称</td>
        <td style="width:15%;">失物描述</td>
        <td style="width:10%;">发布时间</td>
        <td style="width:10%;">发布地点</td>
        <td style="width:5%;">管理员姓名</td>
        <td style="width:10%;">管理员电话</td>
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

        <td><input type="button" onclick="window.location.href='applyFor.jsp?page=<%=request.getParameter("page")%>&item_no=<%=items[i][0]%>&name=<%=items[i][1]%>&description=<%=items[i][2]%>'" value="认领"></td>
        <%--        <td><a href="./applyFor.jsp?item_no=<%=items[i][0]%>&name=<%=items[i][1]%>&description=<%=items[i][2]%>">认领</a></td>--%>
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
            <a href="${pageContext.request.contextPath}/student/itemInfo.jsp?page=<%=front%>">上一页</a>
            <a href="${pageContext.request.contextPath}/student/itemInfo.jsp?page=<%=next%>">下一页</a>
        </td>
    </tr>
    </tbody>
</table>

</body>
</html>
