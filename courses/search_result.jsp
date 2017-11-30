<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="../databases.jsp" %>
<%@include file="../taglibs.jsp" %>
<jsp:useBean id='user' scope='session' class='main.java.beans.UserBean'/>
<jsp:setProperty name='user' property='*'/>

    <c:set var="bodyContent">
        <table style='width:100%'><tr><th><h4>Course</h4></th><th><h4>Enroll</h4></th></tr>
<%

    String subject = request.getParameter("subject");
    String courseNum = request.getParameter("courseNum");
	
	if (subject == "") {
		subject = "%";
	}
	else if (courseNum == "") {
		courseNum = "%";
	}
	
	String query = "SELECT * FROM Courses WHERE dept_short_name LIKE ? AND course_number LIKE ?";

    PreparedStatement stmt = con.prepareStatement(query);
    stmt.setString(1, subject);
    stmt.setString(2, "%" + courseNum + "%");
    ResultSet rs = stmt.executeQuery();

    while (rs.next()) {
		//Very ugly...will deal with front end later
		String courseNumber = rs.getString("course_number");
		String courseName = rs.getString("course_name");
		String departmentShortName = rs.getString("dept_short_name");
		String courseDescription = rs.getString("course_description");
        out.println("<tr><td><p><b>" + departmentShortName + " " + courseNumber + "<br>" + courseName + "</b><br>" + courseDescription + "</p></td>");
        out.println("<td><form action='add_course.jsp' method='POST'><input type='hidden' name='dept_short_name' value='" + departmentShortName + "'><input name='course_number' type='hidden' value='" + courseNumber + "'><input type='Submit' value='Enroll'></form></td></tr><br>");
		out.println("<br>");
    }
	
    stmt.close();
    con.close();
%>
    </table>
</c:set>

<t:genericpage>
    <jsp:attribute name="head">
        <title>Search Results</title>
    </jsp:attribute>
    <jsp:attribute name="header">
        <h1 class="display-3">Search Results</h1>
    </jsp:attribute>
    <jsp:attribute name="footer">
    </jsp:attribute>
    <jsp:body>
        ${bodyContent}
    </jsp:body>

</t:genericpage>
