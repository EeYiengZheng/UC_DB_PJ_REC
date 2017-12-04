<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="../databases.jsp" %>
<%@include file="../taglibs.jsp" %>
<%@include file="../constants.jsp" %>
<jsp:useBean id='user' scope='session' class='main.java.beans.UserBean'/>
<jsp:setProperty name='user' property='*'/>

<c:set var="bodyContent">
    <table style='color: #fff; width:100%'>
        <tr>
            <th><h4>Course</h4></th>
            <th><h4>Add</h4></th>
        </tr>
        <%			
            String query = "";
            String btnName = "";
            if (user.getType().equals("Student")) {
                query = "SELECT *, COUNT(student_id) as count FROM courses NATURAL LEFT JOIN enrolled_in NATURAL LEFT JOIN taught_in NATURAL JOIN teaches NATURAL JOIN professors NATURAL JOIN users WHERE dept_short_name LIKE ? AND course_number LIKE ? AND ge LIKE ? GROUP BY course_id";
                btnName = "Enroll";
            } else if (user.getType().equals("Lecturer")) {
                query = "SELECT *, COUNT(student_id) AS count FROM courses NATURAL LEFT JOIN enrolled_in NATURAL LEFT JOIN taught_in NATURAL LEFT JOIN teaches NATURAL LEFT JOIN professors NATURAL LEFT JOIN users WHERE dept_short_name LIKE ? AND course_number LIKE ? AND ge LIKE ? GROUP BY course_id";
                btnName = "Teach";
            } else {
            }

            String subject = request.getParameter("subject");
            String courseNum = request.getParameter("courseNum");
			String ge = request.getParameter("ge");
			
            PreparedStatement stmt = con.prepareStatement(query);
            stmt.setString(1, subject.trim() + "%");
            stmt.setString(2, "%" + courseNum.trim() + "%");
			stmt.setString(3, "%" + ge + "%");
            ResultSet rs = stmt.executeQuery();
            stmt.close();
            int i = 1;
            while (rs.next()) {
                String anchID = "anchID" + i;
                i++;
                String courseID = rs.getString("course_id");
                String courseNumber = rs.getString("course_number");
                String courseName = rs.getString("course_name");
                String departmentShortName = rs.getString("dept_short_name");
                String courseDescription = rs.getString("course_description");
				String count = rs.getString("count");
				
                String location = "N/A";
                String buildingName = rs.getString("building_name");
                String roomNum = rs.getString("room_num");
                if (buildingName != null && roomNum != null) {
                    location = buildingName + " " + roomNum;
                }
				
                String time = "N/A";
                String sessionDate = rs.getString("session_date");
                String sessionTime = rs.getString("session_time");
                if (sessionDate != null && sessionTime != null) {
                    time = sessionDate + " " + sessionTime;
                }
				
                String professorName = rs.getString("first_name") == null ? NO_PROFESSOR : rs.getString("first_name") + " " + rs.getString("last_name");
                out.println("<tr><td><p id='" + anchID + "'><b>" + departmentShortName + " " + courseNumber + "<br>" + courseName + "</b><br>" + courseDescription + "<br>Instructor: " + professorName + "<br>" + "Classroom: " + location + "<br>" + "Time: " + time + "<br>Class capacity: " + count + "/" +CLASS_CAP + "</p></td>");
				
				
				//Check for time collisions or duplicate classes
				boolean collisionFound = false;
				if (!time.equals("N/A")) {
					String timeQuery = "";
					if (user.getType().equals("Student")) {
						timeQuery = "SELECT session_date, session_time FROM enrolled_in NATURAL JOIN students NATURAL JOIN users NATURAL LEFT JOIN taught_in WHERE username=?";
					}
					else if (user.getType().equals("Lecturer")) {
						timeQuery = "SELECT session_date, session_time FROM teaches NATURAL JOIN professors NATURAL JOIN users NATURAL LEFT JOIN taught_in WHERE username=?";
					}
					
					PreparedStatement timeStmt = con.prepareStatement(timeQuery);
					timeStmt.setString(1, user.getUsername());
					ResultSet timeResult = timeStmt.executeQuery();
					while (!collisionFound && timeResult.next()) {
						String classTime = timeResult.getString("session_date") + " " + timeResult.getString("session_time");
						collisionFound = time.equals(classTime);	
					}
					timeStmt.close();
				}
				else {
					String duplicateQuery = "";
					if (user.getType().equals("Student")) {
						duplicateQuery = "SELECT course_id FROM enrolled_in NATURAL JOIN students NATURAL JOIN users WHERE username=? AND course_id=?";
					}
					else if (user.getType().equals("Lecturer")) {
						duplicateQuery = "SELECT course_id FROM teaches NATURAL JOIN professors NATURAL JOIN users WHERE username=? AND course_id=?";
					}
					
					PreparedStatement duplicateStmt = con.prepareStatement(duplicateQuery);
					duplicateStmt.setString(1, user.getUsername());
					duplicateStmt.setString(2, courseID);
					ResultSet duplicateResult = duplicateStmt.executeQuery();
					if (duplicateResult.next()) {
						collisionFound = true;	
					}
					duplicateStmt.close();	
				}
					
					
				
				if (user.getType().equals("Student") && Integer.parseInt(count) <= CLASS_CAP && !collisionFound) {
					out.println("<td><form action='add_course.jsp' method='POST'><input type='hidden' name='courseID' value='" + courseID + "'><input type='hidden' name='rd_url' value='" + request.getRequestURL() + "?" + request.getQueryString() + "#" + anchID + "'><input class='action_btn_anchor btn btn-danger' type='Submit' value='" + btnName + "'></form></td></tr><br>");
				}
				else if (user.getType().equals("Lecturer") && !collisionFound) {
					
					String profQuery = "SELECT * FROM professors NATURAL LEFT JOIN hired_by NATURAL JOIN users WHERE username = ?";
					PreparedStatement profStmt = con.prepareStatement(profQuery);
					profStmt.setString(1, user.getUsername());
					ResultSet profResult = profStmt.executeQuery();
					profResult.next();
					String professorDepartment = profResult.getString("dept_short_name");
					
					
					if (departmentShortName.equals(professorDepartment) && professorName == NO_PROFESSOR) {
						out.println("<td><form action='add_course.jsp' method='POST'><input type='hidden' name='courseID' value='" + courseID + "'><input type='hidden' name='rd_url' value='" + request.getRequestURL() + "?" + request.getQueryString() + "#" + anchID + "'><input class='action_btn_anchor btn btn-danger' type='Submit' value='" + btnName + "'></form></td></tr><br>");	
					}
				}
                out.println("<br>");
            }

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
