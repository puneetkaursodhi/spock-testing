package com.ig.linkSharing

class LinkResource extends Resource {
    String url

    static constraints = {
        url(url: true, nullable: false, blank: false)
    }

    String toString() {
        return url
    }
}
