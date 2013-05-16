package com.ig.linkSharing

import grails.plugin.spock.ControllerSpec
import grails.test.mixin.Mock
import grails.test.mixin.TestFor
import spock.lang.Specification

@TestFor(TopicController)
@Mock(Topic)
class TopicControllerSpec extends Specification {

    def "test show topic"() {
        setup:
        Topic topic = topicInstance
        topic.save()

        when:
        controller.showTopic(id)
        then:
        response.redirectedUrl == redirectAction
        where:
        topicInstance | redirectAction  | id
        createTopic() | "/topic/show/1" | 1
        createTopic() | "/topic/show/2" | 2
        createTopic() | "/topic/list"   | null

    }

    private Topic createTopic() {
        new Topic(name: "test", visibility: Visibility.PUBLIC, owner: new User(email: "komal@intelligrape.com", dateOfBirth: new Date(), password: "123456", firstName: "komal", lastName: "Jain", isMale: false)
        )
    }

}
