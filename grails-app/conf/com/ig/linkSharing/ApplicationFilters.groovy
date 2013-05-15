package com.ig.linkSharing

class ApplicationFilters {

    def filters = {
        controlAccess(controller: 'login|register', action: 'index|loginHandler|showRegistrationForm|registerUser|checkEmail|recoverPassword|forgotPassword|resetPassword|changePassword', invert: true) {
            before = {
                if (!SessionUtility.user) {
                    flash.message = "You are not logged in..."
                    redirect(controller: 'login', action: 'index')
                    return false
                }
            }
        }

        blockAccess(controller: 'login|register', action: 'index|loginHandler|showRegistrationForm|registerUser|recoverPassword|resetPassword') {
            before = {
                if (SessionUtility.user) {
                    redirect(controller: 'user', action: 'index')
                }
            }
        }

        logParams(controller: '*', action: '*') {
            before = {
                println("params:" + params)
            }
        }

    }
}
