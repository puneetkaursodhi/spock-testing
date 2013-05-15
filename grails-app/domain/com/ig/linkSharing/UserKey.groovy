package com.ig.linkSharing

class UserKey {

    String userEmail
    String uniqueKey

    static constraints = {
        uniqueKey(unique: true)
        userEmail(nullable: false)
    }
}
