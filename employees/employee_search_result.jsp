<%@include file="/taglibs.jsp" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ include file="/databases.jsp" %>


<c:set var="bodyContent">
    <%
        String query = "SELECT user_id, professor_id, first_name, last_name, gender FROM professors NATURAL JOIN users_detail WHERE professor_id NOT IN (SELECT professor_id FROM hired_by)";
        PreparedStatement stmt = con.prepareStatement(query);
        ResultSet profList = stmt.executeQuery();
        out.println("<div class='container'>");
        int i = 0;
        while (profList.next()) {
            String firstName = profList.getString("first_name");
            String lastName = profList.getString("last_name");
            String profID = profList.getString("professor_id");
            String user_id = profList.getString("user_id");
            String gender = profList.getString("gender");
            i++;String btnName = "Hire";
            String anchID = "anchID" + i;
            out.println("<div class='row'>" +
                    "<div class='col-9'>" +
                    "<p id='" + anchID + "'><b>" + firstName + " " + lastName + "</b><br>"  + "Employee ID: " + profID + "<br></p></div>");
            out.println("<div class='col'" +
                    "<form action='hire_employee.jsp' method='POST'><input type='hidden' name='emp_id' value='" + profID + "'><input type='hidden' name='time' value='" + user_id + "'><input type='hidden' name='rd_url' value='" +
                    request.getRequestURL() + "?" + request.getQueryString() + "#" + anchID + "'><input class='action_btn_anchor btn btn-primary' type='Submit' value='" + btnName + "'></form></div></div>");
            out.println("<br>");
        }
        out.println("</div>");

    %>
</c:set>
<t:genericpage>
    <jsp:attribute name="head">
        <title>Employees</title>
    </jsp:attribute>
    <jsp:attribute name="header">
        <h1 class="display-3">Filter Results</h1>
    </jsp:attribute>
    <jsp:attribute name="footer">
    </jsp:attribute>
    <jsp:body>
        ${bodyContent}
    </jsp:body>
</t:genericpage>