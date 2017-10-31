<%--
  Created by IntelliJ IDEA.
  User: Emp
  Date: 10/20/2017
  Time: 12:06 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>$Title$</title>
</head>
<body>
<h3 align="center">CS157A 3-tier Demo</h3>

<form method="POST" action="DBtest.jsp">
    <p>Username: <input type="text" name="username" size="20"></p>
    <p>Password: <input type="password" name="password" size="20"></p>
    <br>
    <p>Database Name: <input type="text" name="databaseName" size="20"></p>
    <p>Table Name: <input type="text" name="tableName" size="20"></p>
    <br>
    <p><input type="submit" value="Submit" name="B1"></p>
</form>
</body>
</html>
