<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="../taglibs.jsp" %>
<%@include file="../databases.jsp" %>
<jsp:useBean id='user' scope='session' class='main.java.beans.UserBean'/>
<jsp:setProperty name='user' property='*'/>


<c:set var="bodyContent">
	<c:choose>
    	<c:when test="${user.getType().equals('Lecturer')}">
			<h3>Courses Currently Teaching</h3>
        </c:when>
        <c:otherwise>
			<h3>Courses Currently Taking</h3>
        </c:otherwise>
	</c:choose>

<%
String query = "SELECT dept_short_name, course_number, course_name FROM courses WHERE course_id IN (SELECT course_id FROM enrolled_in WHERE student_id IN (SELECT user_id FROM Users WHERE username=?))";
PreparedStatement stmt = con.prepareStatement(query);
stmt.setString(1, user.getUsername());
ResultSet courseList = stmt.executeQuery();
while (courseList.next()) {
	out.println(courseList.getString("dept_short_name") + " " + courseList.getString("course_number") + ":" + courseList.getString("course_name"));
	out.println("<br>");
}


stmt.close();
con.close();
%>



<h3>Search for Courses</h3>
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
