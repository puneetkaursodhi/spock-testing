<%@ page import="com.ig.linkSharing.ReadingItem" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'readingItem.label', default: 'ReadingItem')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>
<div class="navbar">
    <div class="navbar-inner">
        <a class="brand" href="#"><g:message code="default.show.label" args="[entityName]"/></a>
    </div>
</div>
<table class="table table-bordered">

    <tr>
        <g:if test="${readingItemInstance?.dateCreated || false}">
            <td><strong><g:message code="readingItem.dateCreated.label" default="Date Created"/></strong></td>

            <td><g:formatDate date="${readingItemInstance?.dateCreated}"/></td>

        </g:if>
    </tr>

    <tr>
        <g:if test="${readingItemInstance?.isFavourite || true}">
            <td><strong><g:message code="readingItem.isFavourite.label" default="Is Favourite"/></strong></td>

            <td><a id="isFavourite${readingItemInstance?.id}" href="javascript:void(0)"
                   onclick="toggleFavourite(${readingItemInstance?.id})">
                <i class="${readingItemInstance?.isFavourite ? 'icon-star' : 'icon-star-empty'}"></i></a>
                %{--${readingItemInstance?.isFavourite ? 'Yes' : 'No'}--}%
            </td>

        </g:if>
    </tr>

    <tr>
        <g:if test="${readingItemInstance?.isRead || true}">
            <td><strong><g:message code="readingItem.isRead.label" default="Is Read"/></strong></td>

            <td>${readingItemInstance?.isRead ? 'Read' : 'Unread'}</td>

        </g:if>
    </tr>

    <tr>
        <g:if test="${readingItemInstance?.lastUpdated || false}">
            <td><strong><g:message code="readingItem.lastUpdated.label" default="Last Updated"/></strong></td>

            <td><g:formatDate date="${readingItemInstance?.lastUpdated}"/></td>

        </g:if>
    </tr>

    <tr>
        <g:if test="${readingItemInstance?.resource || false}">
            <td><strong><g:message code="readingItem.resource.label" default="Resource"/></strong></td>

            <td><g:link controller="resource" action="show"
                        id="${readingItemInstance?.resource?.id}">${readingItemInstance?.resource?.
                        encodeAsHTML()}</g:link>
            <ls:isLink resourceId="${readingItemInstance?.resource?.id}">
                <g:link class="bold" target="_blank" url="${readingItemInstance?.resource}">Open Link</g:link>
            </ls:isLink>
            <ls:isDocument resourceId="${readingItemInstance?.resource?.id}">
                <g:link class="bold" controller="resource" action="download"
                        id="${readingItemInstance?.resource?.id}">Download</g:link>
            </ls:isDocument>
            </td>

        </g:if>
    </tr>

    <tr>
        <g:if test="${readingItemInstance?.user || false}">
            <td><strong>Topic</strong></td>

            <td><g:link controller="topic" action="show"
                        id="${readingItemInstance?.resource?.topic?.id}">${readingItemInstance?.resource?.topic?.
                        encodeAsHTML()}</g:link></td>

        </g:if>
    </tr>
</table>
<g:form>
    <g:hiddenField name="id" value="${readingItemInstance?.id}"/>
    <g:actionSubmit class="btn btn-danger" action="delete"
                    value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                    onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
</g:form>
<script type="text/javascript">
    var toggleFavouriteUrl = "${createLink(controller: 'readingItem',action: 'toggleFavourite')}"
</script>
</body>
</html>
