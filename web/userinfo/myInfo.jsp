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
	
	$("#savePhoneBtn").hide();
	$("#changePhoneBtn").on("click", function() {
		$("#phoneField").attr("readonly", false);
		$("#changePhoneBtn").hide();
		$("#savePhoneBtn").show();
	});
	$("#savePhoneBtn").on("click", function() {
		$("#phoneField").attr("readonly", true);
		$("#savePhoneBtn").hide();
		$("#changePhoneBtn").show();
	});
	
	$("#saveAddressBtn").hide();
	$("#changeAddressBtn").on("click", function() {
		$("#addressField").attr("readonly", false);
		$("#changeAddressBtn").hide();
		$("#saveAddressBtn").show();
	});
	$("#saveAddressBtn").on("click", function() {
		$("#addressField").attr("readonly", true);
		$("#saveAddressBtn").hide();
		$("#changeAddressBtn").show();
	});
	
	$("#saveEthnicityBtn").hide();
	$("#changeEthnicityBtn").on("click", function() {
		$("#ethnicityField").attr("readonly", false);
		$("#changeEthnicityBtn").hide();
		$("#saveEthnicityBtn").show();
	});
	$("#saveEthnicityBtn").on("click", function() {
		$("#ethnicityField").attr("readonly", true);
		$("#saveEthnicityBtn").hide();
		$("#changeEthnicityBtn").show();
	});
	
	$("#saveGenderBtn").hide();
	$("#changeGenderBtn").on("click", function() {
		$("#genderField").attr("readonly", false);
		$("#changeGenderBtn").hide();
		$("#saveGenderBtn").show();
	});
	$("#saveGenderBtn").on("click", function() {
		$("#genderField").attr("readonly", true);
		$("#saveGenderBtn").hide();
		$("#changeGenderBtn").show();
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
String phone_number = rs.getString("phone_number") == null ? "" : rs.getString("phone_number");
String address = rs.getString("address") == null ? "" : rs.getString("address");
String ethnicity = rs.getString("ethnicity") == null ? "" : rs.getString("ethnicity");
String gender = rs.getString("gender") == null ? "" : rs.getString("gender");
stmt.close();
con.close();
%>

<c:set var="bodyContent">

<div class="field-group">
	<form method="post" action="change_info.jsp">
    
    
        <label>First Name</label>
        <input id="firstNameField" name="firstName" type="text" readonly value="<%=firstName%>"></input>
        <br>
        <label>Last Name</label>
        <input id="lastNameField" name="lastName" type="text" readonly value="<%=lastName%>"></input>
        <br>
        <label>Birthday</label>
        <input id="birthdayField" name="birthday" type="text" readonly value="<%=birthday%>"></input>
    	<br>
    
        <label>Nickname</label>
        <input id="nameField" name="nickname" type="text" readonly value="<%=nickname%>"></input>
        <button type="button" id="changeNameBtn">Edit</button>
        <button type="button" id="saveNameBtn">Save</button>
        
        <br>
		<% if (request.getAttribute("errorMessage") != null) {
            out.println(request.getAttribute("errorMessage"));
        }
        %>
        
        <label>Email</label>
        <input id="emailField" name="email" type="text" readonly value="<%=email%>"></input>
        <button type="button" id="changeEmailBtn">Edit</button>
        <button type="button" id="saveEmailBtn">Save</button>
        
        <br>
    
        <label>Phone Number</label>
        <input id="phoneField" name="phone_number" type="text" readonly value="<%=phone_number%>"></input>
        <button type="button" id="changePhoneBtn">Edit</button>
        <button type="button" id="savePhoneBtn">Save</button>
        <br>
    
        <label>Address</label>
        <input id="addressField" name="address" type="text" readonly value="<%=address%>"></input>
        <button type="button" id="changeAddressBtn">Edit</button>
        <button type="button" id="saveAddressBtn">Save</button>
        <br>
    
        <label>Ethnicity</label>
        <input id="ethnicityField" name="ethnicity" type="text" readonly value="<%=ethnicity%>"></input>
        <button type="button" id="changeEthnicityBtn">Edit</button>
        <button type="button" id="saveEthnicityBtn">Save</button>
        <br>
    
        <label>Gender</label>
        <input id="genderField" name="gender" type="text" readonly value="<%=gender%>"></input>
        <button type="button" id="changeGenderBtn">Edit</button>
        <button type="button" id="saveGenderBtn">Save</button>
        
        
        
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
