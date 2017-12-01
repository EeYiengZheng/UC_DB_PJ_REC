<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="../databases.jsp" %>
<jsp:useBean id='user' scope='session' class='main.java.beans.UserBean'/>
<jsp:setProperty name='user' property='*'/>

<%

String current_password = request.getParameter("current_password");
String new_password = request.getParameter("new_password");
String reenter_password = request.getParameter("reenter_password");
if (new_password != "" && reenter_password != "" && current_password != "" && new_password.equals(reenter_password)) {
	String query = "UPDATE Users SET password=sha2(?, 256) WHERE username=? AND password=sha2(?, 256)";
	PreparedStatement stmt = con.prepareStatement(query);
	stmt.setString(1, new_password);
	stmt.setString(2, user.getUsername());
	stmt.setString(3, current_password);
	int rows = stmt.executeUpdate();
	if (rows == 0) {
		request.setAttribute("resultMessage", "Incorrect password");
	}
	else if (rows == 1) {
		request.setAttribute("resultMessage", "Password changed successfully");
	}
	else {
		request.setAttribute("resultMessage", "A serious error has occurred. Please contact the system administrator");
	}
	stmt.close();
	con.close();
}
else {
	request.setAttribute("resultMessage", "Passwords did not match");
}

RequestDispatcher rd = request.getRequestDispatcher("myInfo.jsp");
rd.forward(request, response);


%>