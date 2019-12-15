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
    <title>失物发布</title>
</head>
<body>

<div style="width: 20%" text-align="center">
    <form action="${pageContext.request.contextPath}/AdminServlet" method="post">
        <label>失物名称：<input type="text" name="name" placeholder="请输入物品类别"/></label><br>
        <label>失物描述：<textarea name="des" placeholder="请对物品进行一定的描述"></textarea></label><br>
        <input type="submit" value="发布">
    </form>
</div>

</body>
</html>
