<table class="table table-bordered table-hover table-striped">
    <thead>
    <tr>

        <g:sortableColumn property="name" title="${message(code: 'topic.name.label', default: 'Name')}"/>

        <th><g:message code="topic.owner.label" default="Owner"/></th>

        <g:sortableColumn property="visibility"
                          title="${message(code: 'topic.visibility.label', default: 'Visibility')}"/>
        <th>Subscription</th>
    </tr>
    </thead>
    <tbody>
    <g:each in="${topicInstanceList}" status="i" var="topicInstance">
        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

            <td><g:link action="show"
                        id="${topicInstance.id}">${fieldValue(bean: topicInstance, field: "name")}</g:link></td>

            <td>${fieldValue(bean: topicInstance, field: "owner")}</td>

            <td>${fieldValue(bean: topicInstance, field: "visibility")}</td>

            <td id="subscribeUnsubscribe${topicInstance.id}">
                <g:render template="subscribeUnsubscribe" model="[publicTopicInstance: topicInstance]"/>
            </td>
        </tr>
    </g:each>
    </tbody>
</table>

<div class="pagination pagination-centered">
    <g:paginate total="${topicInstanceTotal}" params="${params}"/>
</div>

<script type="text/javascript">
    var subscribeTopicUrl = "${createLink(controller: 'topic', action: 'subscribeTopic')}"
    var unSubscribeTopicUrl = "${createLink(controller: 'topic', action: 'unSubscribeTopic')}"
</script>

