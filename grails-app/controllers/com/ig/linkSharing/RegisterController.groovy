package com.ig.linkSharing

class RegisterController {

    def registerService

    def showRegistrationForm() {
        render(view: 'register')
    }

    //TODO: Not Sending errors of validate, if any to view
    def registerUser(RegisterCommand registerCommand) {
        if (registerService.registerUser(registerCommand)) {
            redirect(controller: 'user', action: 'index')
        } else {
            render "not registered"
        }
    }

    def checkEmail(String email) {
        User.countByEmail(email) ? render(false) : render(true)
    }
}
