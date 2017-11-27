<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="../databases.jsp" %>
<%@include file="../taglibs.jsp" %>
<jsp:useBean id='user' scope='session' class='main.java.beans.UserBean'/>
<jsp:setProperty name='user' property='*'/>

<%

    String subject = request.getParameter("subject");
    String courseNum = request.getParameter("courseNum");
	
	if (subject == "") {
		subject = "%";
	}
	else if (courseNum == "") {
		courseNum = "%";
	}
	
	String query = "SELECT * FROM Courses WHERE dept_id IN (SELECT dept_id FROM Departments WHERE dept_short_name LIKE ?) AND course_number LIKE ?";

    PreparedStatement stmt = con.prepareStatement(query);
    stmt.setString(1, subject);
    stmt.setString(2, courseNum);
    ResultSet rs = stmt.executeQuery();

    while (rs.next()) {
		//Very ugly...will deal with front end later
		String courseNumber = rs.getString("course_number");
		String courseName = rs.getString("course_name");
		String courseDescription = rs.getString("course_description");
		out.println(courseNumber + "-----" + courseName + "-----" + courseDescription);
		out.println("<br>");
    }
	
    stmt.close();
    con.close();
%>

<c:set var="bodyContent">
Test

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
