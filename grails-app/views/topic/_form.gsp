<%@ page import="com.ig.linkSharing.Topic" %>

<div class="fieldcontain ${hasErrors(bean: topicInstance, field: 'name', 'error')} required control-group">
    <label for="name" class="control-label">
        <g:message code="topic.name.label" default="Name"/>
        <span class="required-indicator">*</span>
    </label>

    <div class="controls">
        <g:textField name="name" required="" value="${topicInstance?.name}"/>
    </div>
</div>

<div class="fieldcontain ${hasErrors(bean: topicInstance, field: 'visibility', 'error')} required control-group">
    <label for="visibility" class="control-label">
        <g:message code="topic.visibility.label" default="Visibility"/>
        <span class="required-indicator">*</span>
    </label>

    <div class="controls">
        <g:select name="visibility" from="${com.ig.linkSharing.Visibility?.values()}"
                  keys="${com.ig.linkSharing.Visibility.values()*.name()}" required=""
                  value="${topicInstance?.visibility?.name()}"/>
    </div>
</div>
