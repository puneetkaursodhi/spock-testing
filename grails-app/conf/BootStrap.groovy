import com.ig.linkSharing.*

class BootStrap {

    def bootStrapService

    def init = { servletContext ->
        if (!User.count) {
            10.times { it ->
                User user = bootStrapService.createUser(it)
                Topic topic = bootStrapService.createTopicAndAddToUser("topic$it", Visibility.PUBLIC, user)
                bootStrapService.subscribeTopic(topic, Seriousness.SERIOUS, user)
                Resource resource = bootStrapService.createLinkResource(user, "title$it", "summary$it", topic, "http://www.google.com")
                bootStrapService.createReadingItem(resource, user)
            }
        }
    }
    def destroy = {
    }
}
