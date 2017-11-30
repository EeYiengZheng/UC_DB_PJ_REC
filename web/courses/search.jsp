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
String query = "SELECT * FROM courses NATURAL JOIN enrolled_in WHERE student_id IN (SELECT student_id FROM Students NATURAL JOIN Users WHERE username=?)";
PreparedStatement stmt = con.prepareStatement(query);
stmt.setString(1, user.getUsername());
ResultSet courseList = stmt.executeQuery();
while (courseList.next()) {
	out.println("<p>" + courseList.getString("dept_short_name") + " " + courseList.getString("course_number") + ":" + courseList.getString("course_name"));
	out.println("<form action='drop_course.jsp' method='GET'><input type='hidden' name='course_id' value='" + courseList.getString("course_id") + "'><input name='student_id' type='hidden' value='" + courseList.getString("student_id") + "'><input type='Submit' value='Drop'></form>");
	out.println("</p>");
}


stmt.close();
con.close();
%>

<h3>Search for Courses</h3>
<% if (request.getAttribute("resultMessage") != null) {
	out.println("<p>" + request.getAttribute("resultMessage") + "</p>");
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
