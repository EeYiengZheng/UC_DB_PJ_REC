<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="../taglibs.jsp" %>
<%@include file="../databases.jsp" %>
<jsp:useBean id='user' scope='session' class='main.java.beans.UserBean'/>
<jsp:setProperty name='user' property='*'/>


<c:set var="bodyContent">
    <c:choose>
        <c:when test="${user.loggedIn}">
        	<%
            	String query = "SELECT * FROM courses NATURAL JOIN teaches NATURAL JOIN professors NATURAL JOIN users WHERE username = ?";
            	PreparedStatement stmt = con.prepareStatement(query);
            	stmt.setString(1, user.getUsername());
            	ResultSet courseList = stmt.executeQuery();
				stmt.close();
			%>
            <h4>My Courses</h4>
            <form action="gradebook.jsp" method="GET">
                <select name="course">
                <%
                    while (courseList.next()) {
                            String dept_short_name = courseList.getString("dept_short_name");
                            String courseNum = courseList.getString("course_number");
							String courseID = courseList.getString("course_id");
							if (courseID.equals(request.getParameter("course"))) {
                            	out.println("<option selected value='" + courseID + "'>" + dept_short_name + " " + courseNum + "</option>");
							}
							else {
                            	out.println("<option value='" + courseID + "'>" + dept_short_name + " " + courseNum + "</option>");
							}
                    }
                %>
                </select>
                <input type="Submit">
            </form>
            
            <%
				if (request.getParameter("course") != null) {
					String course = request.getParameter("course");
					String gradeQuery = "SELECT * FROM enrolled_in NATURAL JOIN students NATURAL JOIN users NATURAL JOIN users_detail WHERE course_id=" + course;
					PreparedStatement studentGradeStatement = con.prepareStatement(gradeQuery);
					ResultSet studentGrades = studentGradeStatement.executeQuery();
					studentGradeStatement.close();
					
					while (studentGrades.next()) {
						String studentName = studentGrades.getString("first_name") + " " + studentGrades.getString("last_name");
						String studentGrade = studentGrades.getString("grade") == null ? "N/A" : studentGrades.getString("grade");
						out.print(studentName + "---Grade:" + studentGrade + "<br>");
						out.print("<form action='drop_student.jsp' method='POST'><input type='hidden' name='student_id' value='" + studentGrades.getInt("student_id") + "'><input type='hidden' name='course_id' value='" + course + "'><input type='Submit' value='Drop Student'></form>");
					}
				}
				con.close();
			%>
        </c:when>
        <c:otherwise>
            <p> You are signed out. </p>
        </c:otherwise>
    </c:choose>
</c:set>

<t:genericpage>
    <jsp:attribute name="head">
        <title>Gradebook</title>
    </jsp:attribute>
    <jsp:attribute name="header">
    </jsp:attribute>
    <jsp:attribute name="footer">
    </jsp:attribute>
    <jsp:body>
        ${bodyContent}
    </jsp:body>

</t:genericpage>