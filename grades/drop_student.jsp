<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="../taglibs.jsp" %>
<%@include file="../databases.jsp" %>
<jsp:useBean id='user' scope='session' class='main.java.beans.UserBean'/>
<jsp:setProperty name='user' property='*'/>


<c:set var="bodyContent">
    <c:choose>
        <c:when test="${user.loggedIn}">
        	<%
				String query = "DELETE FROM enrolled_in WHERE student_id=? AND course_id=?";
				PreparedStatement stmt = con.prepareStatement(query);
				stmt.setString(1, request.getParameter("student_id"));
				stmt.setString(2, request.getParameter("course_id"));
                try {
                    stmt.executeUpdate();
                    request.setAttribute("resultMessage", "Student dropped successfully!");
                } catch (Exception e) {
                    request.setAttribute("resultMessage", "An error occurred while attempting to remove the student. Please contact the system administrator.");
                } finally {
                    stmt.close();
                    con.close();
                }
                RequestDispatcher rd = request.getRequestDispatcher("gradebook.jsp");
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