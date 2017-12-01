<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="../taglibs.jsp" %>
<%@include file="../databases.jsp" %>
<jsp:useBean id='user' scope='session' class='main.java.beans.UserBean'/>
<jsp:setProperty name='user' property='*'/>


<c:set var="bodyContent">
    <% if (request.getAttribute("resultMessage") != null) {
        out.println("<p>" + request.getAttribute("resultMessage") + "</p>");
    }
    %></div>
    <h3>Search for Courses</h3>
    <div class='col-25'></div>
    <form action="search_result.jsp">
        <div class="col-25"><label>Subject:</label></div>
        <div class="col-25"><input type="text" name="subject"><br></div>
        <div class="col-25"><label>Course Number:</label></div>
        <br>
        <div class="col-25"><input type="text" name="courseNum"></div>
        <br><br>
        <div class="col-25"><input type="submit" value="Search" id="search_btn" class="btn btn-info btn-search"></div>
    </form>
    <br><br>

    <c:choose>

        <c:when test="${user.getType().equals('Lecturer')}">
            <h3>Courses Currently Teaching</h3>
        </c:when>
        <c:otherwise>
            <h3>Courses Currently Taking</h3>
        </c:otherwise>
    </c:choose>
    <%

        if (user.getType().equals("Student")) {
            String query = "SELECT * FROM courses NATURAL JOIN enrolled_in WHERE student_id IN (SELECT student_id FROM Students NATURAL JOIN Users WHERE username=?)";
            PreparedStatement stmt = con.prepareStatement(query);
            stmt.setString(1, user.getUsername());
            ResultSet courseList = stmt.executeQuery();
            out.println("<div class='col-25'></div><div class='col-25'></div><table style='width:100%'><tr><th></th><th></th></tr>");
            while (courseList.next()) {
                out.println("<tr><td><p><b>" + courseList.getString("dept_short_name") + " " + courseList.getString("course_number") + ": " + courseList.getString("course_name") + "<br></b>" + courseList.getString("course_description"));
                out.println("</td><td><form action='drop_course.jsp' method='GET'><input type='hidden' name='course_id' value='" + courseList.getString("course_id") + "'><input name='student_id' type='hidden' value='" + courseList.getString("student_id") + "'><input type='Submit' value='Drop'></form>");
                out.println("</td></tr></p></div>");
            }
            stmt.close();
            con.close();
        } else {
            String query = "SELECT * FROM courses NATURAL JOIN teaches WHERE professor_id IN (SELECT professor_id FROM Professors NATURAL JOIN Users WHERE username=?)";
            PreparedStatement stmt = con.prepareStatement(query);
            stmt.setString(1, user.getUsername());
            ResultSet courseList = stmt.executeQuery();
            out.println("<div class='col-25'></div><div class='col-25'></div><table style='width:100%'><tr><th></th><th></th></tr>");
            while (courseList.next()) {
                out.println("<tr><td><p><b>" + courseList.getString("dept_short_name") + " " + courseList.getString("course_number") + ": " + courseList.getString("course_name"));

                out.println("</b></td><td><form action='drop_course.jsp' method='GET'><input type='hidden' name='course_id' value='" + courseList.getString("course_id") + "'><input name='professor_id' type='hidden' value='" + courseList.getString("professor_id") + "'><input type='Submit' value='Drop'></form>");
                out.println("</td></tr></p></div>");
            }
            stmt.close();
            con.close();
        }
    %>
</c:set>

<t:genericpage>
    <jsp:attribute name="head">
        <title>Search Courses</title>
    </jsp:attribute>
    <jsp:attribute name="header">
        <h1 class="display-3">Search Courses</h1>
    </jsp:attribute>
    <jsp:attribute name="footer">
    </jsp:attribute>
    <jsp:body>
        ${bodyContent}
    </jsp:body>

</t:genericpage>