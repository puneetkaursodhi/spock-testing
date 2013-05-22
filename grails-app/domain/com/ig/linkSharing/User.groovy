package com.ig.linkSharing


class User {

    String firstName
    String lastName
    String email
    String password
    Date dateOfBirth
    Boolean isMale
    Date dateCreated
    Date lastUpdated
    static hasMany = [subscriptions: Subscription, topics: Topic, readingItems: ReadingItem]

    static constraints = {
        email(unique: true, nullable: false, blank: false, email: true)
        dateOfBirth(nullable: true)
        password(size: 5..10)
    }

    String toString() {
        return firstName + " " + lastName
    }

    Boolean isAdmin() {
        return email == 'komal@intelligrape.com'
    }
}
