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
                            <form:form id="informationCheckForm">
                            <label for="maske_phone" style="font-size:18px;min-width:100px;"><spring:message code='mobile'/> : </label>
                            <input type="text" id="mask_phone" readonly style="width:230px;" value="${userinfo.mobile_phone}"/>
                            <div style="margin-left:122px;">
                            <input type="text" id="find_phone1" name="mobile_phone1" style="width:69px;padding-left:20px;" maxLength="3">
                            <span class="delimeter dash">-</span>
                            <input type="text" id="find_phone2" name="mobile_phone2" style="width:69px;padding-left:20px;" maxLength="4">
                            <span class="delimeter dash">-</span>
                            <input type="text" id="find_phone3" name="mobile_phone3" style="width:69px;padding-left:20px;"maxLength="4">
                            </div>
                            <label for="mask_email" style="font-size:18px;min-width:100px;"><spring:message code='email'/> : </label>
                            <input type="text" id="mask_email" readonly style="width:230px;margin-left:5px;"value="${userinfo.email}"/>
                            <input type="text" style="width:230px;margin-left:122px;" id="find_email" name="email" maxlength="32" title="<spring:message code='email' />"
                            placeholder="<spring:message code='email' />" required="required" />
                            <input type="hidden" name="user_id" value="${userinfo.user_id}"/>
                            <a href="/main/index.do" style="margin-right:30px;">
                                <spring:message code='login' />
                            </a>
                            <a href="#" onclick="check_userInformation(); return false;">
                                <spring:message code='login.information.confirm' />
                            </a>
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
function findInfoValidation(){
    var mobilephone_regExp1 = /^\d{3,3}$/;
    var mobile_phone1 = $("#find_phone1").val();
    if (mobile_phone1 != null && mobile_phone1 != "" && !mobilephone_regExp1.test(mobile_phone1)) {
        alert(JS_MESSAGE["user.group.mobiler.type"]);
        $("#find_phone1").focus();
        return false;
    }
    var mobilephone_regExp2 = /^\d{3,4}$/;
    var mobile_phone2 = $("#find_phone2").val();
    if (mobile_phone2 != null && mobile_phone2 != "" && !mobilephone_regExp2.test(mobile_phone2)) {
        alert(JS_MESSAGE["user.group.mobiler.type"]);
        $("#find_phone2").focus();
        return false;
    }
    var mobilephone_regExp3 = /^\d{4,4}$/;
    var mobile_phone3 = $("#find_phone3").val();
    if (mobile_phone3 != null && mobile_phone3 != "" && !mobilephone_regExp3.test(mobile_phone3)) {
        alert(JS_MESSAGE["user.group.mobiler.type"]);
        $("#find_phone3").focus();
        return false;
    }
    var email_regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
    if ($("#find_email").val() != null && $("#find_email").val() != "") {
        var emailSplit = $("#find_email").val().split("@");
        if (!email_regExp.test(emailSplit[0] + "@" + emailSplit[1])) {
            alert(JS_MESSAGE["user.group.email.type"]);
            return false;
        }
    }
}
function check_userInformation() {
      if (findInfoValidation() == false) {
          return false;
      }
      var info = $("#informationCheckForm").serialize();
      $.ajax({
          url: "/login/send-passwordEmail.do",
          type: "POST",
          data: info,
          dataType: "json",
          success: function(msg){
            alert(JS_MESSAGE[msg.result]);
          },
          error:function(request,status,error){
            alert(JS_MESSAGE["ajax.error.message"]);
          }
      });
}
</script>
</html>