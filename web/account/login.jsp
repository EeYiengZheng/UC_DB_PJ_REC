<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="../taglibs.jsp" %>
<jsp:useBean id='user' scope='session' class='main.java.beans.UserBean'/>
<jsp:setProperty name='user' property='*'/>


<c:set var="bodyContent">
    <div class="container">
        <div class="row centered-form">
            <div class="col-md-4">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">Please login <br>
                            <small style="font-size: x-small"> (I hope it doesn't crash!)</small>
                        </h3>
                    </div>
                    <div class="panel-body">
                        <form role="form">
                            <div class="form-group">
                                <input type="text" name="username" id="user_name" class="form-control input-sm"
                                       placeholder="Username">
                            </div>
                            <div class="form-group">
                                <input type="password" name="password" id="password" class="form-control input-sm"
                                       placeholder="Password" required>
                            </div>

                            <input type="submit" value="Login" class="btn btn-info btn-block" id="login_btn">

                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <% if (request.getAttribute("errorMessage") != null) {
        out.println(request.getAttribute("errorMessage"));
    }
    %>
</c:set>

<t:genericpage>
    <jsp:attribute name="head">
        <title>Login</title>
    </jsp:attribute>
    <jsp:attribute name="header">
    </jsp:attribute>
    <jsp:attribute name="footer">
    </jsp:attribute>
    <jsp:body>
        ${bodyContent}
    </jsp:body>

</t:genericpage>
