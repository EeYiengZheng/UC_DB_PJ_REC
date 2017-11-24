<%@include file="databases.jsp" %>
<jsp:useBean id='user' scope='session' class='main.java.beans.UserBean'/>

<%

    String userID = request.getParameter("userID");
    String password = request.getParameter("password");


    String query = "SELECT * FROM Users WHERE id=? AND password = sha2(?, 256)";
    PreparedStatement stmt = con.prepareStatement(query);
    stmt.setString(1, userID);
    stmt.setString(2, password);
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
