<%@ page import="com.ig.linkSharing.Resource" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'resource.label', default: 'Resource')}"/>
    <title><g:message code="default.create.label" args="[entityName]"/></title>
</head>

<body>

<div id="create-resource" class="content scaffold-create" role="main">
    <legend><g:message code="default.create.label" args="[entityName]"/></legend>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${resourceInstance}">
        <ul class="errors" role="alert">
            <g:eachError bean="${resourceInstance}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
                        error="${error}"/></li>
            </g:eachError>
        </ul>
    </g:hasErrors>
    <g:form class="form-horizontal" action="save" params="[topicId: params.topicId]" enctype="multiPart/form-data">
        <fieldset class="form">
            <g:render template="form"/>
            <div class="control-group" id="divResourceType" onchange="resourceType()">
                <label class="control-label">Select Type of Resource</label>

                <div class="controls">
                    <input type="radio" name="resourceType" value="linkResource" checked="checked"/>LinkResource
                    <input type="radio" name="resourceType" value="documentResource"/> DocumentResource
                </div>
            </div>

            <div class="control-group" id="linkResource">
                <label class="control-label" for="linkResource">
                    URL
                </label>

                <div class="controls">
                    <g:field type="url" name="url"/>
                </div>
            </div>

            <div class="control-group" id="documentResource" hidden="true">
                <label class="control-label" for="documentResource">
                    Upload pdf File
                </label>

                <div class="controls">
                    <input type="file" name="multipartFile"/>
                </div>
            </div>
        </fieldset>
        <fieldset class="buttons">
            <div class="control-group">
                <div class="controls">
                    <g:submitButton name="create" class="save btn"
                                    value="${message(code: 'default.button.create.label', default: 'Create')}"/>
                </div>
            </div>
        </fieldset>
    </g:form>
</div>
</body>
</html>
