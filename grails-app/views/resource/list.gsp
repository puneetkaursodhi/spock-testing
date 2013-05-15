<%@ page import="com.ig.linkSharing.Resource" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'resource.label', default: 'Resource')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>

<div id="list-resource" class="content scaffold-list" role="main">
    <h1><g:message code="default.list.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <table class="table">
        <thead>
        <tr>

            <g:sortableColumn property="title" title="${message(code: 'resource.title.label', default: 'Title')}"/>

            <g:sortableColumn property="summary"
                              title="${message(code: 'resource.summary.label', default: 'Summary')}"/>

            <th><g:message code="resource.creator.label" default="Creator"/></th>

            <g:sortableColumn property="dateCreated"
                              title="${message(code: 'resource.dateCreated.label', default: 'Date Created')}"/>

            <g:sortableColumn property="lastUpdated"
                              title="${message(code: 'resource.lastUpdated.label', default: 'Last Updated')}"/>

            <th><g:message code="resource.topic.label" default="Topic"/></th>
            <th>Resource</th>

        </tr>
        </thead>
        <tbody>
        <g:each in="${resourceInstanceList}" status="i" var="resourceInstance">
            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                <td><g:link action="show"
                            id="${resourceInstance.id}">${fieldValue(bean: resourceInstance, field: "title")}</g:link></td>

                <td>${fieldValue(bean: resourceInstance, field: "summary")}</td>

                <td>${fieldValue(bean: resourceInstance, field: "creator")}</td>

                <td><g:formatDate date="${resourceInstance.dateCreated}"/></td>

                <td><g:formatDate date="${resourceInstance.lastUpdated}"/></td>

                <td>${fieldValue(bean: resourceInstance, field: "topic.name")}</td>

                <ls:isLink resourceId="${resourceInstance.id}">
                    <td>${fieldValue(bean: resourceInstance, field: "url")}</td>
                </ls:isLink>

                <ls:isDocument resourceId="${resourceInstance.id}">
                    <td>${fieldValue(bean: resourceInstance, field: "fileName")}</td>
                </ls:isDocument>
            </tr>
        </g:each>
        </tbody>
    </table>

    <div class="pagination text-center">
        <g:paginate total="${resourceInstanceTotal}"/>
    </div>
</div>
</body>
</html>
