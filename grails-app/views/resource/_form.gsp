<%@ page import="com.ig.linkSharing.SessionUtility; com.ig.linkSharing.Resource" %>



<div class="fieldcontain ${hasErrors(bean: resourceInstance, field: 'title', 'error')} required control-group">
    <label for="title" class="control-label">
        <g:message code="resource.title.label" default="Title"/>
        <span class="required-indicator">*</span>
    </label>

    <div class="controls">
        <g:textField name="title" required="" value="${resourceInstance?.title}"/>
    </div>
</div>

<div class="fieldcontain ${hasErrors(bean: resourceInstance, field: 'summary', 'error')} required control-group">
    <label for="summary" class="control-label">
        <g:message code="resource.summary.label" default="Summary"/>
        <span class="required-indicator">*</span>
    </label>

    <div class="controls">
        <g:textArea name="summary" cols="40" rows="5" maxlength="1024" required=""
                    value="${resourceInstance?.summary}"/>
    </div>
</div>



