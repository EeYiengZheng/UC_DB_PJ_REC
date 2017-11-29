<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="../taglibs.jsp" %>
<%@include file="../databases.jsp" %>
<jsp:useBean id='user' scope='session' class='main.java.beans.UserBean'/>
<jsp:setProperty name='user' property='*'/>

<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
        integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
        crossorigin="anonymous"></script>
<script>
$(document).ready(function() {
	
	$("#saveNameBtn").hide();
	
	$("#changeNameBtn").on("click", function() {
		$("#nameField").attr("readonly", false);
		$("#changeNameBtn").hide();
		$("#saveNameBtn").show();
	});
	
	$("#saveNameBtn").on("click", function() {
		$("#nameField").attr("readonly", true);
		$("#saveNameBtn").hide();
		$("#changeNameBtn").show();
	});
	
	
	
	$("#saveEmailBtn").hide();
	
	$("#changeEmailBtn").on("click", function() {
		$("#emailField").attr("readonly", false);
		$("#changeEmailBtn").hide();
		$("#saveEmailBtn").show();
	});
	
	$("#saveEmailBtn").on("click", function() {
		$("#emailField").attr("readonly", true);
		$("#saveEmailBtn").hide();
		$("#changeEmailBtn").show();
	});
	
});
</script>

<%
String query = "SELECT * FROM Users_Detail WHERE user_id IN(SELECT user_id FROM Users WHERE username=?)";
PreparedStatement stmt = con.prepareStatement(query);
stmt.setString(1, user.getUsername());
ResultSet rs = stmt.executeQuery();
rs.next();
String nickname = rs.getString("nickname") == null ? "" : rs.getString("nickname");
String email = rs.getString("email") == null ? "" : rs.getString("email");
String firstName = rs.getString("first_name");
String lastName = rs.getString("last_name");
String birthday = rs.getString("birthday");
stmt.close();
con.close();
%>

<c:set var="bodyContent">

<div class="field-group">
	<form method="post" action="change_info.jsp">
    
    
        <label>First Name</label>
        <input id="firstNameField" name="firstName" type="text" readonly value=<%=firstName%>></input>
        <br>
        <label>Last Name</label>
        <input id="lastNameField" name="lastName" type="text" readonly value=<%=lastName%>></input>
        <br>
        <label>Birthday</label>
        <input id="birthdayField" name="birthday" type="text" readonly value=<%=birthday%>></input>
    	<br>
    
        <label>Nickname</label>
        <input id="nameField" name="nickname" type="text" readonly value=<%=nickname%>></input>
        <button type="button" id="changeNameBtn">Edit</button>
        <button type="button" id="saveNameBtn">Save</button>
        
        <br>
		<% if (request.getAttribute("errorMessage") != null) {
            out.println(request.getAttribute("errorMessage"));
        }
        %>
        
        <label>Email</label>
        <input id="emailField" name="email" type="text" readonly value=<%=email%>></input>
        <button type="button" id="changeEmailBtn">Edit</button>
        <button type="button" id="saveEmailBtn">Save</button>
        
        <input type="submit" value="Update Info" class="btn btn-info btn-block">
        
     
    </form>
</div>
</c:set>

<t:genericpage>
    <jsp:attribute name="head">
        <title>User Information</title>
    </jsp:attribute>
    <jsp:attribute name="header">
    </jsp:attribute>
    <jsp:attribute name="footer">
    </jsp:attribute>
    <jsp:body>
        ${bodyContent}
    </jsp:body>

</t:genericpage>
