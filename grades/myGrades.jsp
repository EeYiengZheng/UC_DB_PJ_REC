<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="../taglibs.jsp" %>
<%@include file="../databases.jsp" %>
<jsp:useBean id='user' scope='session' class='main.java.beans.UserBean'/>
<jsp:setProperty name='user' property='*'/>


<c:set var="bodyContent">
    <c:choose>
        <c:when test="${user.loggedIn}">
        	<%
				String query = "SELECT * FROM enrolled_in NATURAL JOIN courses NATURAL JOIN students NATURAL JOIN users WHERE username=? AND is_taking=true";
				PreparedStatement stmt = con.prepareStatement(query);
				stmt.setString(1, user.getUsername());
				ResultSet currentGrades = stmt.executeQuery();
				stmt.close();
			%>
            <h4>Currently Taking</h4>
            <%
				while(currentGrades.next()) {
					String dept_short_name = currentGrades.getString("dept_short_name");
					String courseNum = currentGrades.getString("course_number");
					String courseName = currentGrades.getString("course_name");
					String grade = currentGrades.getString("grade") == null ? "N/A" : currentGrades.getString("grade");
					out.println(dept_short_name + " " + courseNum + ":" + courseName + "-" + grade + "<br>");
				}
				
				query = "SELECT * FROM enrolled_in NATURAL JOIN courses NATURAL JOIN students NATURAL JOIN users WHERE username=? AND is_taking=false";
				stmt = con.prepareStatement(query);
				stmt.setString(1, user.getUsername());
				ResultSet pastGrades = stmt.executeQuery();
				stmt.close();
			%>
            <h4>Previously Taken</h4>
            <%
				while(pastGrades.next()) {
					String dept_short_name = pastGrades.getString("dept_short_name");
					String courseNum = pastGrades.getString("course_number");
					String courseName = pastGrades.getString("course_name");
					String grade = pastGrades.getString("grade") == null ? "N/A" : pastGrades.getString("grade");
					out.println(dept_short_name + " " + courseNum + ":" + courseName + "-" + grade + "<br>");
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
        <title>Grades</title>
    </jsp:attribute>
    <jsp:attribute name="header">
        <h1 class="display-3">Grades</h1>
    </jsp:attribute>
    <jsp:attribute name="footer">
    </jsp:attribute>
    <jsp:body>
        ${bodyContent}
    </jsp:body>

</t:genericpage>
