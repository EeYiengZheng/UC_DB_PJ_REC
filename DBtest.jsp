<%@ page import="java.sql.*" %>
<%--
  Created by IntelliJ IDEA.
  User: Emp
  Date: 10/20/2017
  Time: 12:27 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="databaseBean" scope="page" class="beans.DatabaseBean"/>
<jsp:setProperty name="databaseBean" property="*"/>


<html>
<head>
    <title>SELECT Operation</title>
</head>

<body>
<%
    databaseBean.setConn();
    ResultSet rs= null;
    try {
        rs = databaseBean.query("SELECT DATABASE()");
    } catch (SQLException e) {
        out.println(e.getMessage());
    }
    ResultSetMetaData rsmd = null;
    String col1 = null, col2= null, col3=null, col4=null, col5=null;
    try {
        assert rs != null;
        rsmd = rs.getMetaData();
        col1 = rsmd.getColumnName(1);
        col2 = rsmd.getColumnName(2);
        col3 = rsmd.getColumnName(3);
        col4 = rsmd.getColumnName(4);
        col5 = rsmd.getColumnName(5);

    } catch (SQLException e) {
        e.printStackTrace();
    }
%>

<table border="1" width="100%">
    <tr>
        <th><%=col1%></th>
        <th><%=col2%></th>
        <th><%=col3%></th>
        <th><%=col4%></th>
        <th><%=col5%></th>
    </tr>
    <%
        try {
            int columnsNumber = rsmd.getColumnCount();
            out.println("<tr>");
            while (rs.next()) {
                for (int i = 1; i <= columnsNumber; i++) {
                    String columnValue = rs.getString(i);
                    out.println("<td>" + columnValue + "</td>");
                }
                out.println("");
            }
            out.println("</tr>");
        } catch (Exception ex) {
            out.print(ex);
        }
    %>

</table>

</body>
</html>