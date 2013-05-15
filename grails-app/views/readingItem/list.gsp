<%@ page import="com.ig.linkSharing.ReadingItem" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'readingItem.label', default: 'ReadingItem')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<div class="navbar">
    <div class="navbar-inner">
        <a class="brand" href="#"><g:message code="default.list.label" args="[entityName]"/></a>
    </div>
</div>
<table class="table table-bordered table-striped table-hover">
    <thead>
    <tr>

        <g:sortableColumn class="hidden-phone" property="isFavourite"
                          title="${message(code: 'readingItem.isFavourite.label', default: 'Is Favourite')}"/>

        <g:sortableColumn class="hidden-phone" property="isRead"
                          title="${message(code: 'readingItem.isRead.label', default: 'Is Read')}"/>

        <th class="hidden-phone"><g:message code="readingItem.resource.label" default="Resource"/></th>

        <th class="hidden-phone">Topic</th>

    </tr>
    </thead>
    <tbody>
    <g:each in="${readingItemInstanceList}" status="i" var="readingItemInstance">
        <tr id="readingItem${readingItemInstance?.id}" class="${readingItemInstance?.isRead ? 'muted' : 'bold'}">

            <td class="hidden-phone">
                <a id="isFavourite${readingItemInstance?.id}" href="javascript:void(0)"
                   onclick="toggleFavourite(${readingItemInstance?.id})">
                    <i class="${readingItemInstance?.isFavourite ? 'icon-star' : 'icon-star-empty'}"></i></a>
            </td>

            <td class="hidden-phone"><a id="isRead${readingItemInstance?.id}"
                                        href="javascript:void(0)"
                                        onclick="markAsReadUnread(${readingItemInstance?.id})">${readingItemInstance.isRead ? 'Mark as Unread' : 'Mark as Read'}</a>
            </td>

            <td class="hidden-phone"><g:link action="show"
                                             id="${readingItemInstance.id}">${fieldValue(bean: readingItemInstance, field: "resource")}</g:link></td>

            <td class="hidden-phone">${readingItemInstance?.resource?.topic}</td>

        </tr>
    </g:each>
    </tbody>
</table>

<div class="pagination pagination-centered">
    <g:paginate total="${readingItemInstanceTotal}" params="${params}"/>
</div>
<script type="text/javascript">
    var markAsReadUnreadUrl = "${createLink(controller: 'readingItem',action: 'markAsReadUnread')}";
    var toggleFavouriteUrl = "${createLink(controller: 'readingItem',action: 'toggleFavourite')}"
</script>
</body>
</html>
