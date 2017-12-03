<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="../databases.jsp" %>
<%@include file="../taglibs.jsp" %>
<jsp:useBean id='user' scope='session' class='main.java.beans.UserBean'/>
<jsp:setProperty name='user' property='*'/>

<c:set var="bodyContent">
    <table style='color: #fff; width:100%'>
        <tr>
            <th><h4>Course</h4></th>
            <th><h4>Add</h4></th>
        </tr>
        <%

            String subject = request.getParameter("subject");
            String courseNum = request.getParameter("courseNum");

            if (subject == "") {
                subject = "%";
            } else if (courseNum == "") {
                courseNum = "%";
            }

            String query = "";
            String btnName = "";
            if (user.getType().equals("Student")) {
                query = "SELECT * FROM Courses NATURAL JOIN teaches NATURAL JOIN professors NATURAL JOIN users NATURAL JOIN users_detail WHERE dept_short_name LIKE ? AND course_number LIKE ?";
                btnName = "Enroll";
            } else if (user.getType().equals("Lecturer")) {
                query = "SELECT * FROM Courses NATURAL LEFT JOIN teaches NATURAL LEFT JOIN professors NATURAL LEFT JOIN users NATURAL LEFT JOIN users_detail WHERE dept_short_name LIKE ? AND course_number LIKE ?";
                btnName = "Teach";
            } else {
            }

            PreparedStatement stmt = con.prepareStatement(query);
            stmt.setString(1, subject.trim() + "%");
            stmt.setString(2, "%" + courseNum.trim() + "%");
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                String courseNumber = rs.getString("course_number");
                String courseName = rs.getString("course_name");
                String departmentShortName = rs.getString("dept_short_name");
                String courseDescription = rs.getString("course_description");
                String professorName = rs.getString("first_name") == null ? "None" : rs.getString("first_name") + " " + rs.getString("last_name");
                out.println("<tr><td><p><b>" + departmentShortName + " " + courseNumber + "<br>" + courseName + "</b><br>" + courseDescription + "<br>Instructor: " + professorName + "</p></td>");
                out.println("<td><form action='add_course.jsp' method='POST'><input type='hidden' name='dept_short_name' value='" + departmentShortName + "'><input name='course_number' type='hidden' value='" + courseNumber + "'><input type='Submit' value='" + btnName + "'></form></td></tr><br>");
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
