package com.ig.linkSharing

import org.springframework.dao.DataIntegrityViolationException

class ReadingItemController {

    static allowedMethods = [save: "POST", delete: "POST"]

    def markAsReadUnread() {
        ReadingItem readingItem = ReadingItem.get(params.id.toLong())
        readingItem.isRead = !(readingItem.isRead)
        render(readingItem.isRead)
    }

    def toggleFavourite() {
        ReadingItem readingItem = ReadingItem.get(params.id.toLong())
        readingItem.isFavourite = !(readingItem.isFavourite)
        render(readingItem.isFavourite ? 'icon-star' : 'icon-star-empty')
    }

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = params.max ?: 10
        params.offset = params.offset ?: 0
        List<ReadingItem> readingItemInstanceList = ReadingItem.findAllByUser(SessionUtility.user, params)
        Integer readingItemInstanceTotal = ReadingItem.countByUser(SessionUtility.user)
        [readingItemInstanceList: readingItemInstanceList, readingItemInstanceTotal: readingItemInstanceTotal]
    }

    def create(Long id) {
        def readingItemInstance = id ? ReadingItem.get(id) : new ReadingItem(params)
        if (!readingItemInstance) {
            flash.error = message(code: 'default.not.found.message', args: [message(code: 'readingItem.label', default: 'ReadingItem'), id])
            redirect(action: "list")
        } else {
            [readingItemInstance: readingItemInstance]
        }
    }

    def save(Long id, Long version) {
        def readingItemInstance = id ? ReadingItem.get(id) : new ReadingItem(params)
        if (!readingItemInstance) {
            flash.error = message(code: 'default.not.found.message', args: [message(code: 'readingItem.label', default: 'ReadingItem'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (readingItemInstance.version > version) {
                readingItemInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'readingItem.label', default: 'ReadingItem')] as Object[],
                        "Another user has updated this ReadingItem while you were editing")
                render(view: "create", model: [readingItemInstance: readingItemInstance])
                return
            }
        }

        readingItemInstance.properties = params

        if (!readingItemInstance.save(flush: true)) {
            render(view: "create", model: [readingItemInstance: readingItemInstance])
            return
        }

        if (id) {
            flash.success = message(code: 'default.updated.message', args: [message(code: 'readingItem.label', default: 'ReadingItem'), readingItemInstance.id])
        } else {
            flash.success = message(code: 'default.created.message', args: [message(code: 'readingItem.label', default: 'ReadingItem'), readingItemInstance.id])
        }
        redirect(action: "show", id: readingItemInstance.id)
    }

    def show(Long id) {
        def readingItemInstance = ReadingItem.get(id)
        if (!readingItemInstance) {
            flash.error = message(code: 'default.not.found.message', args: [message(code: 'readingItem.label', default: 'ReadingItem'), id])
            redirect(action: "list")
            return
        }
        readingItemInstance.isRead = true
        [readingItemInstance: readingItemInstance]
    }

    def delete(Long id) {
        def readingItemInstance = ReadingItem.get(id)
        if (!readingItemInstance) {
            flash.error = message(code: 'default.not.found.message', args: [message(code: 'readingItem.label', default: 'ReadingItem'), id])
            redirect(action: "list")
            return
        }

        try {
            readingItemInstance.delete(flush: true)
            flash.success = message(code: 'default.deleted.message', args: [message(code: 'readingItem.label', default: 'ReadingItem'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.error = message(code: 'default.not.deleted.message', args: [message(code: 'readingItem.label', default: 'ReadingItem'), id])
            redirect(action: "show", id: id)
        }
    }
}
