package com.ig.linkSharing

class AdminController {

    def beforeInterceptor = {
        if (!SessionUtility.user.isAdmin()) {
            flash.message = "You are not allowed to access admin page..."
            redirect(controller: 'user')
            return false
        }
    }

    def index() {
        params.max = params.max ?: 5
        params.offset = params.offset ?: 0
        render(view: 'stats', model: [userInstanceList: User.list(params), userInstanceTotal: User.count, topicInstanceList: Topic.list(params), topicInstanceTotal: Topic.count])
    }

    def userDetail() {
        params.max = params.max ?: 5
        params.offset = params.offset ?: 0
        render(template: 'userDetail', model: [userInstanceList: User.list(params), userInstanceTotal: User.count])
    }

    def topicDetail() {
        params.max = params.max ?: 5
        params.offset = params.offset ?: 0
        render(template: 'topicDetail', model: [topicInstanceList: Topic.list(params), topicInstanceTotal: Topic.count])
    }

}
