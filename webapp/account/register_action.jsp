<%@ include file="databases.jsp" %>
<%@ page errorPage="register_exception.jsp" %>

<sql:update dataSource="${datasource}" var="count">
    INSERT INTO Users(id, email, name, password) VALUES (?, ?, ?, sha2(?, 256))
    <sql:param value="${param.userID}"/>
    <sql:param value="${param.email}"/>
    <sql:param value="${param.name}"/>
    <sql:param value="${param.password}"/>
</sql:update>
<c:redirect url="login.jsp"/>
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