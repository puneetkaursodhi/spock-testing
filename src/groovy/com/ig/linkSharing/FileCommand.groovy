package com.ig.linkSharing

import grails.validation.Validateable
import org.springframework.web.multipart.MultipartFile

@Validateable
class FileCommand {
    MultipartFile multipartFile
}
