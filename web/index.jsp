<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id='user' scope='session' class="main.java.beans.UserBean"/>
<jsp:setProperty name='user' property='*'/>

<html>
<head>
    <title>CS157A Database Project</title>
</head>
<body>
<a href="<c:url value = "index.jsp"/>">CS157A Database Project</a>

<br>
<a href="<c:url value="account/login.jsp"/> ">Login</a>
<br>
<a href="<c:url value="account/register.jsp"/> ">Register</a>


</body>
</html>
