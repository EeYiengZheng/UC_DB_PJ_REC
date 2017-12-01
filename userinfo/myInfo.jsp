<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="../taglibs.jsp" %>
<%@include file="../databases.jsp" %>
<jsp:useBean id='user' scope='session' class='main.java.beans.UserBean'/>
<jsp:setProperty name='user' property='*'/>

<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
        integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
        crossorigin="anonymous"></script>
<script>
    $(document).ready(function () {

        $("#saveNameBtn").hide();
        $("#changeNameBtn").on("click", function () {
            $("#nameField").attr("readonly", false);
            $("#changeNameBtn").hide();
            $("#saveNameBtn").show();
        });
        $("#saveNameBtn").on("click", function () {
            $("#nameField").attr("readonly", true);
            $("#saveNameBtn").hide();
            $("#changeNameBtn").show();
        });


        $("#saveEmailBtn").hide();
        $("#changeEmailBtn").on("click", function () {
            $("#emailField").attr("readonly", false);
            $("#changeEmailBtn").hide();
            $("#saveEmailBtn").show();
        });
        $("#saveEmailBtn").on("click", function () {
            $("#emailField").attr("readonly", true);
            $("#saveEmailBtn").hide();
            $("#changeEmailBtn").show();
        });

        $("#savePhoneBtn").hide();
        $("#changePhoneBtn").on("click", function () {
            $("#phoneField").attr("readonly", false);
            $("#changePhoneBtn").hide();
            $("#savePhoneBtn").show();
        });
        $("#savePhoneBtn").on("click", function () {
            $("#phoneField").attr("readonly", true);
            $("#savePhoneBtn").hide();
            $("#changePhoneBtn").show();
        });

        $("#saveAddressBtn").hide();
        $("#changeAddressBtn").on("click", function () {
            $("#addressField").attr("readonly", false);
            $("#changeAddressBtn").hide();
            $("#saveAddressBtn").show();
        });
        $("#saveAddressBtn").on("click", function () {
            $("#addressField").attr("readonly", true);
            $("#saveAddressBtn").hide();
            $("#changeAddressBtn").show();
        });

        $("#saveEthnicityBtn").hide();
        $("#changeEthnicityBtn").on("click", function () {
            $("#ethnicityField").attr("readonly", false);
            $("#changeEthnicityBtn").hide();
            $("#saveEthnicityBtn").show();
        });
        $("#saveEthnicityBtn").on("click", function () {
            $("#ethnicityField").attr("readonly", true);
            $("#saveEthnicityBtn").hide();
            $("#changeEthnicityBtn").show();
        });

        $("#saveGenderBtn").hide();
        $("#changeGenderBtn").on("click", function () {
            $("#genderField").attr("readonly", false);
            $("#changeGenderBtn").hide();
            $("#saveGenderBtn").show();
        });
        $("#saveGenderBtn").on("click", function () {
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
    String firstName = rs.getString("first_name") == null ? "" : rs.getString("first_name");
    String lastName = rs.getString("last_name") == null ? "" : rs.getString("last_name");
    String birthday = rs.getString("birthday") == null ? "" : rs.getString("birthday");
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


            <div class="col-25"><label>First Name</label></div>
            <div class="col-25"><input id="firstNameField" name="firstName" type="text" readonly value="<%=firstName%>">
            </div>
            <br>
            <br>
            <div class="col-25"><label>Last Name</label></div>
            <div class="col-25"><input id="lastNameField" name="lastName" type="text" readonly value="<%=lastName%>">
            </div>
            <br>
            <br>
            <br>
            <div class="col-25"><label>Birthday</label></div>
            <div class="col-25"><input id="birthdayField" name="birthday" type="text" readonly value="<%=birthday%>">
            </div>
            <br>
            <br><br><br>
            <hr>
            <div class="col-25"><label>Nickname</label></div>
            <div class="col-25"><input id="nameField" name="nickname" type="text" readonly value="<%=nickname%>"></div>
            <div class="col-50">
                <button type="button" id="changeNameBtn">Edit</button>
                <button type="button" id="saveNameBtn">Save</button>
            </div>

            <br>
            <% if (request.getAttribute("resultMessage") != null) {
                out.println(request.getAttribute("resultMessage"));
            }
            %>
            <br>
            <div class="col-25"><label>Email</label></div>
            <div class="col-25"><input id="emailField" name="email" type="text" readonly value="<%=email%>"></div>
            <div class="col-50">
                <button type="button" id="changeEmailBtn">Edit</button>
                <button type="button" id="saveEmailBtn">Save</button>
            </div>
            <br><br>

            <div class="col-25"><label>Phone</label></div>
            <div class="col-25"><input id="phoneField" name="phone_number" type="text" readonly
                                       value="<%=phone_number%>"></div>
            <div class="col-50">
                <button type="button" id="changePhoneBtn">Edit</button>
                <button type="button" id="savePhoneBtn">Save</button>
            </div>
            <br><br>

            <div class="col-25"><label>Address</label></div>
            <div class="col-25"><input id="addressField" name="address" type="text" readonly value="<%=address%>"></div>
            <div class="col-50">
                <button type="button" id="changeAddressBtn">Edit</button>
                <button type="button" id="saveAddressBtn">Save</button>
            </div>
            <br><br>

            <div class="col-25"><label>Ethnicity</label></div>
            <div class="col-25"><input id="ethnicityField" name="ethnicity" type="text" readonly value="<%=ethnicity%>">
            </div>
            <div class="col-50">
                <button type="button" id="changeEthnicityBtn">Edit</button>
                <button type="button" id="saveEthnicityBtn">Save</button>
            </div>
            <br><br>

            <div class="col-25"><label>Gender</label></div>
            <div class="col-25"><input id="genderField" name="gender" type="text" readonly value="<%=gender%>"></div>
            <div class="col-50">
                <button type="button" id="changeGenderBtn">Edit</button>
                <button type="button" id="saveGenderBtn">Save</button>
            </div>
            <br>
            <input type="submit" value="Update Info" class="btn btn-info btn-update">
            <br><br><br><br>

        </form>
    </div>
    
    <!--Pls help-->
    <div class ="field-group">
    			<form method="post" action="change_password.jsp">
                    <div class="col-25"><label>Current Password:</label></div>
                    <div class="col-25"><input id="currentPWField" name="current_password" type="password">
                    </div>
                    <br>
                    <br>
                    <div class="col-25"><label>New Password:</label></div>
                    <div class="col-25"><input id="newPWField" name="new_password" type="password">
                    </div>
                    <br>
                    <br>
                    <div class="col-25"><label>Reenter New Password:</label></div>
                    <div class="col-25"><input id="rePWField" name="reenter_password" type="password">
                    </div>
            		<input type="submit" value="Change Password" class="btn btn-info btn-update">
                </form>
    </div>
</c:set>

<t:genericpage>
    <jsp:attribute name="head">
        <title>User Information</title>
    </jsp:attribute>
    <jsp:attribute name="header">
        <h1 class="display-3">MyInfo</h1>
    </jsp:attribute>
    <jsp:attribute name="footer">
    </jsp:attribute>
    <jsp:body>
        ${bodyContent}
    </jsp:body>

</t:genericpage>
