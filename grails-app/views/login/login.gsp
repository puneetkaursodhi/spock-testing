<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main"/>
    <title></title>
</head>

<body>
<div class="row-fluid">

    <div class="span6">
        <g:form name="loginForm" id="loginForm" controller="login" action="loginHandler" class="form-horizontal">

            <legend>Sign In Here</legend>

            <g:if test="${flash.message}">
                <h5 style="color: red">${flash.message}</h5>
            </g:if>

            <div class="control-group">
                <div class="control-label hidden-phone">Email</div>

                <div class="controls">
                    <g:field type="email" name="userName" class="required"
                             placeholder="Email"/>
                </div>
            </div>

            <div class="control-group">
                <div class="control-label hidden-phone">Password</div>

                <div class="controls">
                    <g:passwordField name="userPassword" class="required" placeholder="Password"/>
                </div>
            </div>

            <div class="control-group">
                <div class="controls">
                    <g:submitButton name="login" value="Login" class="btn btn-primary"/>
                </div>
            </div>

            <div class="control-group">
                <div class="controls">
                    <g:link controller="login" action="recoverPassword">forgot password??</g:link><br/>
                </div>
            </div>
        </g:form>

    </div>

    <div class="span6">
        <legend>Not a registered user? Register Now</legend>
        <g:form name="registrationForm" controller="register" action="registerUser" class="form-horizontal">
            <div class="control-group">
                <div class="control-label hidden-phone">FirstName</div>

                <div class="controls"><g:textField name="firstName" class="required" placeholder="FirstName"/></div>
            </div>

            <div class="control-group">
                <div class="control-label hidden-phone">LastName</div>

                <div class="controls"><g:textField name="lastName" class="required" placeholder="LastName"/></div>
            </div>

            <div class="control-group">
                <div class="control-label hidden-phone">Email</div>

                <div class="controls"><g:field name="email" type="email" class="required" placeholder="Email"/></div>
            </div>

            <div class="control-group">
                <div class="control-label hidden-phone">Password</div>

                <div class="controls"><g:passwordField name="password" class="required" id="password"
                                                       placeholder="Password"/></div>
            </div>

            <div class="control-group">
                <div class="control-label hidden-phone">Confirm Password</div>

                <div class="controls"><g:passwordField name="confirmPassword" class="required"
                                                       placeholder="Confirm Password"/></div>
            </div>

            <div class="control-group">
                <div class="control-label">isMale</div>

                <div class="controls"><g:checkBox name="isMale"/></div>
            </div>

            <div class="control-group hidden-phone">
                <div class="control-label">DateOfBirth</div>

                <div class="controls"><g:textField name="dob" id="datePicker" readonly="true"
                                                   class="required" placeholder="DateOfBirth"/></div>
            </div>

            <div class="control-group">
                <div class="controls"><g:submitButton name="register" value="Register" class="btn btn-primary"/></div>
            </div>
        </g:form>
    </div>

</div>
<script type="text/javascript">
    var checkEmailUrl = "${createLink(controller: 'register', action: 'checkEmail')}"
</script>
</body>
</html>