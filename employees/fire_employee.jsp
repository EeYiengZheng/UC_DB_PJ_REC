<%@include file="/databases.jsp" %>
<%@include file="/taglibs.jsp" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<jsp:useBean id='user' scope='session' class='main.java.beans.UserBean'/>

<%
    // user is dept head. user type = "Head"
    try {
        String employee_id = request.getParameter("empl").toString();
        String query = "DELETE FROM hired_by WHERE professor_id=?";
        PreparedStatement stmt = con.prepareStatement(query);
        stmt.setInt(1, Integer.parseInt(employee_id.trim()));
        out.println(stmt.toString());
        ResultSet rs = stmt.executeQuery();
        request.setAttribute("resultMessage", "<p>Employee " + employee_id + " was fired.</p>");
        stmt.close();

        stmt = con.prepareStatement("DELETE FROM enrolled_in WHERE course_id IN (SELECT course_id FROM teaches WHERE professor_id=?)");
        stmt.setInt(1, Integer.parseInt(employee_id));
        stmt.executeUpdate();
        stmt.close();

        stmt = con.prepareStatement("DELETE FROM teaches WHERE professor_id=?");
        stmt.setInt(1, Integer.parseInt(employee_id));
        stmt.executeUpdate();
        stmt.close();

        con.close();
    } catch (Exception e) {
        request.setAttribute("resultMessage", "<p>An error occurred while attempting to FIRE the employee. The employee was defiant. Please contact the police.</p>");
    } finally {
        RequestDispatcher rd = request.getRequestDispatcher("employee_search.jsp");
        rd.forward(request, response);
    }

%>