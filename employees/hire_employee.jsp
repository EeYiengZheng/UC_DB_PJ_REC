<%@include file="../taglibs.jsp" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ include file="/databases.jsp" %>
<jsp:useBean id='user' scope='session' class='main.java.beans.UserBean'/>

<c:choose>
    <c:when test="${user.loggedIn}">
        <%
            String query = "";
            ResultSet rs = null;
            int id = 0;
            //if (user.getType().equals("Head")) {
                PreparedStatement stmt = null;
                query = "SELECT * FROM dept_heads NATURAL JOIN head_of NATURAL JOIN (SELECT user_id FROM users WHERE username=?) un";
                stmt = con.prepareStatement(query);
                stmt.setString(1, user.getUsername().trim());
                rs = stmt.executeQuery();
                if (rs.next()) {
                    String in_dept = rs.getString("dept_short_name");
                    query = "INSERT INTO hired_by(professor_id, dept_short_name) VALUE (?, ?)";
                    stmt = con.prepareStatement(query);
                    stmt.setInt(1, Integer.parseInt(request.getParameter("emp_id").trim()));
                    stmt.setString(2, in_dept);
                    rs = stmt.executeQuery();
                    if (rs.next()){}
                    else {
                        out.println("hire professor failed");
                    }
                }

            //}
            stmt.close();
            con.close();

//                RequestDispatcher rd = request.getRequestDispatcher("search.jsp");
//                rd.forward(request, response);
            String rd_url = request.getParameter("rd_url");
            response.sendRedirect(rd_url);
        %>

    </c:when>
    <c:otherwise>
        <p> You are signed out. </p>
    </c:otherwise>
</c:choose>