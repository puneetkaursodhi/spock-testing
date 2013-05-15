package com.ig.linkSharing

class LoginController {

    def sendMailService

    def index() {
        render(view: 'login')
    }

    def loginHandler() {
        User user = User.findByEmailAndPassword(params.userName, params.userPassword)
        if (user) {
            SessionUtility.userId = user.id
            redirect(controller: 'user', action: 'index')
        } else {
            flash.message = "Incorrect UserName or Password..."
            redirect(controller: 'login', action: 'index')
        }
    }

    def logoutHandler() {
        SessionUtility.clearSession()
        render(view: 'login')
    }

    def recoverPassword() {
        render(view: 'recoverPassword')
    }


    def forgotPassword() {
        User user = User.findByEmail(params.email)
        if (user) {
            UserKey userKey = UserKey.findByUserEmail(user.email)
            if (!userKey) {
                String uniqueKey = UUID.randomUUID().toString()
                userKey = new UserKey(userEmail: user.email, uniqueKey: uniqueKey)
                userKey.save(flush: true)
            }
            sendMailService.sendPasswordRecoverMail(userKey)
            flash.message = "An email has been sent to you. Please follow the instructions in the email."
            redirect(controller: 'login', action: 'index')

        } else {
            flash.message = "You are not registered user Or Incorrect Email"
            redirect(controller: 'login', action: 'recoverPassword')
        }
    }

    def resetPassword() {
        UserKey userKey = UserKey.findByUniqueKey(params.uniqueKey)
        if (userKey) {
            render(view: 'changePassword', model: [uniqueKey: params.uniqueKey])
        } else {
            render "Link expired"
        }
    }

    def changePassword() {
        User user
        if (SessionUtility.user) {
            user = SessionUtility.user
            user.password = params.password
            user.save()
        } else {
            UserKey userKey = UserKey.findByUniqueKey(params.uniqueKey)
            user = User.findByEmail(userKey.userEmail)
            user.password = params.password
            user.save()
            userKey.delete(flush: true)
            SessionUtility.userId = user.id
        }
        flash.message = "Password has been changed successfully!"
        redirect(controller: 'user', action: 'index')
    }
}
