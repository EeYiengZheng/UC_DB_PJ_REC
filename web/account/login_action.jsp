<%@include file="databases.jsp" %>
<jsp:useBean id='user' scope='session' class='main.java.beans.UserBean'/>

<%

    String username = request.getParameter("username");
    String password = request.getParameter("password");


    String query = "SELECT * FROM Users WHERE password = sha2(?, 256) AND username=?";
    PreparedStatement stmt = con.prepareStatement(query);
    stmt.setString(1, password);
    stmt.setString(2, username);
    ResultSet rs = stmt.executeQuery();

    if (rs.next()) {
        user.setLoggedIn(true);
        stmt.close();
        con.close();

        response.sendRedirect("profile.jsp");
    } else {
        user.setLoggedIn(false);
        stmt.close();
        con.close();
        RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
        request.setAttribute("errorMessage", "Invalid ID or password");
        rd.forward(request, response);
    }
%>
