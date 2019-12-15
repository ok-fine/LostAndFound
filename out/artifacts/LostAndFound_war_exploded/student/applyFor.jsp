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

<% if(request.getParameter("type") != null){ %>
<a href="${pageContext.request.contextPath}/student/userInfo.jsp?page=<%=request.getParameter("page")%>&type=<%=request.getParameter("type")%>">返回</a>
<% }else { %>
<a href="${pageContext.request.contextPath}/student/itemInfo.jsp?page=<%=request.getParameter("page")%>">返回</a>
<% } %>
<th><%=request.getParameter("item_no")%></th><br>

<div style="width:30%; text-align:center">
    <table border="1">
        <tr>
            <th style="width:5%;">失物名称</th>
            <th style="width:10%;">失物描述</th>
        </tr>
        <tr>
            <th><%=request.getParameter("name")%></th>
            <th><%=request.getParameter("description")%></th>
        </tr>
    </table>

    <br>
    <br>

    <form action="${pageContext.request.contextPath}/ApplyServlet?page=<%=request.getParameter("page")%>&type=<%=request.getParameter("type")%>" method="post">
        <input type="hidden" name="item_no" value="<%=request.getParameter("item_no")%>">
        <label>认领描述：<textarea name="reason" placeholder="请对物品进行一定的描述"></textarea></label><br>
        <label>预计认领时间：<input type="text" name="g_time" placeholder="xxxx-xx-xx xx:xx" onfocus="WdatePicker({dataFmt:'YYYY-MM-DD HH:mm'})"></label>
        <input type="submit" value="提交">
    </form>
</div>

</body>
</html>
