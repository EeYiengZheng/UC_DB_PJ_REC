<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="../databases.jsp" %>
<%@include file="../taglibs.jsp" %>
<%@include file="../constants.jsp" %>
<jsp:useBean id='user' scope='session' class='main.java.beans.UserBean'/>
<jsp:setProperty name='user' property='*'/>


<c:set var="bodyContent">
    <c:choose>
        <c:when test="${user.loggedIn}">
            <%
                String query = "";
                int id = 0;
                if (user.getType().equals("Student")) {
					if (Integer.parseInt(request.getParameter("count")) >= CLASS_CAP) {
						con.close();
						request.setAttribute("resultMessage", "<p>The class you are trying to add is full.</p>");
					}
                    query = "SELECT student_id FROM students NATURAL JOIN users WHERE username=?";
                    PreparedStatement stmt = con.prepareStatement(query);
                    stmt.setString(1, user.getUsername());
                    ResultSet idResult = stmt.executeQuery();
                    idResult.next();
                    id = idResult.getInt("student_id");
                    stmt.close();
                } else {
                    query = "SELECT professor_id, dept_short_name FROM professors NATURAL JOIN users NATURAL LEFT JOIN hired_by WHERE username=?";
                    PreparedStatement stmt = con.prepareStatement(query);
                    stmt.setString(1, user.getUsername());
                    ResultSet profResult = stmt.executeQuery();
                    profResult.next();
					String classDepartment = request.getParameter("dept_short_name");
					String profDepartment = profResult.getString("dept_short_name");
					if (profDepartment == null || !classDepartment.equals(profDepartment)) {
						stmt.close();
						con.close();
						request.setAttribute("resultMessage", "<p>You are not authorized to teach a class in this department.</p>");
					}
					
                    id = profResult.getInt("professor_id");
                    stmt.close();
                }
				
				String classTime = request.getParameter("time");
				boolean collisionFound = false;
				
				PreparedStatement stmt = null;
				if (user.getType().equals("Student")) {
					//Check for time collisions
					if (!classTime.equals("N/A")) {
						query = "SELECT session_date, session_time FROM enrolled_in NATURAL JOIN students NATURAL JOIN users NATURAL JOIN taught_in WHERE username=?";
						stmt = con.prepareStatement(query);
						stmt.setString(1, user.getUsername());
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
						query = "SELECT session_date, session_time FROM teaches NATURAL JOIN professors NATURAL JOIN users NATURAL JOIN taught_in WHERE username=?";
						stmt = con.prepareStatement(query);
						stmt.setString(1, user.getUsername());
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
//                RequestDispatcher rd = request.getRequestDispatcher("search.jsp");
//                rd.forward(request, response);
                String rd_url = request.getParameter("rd_url");
				response.sendRedirect(rd_url);
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