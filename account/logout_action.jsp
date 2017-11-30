<jsp:useBean id='user' scope='session' class='main.java.beans.UserBean'/>
<jsp:setProperty name="user" property="loggedIn"  value="false"/>
<% response.sendRedirect("/"); %>