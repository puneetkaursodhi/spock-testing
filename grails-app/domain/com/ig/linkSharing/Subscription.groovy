package com.ig.linkSharing

class Subscription {

    Seriousness seriousness
    Date dateCreated
    Date lastUpdated
    static belongsTo = [subscriber: User, topic: Topic]

    static constraints = {
        topic(unique: 'subscriber')
    }

    String toString() {
        return "${topic.name} subscribed by- ${subscriber}"
    }
}
