<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="../taglibs.jsp" %>
<%@include file="../databases.jsp" %>
<jsp:useBean id='user' scope='session' class='main.java.beans.UserBean'/>
<jsp:setProperty name='user' property='*'/>


<c:set var="bodyContent">
    <div class="container">
        <div class="row justify-content-center">
            <% if (request.getAttribute("resultMessage") != null) {
                out.println("<p>" + request.getAttribute("resultMessage") + "</p>");
            }
            %>
        </div>
        <div class="row justify-content-center">
            <h3>Search for Courses</h3>
        </div>
        <br>
        <br>
        <div class="row justify-content-center">
            <div class="form-group">
                <form action="search_result.jsp">
                    <input type="hidden" name="search_submitted" value="submitted" id="submit_flag">
                    <div class="row">
                        <div class="col">
                            <label>Subject:<br>
                                <input type="text" name="subject"></label>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col">
                            <label>Course Number:<br>
                                <input type="text" name="courseNum"></label>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-1"></div>
                        <div class="col">
                            <input type="submit" value="Search" id="search_btn"
                                   class="btn btn-info btn-search">
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>

    </div>
    <div class="container">
        <div class="row justify-content-center">
            <c:choose>
                <c:when test="${user.getType().equals('Lecturer')}">
                    <h3>Courses Currently Teaching</h3>
                </c:when>
                <c:when test="${user.getType().equals('Student')}">
                    <h3>Courses Currently Taking</h3>
                </c:when>
            </c:choose>
        </div>
        <div class="row">
            <div class="col"><h3 align="left">Courses</h3></div>
            <div class="col"><h3 align="right">Drop</h3></div>
        </div>
    </div>

    <%
        if (user.getType().equals("Student")) {
            String query = "SELECT * FROM courses NATURAL JOIN enrolled_in NATURAL JOIN teaches NATURAL JOIN professors NATURAL JOIN users NATURAL JOIN users_detail WHERE student_id IN (SELECT student_id FROM students NATURAL JOIN users WHERE username=?)";
            PreparedStatement stmt = con.prepareStatement(query);
            stmt.setString(1, user.getUsername());
            ResultSet courseList = stmt.executeQuery();
            out.println("<div class='col-25'></div><div class='col-25'></div><table style='width:100%'><tr><th></th><th></th></tr>");
            while (courseList.next()) {
                out.println("<tr><td><p><b>" + courseList.getString("dept_short_name") + " " + courseList.getString("course_number") + ": " + courseList.getString("course_name") + "<br></b>" + courseList.getString("course_description") + "<br>Instructor: " + courseList.getString("first_name") + " " + courseList.getString("last_name"));
                out.println("</td><td><form action='drop_course.jsp' method='GET'><input type='hidden' name='course_id' value='" + courseList.getString("course_id") + "'><input name='student_id' type='hidden' value='" + courseList.getString("student_id") + "'><input type='Submit' value='Drop'></form>");
                out.println("</td></tr></p></div>");
            }
            stmt.close();
            con.close();
        } else if (user.getType().equals("Lecturer")) {
            String query = "SELECT * FROM courses NATURAL JOIN teaches NATURAL JOIN professors NATURAL JOIN users WHERE username=?";
            PreparedStatement stmt = con.prepareStatement(query);
            stmt.setString(1, user.getUsername());
            ResultSet courseList = stmt.executeQuery();
            out.println("<div class='col-25'></div><div class='col-25'></div><table style='width:100%'><tr><th></th><th></th></tr>");
            while (courseList.next()) {
                out.println("<tr><td><p><b>" + courseList.getString("dept_short_name") + " " + courseList.getString("course_number") + ": " + courseList.getString("course_name"));
                out.println("</b></td><td><form action='drop_course.jsp' method='POST'><input type='hidden' name='course_id' value='" + courseList.getString("course_id") + "'><input name='professor_id' type='hidden' value='" + courseList.getString("professor_id") + "'><input type='Submit' value='Drop'></form>");
                out.println("</td></tr></p></div>");
            }
            stmt.close();
            con.close();
        } else {
            // someone else
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
        <style>#footer {
            margin-top: 140px;
        }</style>
    </jsp:attribute>
    <jsp:body>
        ${bodyContent}
    </jsp:body>

</t:genericpage>