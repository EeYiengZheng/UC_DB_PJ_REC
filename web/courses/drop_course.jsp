<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="../databases.jsp" %>
<%@include file="../taglibs.jsp" %>
<jsp:useBean id='user' scope='session' class='main.java.beans.UserBean'/>
<jsp:setProperty name='user' property='*'/>

<%
	if (user.getType().equals("Student")) {
		String query = "DELETE FROM enrolled_in WHERE student_id=? AND course_id=?";
		PreparedStatement stmt = con.prepareStatement(query);
		stmt.setString(1, request.getParameter("student_id"));
		stmt.setString(2, request.getParameter("course_id"));
		
		try {
			stmt.executeUpdate();
			request.setAttribute("resultMessage", "Course dropped successfully!");
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
	}
	else {
		String query = "DELETE FROM teaches WHERE professor_id=? AND course_id=?";
		PreparedStatement stmt = con.prepareStatement(query);
		stmt.setString(1, request.getParameter("professor_id"));
		stmt.setString(2, request.getParameter("course_id"));
		
		try {
			stmt.executeUpdate();
			request.setAttribute("resultMessage", "Course dropped successfully!");
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
	}
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
