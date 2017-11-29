<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="../databases.jsp" %>
<jsp:useBean id='user' scope='session' class='main.java.beans.UserBean'/>
<jsp:setProperty name='user' property='*'/>

<%

String query = "UPDATE Users_Detail SET nickname=?, email=? WHERE user_id IN (SELECT user_id FROM Users WHERE username=?)";
PreparedStatement stmt = con.prepareStatement(query);
stmt.setString(1, request.getParameter("nickname") == "" ? null : request.getParameter("nickname"));
stmt.setString(2, request.getParameter("email") == "" ? null : request.getParameter("email"));
stmt.setString(3, user.getUsername());
try {
	stmt.executeUpdate();
}
catch(Exception e) {
	request.setAttribute("errorMessage", "Email taken");
}
finally {
	stmt.close();
	con.close();
}

RequestDispatcher rd = request.getRequestDispatcher("myInfo.jsp");
rd.forward(request, response);


%>