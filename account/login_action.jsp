<%@include file="../databases.jsp" %>
<jsp:useBean id='user' scope='session' class='main.java.beans.UserBean'/>


<%

    String username = request.getParameter("username");
    String password = request.getParameter("password");


    String query = "SELECT user_id FROM users WHERE password = sha2(?, 256) AND username=?";
    PreparedStatement stmt = con.prepareStatement(query);
    stmt.setString(1, password);
    stmt.setString(2, username);
    ResultSet rs = stmt.executeQuery();

    if (rs.next()) {
		int user_id = rs.getInt("user_id");
        stmt.close();
        user.setLoggedIn(true);
		user.setUsername(username);
		user.setPassword(password);
		
		query = "SELECT * FROM students WHERE user_id=?";
		PreparedStatement studentQuery = con.prepareStatement(query);
		studentQuery.setInt(1, user_id);
		ResultSet studentSet = studentQuery.executeQuery();
		if (studentSet.next()) {
			user.setType("Student");
		}
		else {
		    query = "SELECT * FROM professors WHERE user_id=?";
		    PreparedStatement lecturerQuery = con.prepareStatement(query);
            lecturerQuery.setInt(1, user_id);
		    ResultSet lqrs = lecturerQuery.executeQuery();
		    if (lqrs.next()){
                user.setType("Lecturer");
            } else {
                query = "SELECT * FROM dept_heads WHERE user_id=?";
                PreparedStatement headQuery = con.prepareStatement(query);
                headQuery.setInt(1, user_id);
                ResultSet dhrs = headQuery.executeQuery();
                if (dhrs.next()){
                    user.setType("Head");
                } else {
                    user.setType("Other");
                }
            }
		}
		studentQuery.close();
		
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
