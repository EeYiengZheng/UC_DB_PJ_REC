<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id='user'
 scope='session'
 class='beans.UserBean'/>
<jsp:setProperty name='user' property='*' />

<html>
<head>
    <title>$Title$</title>
</head>
<body>
<h3 align="center">CS157A Database Project</h3>
INDEX HERE


<!--Temporary Link-->
<br>
<a href="login.jsp">Login</a>
<br>
<a href="register.jsp">Register</a>


</body>
</html>
