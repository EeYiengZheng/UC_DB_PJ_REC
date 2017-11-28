<%@tag description="Overall Page template" pageEncoding="UTF-8" %>
<%@attribute name="head" fragment="true" %>
<%@attribute name="header" fragment="true" %>
<%@attribute name="footer" fragment="true" %>
<%@include file="../../taglibs.jsp" %>

<jsp:useBean id="user" class="main.java.beans.UserBean" scope="session"/>
<html>
<head>
    <meta name="author" content="CS157A team 5">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css"
          integrity="sha384-PsH8R72JQ3SOdhVi3uxftmaW6Vc51MKb0q5P2rRUpPvrszuE4W1povHYgTpBfshb" crossorigin="anonymous">
    <jsp:invoke fragment="head"/>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <a class="navbar-brand" href="<c:url value="/"/>">UCBD</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar1" aria-controls="navbar1"
            aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbar1">
        <ul class="navbar-nav mr-auto">
            <c:if test="${user.loggedIn}">
                <li class="nav-item">
                    <a class="nav-link" href="<c:url value="/courses/search.jsp"/>">Search Courses</a>
                </li>
                <c:choose>
                    <c:when test="${user.getType().equals('Lecturer')}">
                        <li class="nav-item">
                            <a class="nav-link" href="<c:url value="/courses/gradebook.jsp"/>">Gradebook</a>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item">
                            <a class="nav-link" href="<c:url value="/courses/grades.jsp"/>">Grades</a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </c:if>
        </ul>
        <ul class="navbar-nav navbar-right">
            <c:choose>
                <c:when test="${user.loggedIn}">
                    <li class="nav-item">
                        <a class="nav-link" href="<c:url value="/account/profile.jsp"/>">Portal</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<c:url value="/account/logout_action.jsp"/>">Sign Out</a>
                    </li>
                </c:when>
                <c:otherwise>
                    <li class="nav-item ">
                        <a class="nav-link" href="<c:url value="/account/login.jsp"/>">Sign In</a>
                    </li>
                    <li class="nav-item ">
                        <a class="nav-link" href="<c:url value="/account/register.jsp"/>">Register</a>
                    </li>
                </c:otherwise>
            </c:choose>
        </ul>
    </div>
</nav>
<div class="jumbotron" style="height: 100vh;">
    <div class="container">
        <div class="row" id="pageheader">
            <jsp:invoke fragment="header"/>
        </div>
        <div class="row" id="body">
            <jsp:doBody/>
        </div>
        <div class="row justify-content-center" id="pagefooter">
            <jsp:invoke fragment="footer"/>
            <small id="copyright">Team 5 CS157A Database Project Copyright 2017, and I hate JSP</small>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js" integrity="sha384-vFJXuSJphROIrBnz7yo7oB41mKfc8JzQZiCq4NCceLEaO4IHwicKwpJf9c9IpFgh" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/js/bootstrap.min.js"
        integrity="sha384-alpBpkh1PFOepccYVYDB4do5UnbKysX5WZXm3XxPqe5iKTfUKjNkCk9SaVuEZflJ"
        crossorigin="anonymous"></script>
</body>
</html>
