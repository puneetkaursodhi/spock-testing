package com.ig.linkSharing

import org.springframework.dao.DataIntegrityViolationException

class TopicController {

    def bootStrapService
    def sendMailService

    def beforeInterceptor = [action: this.&auth, only: ['delete', 'edit', 'update']]

    def auth() {
        Topic topicInstance = Topic.get(params.id.toLong())
        if (!(topicInstance?.isAuthorizedUser())) {
            render "Unauthorized"
            return false
        }
    }

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def showTopic(Long id) {
        Topic topic = Topic.get(id)
        if (topic) {
            redirect(action: 'show', id: id)
        } else {
            redirect(controller: 'topic',action: 'list')
        }
    }

    def subscribeTopic() {
        Topic topicInstance = Topic.get(params.id.toLong())
        Seriousness seriousness = params.seriousness
        bootStrapService.subscribeTopic(topicInstance, seriousness, SessionUtility.user)
        topicInstance.resources.each { resource ->
            bootStrapService.createReadingItem(resource, SessionUtility.user)
        }
        render(template: 'subscribeUnsubscribe', model: ['publicTopicInstance': topicInstance])
    }

    def unSubscribeTopic() {
        Topic topicInstance = Topic.get(params.id.toLong())
        Subscription subscription = Subscription.findByTopicAndSubscriber(topicInstance, SessionUtility.user)
        topicInstance.resources.each { resource ->
            ReadingItem readingItem = ReadingItem.findByUserAndResource(SessionUtility.user, resource)
            readingItem.delete()
        }
        subscription.delete(flush: true)
        render(template: 'subscribeUnsubscribe', model: ['publicTopicInstance': topicInstance])
    }

    def sendInvite() {
        sendMailService.sendInviteMail(params.topicId, params.email)
    }

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = params.max ?: 10
        params.offset = params.offset ?: 0
        List<Topic> topicInstanceList = Topic.findAllByVisibilityOrOwner(Visibility.PUBLIC, SessionUtility.user, params)
        Integer totalCount = Topic.countByVisibility(Visibility.PUBLIC)
        [topicInstanceList: topicInstanceList, topicInstanceTotal: totalCount]
    }

    def create() {
        [topicInstance: new Topic(params)]
    }

    def save() {
        def topicInstance = new Topic(params)
        topicInstance.owner = SessionUtility.user
        topicInstance.save(flush: true)
        if (!topicInstance.save(flush: true)) {
            render(view: "create", model: [topicInstance: topicInstance])
            return
        }
        bootStrapService.subscribeTopic(topicInstance, Seriousness.SERIOUS, SessionUtility.user)
        flash.message = message(code: 'default.created.message', args: [message(code: 'topic.label', default: 'Topic'), topicInstance.id])
        redirect(action: "show", id: topicInstance.id)
    }

    def show(Long id) {
        def topicInstance = Topic.get(id)
        if (!topicInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'topic.label', default: 'Topic'), id])
            redirect(action: "list")
            return
        }

        [topicInstance: topicInstance]
    }

    def edit(Long id) {
        def topicInstance = Topic.get(id)
        if (!topicInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'topic.label', default: 'Topic'), id])
            redirect(action: "list")
            return
        }

        [topicInstance: topicInstance]
    }

    // TODO: Refactor Code according to your requirement instead of crud generated code
    def update(Long id, Long version) {
        def topicInstance = Topic.get(id)
        if (!topicInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'topic.label', default: 'Topic'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (topicInstance.version > version) {
                topicInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'topic.label', default: 'Topic')] as Object[],
                        "Another user has updated this Topic while you were editing")
                render(view: "edit", model: [topicInstance: topicInstance])
                return
            }
        }

        topicInstance.properties = params

        if (!topicInstance.save(flush: true)) {
            render(view: "edit", model: [topicInstance: topicInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'topic.label', default: 'Topic'), topicInstance.id])
        redirect(action: "show", id: topicInstance.id)
    }

    // TODO: Refactor Code according to your requirement instead of crud generated code
    def delete(Long id) {
        def topicInstance = Topic.get(id)
        if (!topicInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'topic.label', default: 'Topic'), id])
            redirect(action: "list")
            return
        }

        try {
            topicInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'topic.label', default: 'Topic'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'topic.label', default: 'Topic'), id])
            redirect(action: "show", id: id)
        }
    }
}
