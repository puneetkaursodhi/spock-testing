package com.ig.linkSharing

class Topic {

    String name
    Visibility visibility
    static belongsTo = [owner: User]
    static hasMany = [subscriptions: Subscription, resources: Resource]

    static constraints = {
        name(unique: true, blank: false)
    }

    static searchable = true

    String toString() {
        return name + " (created by- " + owner + ")"
    }

    Boolean isAuthorizedUser() {
        User currentUser = SessionUtility.user
        return (currentUser == this.owner || currentUser.isAdmin())
    }
}
