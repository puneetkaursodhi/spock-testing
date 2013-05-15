package com.ig.linkSharing

class SendMailService {

    def asynchronousMailService
    def groovyPageRenderer
    def grailsLinkGenerator

    //TODO: Could create separate method for sending mail instead of repeating code
    def sendMail(String email, String subjct, String body) {
        asynchronousMailService.sendMail {
            to email
            subject subjct;
            html body;
        }
    }

    def sendPasswordRecoverMail(UserKey userKey) {
        Map model = [resetPasswordLink: grailsLinkGenerator.link(controller: 'login', action: 'resetPassword', absolute: true, params: [uniqueKey: userKey.uniqueKey])]
        String email = userKey.userEmail
        String subject = 'Recover Password'
        String body = groovyPageRenderer.render(template: '/login/forgotPasswordLink', model: model)
        sendMail(email, subject, body)
    }

    def sendWelcomeMail(User user) {
        String email = user.email
        String subject = 'Welcome Mail'
        String body = '<body>Hello ,<br/><u>Congratulations! Your account has been created!! </u></body>'
        sendMail(email, subject, body)
    }

    def sendInviteMail(String topicId, String email) {
        Topic topic = Topic.get(topicId.toLong())
        String subject = 'Invitation Mail'
        String body = '<body>Hello ,<br/>You are invited for subscription of topic <u> ' + topic + ' </u></body>'
        sendMail(email, subject, body)
    }
}
