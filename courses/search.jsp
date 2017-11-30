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
    <div class="col-25"><label>Subject:</label></div>
    <div class="col-25"><input type="text" name="subject"><br></div>
    <div class="col-25"><label>Course Number:</label></div><br>
    <div class="col-25"><input type="text" name="courseNum"></div><br><br>
    <div class="col-25"><input type="submit" value="Search" id="search_btn"></div>
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
