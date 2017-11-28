<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="../taglibs.jsp" %>
<jsp:useBean id='user' scope='session' class='main.java.beans.UserBean'/>
<jsp:setProperty name='user' property='*'/>

<c:set var="bodyContent">
    <div class="container">
        <div class="row justify-content-md-center">
            <div class="col-md-8">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">Register for an Account<br>
                        </h3>
                    </div>
                    <div class="panel-body">
                        <form role="form" action="register_action.jsp">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <input type="text" name="fname" id="first_name" class="form-control input-sm"
                                               placeholder="First Name">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <input type="text" name="lname" id="last_name" class="form-control input-sm"
                                               placeholder="Last Name">
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <input type="text" name="nickname" id="nickname" class="form-control input-sm"
                                               placeholder="Nickname">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <input type="date" name="birthday" id="date" class="form-control input-sm"
                                               placeholder="Date of Birth">
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <input type="email" name="email" id="email" class="form-control input-sm"
                                       placeholder="Email Address">
                            </div>
                            <div class="form-group">
                                <input type="text" name="username" id="user_name" class="form-control input-sm"
                                       placeholder="Username" required>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <input type="password" name="password" id="password"
                                               class="form-control input-sm" placeholder="Password" required>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <input type="password" name="conf_password" id="password_confirmation"
                                               class="form-control input-sm" placeholder="Confirm Password" required>
                                    </div>
                                </div>
                            </div>
                            <fieldset class="form-group">
                                <div class="row">
                                    <div class="col-9">
                                        <div class="form-check form-check-inline">
                                            <label class="form-check-label">
                                                <input class="form-check-input" type="radio" name="user_type"
                                                       id="user_type1" value="option1" checked>
                                                Student
                                            </label>
                                        </div>
                                        <div class="form-check form-check-inline">
                                            <label class="form-check-label">
                                                <input class="form-check-input" type="radio" name="user_type"
                                                       id="user_type2" value="option2">
                                                Lecturer
                                            </label>
                                        </div>
                                        <div class="form-check form-check-inline disabled">
                                            <label class="form-check-label">
                                                <input class="form-check-input" type="radio" name="user_type"
                                                       id="user_type3" value="option3" disabled>
                                                VIP
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </fieldset>
                            <input type="submit" value="Register" class="btn btn-info btn-block">
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</c:set>

<t:genericpage>
    <jsp:attribute name="head">
        <title>Register</title>
        <style>
            input[type="date"]:before {
                content: attr(placeholder) !important;
                color: #aaa;
                margin-right: 0.5em;
            }

            input[type="date"]:focus:before,
            input[type="date"]:valid:before {
                content: "";
            }

            #user_name::placeholder  {
                color: #f66;
            }

            #password::placeholder  {
                color: #f66;
            }

            #password_confirmation::placeholder  {
                color: #f66;
            }

        </style>
    </jsp:attribute>
    <jsp:attribute name="header">
    </jsp:attribute>
    <jsp:attribute name="footer">
        <script>
            $(document).ready(function () {
                var today = new Date();
                var date = (today.getMonth() + 1) + '/' + today.getDate() + '/' + today.getFullYear();
                $("#date").attr("placeholder", date.valueOf());
            });
        </script>
    </jsp:attribute>
    <jsp:body>
        ${bodyContent}
    </jsp:body>

</t:genericpage>

<% if (request.getAttribute("errorMessage") != null) {
    out.println(request.getAttribute("errorMessage"));
}
%>