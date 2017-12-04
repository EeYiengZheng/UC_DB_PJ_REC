<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="../databases.jsp" %>
<%@include file="../taglibs.jsp" %>
<%@include file="../constants.jsp" %>
<jsp:useBean id='user' scope='session' class='main.java.beans.UserBean'/>
<jsp:setProperty name='user' property='*'/>
    
    <c:set var="bodyContent">
    <c:choose>
        <c:when test="${user.loggedIn}">
<%
    String query = "SELECT * FROM Users_Detail WHERE user_id IN(SELECT user_id FROM Users WHERE username=?)";
    PreparedStatement stmt = con.prepareStatement(query);
    stmt.setString(1, user.getUsername());
    ResultSet rs = stmt.executeQuery();

   out.println("<p>Welcome back, " + user.getUsername() + "!<br><br> You are using a(n) <b>" + user.getType() + "</b> account. <br><br> You can do the following things with your account: ");
   
   out.println("<li></li>");
%>
        </c:when>
        <c:otherwise>
            <p> You are signed out. </p>
        </c:otherwise>
    </c:choose>
</c:set>
<t:genericpage>
    <jsp:attribute name="head">
        <title>Dashboard</title>
    </jsp:attribute>
    <jsp:attribute name="header">
      <h1 class="display-3">Dashboard</h1>
    </jsp:attribute>
    <jsp:attribute name="footer">
      <p id="copyright"></p>
    </jsp:attribute>
    <jsp:body>
        <div class="container justify-content-center" style="width: auto">
        ${bodyContent}
        </div>
    </jsp:body>

</t:genericpage>
