<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="../databases.jsp" %>
<jsp:useBean id='user' scope='session' class='main.java.beans.UserBean'/>
<jsp:setProperty name='user' property='*'/>

<%

String query = "UPDATE Users_Detail SET nickname=? WHERE user_id IN (SELECT user_id FROM Users WHERE username=?)";
PreparedStatement stmt = con.prepareStatement(query);
stmt.setString(1, request.getParameter("nickname"));
stmt.setString(2, user.getUsername());
stmt.executeUpdate();
stmt.close();
con.close();
response.sendRedirect("myInfo.jsp");


%>