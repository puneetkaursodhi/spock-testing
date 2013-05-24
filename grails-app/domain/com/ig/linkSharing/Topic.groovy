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
        return name
    }

    Boolean isAuthorizedUser() {
        User currentUser = SessionUtility.user
        return (currentUser == this.owner || currentUser.isAdmin())
    }

    public static String fetchUserStatus(User user) {
        String status
        List<Topic> userTopics = Topic.findAllByOwner(user)
        int publicTopicCount = userTopics.count { it.visibility == Visibility.PUBLIC }
        if (publicTopicCount > 5) {
            status = "Serious User"
        } else {
            status = "Casual User"
        }
        return status
    }
}
