<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="../databases.jsp" %>
<%@include file="../taglibs.jsp" %>
<jsp:useBean id='user' scope='session' class='main.java.beans.UserBean'/>
<jsp:setProperty name='user' property='*'/>

<%

	String query = "SELECT user_id FROM Users WHERE username=?";
	PreparedStatement stmt = con.prepareStatement(query);
	stmt.setString(1, user.getUsername());
	ResultSet idResult = stmt.executeQuery();
	idResult.next();
	int userID = idResult.getInt("user_id");
	stmt.close();
	
	query = "SELECT course_id FROM courses WHERE dept_short_name=? AND course_number=?";
	stmt = con.prepareStatement(query);
	stmt.setString(1, request.getParameter("dept_short_name"));
	stmt.setString(2, request.getParameter("course_number"));
	ResultSet courseResult = stmt.executeQuery();
	courseResult.next();
	int courseID = courseResult.getInt("course_id");
	stmt.close();

	query = "INSERT INTO enrolled_in(student_id, course_id, grade, is_taking) VALUES(?, ?, ?, ?)";
	stmt = con.prepareStatement(query);
	stmt.setInt(1, userID);
	stmt.setInt(2, courseID);
	stmt.setString(3, null);
	stmt.setBoolean(4, true);
	
	try {
		stmt.executeUpdate();
    	request.setAttribute("resultMessage", "Course added successfully!");
	}
	catch(Exception e) {
		request.setAttribute("resultMessage", "An error occurred while attempting to add the course. Please contact the system administrator.");
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
