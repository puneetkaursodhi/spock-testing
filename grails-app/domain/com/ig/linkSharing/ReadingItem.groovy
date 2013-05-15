package com.ig.linkSharing

class ReadingItem {
    Boolean isFavourite
    Boolean isRead
    Date dateCreated
    Date lastUpdated
    static belongsTo = [user: User, resource: Resource]
    static constraints = {
    }

    String toString() {
        return resource
    }
}
