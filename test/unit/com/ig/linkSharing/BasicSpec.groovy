package com.ig.linkSharing

import spock.lang.Specification
import spock.lang.Unroll

class BasicSpec extends Specification {

    def "test maximum"() {
        expect:
        Math.max(a, b) == c

        where:
        a | b | c
        1 | 3 | 1
        7 | 4 | 4
        0 | 0 | 0

//        where:
//        a << [3, 7, 0]
//        b << [5, 0, 0]
//        c << [5, 7, 0]
    }

    @Unroll
    def "test maximum with unroll"() {
        expect:
        Math.max(a, b) == c

        where:
        a | b | c
        1 | 3 | 1
        7 | 4 | 4
        0 | 0 | 0
    }

    @Unroll
    def "maximum #a and #b is #c with unroll more intutive"() {
        expect:
        Math.max(a, b) == c

        where:
        a | b | c
        1 | 3 | 1
        7 | 4 | 4
        0 | 0 | 0
    }
}
