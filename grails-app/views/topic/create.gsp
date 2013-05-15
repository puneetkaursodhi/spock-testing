<%@ page import="com.ig.linkSharing.Topic" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'topic.label', default: 'Topic')}"/>
    <title><g:message code="default.create.label" args="[entityName]"/></title>
</head>

<body>

<div id="create-topic" class="content scaffold-create " role="main">
    <div class="navbar">
        <div class="navbar-inner">
            <a class="brand" href="#"><g:message code="default.create.label" args="[entityName]"/></a>
        </div>
    </div>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${topicInstance}">
        <ul class="errors" role="alert">
            <g:eachError bean="${topicInstance}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
                        error="${error}"/></li>
            </g:eachError>
        </ul>
    </g:hasErrors>
    <g:form class="form-horizontal" action="save">
        <fieldset class="form">
            <g:render template="form"/>
        </fieldset>
        <fieldset class="buttons">
            <div class="control-group">
                <div class="controls">
                    <g:submitButton name="create" class="btn"
                                    value="${message(code: 'default.button.create.label', default: 'Create')}"/>
                </div>
            </div>
        </fieldset>
    </g:form>
</div>
</body>
</html>
