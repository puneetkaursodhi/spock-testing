package com.ig.linkSharing

import org.springframework.dao.DataIntegrityViolationException

class ResourceController {

    def bootStrapService

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def beforeInterceptor = [action: this.&auth, only: ['delete', 'edit', 'update']]

    def auth() {
        Resource resourceInstance = Resource.get(params.id.toLong())
        if (!(resourceInstance?.isAuthorizedUser())) {
            render "Unauthorized"
            return false
        }
    }

    List<User> subscribedUserList(Topic topic) {
        List<User> userList = Subscription.createCriteria().list {
            projections {
                property('subscriber')
            }
            eq('topic', topic)
        }
    }

    def index() {
//        redirect(action: "list", params: params)
    }

    def list(Long id) {
        Topic topic = Topic.get(id)
        params.max = params.max ?: 10
        params.offset = params.offset ?: 0
        List<Resource> resourceInstanceList = Resource.findAllByTopic(topic, params)
        Integer totalCount = Resource.countByTopic(topic)
        [resourceInstanceList: resourceInstanceList, resourceInstanceTotal: totalCount]
    }

    def create() {
        [resourceInstance: new Resource(params)]
    }

    def download(Long id) {
        DocumentResource documentResource = DocumentResource.get(id)
        byte[] data = documentResource.data
        response.setHeader("Content-disposition", "attachment; filename=" + documentResource.fileName)
        response.contentType = documentResource.contentType
        response.contentLength = documentResource.data.length
        response.outputStream << documentResource.data
        redirect(controller: 'user')
    }

    def createReadingItemOfResource(Resource resourceInstance) {
        Topic topic = resourceInstance.topic
        List<User> subscribedUserList = subscribedUserList(topic)
        subscribedUserList.each { subscribedUser ->
            bootStrapService.createReadingItem(resourceInstance, subscribedUser)
        }
    }

    // TODO: Refactor Code
    def save() {
        Topic topic = Topic.get(params.topicId.toLong())
        def resourceInstance
        if (params.resourceType == 'linkResource') {
            resourceInstance = new LinkResource(params)
        } else {
            FileCommand fileCommand = new FileCommand()
            fileCommand.multipartFile = params.multipartFile
            resourceInstance = new DocumentResource(params)
            if (!fileCommand?.multipartFile?.isEmpty()) {
                if (fileCommand.multipartFile.contentType.endsWith("pdf")) {
                    resourceInstance.fileName = fileCommand.multipartFile.originalFilename
                    resourceInstance.contentType = fileCommand.multipartFile.contentType
                    resourceInstance.data = fileCommand.multipartFile.bytes
                } else {
                    flash.message = "Upload pdf file Only"
                }
            } else {
                flash.message = "Please Select any File"
            }
        }
        resourceInstance.creator = SessionUtility.user
        resourceInstance.topic = topic
        if (!resourceInstance.save(flush: true)) {
            render(view: "create", model: [resourceInstance: resourceInstance])
            return
        }
        createReadingItemOfResource(resourceInstance)

        flash.message = message(code: 'default.created.message', args: [message(code: 'resource.label', default: 'Resource'), resourceInstance.id])
        redirect(action: "show", id: resourceInstance.id)
    }

    def show(Long id) {
        def resourceInstance = Resource.get(id)
        if (!resourceInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'resource.label', default: 'Resource'), id])
            redirect(action: "list")
            return
        }
        [resourceInstance: resourceInstance]
    }

    def edit(Long id) {
        def resourceInstance = Resource.get(id)
        if (!resourceInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'resource.label', default: 'Resource'), id])
            redirect(action: "list")
            return
        }

        [resourceInstance: resourceInstance]
    }

    def update(Long id, Long version) {
        def resourceInstance = Resource.get(id)
        if (!resourceInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'resource.label', default: 'Resource'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (resourceInstance.version > version) {
                resourceInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'resource.label', default: 'Resource')] as Object[],
                        "Another user has updated this Resource while you were editing")
                render(view: "edit", model: [resourceInstance: resourceInstance])
                return
            }
        }

        resourceInstance.properties = params
        if (resourceInstance.instanceOf(DocumentResource)) {
            FileCommand fileCommand = new FileCommand()
            fileCommand.multipartFile = params.multipartFile
            if (!fileCommand?.multipartFile?.isEmpty()) {
                if (fileCommand.multipartFile.contentType.endsWith("pdf")) {
                    resourceInstance.fileName = fileCommand.multipartFile.originalFilename
                    resourceInstance.contentType = fileCommand.multipartFile.contentType
                    resourceInstance.data = fileCommand.multipartFile.bytes
                } else {
                    flash.message = "Upload pdf file Only"
                    render(view: "edit", model: [resourceInstance: resourceInstance])
                    return
                }
            }
        }

        if (!resourceInstance.save(flush: true)) {
            render(view: "edit", model: [resourceInstance: resourceInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'resource.label', default: 'Resource'), resourceInstance.id])
        redirect(action: "show", id: resourceInstance.id)
    }

    def delete(Long id) {

        def resourceInstance = Resource.get(id)
        Long topicId = resourceInstance.topic.id
        if (!resourceInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'resource.label', default: 'Resource'), id])
            redirect(controller: 'topic', action: 'show', id: topicId)
            return
        }

        try {
            resourceInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'resource.label', default: 'Resource'), id])
            redirect(controller: 'topic', action: 'show', id: topicId)
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'resource.label', default: 'Resource'), id])
            redirect(action: "show", id: id)
        }
    }
}
