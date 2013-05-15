<%@ page import="com.ig.linkSharing.Topic" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'topic.label', default: 'Topic')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>

<div id="list-topic" class="content scaffold-list" role="main">
    <div class="navbar">
        <div class="navbar-inner">
            <a class="brand" href="#"><g:message code="default.list.label" args="[entityName]"/></a>
        </div>
    </div>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <g:render template="topicList"/>
</div>
</body>
</html>
