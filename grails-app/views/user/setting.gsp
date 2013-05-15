<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}"/>
    <title>Settings</title>
</head>

<body>

<div class="container-fluid">
    <div class="row-fluid">
        <div class="span12">

            <div class="navbar">
                <div class="navbar-inner">
                    <a class="brand" href="#">Show User</a>
                </div>
            </div>

            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>

            <table class="table table-bordered">

                <g:if test="${userInstance?.email}">
                    <tr>

                        <td><strong><g:message code="user.email.label" default="Email"/></strong></td>
                        <td><g:fieldValue bean="${userInstance}" field="email"/></td>

                    </tr>
                </g:if>
                <g:if test="${userInstance?.firstName}">
                    <tr>

                        <td><strong><g:message code="user.firstName.label" default="First Name"/></strong></td>
                        <td><g:fieldValue bean="${userInstance}" field="firstName"/></td>

                    </tr>
                </g:if>
                <g:if test="${userInstance?.lastName}">
                    <tr>

                        <td><strong><g:message code="user.lastName.label" default="LastName"/></strong></td>
                        <td><g:fieldValue bean="${userInstance}" field="lastName"/></td>

                    </tr>
                </g:if>
                <g:if test="${userInstance?.dateOfBirth}">
                    <tr>

                        <td><strong><g:message code="user.dateOfBirth.label" default="Date Of Birth"/></strong></td>
                        <td><g:fieldValue bean="${userInstance}" field="dateOfBirth"/></td>

                    </tr>
                </g:if>
                <g:if test="${userInstance?.isMale}">
                    <tr>

                        <td><strong><g:message code="user.isMale.label" default="Is Male"/></strong></td>
                        <td><g:fieldValue bean="${userInstance}" field="isMale"/></td>

                    </tr>
                </g:if>
                <g:if test="${userInstance?.dateCreated}">
                    <tr>

                        <td><strong><g:message code="user.dateCreated.label" default="Date Created"/></strong></td>

                        <td><g:fieldValue bean="${userInstance}" field="dateCreated"/></td>

                    </tr>

                </g:if>
                <g:if test="${userInstance?.lastUpdated}">
                    <tr>

                        <td><strong><g:message code="user.lastUpdated.label" default="Last Updated"/></strong></td>

                        <td><g:fieldValue bean="${userInstance}" field="lastUpdated"/></td>

                    </tr>
                </g:if>
                <g:if test="${userInstance?.subscriptions}">
                    <tr>

                        <td><strong><g:message code="user.subscriptions.label" default="Subscriptions"/></strong></td>

                        <td><ul class="unstyled">
                            <g:each in="${userInstance?.subscriptions}" var="subscription">
                                <li><g:link controller="topic" action="show"
                                            id="${subscription?.topic?.id}">${subscription?.topic}</g:link></li>
                            </g:each>
                        </ul></td>

                    </tr>
                </g:if>
                <g:if test="${userInstance?.topics}">
                    <tr>

                        <td><strong><g:message code="user.topics.label" default="Topics"/></strong></td>

                        <td><ul class="unstyled">
                            <g:each in="${userInstance?.topics}" var="topic">

                                <li><g:link controller="topic" action="show"
                                            id="${topic?.id}">${topic?.name}</g:link></li>
                            </g:each>
                        </ul></td>

                    </tr>
                </g:if>
                <g:if test="${userInstance}">
                    <tr>
                        <td></td>
                        <td><g:link controller="user" action="resetPassword">Change Password</g:link></td>
                    </tr>
                </g:if>
            </table>
        </div>
    </div>
</div>

</body>
</html>