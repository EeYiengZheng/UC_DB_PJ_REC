<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="../taglibs.jsp" %>
<jsp:useBean id='user' scope='session' class='main.java.beans.UserBean'/>
<jsp:setProperty name='user' property='*'/>


<c:set var="bodyContent">
<p>Grades go here</p>
</c:set>

<t:genericpage>
    <jsp:attribute name="head">
        <title>Grades</title>
    </jsp:attribute>
    <jsp:attribute name="header">
        <h1 class="display-3">Grades</h1>
    </jsp:attribute>
    <jsp:attribute name="footer">
    </jsp:attribute>
    <jsp:body>
        ${bodyContent}
    </jsp:body>

</t:genericpage>
