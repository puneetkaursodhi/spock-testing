<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>ADMIN</title>
</head>

<body>
<div id="userDetailDiv">
    <g:render template="userDetail" model="[userInstanceList: userInstanceList, userInstanceTotal: userInstanceTotal]"/>
</div>

<div id="topicDetailDiv">
    <g:render template="topicDetail"
              model="[topicInstanceList: topicInstanceList, topicInstanceTotal: topicInstanceTotal]"/>
</div>
</body>
</html>