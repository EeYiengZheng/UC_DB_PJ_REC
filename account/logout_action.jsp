<jsp:useBean id='user' scope='session' class='main.java.beans.UserBean'/>
<% user.setUsername(null);
    user.setType(null);
    user.setLoggedIn(false);
    user.setPassword(null);
    response.sendRedirect("../"); %>