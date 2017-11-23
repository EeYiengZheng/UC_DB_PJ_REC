<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<jsp:useBean id='user' scope='session' class='beans.UserBean'/>
<jsp:setProperty name='user' property='*'/>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Login</title>
</head>
<body>
<form method="POST" action="login_action.jsp">
    <p>UserID: <input type="text" name="userID" size="20"></p>
    <p>Password: <input type="password" name="password" size="20"></p>
    <br>
    <p><input type="submit" value="Submit" name="B1"></p>
    <% if (request.getAttribute("errorMessage") != null) {
        out.println(request.getAttribute("errorMessage"));
    }
    %>
</form>
</body>
</html>