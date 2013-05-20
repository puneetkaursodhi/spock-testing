package com.ig.linkSharing

class BootStrapService {
    def sendMailService

    User createUser(int it) {
        User user = new User(firstName: "Tanu$it", lastName: "Siwag$it", email: "tanu+$it@intelligrape.com", password: "tanu$it", dateOfBirth: new Date('02/12/1989'), isMale: false)
        user.save()
        return user
    }


    Topic createTopicAndAddToUser(String topicName, Visibility visibility, User owner) {
        Topic topic = new Topic(name: topicName, visibility: visibility, owner: owner)
        topic.save()
        sendMailService.sendTopicCreationMailToAdmin(topic)
        return topic
    }

    void subscribeTopic(Topic topic, Seriousness seriousness, User subscriber) {
        Subscription subscription = new Subscription(topic: topic, seriousness: seriousness, subscriber: subscriber)
        saveSubscription(subscription)
    }

    void saveSubscription(Subscription subscription) {
        subscription.save()
    }

    LinkResource createLinkResource(User creator, String title, String summary, Topic topic, String url) {
        LinkResource linkResource = new LinkResource(creator: creator, title: title, summary: summary, topic: topic, url: url)
        linkResource.save()
        return linkResource
    }

    void createReadingItem(Resource resource, User user) {
        ReadingItem readingItem = new ReadingItem(resource: resource, isRead: false, isFavourite: false, user: user)
        readingItem.save(flush: true)
    }

}
