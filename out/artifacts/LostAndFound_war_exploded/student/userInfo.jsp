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
</head>
<body>
<%

    String apply_no = request.getParameter("apply_no");
    if(apply_no != null){
        Application.delete(Integer.parseInt(apply_no));
    }

    User user = (User) session.getAttribute("user");

    int start = Integer.parseInt(request.getParameter("page"));
    String type = request.getParameter("type");
    String editInfo = request.getParameter("editInfo");
//    String editApply = request.getParameter("editApply");

    int no = -1;

    String[][] applications = new String[3][9];
    int length = 0;
    try {
        applications = Application.applications(start, user.getNo(), type);
        length = Integer.parseInt(applications[2][0]);
    } catch (SQLException e) {
        e.printStackTrace();
    }
%>

<a href="${pageContext.request.contextPath}/student/userInfo.jsp?page=<%=start%>&type=<%=type%>&editInfo=1">编辑个人信息</a><br>
<form action="${pageContext.request.contextPath}/StudentServlet" method="get" style="width: 60%">
    <input type="hidden" name="page" value="<%=start%>">
    <input type="hidden" name="type" value="<%=type%>">
    <input type="hidden" name="user_no" value="<%=user.getNo()%>">
    <table border="1">
        <thead>
        <tr>
            <td colspan="2" align="center">用户个人信息</td>
        </tr>
        <tr>
            <td style="width: 5%;">用户名</td>
            <% if(editInfo != null){ %>
                <td><input type="text" placeholder="<%=user.getName()%>" name="name" required></td>
            <% }else { %>
                <td style="width: 10%;"><%=user.getName()%></td>
            <% } %>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td style="width: 5%;">电话</td>
            <% if(editInfo != null){ %>
            <td><input type="text" placeholder="<%=user.getTel()%>" name="tel" required></td>
            <% }else { %>
            <td style="width: 10%;"><%=user.getTel()%></td>
            <% } %>
        </tr>
        <% if(editInfo != null){ %>
        <tr>
            <td style="width: 5%;">登陆密码</td>
            <td><input type="text" placeholder="<%=user.getPassword()%>" name="password" required></td>
        </tr>
        <tr>
            <td colspan="2"><input type="submit" value="确定"></td>
        </tr>
        <% }%>
        </tbody>
    </table>
</form>

<a href="${pageContext.request.contextPath}/student/itemInfo.jsp?page=0">回到首页</a><br>
<a href="${pageContext.request.contextPath}/student/userInfo.jsp?page=0&type=all">全部申请</a>
 /
<a href="${pageContext.request.contextPath}/student/userInfo.jsp?page=0&type=wait">待审核申请</a>
<br>
<br>


<table border="1">
    <tbody>
    <tr>
        <th style="width:5%;">失物名称</th>
        <th style="width:15%;">失物描述</th>
        <th style="width:15%;">认领描述</th>
        <th style="width:10%;">申请时间</th>
        <th style="width:5%;">管理员姓名</th>
        <th style="width:10%;">管理员电话</th>
        <th style="width:5%;">状态</th>
        <th style="width:10%;" colspan="2">操作</th>
    </tr>
    </tbody>
    <% if(length == 0 && start == 0) { %>
    <tr>
        <td colspan="9">暂时还没有认领东西哦～</td>
    </tr>

    <%} else {
        for(int i = 0 ; i < length ; i++){
//            if(type.equals("wait") && !applications[i][7].equals("待审核")){
//                continue;
//            } else {
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
//        }
        }
    }
%>
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

    <thead>

    </thead>

</table>

<script language="JavaScript">
    function deleteApp(){
        if(confirm("确定删除吗？")){
            location.href = "${pageContext.request.contextPath}/student/userInfo.jsp?page=<%=start%>&type=<%=type%>";
        }
    }
</script>

</body>
</html>