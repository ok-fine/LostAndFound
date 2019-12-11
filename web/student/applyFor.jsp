<%--
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
</head>
<body>

填写认领申请<br>

<table>
    <tr>
        <th>失物名称</th>
        <th>失物描述</th>
    </tr>
    <tr>
        <th><%=request.getParameter("name")%>></th>
        <th><%=request.getParameter("description")%>></th>
    </tr>
</table>

<br>
<br>

<form action="${pageContext.request.contextPath}/ApplyServlet" method="post">
    <input type="hidden" name="item_no" value="<%=request.getParameter("item_no")%>>">
    <tr>
        <th>认领描述</th>
        <th><textarea name="reason" placeholder="请对物品进行一定的描述"></textarea></th>
    </tr>
    <tr>
        <th>预计认领时间</th>
        <th><input type="date" name="g_time"></th>
    </tr>
    <input type="submit" value="提交">
</form>

</body>
</html>
