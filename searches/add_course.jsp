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
                    query = "SELECT student_id FROM students NATURAL JOIN users WHERE username=?";
                    PreparedStatement stmt = con.prepareStatement(query);
                    stmt.setString(1, user.getUsername());
                    ResultSet idResult = stmt.executeQuery();
                    idResult.next();
                    id = idResult.getInt("student_id");
                    stmt.close();
                } else {
                    query = "SELECT professor_id FROM professors NATURAL JOIN users WHERE username=?";
                    PreparedStatement stmt = con.prepareStatement(query);
                    stmt.setString(1, user.getUsername());
                    ResultSet profResult = stmt.executeQuery();
                    profResult.next();
                    id = profResult.getInt("professor_id");
                    stmt.close();
                }
				
				PreparedStatement stmt = null;
				if (user.getType().equals("Student")) {
                    query = "INSERT INTO enrolled_in(student_id, course_id, grade, is_taking) VALUES(?, ?, ?, ?)";
                    stmt = con.prepareStatement(query);
                    stmt.setInt(1, id);
                    stmt.setString(2, request.getParameter("courseID"));
                    stmt.setString(3, null);
                    stmt.setBoolean(4, true);
                } else {
                    query = "INSERT INTO teaches(professor_id, course_id) VALUES(?, ?)";
                    stmt = con.prepareStatement(query);
                    stmt.setInt(1, id);
                    stmt.setString(2, request.getParameter("courseID"));
                }
				stmt.executeUpdate();
				stmt.close();
				con.close();
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