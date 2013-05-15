package com.ig.linkSharing

import javax.servlet.http.HttpSession

class SessionUtility {

    static HttpSession getSession() {
        org.springframework.web.context.request.RequestContextHolder.requestAttributes.request.session
    }

    static User getUser() {
        User.get(session.userId)
    }

    static void setUserId(Long userId) {
        session.userId = userId
    }

    static void clearSession() {
        session.invalidate()
    }
}
