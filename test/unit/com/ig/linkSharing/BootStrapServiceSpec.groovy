package com.ig.linkSharing


import grails.plugin.spock.UnitSpec
import grails.test.mixin.Mock
import grails.test.mixin.TestFor
import org.codehaus.groovy.grails.commons.GrailsApplication
import spock.lang.Specification

@TestFor(BootStrapService)
@Mock([Topic,Subscription])
class BootStrapServiceSpec extends Specification {

    def "test create topic and add to user method"() {
        setup:
        def mockedService = mockFor(SendMailService)
        mockedService.demand.sendTopicCreationMailToAdmin() { Topic topic ->
            println "inside mocked version"
        }
        service.sendMailService = mockedService.createMock()
        when:
        service.createTopicAndAddToUser(topicName, visibility, owner)
        then:
        Topic.count() == count
        where:
        topicName | visibility         | owner        | count
        "topic 1" | Visibility.PRIVATE | createUser() | 1
        "topic 1" | Visibility.PRIVATE | null         | 0

    }

    def "test subscribe topic"() {
        setup:

        when:
        service.subscribeTopic(topic, seriousness, subscriber)
        then:
        Subscription.count() == count
        where:
        topic         | seriousness        | subscriber   | count
        createTopic() | Seriousness.CASUAL | createUser() | 1

    }

    private User createUser() {
        new User(email: "komal@intelligrape.com", dateOfBirth: new Date(), password: "123456", firstName: "komal", lastName: "Jain", isMale: false)
    }

    private Topic createTopic() {
        new Topic(name: "test", visibility: Visibility.PUBLIC, owner: createUser())
    }
}
