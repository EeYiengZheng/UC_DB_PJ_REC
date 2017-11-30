<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="../taglibs.jsp" %>
<jsp:useBean id='user' scope='session' class='main.java.beans.UserBean'/>
<jsp:setProperty name='user' property='*'/>


<c:set var="bodyContent">

    <% if (request.getAttribute("resultMessage") != null) {
        out.println(request.getAttribute("resultMessage"));
    }
    %>
    
<form action="search_result.jsp">
  Subject:<br>
  <input type="text" name="subject"><br>
  Course Number:<br>
  <input type="text" name="courseNum">
  <input type="submit" value="Search" id="search_btn">
</form>

</c:set>

<t:genericpage>
    <jsp:attribute name="head">
        <title>Search Courses</title>
    </jsp:attribute>
    <jsp:attribute name="header">
    </jsp:attribute>
    <jsp:attribute name="footer">
    </jsp:attribute>
    <jsp:body>
        ${bodyContent}
    </jsp:body>

</t:genericpage>
