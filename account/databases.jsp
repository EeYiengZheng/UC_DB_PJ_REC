<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import = "java.sql.*, java.util.*, java.io.*" %>
<%		
Connection con=null;
try {
Class.forName("com.mysql.jdbc.Driver");
con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs157a", "root", "");
}
catch(Exception e) {
	out.print("An error occurred while connecting to the database");
	return;
}
%>