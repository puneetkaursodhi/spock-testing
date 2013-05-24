package com.ig.linkSharing

import grails.test.mixin.Mock
import grails.test.mixin.TestFor
import spock.lang.Specification

@TestFor(TopicController)
@Mock([Topic, User])
class TopicControllerSpec extends Specification {

    def "test show topic"() {
        setup:
        Topic topic = topicInstance
        topic.save()

        when:
        controller.showTopic(id)
        then:
        response.redirectedUrl == redirectUrl
        where:
        topicInstance | redirectUrl     | id
        createTopic() | "/topic/show/1" | 1
//        createTopic() | "/topic/show/2" | 2
        createTopic() | "/topic/list" | null

    }

    def "test forward action"() {
        setup:
        Topic topic = topicInstance
        topic.save()

        when:
        controller.forwardAction(id)
        then:
        forwardedUrl == url
        forwardedParams.id == id.toString()
        response.contentAsString == outputString
        where:
        topicInstance | url           | id | outputString
        createTopic() | "/topic/show" | 1  | ""
        //        createTopic() | null          | 2  | "topic not found"

    }


    def "test json response"() {
        setup:
        Topic topic = topicInstance
        topic.save()

        when:
        controller.renderTopicAsJSON(id)
        then:
        response.json.status == responseStatus
        where:
        topicInstance | responseStatus | id
        createTopic() | "success"      | 1
        createTopic() | "failure"      | 2
    }


    def "test save topic with grails mocking"() {
        setup:
        def mockedSessionUtility = mockFor(SessionUtility)
        mockedSessionUtility.demand.static.getUser(1..2) {->
            return userObject
        }

        def mockedService = Mock(BootStrapService)
        controller.bootStrapService = mockedService

        when:
        populateValidParams(params, name, visibility)
        controller.save()
        then:
        response.redirectedUrl == redirectUrl
        view == redirectedView

        where:
        name    | visibility         | redirectUrl     | userObject   | redirectedView
        "hello" | Visibility.PRIVATE | "/topic/show/1" | createUser() | null
        ""      | Visibility.PRIVATE | null            | createUser() | "/topic/create"

    }

    def "test save topic with spock mocking"() {
        setup:
        //static method mocking is done with global parameter true
        GroovyMock(SessionUtility, global: true)
        SessionUtility.getUser() >> userObject

        def mockedService = Mock(BootStrapService)
        controller.bootStrapService = mockedService

        when:
        populateValidParams(params, name, visibility)
        controller.save()
        then:
        response.redirectedUrl == redirectUrl
        view == redirectedView

        where:
        name    | visibility         | redirectUrl     | userObject   | redirectedView
        "hello" | Visibility.PRIVATE | "/topic/show/1" | createUser() | null
        ""      | Visibility.PRIVATE | null            | createUser() | "/topic/create"

    }


    def populateValidParams(Map params, String name, Visibility visibility) {
        params.name = name
        params.visibility = visibility
    }

    private Topic createTopic() {
        new Topic(name: "test", visibility: Visibility.PUBLIC, owner: createUser())
    }

    private User createUser() {
        new User(email: "komal@intelligrape.com", dateOfBirth: new Date(), password: "123456", firstName: "komal", lastName: "Jain", isMale: false)
    }

    private getForwardedParams() {
        parseResponseForwardedUrl()[1]
    }

    private String getForwardedUrl() {
        parseResponseForwardedUrl()[0]
    }

    private parseResponseForwardedUrl() {
        // Pattern for forwardedUrl stored in response.
        def forwardedUrlPattern = ~/\/grails\/(.*)?\.dispatch\?*(.*)/

        // Match forwardedUrl in response with pattern.
        def matcher = response.forwardedUrl =~ forwardedUrlPattern

        def forwardUrl = null
        def forwardParameters = [:]

        if (matcher) {
            // Url is first group in pattern. We add '/' so it has the same format as redirectedUrl from response.
            forwardUrl = "/${matcher[0][1]}"

            // Parse parameters that are available in the forwardedUrl of the response.
            forwardParameters = parseResponseForwardedParams(matcher[0][2])
        }

        [forwardUrl, forwardParameters]
    }

    private parseResponseForwardedParams(final String queryString) {
        // Query string has format paramName=paramValue¶m2Name=param2Value. & is optional.
        def parameters = queryString.split('&')

        // Turn the paramName=paramValue parts into a Map.
        def forwardParameters = parameters.inject([:]) { result, parameter ->
            def (parameterName, parameterValue) = parameter.split('=')
            result[parameterName] = parameterValue
            result
        }
        forwardParameters
    }

}
