<%@include file="../taglibs.jsp" %>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.sql.*, java.util.*, java.io.*" %>
<%
    Connection con = null;
    try {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs157a", "root", "");
    } catch (Exception e) {
        out.print("An error occurred while connecting to the database");
        return;
    }
%>
<sql:setDataSource var="datasource" driver="com.mysql.jdbc.Driver"
                   url="jdbc:mysql://localhost/cs157a"
                   user="root" password=""/>
