<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="taglibs.jsp" %>
<jsp:useBean id='user' class="main.java.beans.UserBean"/>
<jsp:setProperty name='user' property='loggedIn' value="false"/>

<t:genericpage>
    <jsp:attribute name="head">
        <title>Welcome</title>
    </jsp:attribute>
    <jsp:attribute name="header">
        <h1 class="display-3"><img src="https://4erff29jo03b8uhp4b94vxhq-wpengine.netdna-ssl.com/wp-content/uploads/2015/05/caspio-features-illustr_cloud-data_3_2x.png" width="140px" height="120px">University Database Project</h1>
    </jsp:attribute>
    <jsp:attribute name="footer">
    </jsp:attribute>
    <jsp:body>
        <br><br>
        <h3>Search Professors | View Grades | Register for Courses</h3><br><br>
        </br>
        <br>
        <p>Created for CS157A with Professor Mike Wu, the UCDB project demonstrates the team's knowledge of databases. <br><br>
    The application is a private database for a university to store information. The database may be ordered by relation. Information may include departments, staff and faculty members, buildings, courses, students, or more. Users will be able to query the database for specific information. Students can add/drop courses and professors can assign grades.<br><br>
            <br>
    Having a private database that stores university information is highly beneficial to both students and professors alike, because storing that much information without a database would be daunting. The main benefit of a database is its query functionality. Students will be able to quickly and efficiently query the database for information about their courses. They can look up available courses and obtain useful information about them such as the current professor, the time, and the location of the class. This allows students to easily plan out their future class schedules. Students can also utilize the database to drop themselves from courses when their workload is too much for them to handle. Professors will be able to see their classes and students within each course. They can also assign grades to students.</p>
    <br><br>
    </jsp:body>
</t:genericpage>