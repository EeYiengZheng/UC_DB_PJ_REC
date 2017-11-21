<%@include file="databases.jsp" %>
<%

String username = request.getParameter( "username" );
String password = request.getParameter( "password" );

String query = "SELECT COUNT(*) FROM Users WHERE username=? and password = sha2(?, 256)";
PreparedStatement stmt = con.prepareStatement(query);
stmt.setString(1, username);
stmt.setString(2, password);
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
%>