package com.ig.linkSharing

class Resource {
    User creator
    String title
    String summary
    Date dateCreated
    Date lastUpdated
    static belongsTo = [topic: Topic]
    static hasMany = [readingItem: ReadingItem]

    static constraints = {
        title(unique: 'topic')
        summary(maxSize: 1024)
    }

    static mapping = {
        summary type: "text"
        tablePerHierarchy false
    }

    String toString() {
        return title + " (" + topic + ") "
    }

    Boolean isAuthorizedUser() {
        User currentUser = SessionUtility.user
        return (currentUser == this.creator || currentUser.isAdmin())
    }
}
