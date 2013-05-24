package com.ig.linkSharing

import spock.lang.Specification


class TopicSpec extends Specification {

    def "test validation of topic"() {
        setup:
        mockForConstraintsTests(Topic)
        Topic topic = new Topic()
        expect:
        topic.validate()
    }

}
