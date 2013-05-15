<table class="table table-bordered table-hover table-striped">
    <thead>
    <tr>
        <th>Topic</th>
        <th>Number of Subscriptions</th>
    </tr>
    </thead>
    <g:each in="${topicInstanceList}" status="i" var="topicInstance">
        <tr>
            <td>${topicInstance}</td>
            <td>${topicInstance.subscriptions.size()}</td>
        </tr>
    </g:each>
</table>

<div class="pagination pagination-centered">
    <util:remotePaginate controller='admin' action='topicDetail' total="${topicInstanceTotal}" update="topicDetailDiv"
                         max="5"/>
</div>