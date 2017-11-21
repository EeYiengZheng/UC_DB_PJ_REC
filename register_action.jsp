<%@include file="databases.jsp" %>
<%
String username = request.getParameter( "username" );
String password = request.getParameter( "password" );



String query = "INSERT INTO Users(username, password) VALUES (?, sha2(?, 256))";
PreparedStatement stmt = con.prepareStatement(query);
stmt.setString(1,username);
stmt.setString(2,password);
boolean success = stmt.executeUpdate() > 0;


if (success) {
	stmt.close();
	con.close();
	response.sendRedirect("login.jsp");
}
else {
	stmt.close();
	con.close();
	response.sendRedirect("register.jsp"); 	
}
%>




