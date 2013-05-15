<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Reset Password</title>
</head>

<body>
<div>
    <legend>Reset Password</legend>

    <center>
        <g:form name="changePasswordForm" id="changePasswordForm" controller="login" action="changePassword"
                params="[uniqueKey: params.uniqueKey]" class="form-actions">
            <table>

                <ls:isLoggedIn>
                    <tr><td>Enter Current Password:</td><td><g:passwordField name="currentPassword" class="required"
                                                                             id="currentPassword"
                                                                             placeholder="CurrentPassword"/></td></tr>
                </ls:isLoggedIn>
                <tr><td>Enter New Password:</td><td><g:passwordField name="password" class="required"
                                                                     id="password" placeholder="NewPassword"/></td></tr>
                <tr><td>Confirm Password:</td><td><g:passwordField name="confirmPassword" class="required"
                                                                   placeholder="ConfirmPassword"/></td></tr>
                <tr><td></td><td><g:submitButton name="submit" value="Submit" class="btn"/></td></tr>
            </table>
        </g:form>
    </center>
</div>
<script type="text/javascript">
    var checkPassword = "${createLink(controller: 'user', action: 'checkPassword')}"
</script>
</body>
</html>