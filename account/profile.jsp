<%@include file="../taglibs.jsp" %>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:useBean id="user" scope='session' class="main.java.beans.UserBean"/>

<c:set var="bodyContent">
    <c:choose>
        <c:when test="${user.loggedIn}">
            <p> Body content </p>
        </c:when>
        <c:otherwise>
            <p> You are signed out </p>
        </c:otherwise>
    </c:choose>
</c:set>
<t:genericpage>
    <jsp:attribute name="head">
        <title>Portal</title>
    </jsp:attribute>
    <jsp:attribute name="header">
      <h1 class="display-3">Your Portal Placeholder</h1>
    </jsp:attribute>
    <jsp:attribute name="footer">
      <p id="copyright">Yep, I still hate JSP</p>
    </jsp:attribute>
    <jsp:body>
        ${bodyContent}
    </jsp:body>

</t:genericpage>
