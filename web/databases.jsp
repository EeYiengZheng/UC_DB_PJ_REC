<%@include file="taglibs.jsp" %>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.sql.*, java.util.*, java.io.*" %>
<%
    Connection con = null;
    Class.forName("org.mariadb.jdbc.Driver");
    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs157a", "root", "");

%>
<sql:setDataSource var="datasource" driver="org.mariadb.jdbc.Driver"
                   url="jdbc:mysql://localhost/cs157a"
                   user="root" password=""/>
