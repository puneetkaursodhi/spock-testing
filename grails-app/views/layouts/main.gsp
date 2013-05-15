<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <g:set var="appName" value="${grails.util.GrailsNameUtils.getNaturalName(g.meta(name: 'app.name'))}" scope="page"/>
    <title>${appName} | <g:layoutTitle/></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="http://www.imomentous.com/wp-content/themes/imomentous/images/favicon.ico"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'bootstrap.css')}"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'custom.css')}"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'application.css')}" type="text/css">
    <style type="text/css">
    body {
        padding-top: 60px;
        padding-bottom: 40px;
    }
    </style>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'bootstrap-responsive.css')}"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'prettify.css')}"/>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-1.8.0.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'bootstrap.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'application.js')}"></script>
    <g:javascript library="jquery" plugin="jquery"/>
    <jqui:resources/>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.validate.js')}"></script>
    <g:layoutHead/>
</head>

<body>
<div class="navbar navbar-inverse navbar-fixed-top">
    <div class="navbar-inner">
        <div class="container-fluid">
            <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </a>
            <a class="brand" href="${grailsApplication.config.grails.serverURL}">Link Sharing</a>

            <div class="nav-collapse collapse">
                <ls:isLoggedIn>
                    <ul class="nav">
                        <li class="controller"><g:link controller="user" action="index"><i
                                class="icon-home icon-white"></i> Home</g:link></li>
                        <li class="controller"><g:link controller="topic" action="list"><i
                                class="icon-list icon-white"></i> Topic List</g:link></li>
                        <li class="controller"><g:link controller="topic" action="create"><i
                                class="icon-plus-sign icon-white"></i> Add Topic</g:link></li>
                        <li class="controller"><g:link controller="readingItem" action="index"><i
                                class="icon-list icon-white"></i> ReadingItems</g:link></li>
                        <li class="controller"><g:link controller="user" action="setting"><i
                                class="icon-asterisk icon-white"></i> Settings</g:link></li>
                        <ls:isAdmin>
                            <li class="controller"><g:link controller="admin" action="index"><i
                                    class="icon-briefcase icon-white"></i>Show Stats</g:link></li>
                        </ls:isAdmin>
                    </ul>

                    <div class="navbar-text">
                        <g:link controller="login" action="logoutHandler"
                                class="visible-desktop btn btn-inverse pull-right">Logout</g:link>
                        <span class="pull-right"><i
                                class="icon-user icon-white"></i> ${com.ig.linkSharing.SessionUtility.user}&nbsp</span>
                        <g:link controller="login" action="logoutHandler"
                                class="hidden-desktop btn btn-block btn-inverse pull-right">Logout</g:link>
                    </div>
                </ls:isLoggedIn>
            </div>
        </div>
    </div>
</div>

<div class="container-fluid">
    <div class="row-fluid">
        <div class="span12">
            <g:if test="${flash.error}">
                <div class="alert alert-error">
                    <button type="button" class="close" data-dismiss="alert">×</button>
                    ${flash.error}
                </div>
            </g:if>
            <g:if test="${flash.success}">
                <div class="alert alert-success">
                    <button type="button" class="close" data-dismiss="alert">×</button>
                    ${flash.success}
                </div>
            </g:if>
            <g:layoutBody/>
        </div>
    </div>
    <footer>
        <div class="navbar navbar-fixed-bottom navbar-static">
            <p>&copy;&nbsp;<a href="http://www.intelligrape.com">Intelligrape Software Pvt. Ltd.</a></p>
        </div>
    </footer>
</div>

<div id="spinner" class="spinner" style="display:none;">
    <img id="img-spinner" src="${resource(dir: 'images', file: 'spinner.gif')}" alt="Loading"/>
</div>
<g:javascript library="application"/>
</body>
</html>
