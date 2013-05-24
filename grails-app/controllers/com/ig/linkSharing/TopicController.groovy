package com.ig.linkSharing

import grails.converters.JSON
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
            redirect(controller: 'topic', action: 'list')
        }
    }

    def forwardAction(Long id) {
        Topic topic = Topic.get(id)
        if (topic) {
            forward(controller: 'topic', action: 'show', id: id)
        } else {
            render "topic not found"
        }
    }

    def renderTopicAsJSON(Long id) {
        Map responseMap = [status: 'success']
        Topic topic = Topic.get(id)
        if (topic) {
            responseMap.topic = topic
        } else {
            responseMap.status = "failure"
        }
        render responseMap as JSON
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
        if (!topicInstance.save(flush: true)) {
            render(view: "create", model: [topicInstance: topicInstance])
        } else {
            bootStrapService.subscribeTopic(topicInstance, Seriousness.SERIOUS, SessionUtility.user)
            flash.message = message(code: 'default.created.message', args: [message(code: 'topic.label', default: 'Topic'), topicInstance.id])
            redirect(action: "show", id: topicInstance.id)
        }

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

    def update(Long id, Long version) {
        def topicInstance = Topic.get(id)
        if (!topicInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'topic.label', default: 'Topic'), id])
            redirect(action: "list")
            return
        }
        topicInstance.properties = params

        if (!topicInstance.save(flush: true)) {
            render(view: "edit", model: [topicInstance: topicInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'topic.label', default: 'Topic'), topicInstance.id])
        redirect(action: "show", id: topicInstance.id)
    }

    def delete(Long id) {
        def topicInstance = Topic.get(id)
        if (!topicInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'topic.label', default: 'Topic'), id])
            redirect(action: "list")
            return
        }
        topicInstance.delete(flush: true)
        sendMailService.sendTopicDeletionMailToAdmin(id)
        flash.message = message(code: 'default.deleted.message', args: [message(code: 'topic.label', default: 'Topic'), id])
        redirect(action: "list")
    }
}
