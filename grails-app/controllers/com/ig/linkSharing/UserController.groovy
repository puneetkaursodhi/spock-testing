package com.ig.linkSharing

class UserController {


    def index() {
        List mostSubscribedTopics = mostSubscribedPublicTopicList()
        List<ReadingItem> unreadItemList = ReadingItem.findAllByUserAndIsRead(SessionUtility.user, false, [max: 10])
        List<Subscription> subscribedTopics = Subscription.findAllBySubscriber(SessionUtility.user)
        render(view: 'dashboard', model: [user: SessionUtility.user, subscribedTopics: subscribedTopics, unreadItemList: unreadItemList, mostSubscribedTopicList: mostSubscribedTopics])
    }



    def setting() {
        [userInstance: SessionUtility.user]
    }

    def resetPassword() {
        if (SessionUtility.user) {
            render(view: '/login/changePassword', model: [uniqueKey: params.uniqueKey])
        } else {
            render "*********"
        }
    }

    def checkPassword(String currentPassword) {
        render(SessionUtility.user.password == currentPassword)
    }

    def update() {
        User currentUser = SessionUtility.user
    }

    List mostSubscribedPublicTopicList() {
        def result = Subscription.createCriteria().list {
            projections {
                groupProperty('topic')
                count('topic', 'noOfSubscriptions')
            }
            'topic' {
                eq('visibility', Visibility.PUBLIC)
            }
            order('noOfSubscriptions', 'desc')
            maxResults 10
        }
        return result
    }

    List unreadItemList() {
        List unreadItemList = ReadingItem.createCriteria().list {
            eq('isRead', false)
            eq('user', SessionUtility.user)
            maxResults 10
        }
        return unreadItemList
    }

    List subscribedTopicList() {
        List<Topic> subscribedTopicList = Subscription.createCriteria().list {
            projections {
                property('topic')
            }
            eq('subscriber', SessionUtility.user)
        }
        return subscribedTopicList
    }

}
