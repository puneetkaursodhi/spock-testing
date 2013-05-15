<%@ page import="com.ig.linkSharing.ReadingItem" %>



            <div class="control-group">
                <label class="control-label hidden-phone" for="isFavourite">
                    <g:message code="readingItem.isFavourite.label" default="Is Favourite" />
                    
                </label>
                <div class="controls">
                    <g:checkBox name="isFavourite" value="${readingItemInstance?.isFavourite}" />
                </div>
            </div>

            <div class="control-group">
                <label class="control-label hidden-phone" for="isRead">
                    <g:message code="readingItem.isRead.label" default="Is Read" />
                    
                </label>
                <div class="controls">
                    <g:checkBox name="isRead" value="${readingItemInstance?.isRead}" />
                </div>
            </div>

            <div class="control-group">
                <label class="control-label hidden-phone" for="resource">
                    <g:message code="readingItem.resource.label" default="Resource" />
                    <span class="required-indicator">*</span>
                </label>
                <div class="controls">
                    <g:select id="resource" name="resource.id" from="${com.ig.linkSharing.Resource.list()}" optionKey="id" required="" value="${readingItemInstance?.resource?.id}" class="many-to-one"/>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label hidden-phone" for="user">
                    <g:message code="readingItem.user.label" default="User" />
                    <span class="required-indicator">*</span>
                </label>
                <div class="controls">
                    <g:select id="user" name="user.id" from="${com.ig.linkSharing.User.list()}" optionKey="id" required="" value="${readingItemInstance?.user?.id}" class="many-to-one"/>
                </div>
            </div>

