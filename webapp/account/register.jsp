<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<jsp:useBean id='user' scope='session' class='beans.UserBean'/>
<jsp:setProperty name='user' property='*'/>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Registration</title>
</head>
<body>
<form method="POST" action="register_action.jsp">
    <label>UserID:
        <input type="text" name="userID" size="20">
    </label>
    <label>Email Address:
        <input type="text" name="email" size="20">
    </label>
    <label>Name:
        <input type="text" name="name" size="20"></label>
    <label>Password:
        <input type="password" name="password" size="20"></label>
    <br>
    <input type="submit" value="Submit" name="B1">
</form>

</body>
</html>