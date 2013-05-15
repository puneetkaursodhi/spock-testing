<div id="sendInvite${topicInstance.id}">
    <ls:isSubscribed topicInstance="${topicInstance}">
        <a class="btn" onclick="sendInviteViaAjax(${topicInstance.id})"><i
                class="icon-envelope"></i>Send Invite</a>
        <g:select name="email" from="${com.ig.linkSharing.User.getAll()*.email}"/>
        <g:link controller="resource" action="create"
                params="[topicId: topicInstance.id]">Add Resource</g:link>
    </ls:isSubscribed>
</div>