<%@ include file="../databases.jsp" %>
<%@ page errorPage="register_exception.jsp" %>

<%--
<!--
<%
    String pass1 = request.getParameter("password");
    String pass2 = request.getParameter("conf_password");

    if (pass1 != null && pass2 != null && pass1.equals(pass2)) {
%>
<sql:update dataSource="${datasource}" var="count">
    INSERT INTO Users(user_id, username, password, type) VALUES (NULL, ?, sha2(?, 256), ?)
    <sql:param value="${param.username}"/>
    <sql:param value="${param.password}"/>
    <sql:param value="${param.user_type}"/>
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
-->
--%>


<%

    String pass1 = request.getParameter("password");
    String pass2 = request.getParameter("conf_password");

    if (pass1 != null && pass2 != null && pass1.equals(pass2)) {
        String query = "INSERT INTO users(username, password, email, first_name, last_name, birthday, nickname) VALUES(?, sha2(?, 256), ?, ?, ?, ?, ?)";
        String username = request.getParameter("username");
        PreparedStatement stmt = con.prepareStatement(query);
        stmt.setString(1, username);
        stmt.setString(2, pass1);
        String email = request.getParameter("email").equals("") ? null : request.getParameter("email");
        String fname = request.getParameter("fname").equals("") ? null : request.getParameter("fname");
        String lname = request.getParameter("lname").equals("") ? null : request.getParameter("lname");
        String birthday = request.getParameter("birthday").equals("") ? null : request.getParameter("birthday");
        String nickname = request.getParameter("nickname").equals("") ? null : request.getParameter("nickname");
        stmt.setString(3, email);
        stmt.setString(4, fname);
        stmt.setString(5, lname);
        stmt.setString(6, birthday);
        stmt.setString(7, nickname);
        stmt.executeUpdate();
        stmt.close();

        query = "SELECT user_id FROM users WHERE username=? AND password=sha2(?, 256)";
        PreparedStatement idStmt = con.prepareStatement(query);
        idStmt.setString(1, username);
        idStmt.setString(2, pass1);
        ResultSet rs = idStmt.executeQuery();
        rs.next();
        int userID = rs.getInt("user_id");
        idStmt.close();

        String type = request.getParameter("user_type");
        if (type.equals("Lecturer")) {
            query = "INSERT INTO professors(user_id) VALUES(?)";
        } else if (type.equals("Student")) {
            query = "INSERT INTO students(user_id) VALUES(?)";
        }
        PreparedStatement subclassStmt = con.prepareStatement(query);
        subclassStmt.setInt(1, userID);
        subclassStmt.executeUpdate();
        subclassStmt.close();

        con.close();
        response.sendRedirect("login.jsp");
    } else {
        con.close();
        RequestDispatcher rd = request.getRequestDispatcher("register.jsp");
        request.setAttribute("errorMessage", "Invalid password");
        rd.forward(request, response);
    }
%>
