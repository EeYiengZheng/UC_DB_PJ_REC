<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="taglibs.jsp" %>
<jsp:useBean id='user' class="main.java.beans.UserBean"/>
<jsp:setProperty name='user' property='loggedIn' value="false"/>

<t:genericpage>
    <jsp:attribute name="header">
      <h1 class="display-3">CS157A Database Project</h1>
    </jsp:attribute>
    <jsp:attribute name="footer">
      <p id="copyright">Copyright 2017, and I hate JSP</p>
    </jsp:attribute>
    <jsp:body>
        <br><br>
        <p> Uhh, about this project...</p>
    </jsp:body>
</t:genericpage>