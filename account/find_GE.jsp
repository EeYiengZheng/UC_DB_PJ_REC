<%@include file="../databases.jsp" %>
<jsp:useBean id='user' scope='session' class='main.java.beans.UserBean'/>


<%
    String query = "SELECT * FROM courses WHERE course_description LIKE '%GE Area: B4%'";
 	PreparedStatement stmt = con.prepareStatement(query);
	ResultSet rs = stmt.executeQuery();
	stmt.close();
	
	while (rs.next()) {
		out.print(rs.getString("dept_short_name") + " " + rs.getString("course_number"));
		out.print("<br>");	
	}
	
	con.close();
%>
