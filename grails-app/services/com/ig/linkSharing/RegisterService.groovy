package com.ig.linkSharing


class RegisterService {

    def sendMailService

    boolean registerUser(RegisterCommand registerCommand) {
        if (registerCommand.validate()) {
            User user = new User()
            user.properties = registerCommand.properties
            user.dateOfBirth = new Date().parse("dd-MMM-yyy", registerCommand.dob)
            user.save(failOnError: true)
            println user.properties
            SessionUtility.userId = user.id
            sendMailService.sendWelcomeMail(user)
            return true
        } else {
            return false
        }
    }


}
