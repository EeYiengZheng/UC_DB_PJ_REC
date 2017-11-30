<%@tag description="Overall Page template" pageEncoding="UTF-8" %>
<%@attribute name="head" fragment="true" %>
<%@attribute name="header" fragment="true" %>
<%@attribute name="footer" fragment="true" %>
<%@include file="../../taglibs.jsp" %>

<jsp:useBean id="user" class="main.java.beans.UserBean" scope="session"/>
<html>
<head>
    <link rel="shortcut icon" type="image/png"
          href="https://prometheus.atlas-sys.com/download/attachments/116130109/database02.png"/>
    <meta name="author" content="CS157A team 5">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css"
          integrity="sha384-PsH8R72JQ3SOdhVi3uxftmaW6Vc51MKb0q5P2rRUpPvrszuE4W1povHYgTpBfshb" crossorigin="anonymous">
    <jsp:invoke fragment="head"/>
    <style>
        .jumbotron {
            line-height: 1;
            background-image: linear-gradient(#011f4b, #03396c, #005b96, #6497b1, #b3cde0);
            background-repeat: no-repeat;
            background-size: 100% 100%;
            background-color: #b3cde0;
            border-radius: 0px;
        }

        #body-override .jumbotron {
            line-height: 1;
            background-color: #b3cde0;
            height: 100vh;
        }

        body {
            background-color: #b3cde0;
        }

        h1, h2, h3, p, footer, small, .nav-link, .navbar-toggler-icon, label {
            color: white !important;
        }
hr {
    color: white;
    border-color: white;
    background-color: white;
}
.col-25 {
  float: left;
  width: 40%;
  margin-top: 6px;
    padding: 5px 5px;
}
.col-50 {
  float: right;
  width: 0%;
  margin-top: 5px;
    padding: 5px 5px;
}
label {
    padding: 4px 0px;
}
.col-75 {
  float: left;
  width: 75%;
  margin-top: 6px;
}
input[type=text]{
    width:140%;
    border-radius: 4px;
    padding: 5px 5px;
    margin: 0 0;
}

button {
    padding: 7px 7px;
    border-radius: 4px;
    box-sizing: border-box;
}
        .display-3 {
            color: white !important;
        }

        .bg-dark {
            background-color: #011f4b !important;
        }
    </style>
</head>
<body id="body-override">
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <a class="navbar-brand" href="<c:url value="/"/>">UCDB</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar1" aria-controls="navbar1"
            aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbar1">
        <ul class="navbar-nav mr-auto">
            <c:if test="${user.loggedIn}">
                <li class="nav-item">
                    <a class="nav-link" href="<c:url value="/userinfo/myInfo.jsp"/>">MyInfo</a>
                </li>
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
                        <a class="nav-link" href="<c:url value="/account/profile.jsp"/>">Dashboard</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<c:url value="/account/logout_action.jsp"/>">Sign Out</a>
                    </li>
                </c:when>
                <c:otherwise>
                    <li class="nav-item ">
                        <a class="nav-link" href="<c:url value="/account/login.jsp"/>">Login</a>
                    </li>
                    <li class="nav-item ">
                        <a class="nav-link" href="<c:url value="/account/register.jsp"/>">Register</a>
                    </li>
                </c:otherwise>
            </c:choose>
        </ul>
    </div>
</nav>
<div class="jumbotron">
    <div class="container">
        <div class="row justify-content-center" id="pageheader">
            <jsp:invoke fragment="header"/>
        </div>
        <div class="row" id="body">
            <jsp:doBody/>
        </div>
        <div class="row justify-content-center" id="pagefooter">
            <jsp:invoke fragment="footer"/>
            <small id="copyright">© Copyright Team 5: CS157A Database Project 2017</small>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
        integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
        crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js"
        integrity="sha384-vFJXuSJphROIrBnz7yo7oB41mKfc8JzQZiCq4NCceLEaO4IHwicKwpJf9c9IpFgh"
        crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/js/bootstrap.min.js"
        integrity="sha384-alpBpkh1PFOepccYVYDB4do5UnbKysX5WZXm3XxPqe5iKTfUKjNkCk9SaVuEZflJ"
        crossorigin="anonymous"></script>
</body>
</html>