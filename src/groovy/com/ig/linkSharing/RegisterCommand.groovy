package com.ig.linkSharing

import grails.validation.Validateable

@Validateable
class RegisterCommand {

    String firstName
    String lastName
    String email
    String password
    String confirmPassword
    String dob
    Boolean isMale

    static constraints = {
        email(nullable: false, blank: false, email: true)
        password(size: 5..10)
        confirmPassword(validator: { val, obj ->
            if (val?.equals(obj.password))
                return true
            else return false
        })
    }
}
