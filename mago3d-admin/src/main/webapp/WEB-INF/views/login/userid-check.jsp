<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width">
    <title><spring:message code='user.find.title' /></title>
    <link rel="shortcut icon" href="/images/favicon.ico">
    <link rel="stylesheet" href="/css/${lang}/font/font.css" />
    <link rel="stylesheet" href="/images/${lang}/icon/glyph/glyphicon.css" />
    <link rel="stylesheet" href="/externlib/normalize/normalize.min.css" />
    <link rel="stylesheet" href="/css/${lang}/style.css" />
    <script type="text/javascript" src="/externlib/jquery/jquery.js"></script>
    <script type="text/javascript" src="/js/${lang}/common.js"></script>
    <script type="text/javascript" src="/js/${lang}/message.js"></script>
    <script type="text/javascript" src="/js/gibberish-aes.js"></script>
</head>
<body class="sign">
    <div class="site-body">
        <div class="row">
            <div class="container">
                  <div class="row">
                    <h1 style="padding-bottom:10px; font-size:38px; font-family:Lousianne; color:#573592;"><a href="/main/index.do">mago3D</a></h1>
<c:if test="${userInfo.error_code ne null && userInfo.error_code ne ''}">
                    <h6 style="padding-left: 10px; color: red;">*
                        <spring:message code="${userInfo.error_code}" />
                    </h6>
</c:if>
                </div>
                <div class="panel row">
                    <h2 class="sign-title"><span class="text-sub"><spring:message code='user.find.password'/></span>
                    	<br /><a href="/login/login.do" style="font-size: 16px;">[ Login Page ]</a></h2>
                    <div class="sign-inputs">
                        <div class="sign-desc"><spring:message code='user.find.id' /></div>
                        <form:form id="idCheckForm" modelAttribute="userInfo" method="get" action="/login/ajax-userid-check.do" onsubmit="return userid_check();">
                            <label for="find_id" style="font-size:18px;"><spring:message code='id'/>: </label>
                            <input type="text" id="find_id" name="user_id" maxlength="32" style="width:250px;" title="<spring:message code='login.id.title' />"
                            placeholder="<spring:message code='login.id.placeholder' />" required="required" />
                            <input type="submit" value="Confirm" class="sign-submit" />
                        </form:form>
                    </div>
                </div>
            </div>
            <div class="" style="text-align: center; margin-top: 50px;">
                Mago3D ⓒ Gaia3d Corp. All Rights Reserved
            </div>
        </div>
    </div>
</body>
<script>
function userid_check() {
    if ($("#find_id").val() == "") {
        alert(JS_MESSAGE["user.id.empty"]);
        $("#find_id").focus();
        return false;
    }
}
</script>
</html>