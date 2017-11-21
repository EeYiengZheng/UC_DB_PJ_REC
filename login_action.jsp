<%@include file="databases.jsp" %>
<%

//Check user
String username = request.getParameter( "username" );
String password = request.getParameter( "password" );
String query = "SELECT * FROM Users WHERE username='" + username + "' and password = sha2('"+ password + "', 256)";

//Incorrect usage of preparedstatement. Will fix later.
PreparedStatement stmt = con.prepareStatement(query);
ResultSet rs = stmt.executeQuery();

if (rs.next()) {
	stmt.close();
	con.close();
	response.sendRedirect("index.jsp");	
}
else {
	stmt.close();
	con.close();
	RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
	request.setAttribute("errorMessage", "Invalid user or password");
	rd.forward(request, response); 
}

/*

			if (rs.first()) {
				response.sendRedirect("index.jsp");
			}
			else {
				RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
				request.setAttribute("errorMessage", "Invalid user or password");
		        rd.forward(request, response); 
			}
*/

%>