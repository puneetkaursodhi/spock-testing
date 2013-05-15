<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main"/>
    <title></title>
</head>

<body>
<div style="text-align: center">
    <g:form name="recoverPasswordForm" id="forgotPasswordForm" controller="login" action="forgotPassword"
            class="form-actions">
        <g:if test="${flash.message}">
            <h5 style="color: red">${flash.message}</h5>
        </g:if>
        <g:else>
            <h3>Have you forgotten your password?</h3>
            Please enter your email address below to retrieve your password
        </g:else>
        <ul type="none">
            <li>Email:<g:field type="email" name="email" class="required" placeholder="Enter your email"/></li>
            <li><g:submitButton name="submit" value="Submit" class="btn"/></li>
        </ul>
    </g:form>
</div>
</body>
</html>