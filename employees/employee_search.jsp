<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="../taglibs.jsp" %>
<%@include file="../databases.jsp" %>
<jsp:useBean id='user' scope='session' class='main.java.beans.UserBean'/>

<c:set var="bodyContent">
    <% if (request.getAttribute("resultMessage") != null) {
        out.println("<p>" + request.getAttribute("resultMessage") + "</p>");
    }
    %>
    <div class="container ">
        <br>
        <br>
        <div class="row justify-content-center">
            <div class="row">
                <form action="employee_search_result.jsp">
                    <div class="form-group">
                        <div class="row">
                            <div class="col">
                                <label>First Name:<br><input type="text" name="lec_fname"></label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <label>Last Name:<br><input type="text" name="lec_lname"></label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <label>Employee ID:<br><input type="text" name="lec_id"></label>
                            </div>
                        </div>
                    </div>
                    <div class="row justify-content-center">
                        <div class="col-1"></div>
                        <div class="col"><input type="submit" value="Search" id="search_btn"
                                                class="btn btn-info btn-search">
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <br><br>
    <% if (request.getAttribute("resultMessage") != null) {
        out.println("<table style='width:100%'><tr><th><h4>Employee</h4></th><th><h4 align='right'>Fire</h4></th></tr>" + request.getAttribute("resultMessage") + "</p>");
    }
    %>
    <div class="container">
        <div class="row justify-content-center">
            <h3>My Employees</h3>
        </div>
        <%
            // user is dept head. user type = "Head"
            if (user.getType().equals("Head")) {
                String query = "SELECT * FROM users_detail NATURAL JOIN professors WHERE professor_id IN (SELECT professor_id FROM hired_by NATURAL JOIN head_of NATURAL JOIN dept_heads NATURAL JOIN users WHERE username=?)";
                PreparedStatement stmt = con.prepareStatement(query);
                stmt.setString(1, user.getUsername());
                ResultSet profList = stmt.executeQuery();
                if (profList.next()) {
                    out.println("<table style='width:100%'><tr><th></th><th></th></tr>");
                    while (profList.next()) {
                        String firstName = profList.getString("first_name");
                        String lastName = profList.getString("last_name");
                        String profID = profList.getString("professor_id");
                        String user_id = profList.getString("user_id");
                        String gender = profList.getString("gender");
                        request.getSession().setAttribute("fname", firstName);
                        request.getSession().setAttribute("lname", lastName);
                        request.getSession().setAttribute("emp_id", profID);
        %>
        <div class="d-flex flex-row">
            <div class="p-2"><h5 style="color:white;">Name: <c:out value="${fname} ${lname}"/></h5></div>
        </div>
        <div class="d-flex flex-row">
            <div class="p-2"><h5 style="color:white;">Emp ID: <c:out value="${emp_id}"/><br></h5></div>
            <form action='fire_employee.jsp' method='GET'>
                <input name='prof_user_id' type='hidden' value="${user_id}">
                <div class="ml-auto p-2">
                    <input type="hidden" name="empl" value="<c:out value="${emp_id}"/>">
                    <input type='Submit' class="btn btn-default btn-danger" value='Fire'>
                </div>
            </form>
        </div>
        <div class="d-flex flex-row"></div>
    </div>

    <%
                }
                stmt.close();
                con.close();
            } else {
                // someone else
            }
        }
    %>
</c:set>

<t:genericpage>
    <jsp:attribute name="head">
        <title>Search Employee</title>
    </jsp:attribute>
    <jsp:attribute name="header">
        <h1 class="display-3">Find Employees</h1>
    </jsp:attribute>
    <jsp:attribute name="footer">
        <style>#footer {
            margin-top: 140px;
        }</style>
    </jsp:attribute>
    <jsp:body>
        ${bodyContent}
    </jsp:body>

</t:genericpage>