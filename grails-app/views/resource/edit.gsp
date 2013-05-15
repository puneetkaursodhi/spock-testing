<%@ page import="com.ig.linkSharing.Resource" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'resource.label', default: 'Resource')}"/>
    <title><g:message code="default.edit.label" args="[entityName]"/></title>
</head>

<body>

<div id="edit-resource" class="content scaffold-edit" role="main">
    <h1><g:message code="default.edit.label" args="[entityName]"/></h1>
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
    <g:form method="post" enctype="multiPart/form-data">
        <g:hiddenField name="id" value="${resourceInstance?.id}"/>
        <g:hiddenField name="version" value="${resourceInstance?.version}"/>
        <fieldset class="form">
            <g:render template="form"/>

            <ls:isLink resourceId="${resourceInstance?.id}">
                <div id="linkResource"
                     class="fieldcontain ${hasErrors(bean: resourceInstance, field: 'url', 'error')} required">
                    <label for="url">
                        <g:message code="resource.url.label" default="Url"/>
                        <span class="required-indicator">*</span>
                    </label>
                    <g:field type="url" name="url" required="" value="${resourceInstance?.url}"/>
                </div>
            </ls:isLink>

            <ls:isDocument resourceId="${resourceInstance.id}">
                <div id="documentResource">
                    <label for="documentResource">
                        Upload pdf File
                    </label>
                    <input type="file" name="multipartFile"/>
                </div>
            </ls:isDocument>

        </fieldset>
        <fieldset class="buttons">
            <g:actionSubmit class="save" action="update"
                            value="${message(code: 'default.button.update.label', default: 'Update')}"/>
            <g:actionSubmit class="delete" action="delete"
                            value="${message(code: 'default.button.delete.label', default: 'Delete')}" formnovalidate=""
                            onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
        </fieldset>
    </g:form>
</div>
</body>
</html>
