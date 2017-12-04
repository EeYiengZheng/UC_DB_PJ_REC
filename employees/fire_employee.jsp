
<%@include file="../taglibs.jsp" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<jsp:useBean id='user' scope='session' class='main.java.beans.UserBean'/>

<%
    // user is dept head. user type = "Head"
        String query = "SELECT * FROM users_detail NATURAL JOIN professors WHERE professor_id IN (SELECT professor_id FROM hired_by NATURAL JOIN head_of NATURAL JOIN dept_heads NATURAL JOIN users WHERE username=?)";
        PreparedStatement stmt = con.prepareStatement(query);
        stmt.setString(1, user.getUsername());
        ResultSet profList = stmt.executeQuery();
        if (profList.next()) {
            out.println("<table style='width:100%'><tr><th></th><th></th></tr>");
            while (profList.next()) {
                String firstName = profList.getString("first_name");
                String lastName = profList.getString("last_name");
                String profID = profList.getString("professor_id");
                String user_id = profList.getString("user_id");
                String gender = profList.getString("gender");
                request.getSession().setAttribute("fname", firstName);
                request.getSession().setAttribute("lname", lastName);
                request.getSession().setAttribute("emp_id", profID);
%>