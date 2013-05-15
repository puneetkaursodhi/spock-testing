package com.ig.linkSharing

class DocumentResource extends Resource {
    String fileName
    String contentType
    byte[] data

    static constraints = {
        fileName(blank: false, nullable: false)
        contentType(blank: false, nullable: false)
        data(blank: false, nullable: true, maxSize: 5000000)
    }

    String toString() {
        return fileName
    }
}
