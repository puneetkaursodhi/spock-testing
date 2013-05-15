package com.ig.linkSharing

class ApplicationTagLib {

    static namespace = "ls"

    def isAdminOrTopicCreator = { attr, body ->
        Topic topic = attr.topicInstance
        if (topic?.isAuthorizedUser()) {
            out << body()
        }
    }

    def isAdminOrResourceCreator = { attr, body ->
        Resource resource = attr.resourceInstance
        if (resource?.isAuthorizedUser()) {
            out << body()
        }
    }

    def isOwner = { attr, body ->
        if ((attr.topicInstance?.owner == SessionUtility.user) || (attr.resourceInstance?.creator == SessionUtility.user)) {
            out << 'You'
        } else {
            out << body()
        }
    }

    def isSubscribed = { attr, body ->
        Topic topicInstance = attr['topicInstance']
        if ((SessionUtility.user in topicInstance.subscriptions*.subscriber)) {
            out << body()
        }
    }

    def notSubscribed = { attr, body ->
        Topic topicInstance = attr['topicInstance']
        if (!(SessionUtility.user in topicInstance.subscriptions*.subscriber)) {
            out << body()
        }
    }

    def isLink = { attr, body ->
        Resource resource = Resource.get(attr.resourceId)
        if (resource.instanceOf(LinkResource)) {
            out << body()
        }
    }

    def isDocument = { attr, body ->
        Resource resource = Resource.get(attr.resourceId)
        if (resource.instanceOf(DocumentResource)) {
            out << body()
        }
    }

    def addClassForSubscribe = { attr ->
        Topic topicInstance = attr['topicInstance']
        String className = ''
        if (!(SessionUtility.user in topicInstance.subscriptions*.subscriber)) {
            className = 'hidden'
        }
        out << className
    }

    def isLoggedIn = { attr, body ->
        if (SessionUtility.user) {
            out << body()
        }
    }

    def notLoggedIn = { attr, body ->
        if (!SessionUtility.user) {
            out << body()
        }
    }

    def isAdmin = { attr, body ->
        if (SessionUtility.user.isAdmin()) {
            out << body()
        }
    }
}
