<%@tag description="Overall Page template" pageEncoding="UTF-8" %>
<%@attribute name="head" fragment="true" %>
<%@attribute name="header" fragment="true" %>
<%@attribute name="footer" fragment="true" %>
<%@include file="../../taglibs.jsp" %>

<jsp:useBean id="user" class="main.java.beans.UserBean" scope="application"/>
<html>
<head>
    <meta name="author" content="CS157A team 5">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link href="https://getbootstrap.com/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <jsp:invoke fragment="head"/>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-inverse bg-inverse rounded">
    <a class="navbar-brand" href="<c:url value="/"/>">Log Analyzer</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar1"
            aria-controls="navbarsExample09" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbar1">
        <ul class="navbar-nav mr-auto">

        </ul>
        <ul class="nav navbar-nav navbar-right">
            <c:choose>
                <c:when test="${user.loggedIn}">
                    <li class="nav-item">
                        <a class="nav-link" href="<c:url value="../../account/profile.jsp"/>">Portal</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<c:url value="../../account/logout_action.jsp"/>">Sign Out</a>
                    </li>
                </c:when>
                <c:otherwise>
                    <li class="nav-item ">
                        <a class="nav-link" href="<c:url value="../../account/login.jsp"/>">Sign In</a>
                    </li>
                    <li class="nav-item ">
                        <a class="nav-link" href="<c:url value="../../account/register.jsp"/>">Register</a>
                    </li>
                </c:otherwise>
            </c:choose>
        </ul>
    </div>
</nav>
<div class="jumbotron">
    <div class="container">
        <div id="pageheader">
            <jsp:invoke fragment="header"/>
        </div>
        <div id="body">
            <jsp:doBody/>
        </div>
        <div id="pagefooter">
            <jsp:invoke fragment="footer"/>
        </div>
    </div>
</div>
<script
        src="https://code.jquery.com/jquery-3.2.1.min.js"
        integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4="
        crossorigin="anonymous"></script>
<script>window.jQuery || document.write('<script src="https://getbootstrap.com/assets/js/vendor/jquery.min.js"><\/script>')</script>
<script src="https://getbootstrap.com/assets/js/vendor/popper.min.js"></script>
<script src="https://getbootstrap.com/dist/js/bootstrap.min.js"></script>
</body>
</html>
