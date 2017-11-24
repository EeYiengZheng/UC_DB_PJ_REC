<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="../taglibs.jsp" %>
<jsp:useBean id='user' scope='session' class='main.java.beans.UserBean'/>
<jsp:setProperty name='user' property='*'/>

<c:set var="bodyContent">
    <form method="POST" action="login_action.jsp">
    <p>UserID: <input type="text" name="userID" size="20"></p>
    <p>Password: <input type="password" name="password" size="20"></p>
    <br>
    <p><input type="submit" value="Submit" name="B1"></p>
    <% if (request.getAttribute("errorMessage") != null) {
        out.println(request.getAttribute("errorMessage"));
    }
    %>
</c:set>
<t:genericpage>
    <jsp:attribute name="head">
        <title>Login</title>
    </jsp:attribute>
    <jsp:attribute name="header">
      <h1 class="display-3">CS157A Database Project</h1>
    </jsp:attribute>
    <jsp:attribute name="footer">
      <p id="copyright">Copyright 2017, and I hate JSP</p>
    </jsp:attribute>
    <jsp:body>
        ${bodyContent}
    </jsp:body>

</t:genericpage>
