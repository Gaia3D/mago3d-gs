<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title><spring:message code='login.page.title' /></title>
	<link rel="shortcut icon" href="/images/favicon.ico">
	<link rel="stylesheet" href="/css/${lang}/font/font.css" />
	<link rel="stylesheet" href="/images/${lang}/icon/glyph/glyphicon.css" />
	<link rel="stylesheet" href="/externlib/normalize/normalize.min.css" />
	<link rel="stylesheet" href="/css/${lang}/style.css" />
	<script type="text/javascript" src="/externlib/jquery/jquery.js"></script>
	<script type="text/javascript" src="/js/${lang}/common.js"></script>
	<script type="text/javascript" src="/js/${lang}/message.js"></script>
	<script type="text/javascript" src="/js/gibberish-aes.js"></script>
	<script type="text/javascript" src="/js/aes.js"></script>
	<script type="text/javascript" src="/js/AESUtil.js"></script>
		<script type="text/javascript" src="/js/string-parse.js"></script>
</head>
<body class="sign">
	<div class="site-body">
		<div class="row">
			<div class="container">
				<div style="float: right;">
					<select id="userLocale" name="userLocale" onchange="changeLanguage(this.value);">
						<option value="ko">KOREA</option>
						<option value="en">ENGLISH</option>
						<option value="ja">JAPAN</option>
					</select>
				</div>
				<div class="row">
					<h1 style="padding-bottom:10px; font-size:38px; font-family:Lousianne; color:#573592;">mago3D</h1>
<c:if test="${loginForm.error_code ne null && loginForm.error_code ne ''}">
					<h6 style="padding-left: 10px; color: red;">* 
						<spring:message code="${loginForm.error_code}" />
					</h6>
</c:if>
				</div>
				<div class="panel row">
					<h2 class="sign-title"><span class="text-sub">Administrator</span><br /><span class="text-main">Login</span></h2>
					<div class="sign-inputs">
						<div class="sign-desc">Content Management System</div>
						<form:form id="loginForm" modelAttribute="loginForm" method="post" action="/login/process-login.do" onsubmit="return check();">
							<label for="user_id"><span class="icon-glyph glyph-users"></span></label>
							<input type="text" id="user_id" name="user_id" maxlength="32" title="<spring:message code='login.id.title' />" 
							placeholder="<spring:message code='login.id.placeholder' />" required="required" />
							<label for="password"><span class="icon-glyph glyph-lock"></span></label>
							<input type="password" id="password" name="password" maxlength="32" title="<spring:message code='login.password.title' />" 
							placeholder="<spring:message code='login.password.placeholder' />" required="required" />
							<input type="submit" value="Sign In" class="sign-submit" />
						</form:form>					
						<div class="sign-links">
							Forgot your password? &nbsp;<a href="/login/find-password.do">Click</a>
						</div>
					</div>
				</div>
			</div>
			<div class="" style="text-align: center; margin-top: 50px;">
				Mago3D ⓒ Gaia3d Corp. All Rights Reserved
			</div>
 		</div>
	</div>
	
<script type="text/javascript">
	$(document).ready(function () {
	});
	
	function check() {
		if ($("#user_id").val() == "") {
			alert(JS_MESSAGE["user.id.empty"]);
			$("#user_id").focus();
			return false;
		}
		
		if ($("#password").val() == "") {
			alert(JS_MESSAGE["password.empty"]);
			$("#password").focus();
			return false;
		}
		
		/* GibberishAES.size(128);	
		var encryptionPassword = GibberishAES.aesEncrypt($("#password").val(), "${TOKEN_AES_KEY}"); */
		//alert("encryptionPassword = " + encryptionPassword + ", password = " + encodeURIComponent(encryptionPassword));
		//$("#password").val(encodeURIComponent(encodeURIComponent(encryptionPassword)));
		//$("#password").val(encryptionPassword); */
		
		var val = $("#password").val();
		//var rkEncryptionKey = CryptoJS.enc.Base64.parse('${TOKEN_AES_KEY}');
		var rkEncryptionKey = getEncryptKey("${EncryptionKey}");
		var rkEncryptionIv = getEncryptIv("${EncryptionIv}");
		var utf8Stringified = CryptoJS.enc.Utf8.parse(val);
		var encrypted = CryptoJS.AES.encrypt(utf8Stringified.toString(), rkEncryptionKey, 
			{	mode: CryptoJS.mode.CBC, padding: CryptoJS.pad.Pkcs7, iv: rkEncryptionIv});
			 $("#password").val(encrypted.ciphertext.toString(CryptoJS.enc.Base64));
	}
	
	
	
	
	
	function changeLanguage(lang) {
		var updateFlag = true;
		if(updateFlag) {
			updateFlag = false;
			$.ajax({
				url: "/login/ajax-change-language.do?lang=" + lang,
				type: "GET",
				//data: info,
				cache: false,
				dataType: "json",
				success: function(msg){
					if(msg.result == "success") {
						//alert(JS_MESSAGE["success"]);
					} else {
						alert(JS_MESSAGE[msg.result]);
					}
					updateFlag = true;
				},
				error:function(request,status,error){
			        //alert(JS_MESSAGE["ajax.error.message"]);
			        console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			        updateFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}
	
	
	var enc64List, dec64List;
	 
	function initBase64() {
	    enc64List = new Array();
	    dec64List = new Array();
	    var i;
	    for (i = 0; i < 26; i++) {
	        enc64List[enc64List.length] = String.fromCharCode(65 + i);
	    }
	    for (i = 0; i < 26; i++) {
	        enc64List[enc64List.length] = String.fromCharCode(97 + i);
	    }
	    for (i = 0; i < 10; i++) {
	        enc64List[enc64List.length] = String.fromCharCode(48 + i);
	    }
	    enc64List[enc64List.length] = "+";
	    enc64List[enc64List.length] = "/";
	    for (i = 0; i < 128; i++) {
	        dec64List[dec64List.length] = -1;
	    }
	    for (i = 0; i < 64; i++) {
	        dec64List[enc64List[i].charCodeAt(0)] = i;
	    }
	}
	 
	function base64Encode(str) {
	    initBase64();
	    var c, d, e, end = 0;
	    var u, v, w, x;
	    var ptr = -1;
	    var input = str.split("");
	    var output = "";
	    while(end == 0) {
	        c = (typeof input[++ptr] != "undefined") ? input[ptr].charCodeAt(0) : 
	            ((end = 1) ? 0 : 0);
	        d = (typeof input[++ptr] != "undefined") ? input[ptr].charCodeAt(0) : 
	            ((end += 1) ? 0 : 0);
	        e = (typeof input[++ptr] != "undefined") ? input[ptr].charCodeAt(0) : 
	            ((end += 1) ? 0 : 0);
	        u = enc64List[c >> 2];
	        v = enc64List[(0x00000003 & c) << 4 | d >> 4];
	        w = enc64List[(0x0000000F & d) << 2 | e >> 6];
	        x = enc64List[e & 0x0000003F];
	        if (end >= 1) {x = "=";}
	        if (end == 2) {w = "=";}
	        if (end < 3) {output += u + v + w + x;}
	    }
	    var formattedOutput = "";
	    var lineLength = 76;
	    while (output.length > lineLength) {
	     formattedOutput += output.substring(0, lineLength) + "\n";
	     output = output.substring(lineLength);
	    }
	    formattedOutput += output;
	    return formattedOutput;
	}
	 
	function base64Decode(str) {
	    var c=0, d=0, e=0, f=0, i=0, n=0;
	    var input = str.split("");
	    var output = "";
	    var ptr = 0;
	    do {
	        f = input[ptr++].charCodeAt(0);
	        i = dec64List[f];
	        if ( f >= 0 && f < 128 && i != -1 ) {
	            if ( n % 4 == 0 ) {
	                c = i << 2;
	            } else if ( n % 4 == 1 ) {
	                c = c | ( i >> 4 );
	                d = ( i & 0x0000000F ) << 4;
	            } else if ( n % 4 == 2 ) {
	                d = d | ( i >> 2 );
	                e = ( i & 0x00000003 ) << 6;
	            } else {
	                e = e | i;
	            }
	            n++;
	            if ( n % 4 == 0 ) {
	                output += String.fromCharCode(c) + 
	                          String.fromCharCode(d) + 
	                          String.fromCharCode(e);
	            }
	        }
	    }
	    while (typeof input[ptr] != "undefined");
	    output += (n % 4 == 3) ? String.fromCharCode(c) + String.fromCharCode(d) : 
	              ((n % 4 == 2) ? String.fromCharCode(c) : "");
	    return output;
	}
</script>
</body>
</html>