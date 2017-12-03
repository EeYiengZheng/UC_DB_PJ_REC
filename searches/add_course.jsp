<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="../databases.jsp" %>
<%@include file="../taglibs.jsp" %>
<jsp:useBean id='user' scope='session' class='main.java.beans.UserBean'/>
<jsp:setProperty name='user' property='*'/>


<c:set var="bodyContent">
    <c:choose>
        <c:when test="${user.loggedIn}">
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
                } else {
                    query = "SELECT professor_id FROM Professors NATURAL JOIN Users WHERE username=?";
                    PreparedStatement stmt = con.prepareStatement(query);
                    stmt.setString(1, user.getUsername());
                    ResultSet idResult = stmt.executeQuery();
                    idResult.next();
                    id = idResult.getInt("professor_id");
                    stmt.close();
                }
				
				String classTime = request.getParameter("time");
				boolean collisionFound = false;
				
				PreparedStatement stmt = null;
				if (user.getType().equals("Student")) {
					//Check for time collisions
					if (!classTime.equals("N/A")) {
						query = "SELECT session_date, session_time FROM enrolled_in NATURAL JOIN taught_in";
						stmt = con.prepareStatement(query);
						ResultSet rs = stmt.executeQuery();
						while (!collisionFound && rs.next()) {
							String time = rs.getString("session_date") + " " + rs.getString("session_time");
							collisionFound = time.equals(classTime);	
						}
						stmt.close();
					}
					
					
                    query = "INSERT INTO enrolled_in(student_id, course_id, grade, is_taking) VALUES(?, ?, ?, ?)";
                    stmt = con.prepareStatement(query);
                    stmt.setInt(1, id);
                    stmt.setString(2, request.getParameter("courseID"));
                    stmt.setString(3, null);
                    stmt.setBoolean(4, true);
                } else {
					//Check for time collisions
					if (!classTime.equals("N/A")) {
						query = "SELECT session_date, session_time FROM teaches NATURAL JOIN taught_in";
						stmt = con.prepareStatement(query);
						ResultSet rs = stmt.executeQuery();
						while (!collisionFound && rs.next()) {
							String time = rs.getString("session_date") + " " + rs.getString("session_time");
							collisionFound = time.equals(classTime);	
						}
						stmt.close();
					}
					
					
                    query = "INSERT INTO teaches(professor_id, course_id) VALUES(?, ?)";
                    stmt = con.prepareStatement(query);
                    stmt.setInt(1, id);
                    stmt.setString(2, request.getParameter("courseID"));
                }

                try {
					if (collisionFound) {
						request.setAttribute("resultMessage", "<p>You already have a course that occupies the same time slot!</p>");
					}
					else {
                    	stmt.executeUpdate();
                    	request.setAttribute("resultMessage", "<p align='center'>Course added successfully!</p>");	
					}
                } catch (Exception e) {
                    request.setAttribute("resultMessage", "<p>An error occurred while attempting to add the course. Please contact the system administrator.</p>");
                } finally {
                    stmt.close();
                    con.close();
                }
                RequestDispatcher rd = request.getRequestDispatcher("search.jsp");
                rd.forward(request, response);
            %>

        </c:when>
        <c:otherwise>
            <p> You are signed out. </p>
        </c:otherwise>
    </c:choose>
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