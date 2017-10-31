<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="databaseBean" scope="page" class="beans.DatabaseBean"/>
<jsp:setProperty name="databaseBean" property="*"/>


<html>
<head>
    <title>SELECT Operation</title>
</head>

<body>
<%
    String col1 = null, col2 = null, col3 = null, col4 = null, col5 = null;
    try {
        Class.forName("org.mariadb.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/publications?user=" + databaseBean.getUsername() + "&password=" + databaseBean.getPassword());
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT * FROM " + databaseBean.getTableName());
        ResultSetMetaData rsmd = rs.getMetaData();
        col1 = rsmd.getColumnName(1);
        col2 = rsmd.getColumnName(2);
        col3 = rsmd.getColumnName(3);
        col4 = rsmd.getColumnName(4);
        col5 = rsmd.getColumnName(5);
%>
<table border="1" width="100%">
    <tr>
        <th><%=col1%>
        </th>
        <th><%=col2%>
        </th>
        <th><%=col3%>
        </th>
        <th><%=col4%>
        </th>
        <th><%=col5%>
        </th>
    </tr>
<%
        int columnsNumber = rsmd.getColumnCount();
        while (rs.next()) {
            out.println("<tr>");
            for (int i = 1; i <= columnsNumber; i++) {
                String columnValue = rs.getString(i);
                out.println("<td>" + columnValue + "</td>");
            }
            out.println("</tr>");

        }
    } catch (Exception e) {
        out.println(e.getMessage());
    }
%>
</table>
</body>
</html>