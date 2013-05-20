package com.ig.linkSharing

import grails.test.mixin.TestFor
import spock.lang.Shared
import spock.lang.Unroll

@TestFor(User)
class UserSpec extends spock.lang.Specification {
    @Shared
    User userObj

    def setup() {
        userObj = new User(email: "komal@intelligrape.com", dateOfBirth: new Date(), password: "123456", firstName: "komal", lastName: "Jain", isMale: false)
    }

    def "test user validation"() {
        setup:
        User user = new User(email: email, dateOfBirth: dateOfBirth, password: password, firstName: firstName, lastName: lastName, isMale: isMale)

        when:
        user.save()

        then:
        User.count() == count


        where:
        email                     | dateOfBirth | password | firstName | lastName | isMale | count
        "puneet@intelligrape.com" | null        | "123456" | ""        | ""       | false  | 1
        "puneet"                  | null        | "123456" | ""        | ""       | false  | 0

    }

    @Unroll
    def "test shared example"() {
        setup:
        userObj.save()
        User user = new User(email: email, dateOfBirth: dateOfBirth, password: password, firstName: firstName, lastName: lastName, isMale: isMale)

        when:
        user.save()


        then:
        User.count() == count

        where:
        email                    | dateOfBirth | password | firstName | lastName | isMale | count
        "komal@intelligrape.com" | null        | "123456" | ""        | ""       | false  | 1
        "puneet"                 | null        | "123456" | ""        | ""       | false  | 1
        "tanu@intelligrape.com"  | null        | "123456" | ""        | ""       | false  | 2


    }
}
