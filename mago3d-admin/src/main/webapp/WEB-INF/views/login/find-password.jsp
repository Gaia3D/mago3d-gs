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
                </div>
                <div class="panel row">
                    <h2 class="sign-title"><span class="text-sub"><spring:message code='user.find.password'/></span></h2>
                    <div class="sign-inputs">
                        <div class="sign-desc"><spring:message code='login.information.input' /></div>
<%--                         <form:form id="informationCheckForm" modelAttribute="informationCheckForm" method="post" action="/login/send-passwordEmail.do" onsubmit="return testAlert();"> --%>
                            <form:form id="informationCheckForm" modelAttribute="informationCheckForm">
                            <label for="maske_phone"><span class="icon-glyph glyph-users-circle"></span></label>
                            <input type="text" id="mask_phone" readonly value="${userinfo.mobile_phone}"/>
                            <label for="find_phone"><span class="icon-glyph glyph-users"></span></label>
                            <div>
                            <input type="text" name="mobile_phone1" style="width:86px;margin-left:-67px;" maxLength="3">
                            <span class="delimeter dash">-</span>
                            <input type="text" name="mobile_phone2" style="width:104px;" maxLength="4">
                            <span class="delimeter dash">-</span>
                            <input type="text" name="mobile_phone3" style="width:104px;"maxLength="4">
                            </div>
                            <label for="mask_email"><span class="icon-glyph glyph-users-circle"></span></label>
                            <input type="text" id="mask_email" readonly value="${userinfo.email}"/>
                            <label for="find_email"><span class="icon-glyph glyph-users"></span></label>
                            <input type="text" id="find_email" name="email" maxlength="32" title="<spring:message code='email' />"
                            placeholder="<spring:message code='email' />" required="required" />
                            <input type="submit" value="Confirm" class="sign-submit" onclick="check_userInformation();" />
                            <input type="hidden" name="user_id" value="${userinfo.user_id}"/>
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
function check_userInformation() {
      var info = $("#informationCheckForm").serialize();
      $.ajax({
          url: "/login/send-passwordEmail.do",
          type: "POST",
          data: info,
          cache: false,
          dataType: "json",
          success: function(msg){
            alert(JS_MESSAGE[msg.result]);
          },
          error:function(request,status,error){
            alert(JS_MESSAGE[error]);
          }
      });

}
</script>
</html>