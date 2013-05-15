<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>DASHBOARD</title>
</head>

<body>

<g:if test="${flash.message}">
    <h5 style="color: red">${flash.message}</h5>
</g:if>
<br/>

<div class="row-fluid">

    <div class="span4">
        <g:if test="${subscribedTopics}">
            <table class="table table-striped table-bordered table-hover">
                <thead>
                <tr>
                    <th>Subscribed Topics</th>
                    <th>Seriousness</th>
                </tr>
                </thead>
                <tbody>
                <g:each in="${subscribedTopics}" status="i" var="subscribedTopic">
                    <tr>
                        <td>${subscribedTopic?.topic?.name}</td>
                        <td>${subscribedTopic?.seriousness}</td>
                    </tr>
                </g:each>
                </tbody>
            </table>
        </g:if>
    </div>

    <div class="span4">
        <g:if test="${mostSubscribedTopicList}">
            <table class="table table-striped table-bordered table-hover">
                <thead>
                <tr>
                    <th>Topic</th>
                    <th>Number Of Subscriptions</th>
                </tr>
                </thead>
                <tbody>
                <g:each in="${mostSubscribedTopicList}" status="i" var="topic">
                    <tr>
                        <td>${topic?.first()?.name}</td>
                        <td>${topic?.last()}</td>
                    </tr>
                </g:each>
                </tbody>
            </table>
        </g:if>
    </div>

    <div class="span4">
        <g:if test="${unreadItemList}">
            <table class="table table-striped table-bordered table-hover">
                <thead>
                <tr>
                    <th>Resource</th>
                    <th>IsFavourite</th>
                </tr>
                </thead>
                <tbody>
                <g:each in="${unreadItemList}" status="i" var="unreadItem">
                    <tr>
                        <td>${unreadItem?.resource}</td>
                        <td><i class="${readingItemInstance?.isFavourite ? 'icon-star' : 'icon-star-empty'}"></i>
                        </td>
                    </tr>
                </g:each>
                </tbody>
            </table>
        </g:if>
    </div>
</div>

</body>
</html>