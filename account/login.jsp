<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="../taglibs.jsp" %>
<jsp:useBean id='user' scope='session' class='main.java.beans.UserBean'/>
<jsp:setProperty name='user' property='*'/>


<c:set var="bodyContent">
    <div class="container">
        <div class="row justify-content-md-center">
            <div class="col-md-6">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">Login<br>
                        </h3>
                    </div>
                     <% if (request.getAttribute("errorMessage") != null) {
                        out.println(request.getAttribute("errorMessage"));
                    }
                    %>
                    <div class="panel-body">
                        <form role="form" action="login_action.jsp">
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
