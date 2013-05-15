<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main"/>
    <title></title>
</head>

<body>
<div>
    <center>
        <g:form name="registrationForm" controller="register" action="registerUser" class="form-actions">
            <table>
                <tr><td>FirstName:</td><td><g:textField name="firstName" class="required"/></td></tr>
                <tr><td>LastName:</td><td><g:textField name="lastName" class="required"/></td></tr>
                <tr><td>E-mail:</td><td><g:field name="email" type="email" class="required"/></td></tr>
                <tr><td>Password:</td><td><g:passwordField name="password" class="required" id="password"/></td></tr>
                <tr><td>Confirm Password:</td><td><g:passwordField name="confirmPassword" class="required"/></td></tr>
                <tr><td>isMale:</td><td><g:checkBox name="isMale"/></td></tr>
                <tr><td>DateOfBirth</td><td><g:textField name="dob" id="datePicker" readonly="true"
                                                         class="required"/></td></tr>
                <tr><td></td><td><g:submitButton name="register" value="Register" class="btn btn-info"/></td></tr>
            </table>
        </g:form>
    </center>
</div>
<script type="text/javascript">
    var checkEmailUrl = "${createLink(controller: 'register', action: 'checkEmail')}"
</script>
</body>
</html>