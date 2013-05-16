package com.ig.linkSharing

import spock.lang.Shared


class UserSpec extends spock.lang.Specification {
    @Shared
    User userObj = new User(email: "komal@intelligrape.com", dateOfBirth: new Date(), password: "123456", firstName: "komal", lastName: "Jain", isMale: false)

    def "test userValidation"() {
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

    def "test sharedExample"() {
        setup:
        userObj.save()
        User user = new User(email: email, dateOfBirth: dateOfBirth, password: password, firstName: firstName, lastName: lastName, isMale: isMale)

        when:
        user.save()


        then:
        User.count() == count

        // put 1st condition in last and test
        where:
        email                    | dateOfBirth | password | firstName | lastName | isMale | count
        "tanu@intelligrape.com"  | null        | "123456" | ""        | ""       | false  | 2
        "komal@intelligrape.com" | null        | "123456" | ""        | ""       | false  | 1
        "puneet"                 | null        | "123456" | ""        | ""       | false  | 1

    }
}
