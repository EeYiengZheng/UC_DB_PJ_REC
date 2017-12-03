
<%@include file="../taglibs.jsp" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>


<c:set var="bodyContent">
</c:set>
<t:genericpage>
    <jsp:attribute name="head">
        <title>Employees</title>
    </jsp:attribute>
    <jsp:attribute name="header">
        <h1 class="display-3">Filter Results</h1>
    </jsp:attribute>
    <jsp:attribute name="footer">
    </jsp:attribute>
    <jsp:body>
        ${bodyContent}
    </jsp:body>
</t:genericpage>