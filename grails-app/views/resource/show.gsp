<%@ page import="com.ig.linkSharing.Resource" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'resource.label', default: 'Resource')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>

<div id="show-resource" class="content scaffold-show" role="main">
    <div class="navbar">
        <div class="navbar-inner">
            <a class="brand" href="#"><g:message code="default.show.label" args="[entityName]"/></a>
        </div>
    </div>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <table class="table table-bordered">

        <tr>
            <g:if test="${resourceInstance?.topic}">
                <td><strong>
                    <span id="topic-label" class="property-label"><g:message code="resource.topic.label"
                                                                             default="Topic"/></span>
                </strong></td>
                <td>
                    <span class="property-value" aria-labelledby="topic-label"><g:link controller="topic" action="show"
                                                                                       id="${resourceInstance?.topic?.id}">${resourceInstance?.topic?.encodeAsHTML()}</g:link></span>

                </td>
            </g:if>
        </tr>
        <tr>

            <g:if test="${resourceInstance?.title}">
                <td><strong>
                    <span id="title-label" class="property-label"><g:message code="resource.title.label"
                                                                             default="Title"/></span>
                </strong></td>
                <td>
                    <span class="property-value" aria-labelledby="title-label"><g:fieldValue bean="${resourceInstance}"
                                                                                             field="title"/></span>

                </td>
            </g:if>
        </tr>
        <tr>
            <g:if test="${resourceInstance?.summary}">
                <td><strong>
                    <span id="summary-label" class="property-label"><g:message code="resource.summary.label"
                                                                               default="Summary"/></span>
                </strong></td>
                <td>
                    <span class="property-value" aria-labelledby="summary-label"><g:fieldValue
                            bean="${resourceInstance}"
                            field="summary"/></span>

                </td>
            </g:if>
        </tr>
        <tr>
            <g:if test="${resourceInstance?.creator}">
                <td><strong>
                    <span id="creator-label" class="property-label"><g:message code="resource.creator.label"
                                                                               default="Creator"/></span>
                </strong></td>
                <td>
                    <span class="property-value" aria-labelledby="creator-label">
                        <ls:isOwner resourceInstance="${resourceInstance}">
                            <g:link controller="user" action="show"
                                    id="${resourceInstance?.creator?.id}">${resourceInstance?.creator?.encodeAsHTML()}</g:link>
                        </ls:isOwner>
                    </span>

                </td>
            </g:if>
        </tr>
        <tr>
            <ls:isLink resourceId="${resourceInstance.id}">
                <td><strong>
                    <span id="url-label" class="property-label"><g:message code="resource.url.label"
                                                                           default="Url"/></span>
                </strong></td>
                <td>
                    <span class="property-value"
                          aria-labelledby="url-label"><g:link target="_blank" url="${resourceInstance}"><g:fieldValue
                            bean="${resourceInstance}"
                            field="url"/></g:link>
                    </span>

                </td>
            </ls:isLink>

            <ls:isDocument resourceId="${resourceInstance.id}">
                <td><strong>
                    <span id="fileName-label" class="property-label"><g:message code="resource.fileName.label"
                                                                                default="File Name"/></span>
                </strong></td>
                <td>
                    <span class="property-value"
                          aria-labelledby="fileName-label"><g:link action="download"
                                                                   id="${resourceInstance?.id}"><g:fieldValue
                                bean="${resourceInstance}"
                                field="fileName"/></g:link>
                    </span>

                </td>
            </ls:isDocument>
        </tr>
        <tr>
            <g:if test="${resourceInstance?.dateCreated}">
                <td><strong>
                    <span id="dateCreated-label" class="property-label"><g:message code="resource.dateCreated.label"
                                                                                   default="Date Created"/></span>
                </strong></td>
                <td>
                    <span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate
                            date="${resourceInstance?.dateCreated}"/></span>

                </td>
            </g:if>
        </tr>
        <tr>
            <g:if test="${resourceInstance?.lastUpdated}">
                <td><strong>
                    <span id="lastUpdated-label" class="property-label"><g:message code="resource.lastUpdated.label"
                                                                                   default="Last Updated"/></span>
                </strong></td>
                <td>
                    <span class="property-value" aria-labelledby="lastUpdated-label"><g:formatDate
                            date="${resourceInstance?.lastUpdated}"/></span>

                </td>
            </g:if>
        </tr>
    </table>
    <g:form>
        <fieldset class="buttons">
            <g:hiddenField name="id" value="${resourceInstance?.id}"/>
            <ls:isAdminOrResourceCreator resourceInstance="${resourceInstance}">
                <g:link class="edit" action="edit" id="${resourceInstance?.id}"><g:message
                        code="default.button.edit.label"
                        default="Edit"/></g:link>
                <g:actionSubmit class="delete" action="delete"
                                value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                                onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
            </ls:isAdminOrResourceCreator>
        </fieldset>
    </g:form>
</div>
</body>
</html>
