<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="../databases.jsp" %>
<jsp:useBean id='user' scope='session' class='main.java.beans.UserBean'/>
<jsp:setProperty name='user' property='*'/>

<%

String query = "UPDATE Users_Detail SET nickname=?, email=?, phone_number=?, address=?, ethnicity=?, gender=? WHERE user_id IN (SELECT user_id FROM Users WHERE username=?)";
PreparedStatement stmt = con.prepareStatement(query);
stmt.setString(1, request.getParameter("nickname") == "" ? null : request.getParameter("nickname"));
stmt.setString(2, request.getParameter("email") == "" ? null : request.getParameter("email"));
stmt.setString(3, request.getParameter("phone_number") == "" ? null : request.getParameter("phone_number"));
stmt.setString(4, request.getParameter("address") == "" ? null : request.getParameter("address"));
stmt.setString(5, request.getParameter("ethnicity") == "" ? null : request.getParameter("ethnicity"));
stmt.setString(6, request.getParameter("gender") == "" ? null : request.getParameter("gender"));
stmt.setString(7, user.getUsername());
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