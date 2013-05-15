<table class="table table-bordered table-hover table-striped">
    <thead>
    <tr>
        <th>User</th>
        <th>Number of Topics Created</th>
        <th>Number of Topics Subscribed</th>
    </tr>
    </thead>
    <g:each in="${userInstanceList}" status="i" var="userInstance">
        <tr>
            <td>${userInstance}</td>
            <td>${userInstance.topics.size()}</td>
            <td>${userInstance.subscriptions.size()}</td>
        </tr>
    </g:each>
</table>

<div class="pagination pagination-centered">
    <util:remotePaginate controller='admin' action="userDetail" total="${userInstanceTotal}" update="userDetailDiv"
                         max="5"/>
</div>