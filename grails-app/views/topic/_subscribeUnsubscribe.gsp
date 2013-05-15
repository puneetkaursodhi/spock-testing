<ls:notSubscribed topicInstance="${publicTopicInstance}">
    <a onclick="subscribeTopicViaAjax(${publicTopicInstance.id})">Subscribe</a>
    <g:select name="seriousness${publicTopicInstance.id}" from="${com.ig.linkSharing.Seriousness?.values()}"/>
</ls:notSubscribed>
<ls:isSubscribed topicInstance="${publicTopicInstance}">
    <a onclick="unSubscribeTopicViaAjax(${publicTopicInstance.id})">UnSubscribe</a>
</ls:isSubscribed>