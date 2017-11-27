<%@ include file="../databases.jsp" %>
<%@ page errorPage="register_exception.jsp" %>

<%
    String pass1 = request.getParameter("password");
    String pass2 = request.getParameter("conf_password");

    if (pass1 != null && pass2 != null && pass1.equals(pass2)) {
%>
<sql:update dataSource="${datasource}" var="count">
    INSERT INTO Users(user_id, username, password, email, first_name, last_name) VALUES (NULL, ?, sha2(?, 256), ?, ?, ?)
    <sql:param value="${param.username}"/>
    <sql:param value="${param.password}"/>
    <sql:param value="${param.email}"/>
    <sql:param value="${param.fname}"/>
    <sql:param value="${param.lname}"/>
</sql:update>
<c:redirect url="login.jsp"/>
<%
    } else {
        RequestDispatcher rd = request.getRequestDispatcher("register.jsp");
        request.setAttribute("errorMessage", "Invalid password");
        rd.forward(request, response);
%>
<br>
<jsp:forward page="login.jsp"/>
<c:out value="Please confirm your inputs"/>

<%
    }
%>

<%--
<%
    String userID = request.getParameter("userID");
    String email = request.getParameter("email");
    String name = request.getParameter("name");
    String password = request.getParameter("password");


    String query = "INSERT INTO Users(id, email, name, password) VALUES (?, ?, ?, sha2(?, 256))";
    PreparedStatement stmt = con.prepareStatement(query);
    stmt.setString(1, userID);
    stmt.setString(2, email);
    stmt.setString(3, name);
    stmt.setString(4, password);
    try {
        stmt.executeUpdate();
        stmt.close();
        con.close();
        response.sendRedirect("login.jsp");
    } catch (Exception e) {
        stmt.close();
        con.close();
        response.sendRedirect("register.jsp");
    }
%>
--%>
