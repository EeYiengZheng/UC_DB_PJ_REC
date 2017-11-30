<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="../databases.jsp" %>
<%@include file="../taglibs.jsp" %>
<jsp:useBean id='user' scope='session' class='main.java.beans.UserBean'/>
<jsp:setProperty name='user' property='*'/>

<%
	String query = "";
	int id = 0;
	if (user.getType().equals("Student")) {
		query = "SELECT student_id FROM Students NATURAL JOIN Users WHERE username=?";
		PreparedStatement stmt = con.prepareStatement(query);
		stmt.setString(1, user.getUsername());
		ResultSet idResult = stmt.executeQuery();
		idResult.next();
		id = idResult.getInt("student_id");
		stmt.close();
	}
	else {
		query = "SELECT professor_id FROM Professors NATURAL JOIN Users WHERE username=?";	
		PreparedStatement stmt = con.prepareStatement(query);
		stmt.setString(1, user.getUsername());
		ResultSet idResult = stmt.executeQuery();
		idResult.next();
		id = idResult.getInt("professor_id");
		stmt.close();
	}
	
	query = "SELECT course_id FROM courses WHERE dept_short_name=? AND course_number=?";
	PreparedStatement stmt = con.prepareStatement(query);
	stmt.setString(1, request.getParameter("dept_short_name"));
	stmt.setString(2, request.getParameter("course_number"));
	ResultSet courseResult = stmt.executeQuery();
	courseResult.next();
	int courseID = courseResult.getInt("course_id");
	stmt.close();

	if (user.getType().equals("Student")) {
		query = "INSERT INTO enrolled_in(student_id, course_id, grade, is_taking) VALUES(?, ?, ?, ?)";
		stmt = con.prepareStatement(query);
		stmt.setInt(1, id);
		stmt.setInt(2, courseID);
		stmt.setString(3, null);
		stmt.setBoolean(4, true);
	}
	else {
		query = "INSERT INTO teaches(professor_id, course_id) VALUES(?, ?)";
		stmt = con.prepareStatement(query);
		stmt.setInt(1, id);
		stmt.setInt(2, courseID);
	}
	
	try {
		stmt.executeUpdate();
    	request.setAttribute("resultMessage", "<p>Course added successfully!</p>");
	}
	catch(Exception e) {
		request.setAttribute("resultMessage", "<p>An error occurred while attempting to add the course. Please contact the system administrator.</p>");
	}
	finally {
		stmt.close();
		con.close();
	}
	RequestDispatcher rd = request.getRequestDispatcher("search.jsp");
    rd.forward(request, response);
%>

<c:set var="bodyContent">

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
