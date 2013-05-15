<%@ page import="com.ig.linkSharing.Topic" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'topic.label', default: 'Topic')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>

<div id="show-topic" class="content scaffold-show" role="main">
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

            <g:if test="${topicInstance?.name}">
                <td><strong>
                    <span id="name-label" class="control-label"><g:message code="topic.name.label"
                                                                           default="Name"/></span>
                </strong></td>
                <td>
                    <span class="controls" aria-labelledby="name-label"><g:fieldValue bean="${topicInstance}"
                                                                                      field="name"/></span>

                </td>
            </g:if>
        </tr>
        <tr>

            <g:if test="${topicInstance?.owner}">
                <td><strong>
                    <span id="owner-label" class="control-label"><g:message code="topic.owner.label"
                                                                            default="Owner"/></span>
                </strong></td>
                <td>
                    <span class="controls" aria-labelledby="owner-label">
                        <ls:isOwner topicInstance="${topicInstance}">
                            ${topicInstance?.owner?.encodeAsHTML()}
                        </ls:isOwner>
                    </span>

                </td>
            </g:if>

        </tr>
        <tr>
            <g:if test="${topicInstance?.resources}">
                <td><strong>
                    <span id="resources-label" class="control-label"><g:message code="topic.resources.label"
                                                                                default="Resources"/></span>
                </strong></td>
                <td>
                    <g:each in="${topicInstance.resources}" var="r">
                        <span class="controls" aria-labelledby="resources-label"><g:link controller="resource"
                                                                                         action="show"
                                                                                         id="${r.id}">${r?.encodeAsHTML()}</g:link></span><br/>
                    </g:each>

                </td>
            </g:if>
        </tr>
        <tr>
            <g:if test="${topicInstance?.subscriptions}">
                <td><strong>
                    <span id="subscriptions-label" class="control-label"><g:message code="topic.subscriptions.label"
                                                                                    default="Subscriptions"/></span>
                </strong></td>
                <td>
                    <g:each in="${topicInstance.subscriptions}" var="s">
                        <span class="controls" aria-labelledby="subscriptions-label">${s?.encodeAsHTML()}</span><br/>
                    </g:each>

                </td>
            </g:if>
        </tr>
        <tr>
            <g:if test="${topicInstance?.visibility}">
                <td><strong>
                    <span id="visibility-label" class="control-label"><g:message code="topic.visibility.label"
                                                                                 default="Visibility"/></span>
                </strong></td>
                <td>
                    <span class="controls" aria-labelledby="visibility-label"><g:fieldValue bean="${topicInstance}"
                                                                                            field="visibility"/></span>

                </td>
            </g:if>

        </tr>
    </table>
    <g:form class="form-actions">
        <fieldset class="buttons">
            <ls:isAdminOrTopicCreator topicInstance="${topicInstance}">
                <g:hiddenField name="id" value="${topicInstance?.id}"/>
                <g:link class="btn" action="edit" id="${topicInstance?.id}"><i class="icon-edit"></i><g:message
                        code="default.button.edit.label" default="Edit"/></g:link>
                <g:actionSubmit class="btn" action="delete"
                                value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                                onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
            </ls:isAdminOrTopicCreator>

            <div id="sendInvite${topicInstance.id}"
                 class="${ls.addClassForSubscribe(topicInstance: topicInstance)}">
                <a class="btn" onclick="sendInviteViaAjax(${topicInstance.id})"><i
                        class="icon-envelope"></i>Send Invite</a>
                <g:select name="email" from="${com.ig.linkSharing.User.getAll()*.email}"/>
                <g:link controller="resource" action="create"
                        params="[topicId: topicInstance.id]">Add Resource</g:link>
            </div>

            <div id="subscribeUnsubscribe${topicInstance.id}">
                <g:render template="subscribeUnsubscribe" model="[publicTopicInstance: topicInstance]"/>
            </div>
        </fieldset>
    </g:form>
</div>
<script type="text/javascript">
    var subscribeTopicUrl = "${createLink(controller: 'topic', action: 'subscribeTopic')}"
    var unSubscribeTopicUrl = "${createLink(controller: 'topic', action: 'unSubscribeTopic')}"
    var sendInviteUrl = "${createLink(controller: 'topic', action: 'sendInvite')}"
</script>
</body>
</html>
