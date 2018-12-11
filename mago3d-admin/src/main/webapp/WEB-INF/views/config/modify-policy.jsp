<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>${sessionSiteName }</title>
	<link rel="stylesheet" href="/css/${lang}/font/font.css" />
	<link rel="stylesheet" href="/images/${lang}/icon/glyph/glyphicon.css" />
	<link rel="stylesheet" href="/externlib/normalize/normalize.min.css" />
	<link rel="stylesheet" href="/externlib/jquery-ui/jquery-ui.css" />
	<link rel="stylesheet" href="/externlib/color-picker/palette-color-picker.css" />
	<link rel="stylesheet" href="/css/${lang}/style.css" />
	
	<script type="text/javascript" src="/externlib/jquery/jquery.js"></script>
	<script type="text/javascript" src="/externlib/jquery-ui/jquery-ui.js"></script>
	<script type="text/javascript" src="/externlib/jqplot/jquery.jqplot.min.js"></script>
	<script type="text/javascript" src="/externlib/color-picker/palette-color-picker.js"></script>
	
	<script type="text/javascript" src="/js/${lang}/common.js"></script>
	<script type="text/javascript" src="/js/${lang}/message.js"></script>
	<script type="text/javascript" src="/js/navigation.js"></script>
</head>
<body>
	<%@ include file="/WEB-INF/views/layouts/header.jsp" %>
	<%@ include file="/WEB-INF/views/layouts/menu.jsp" %>
	<div class="site-body">
		<div class="container">
			<div class="site-content">
				<%@ include file="/WEB-INF/views/layouts/sub_menu.jsp" %>
				<div class="page-area">
					<%@ include file="/WEB-INF/views/layouts/page_header.jsp" %>
					<div class="page-content">
						<div class="content-desc u-pull-right"><span class="icon-glyph glyph-emark-dot color-warning"></span><spring:message code='check'/></div>
						<div class="tabs">
							<ul>
								<li><a href="#user_tab"><spring:message code='user.group.user'/></a></li>
								<li><a href="#password_tab"><spring:message code='password'/></a></li>
								<li><a href="#geo_tab"><spring:message code='spatial.information'/></a></li>
								<!-- <li><a href="#geoserver_tab">GeoServer</a></li> -->
								<li><a href="#geocallback_tab">CallBack</a></li>
								<%-- <li><a href="#security_tab"><spring:message code='security'/></a></li> --%>
								<li><a href="#content_tab"><spring:message code='content'/></a></li>
								<li><a href="#userupload_tab">사용자 업로딩 파일</a></li>
								<%-- <li><a href="#backoffice_tab"><spring:message code='back.office.information'/></a></li>
								<li><a href="#site_tab"><spring:message code='site.information'/></a></li>
								<li><a href="#solution_tab"><spring:message code='product.information'/></a></li> --%>
							</ul>
							
							<%@ include file="/WEB-INF/views/config/modify-policy-user.jsp" %>
							<%@ include file="/WEB-INF/views/config/modify-policy-password.jsp" %>
							<%@ include file="/WEB-INF/views/config/modify-policy-geo.jsp" %>
							<%-- <%@ include file="/WEB-INF/views/config/modify-policy-geoserver.jsp" %> --%>
							<%@ include file="/WEB-INF/views/config/modify-policy-geocallback.jsp" %>
							<%-- <%@ include file="/WEB-INF/views/config/modify-policy-security.jsp" %> --%>
							<%@ include file="/WEB-INF/views/config/modify-policy-content.jsp" %>
							<%@ include file="/WEB-INF/views/config/modify-policy-userupload.jsp" %>
							<%-- <%@ include file="/WEB-INF/views/config/modify-policy-backoffice.jsp" %>
							<%@ include file="/WEB-INF/views/config/modify-policy-site.jsp" %>
							<%@ include file="/WEB-INF/views/config/modify-policy-solution.jsp" %> --%>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>
<script type="text/javascript">
	$(document).ready(function() {
		$( ".tabs" ).tabs();
		initGeo();
		
		$("#user_delete_type").val("${policyUser.user_delete_type}");
		
		$("#security_session_timeout_yn").val("${policySecurity.security_session_timeout_yn}");
		$("#security_session_hijacking").val("${policySecurity.security_session_hijacking}");
		$("#security_sso").val("${policySecurity.security_sso}");
		$("#security_log_save_type").val("${policySecurity.security_log_save_type}");
		$("#security_log_save_term").val("${policySecurity.security_log_save_term}");
		$("#security_dynamic_block_yn").val("${policySecurity.security_dynamic_block_yn}");
		
		$("#content_statistics_interval").val("${policySecurity.content_statistics_interval}");

		$("[name=security_api_result_secure_yn]").filter("[value='${policySecurity.security_api_result_secure_yn}']").prop("checked",true);
		$("[name=security_masking_yn]").filter("[value='${policySecurity.security_masking_yn}']").prop("checked",true);
		$("[name=user_duplication_login_yn]").filter("[value='${policyUser.user_duplication_login_yn}']").prop("checked",true);
		
		/* $("#backoffice_user_db_driver").val("${policyBackoffice.backoffice_user_db_driver}"); */
		
		$( ".select" ).selectmenu();
		
	});

	// 사용자 정책 저장
	var updateUserFlag = true;
	function updatePolicyUser() {
		if(updateUserFlag) {
			if($("#user_id_min_length").val() == "") {
				alert(JS_MESSAGE["policy.user.id.min.length"]);
				$("#user_id_min_length").focus();
				return;
			}
			if(!isNumber($("#user_id_min_length").val())) {
				$("#user_id_min_length").focus();
				return;
			}
			if(parseInt($("#user_id_min_length").val()) < 4) {
				alert(JS_MESSAGE["policy.user.id.min.length.rule"]);
				$("#user_id_min_length").focus();
				return;
			}
			if($("#user_fail_login_count").val() == "") {
				alert(JS_MESSAGE["policy.user.login.fail"]);
				$("#user_fail_login_count").focus();
				return;
			}
			if(!isNumber($("#user_fail_login_count").val())) {
				$("#user_fail_login_count").focus();
				return;
			}
			/* if($("#user_fail_lock_release").val() == "") {
				alert("로그인 실패 잠금 해제 기간을 입력하여 주십시오.");
				$("#user_fail_lock_release").focus();
				return;
			}
			if(!isNumber($("#user_fail_lock_release").val())) {
				$("#user_fail_lock_release").focus();
				return;
			} */
			if($("#user_last_login_lock").val() == "") {
				alert(JS_MESSAGE["policy.user.lockout.period"]);
				$("#user_last_login_lock").focus();
				return;
			}
			if(!isNumber($("#user_last_login_lock").val())) {
				$("#user_last_login_lock").focus();
				return;
			}
			
			updateUserFlag = false;
			var info = $("#policyUser").serialize();
			$.ajax({
				url: "/config/ajax-update-policy-user.do",
				type: "POST",
				data: info,
				cache: false,
				dataType: "json",
				success: function(msg){
					if(msg.result == "success") {
						alert(JS_MESSAGE["policy.user.update"]);
					} else {
						alert(JS_MESSAGE[msg.result]);
					}
					updateUserFlag = true;
				},
				error:function(request,status,error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        updateUserFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}
	
	// 패스워드 정책 저장
	var updatePasswordFlag = true;
	function updatePolicyPassword() {
		if(updatePasswordFlag) {
			if($("#password_change_term").val() == "") {
				alert(JS_MESSAGE["policy.password.period"]);
				$("#password_change_term").focus();
				return;
			}
			if(!isNumber($("#password_change_term").val())) {
				$("#password_change_term").focus();
				return;
			}
			if($("#password_min_length").val() == "") {
				alert(JS_MESSAGE["policy.password.min.length"]);
				$("#password_min_length").focus();
				return;
			}
			if(!isNumber($("#password_min_length").val())) {
				$("#password_min_length").focus();
				return;
			}
			
			if(parseInt($("#password_min_length").val()) < 8) {
				alert(JS_MESSAGE["policy.password.min.length.invalid"]);
				$("#password_min_length").focus();
				return;			
			}
			if($("#password_max_length").val() == "") {
				alert(JS_MESSAGE["policy.password.max.length"]);
				$("#password_max_length").focus();
				return;
			}
			if(!isNumber($("#password_max_length").val())) {
				$("#password_max_length").focus();
				return;
			}
			if($("#password_eng_upper_count").val() == "") {
				alert(JS_MESSAGE["policy.password.uppercase"]);
				$("#password_eng_upper_count").focus();
				return;
			}
			if(!isNumber($("#password_eng_upper_count").val())) {
				$("#password_eng_upper_count").focus();
				return;
			}
			if($("#password_eng_lower_count").val() == "") {
				alert(JS_MESSAGE["policy.password.lowercase"]);
				$("#password_eng_lower_count").focus();
				return;
			}
			if(!isNumber($("#password_eng_lower_count").val())) {
				$("#password_eng_lower_count").focus();
				return;
			}
			if($("#password_number_count").val() == "") {
				alert(JS_MESSAGE["policy.password.number"]);
				$("#password_number_count").focus();
				return;
			}
			if(!isNumber($("#password_number_count").val())) {
				$("#password_number_count").focus();
				return;
			}
			if($("#password_special_char_count").val() == "") {
				alert(JS_MESSAGE["policy.password.special.letters"]);
				$("#password_special_char_count").focus();
				return;
			}
			if(!isNumber($("#password_special_char_count").val())) {
				$("#password_special_char_count").focus();
				return;
			}
			if($("#password_continuous_char_count").val() == "") {
				alert(JS_MESSAGE["policy.password.serial.limit"]);
				$("#password_continuous_char_count").focus();
				return;
			}
			if(!isNumber($("#password_continuous_char_count").val())) {
				$("#password_continuous_char_count").focus();
				return;
			}
/* 			if($("#password_create_char").val() == "") {
				alert("초기 패스워드 생성 문자열을 입력하여 주십시오.");
				$("#password_create_char").focus();
				return;
			} */
			
			updatePasswordFlag = false;
			var info = $("#policyPassword").serialize() + "&policy_id=" + $("#policy_id").val();
			$.ajax({
				url: "/config/ajax-update-policy-password.do",
				type: "POST",
				data: info,
				cache: false,
				dataType: "json",
				success: function(msg){
					if(msg.result == "success") {
						alert(JS_MESSAGE["policy.password.update"]);
					} else {
						alert(JS_MESSAGE[msg.result]);
					}
					updatePasswordFlag = true;
				},
				error:function(request,status,error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        updatePasswordFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}
	
	// 공간 정보
	var updatePolicyGeoFlag = true;
	function updatePolicyGeo() {
		if(updatePolicyGeoFlag) {
			// validation 나중에
			updatePolicyGeoFlag = false;
			var info = {};
			info["policy_id"] = $("#policy_id").val();
			$.each( $("#policyGeo").serializeArray(), function(i, obj) { 
				if(obj.name === "geo_ambient_reflection_coef") {
					info[obj.name] = $("#geo_ambient_reflection_coef").val();
				} else if(obj.name === "geo_diffuse_reflection_coef") {
					info[obj.name] = $("#geo_diffuse_reflection_coef").val();
				} else if(obj.name === "geo_specular_reflection_coef") {
					info[obj.name] = $("#geo_specular_reflection_coef").val();
				} else {
					info[obj.name] = obj.value;
				}
			});
			$.ajax({
				url: "/config/ajax-update-policy-geo.do",
				type: "POST",
				data: info,
				cache: false,
				dataType: "json",
				success: function(msg){
					if(msg.result == "success") {
						alert(JS_MESSAGE["policy.geo.update"]);
					} else {
						alert(JS_MESSAGE[msg.result]);
					}
					updatePolicyGeoFlag = true;
				},
				error:function(request,status,error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        updatePolicyGeoFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}
	
	// geo 정보 설정
	function initGeo() {
		var ambient = $( "#geo_ambient_reflection_coef_view" );
		$( "#geo_ambient_reflection_coef" ).slider({
			range: "max",
			min: 0, // min value
			max: 1, // max value
			step: 0.01,
			value: '${policy.geo_ambient_reflection_coef}', // default value of slider
			create: function() {
				ambient.text( $( this ).slider( "value" ) );
			},
			slide: function( event, ui ) {
				ambient.text( ui.value);
				$("#geo_ambient_reflection_coef" ).val(ui.value);
			}
		});
		var diffuse = $( "#geo_diffuse_reflection_coef_view" );
		$( "#geo_diffuse_reflection_coef" ).slider({
			range: "max",
			min: 0, // min value
			max: 1, // max value
			step: 0.01,
			value: '${policy.geo_diffuse_reflection_coef}', // default value of slider
			create: function() {
				diffuse.text( $( this ).slider( "value" ) );
			},
			slide: function( event, ui ) {
				diffuse.text( ui.value);
				$("#geo_diffuse_reflection_coef" ).val(ui.value);
			}
		});
		var specular = $( "#geo_specular_reflection_coef_view" );
		$( "#geo_specular_reflection_coef" ).slider({
			range: "max",
			min: 0, // min value
			max: 1, // max value
			step: 0.01,
			value: '${policy.geo_specular_reflection_coef}', // default value of slider
			create: function() {
				specular.text( $( this ).slider( "value" ) );
			},
			slide: function( event, ui ) {
				specular.text( ui.value);
				$("#geo_specular_reflection_coef" ).val(ui.value);
			}
		});
		
		$('[name="geo_ambient_color"]').paletteColorPicker({
			clear_btn: 'last',
			//position: 'downside',
			close_all_but_this: true // Default is false
		});
		$('[name="geo_specular_color"]').paletteColorPicker({
			clear_btn: 'last',
			//position: 'downside',
			close_all_but_this: true // Default is false
		});
	}
	
	var dataDialog = $( ".dataDialog" ).dialog({
		autoOpen: false,
		height: 600,
		width: 1200,
		modal: true,
		overflow : "auto",
		resizable: false
	});
	
	// 시작 프로젝트 찾기
	$( "#projectFind" ).on( "click", function() {
		dataDialog.dialog( "open" );
		drawProjectList();
	});
	
	function drawProjectList() {
		$.ajax({
			url: "/data/ajax-list-project.do",
			type: "POST",
			//data: info,
			cache: false,
			dataType: "json",
			success: function(msg){
				if(msg.result == "success") {
					var content = "";
					var projectList = msg.projectList;
					if(projectList == null || projectList.length == 0) {
						content = content
							+ 	"<tr>"
							+ 	"	<td colspan=\"11\" class=\"col-none\">프로젝트가 존재하지 않습니다.</td>"
							+ 	"</tr>";
					} else {
						projectListCount = projectList.length;
						for(i=0; i<projectListCount; i++ ) {
							var project = projectList[i];
							content = content 
								+ 	"<tr>"
								+ 	"	<td class=\"col-checkbox\"><input type=\"checkbox\" id=\"project_id_" + project.project_id 
								+ 											"\" name=\"project_id\" value=\"" + project.project_id + "," + project.project_name + "\" /></td>"
								+ 	"	<td class=\"col-name\">" + project.project_key + " </td>"
								+ 	"	<td class=\"col-name\">" + project.project_name + " </td>"
								+ 	"	<td class=\"col-number\">" + project.view_order + "</td>"
								+ 	"	<td class=\"col-toggle\">" + project.default_yn + "</td>"
								+ 	"	<td class=\"col-toggle\">" + project.use_yn + "</td>"
								+ 	"	<td class=\"col-toggle\">" + project.latitude + "</td>"
								+ 	"	<td class=\"col-toggle\">" + project.longitude + "</td>"
								+ 	"	<td class=\"col-toggle\">" + project.height + "</td>"
								+ 	"	<td class=\"col-toggle\">" + project.duration + "</td>"
								+ 	"	<td class=\"col-toggle\">" + project.insert_date +"</td>"
								+ 	"	</tr>";
						}
					}
					
					$("#projectList").empty();
					$("#projectList").html(content);
				} else {
					alert(JS_MESSAGE[msg.result]);
				}
			},
			error:function(request, status, error) {
				//alert(JS_MESSAGE["ajax.error.message"]);
				alert(" code : " + request.status + "\n" + ", message : " + request.responseText + "\n" + ", error : " + error);
    		}
		});
	}
	
	// 전체 선택 
	$("#chk_all").click(function() {
		$(":checkbox[name=project_id]").prop("checked", this.checked);
	});
	
	$( "#projectSelect" ).on( "click", function() {
		var checkedValue = "";
		var checkedName = "";
		$("input:checkbox[name=project_id]:checked").each(function(index){
			var tempValue = $(this).val().split(",");
			checkedValue += tempValue[0] + ",";
			checkedName += tempValue[1] + ",";
		});
		if(checkedValue.indexOf(",") > 0) {
			checkedValue =checkedValue.substring(0, checkedValue.lastIndexOf(","));
			checkedName =checkedName.substring(0, checkedName.lastIndexOf(","));
		}
		
		$("#geo_data_default_projects").val(checkedValue);
		$("#geo_data_default_projects_view").val(checkedName);
		dataDialog.dialog( "close" );
	});
	
	// GeoServer
	var updatePolicyGeoServerFlag = true;
	function updatePolicyGeoServer() {
		if(updatePolicyGeoServerFlag) {
			// validation 나중에
			updatePolicyGeoServerFlag = false;
			var info = $("#policyGeoServer").serialize() + "&policy_id=" + $("#policy_id").val();
			$.ajax({
				url: "/config/ajax-update-policy-geoserver.do",
				type: "POST",
				data: info,
				cache: false,
				dataType: "json",
				success: function(msg){
					if(msg.result == "success") {
						alert(JS_MESSAGE["policy.geoserver.update"]);
					} else {
						alert(JS_MESSAGE[msg.result]);
					}
					updatePolicyGeoServerFlag = true;
				},
				error:function(request,status,error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        updatePolicyGeoServerFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}
	
	// Geo CallBack Function
	var updatePolicyGeoCallBackFlag = true;
	function updatePolicyGeoCallBack() {
		if(updatePolicyGeoCallBackFlag) {
			// validation 나중에
			updatePolicyGeoCallBackFlag = false;
			var info = $("#policyGeoCallBack").serialize() + "&policy_id=" + $("#policy_id").val();
			$.ajax({
				url: "/config/ajax-update-policy-geocallback.do",
				type: "POST",
				data: info,
				cache: false,
				dataType: "json",
				success: function(msg){
					if(msg.result == "success") {
						alert(JS_MESSAGE["policy.geo.update"]);
					} else {
						alert(JS_MESSAGE[msg.result]);
					}
					updatePolicyGeoCallBackFlag = true;
				},
				error:function(request,status,error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        updatePolicyGeoCallBackFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}
	
	// 보안 정책 저장
	var updateSecurityFlag = true;
	function updatePolicySecurity() {
		if(updateSecurityFlag) {
			if(!isNumber($("#security_session_timeout").val())) {
				$("#security_session_timeout").focus();
				return;
			}
			var security_sso_token_verify_time = $("#security_sso_token_verify_time").val();
			if(security_sso_token_verify_time != null && security_sso_token_verify_time != "") {
				if(!isNumber(security_sso_token_verify_time)) {
					$("#security_sso_token_verify_time").focus();
					return;
				}
			}
			updateSecurityFlag = false;
			var info = $("#policySecurity").serialize() + "&policy_id=" + $("#policy_id").val();
			$.ajax({
				url: "/config/ajax-update-policy-security.do",
				type: "POST",
				data: info,
				cache: false,
				dataType: "json",
				success: function(msg){
					if(msg.result == "success") {
						alert(JS_MESSAGE["policy.security.update"]);
					} else {
						alert(JS_MESSAGE[msg.result]);
					}
					updateSecurityFlag = true;
				},
				error:function(request,status,error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        updateSecurityFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}
	
	// 컨텐트 정책 저장
	var updateContentFlag = true;
	function updatePolicyContent() {
		if(updateContentFlag) {
			if(!isNumber($("#content_cache_version").val())) {
				$("#content_cache_version").focus();
				return;
			}
			if($("#content_main_widget_count").val() == "") {
				alert(JS_MESSAGE["policy.contents.main.display"]);
				$("#content_main_widget_count").focus();
				return;
			}
			if(!isNumber($("#content_main_widget_count").val())) {
				$("#content_main_widget_count").focus();
				return;
			}
			if($("#content_main_widget_interval").val() == "") {
				alert(JS_MESSAGE["policy.contents.widget.interval"]);
				$("#content_main_widget_interval").focus();
				return;
			}
			if(!isNumber($("#content_main_widget_interval").val())) {
				$("#content_main_widget_interval").focus();
				return;
			}
			if($("#content_statistics_interval").val() == "") {
				alert(JS_MESSAGE["policy.statistics_.interval"]);
				$("#content_statistics_interval").focus();
				return;
			}
			if($("#content_load_balancing_interval").val() == "") {
				alert(JS_MESSAGE["load.balancing.interval"]);
				$("#content_load_balancing_interval").focus();
				return;
			}
			if(!isNumber($("#content_load_balancing_interval").val())) {
				$("#content_load_balancing_interval").focus();
				return;
			}
			if($("#content_menu_group_root").val() == "") {
				alert(JS_MESSAGE["policy.contents.menu.group.root"]);
				$("#content_menu_group_root").focus();
				return;
			}
			if($("#content_user_group_root").val() == "") {
				alert(JS_MESSAGE["policy.contents.user.group.root"]);
				$("#content_user_group_root").focus();
				return;
			}
			
			updateContentFlag = false;
			var info = $("#policyContent").serialize() + "&policy_id=" + $("#policy_id").val();
			$.ajax({
				url: "/config/ajax-update-policy-content.do",
				type: "POST",
				data: info,
				cache: false,
				dataType: "json",
				success: function(msg){
					if(msg.result == "success") {
						alert(JS_MESSAGE["policy.content.update"]);
					} else {
						alert(JS_MESSAGE[msg.result]);
					}
					updateContentFlag = true;
				},
				error:function(request,status,error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        updateContentFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}
	
	// 사용자 파일 업로드 정책 저장
	var updateUserUploadFlag = true;
	function updatePolicyUserUpload() {
		if(updateUserUploadFlag) {
			if($("#user_upload_type").val() == "") {
				alert("업로딩 가능한 타입을 입력하여 주십시오.");
				$("#user_upload_type").focus();
				return;
			}
			if(!isNumber($("#user_upload_max_filesize").val())) {
				$("#user_upload_max_filesize").focus();
				return;
			}
			if(!isNumber($("#user_upload_max_count").val())) {
				$("#user_upload_max_count").focus();
				return;
			}
			
			updateUserUploadFlag = false;
			var info = $("#policyUserUpload").serialize() + "&policy_id=" + $("#policy_id").val();
			$.ajax({
				url: "/config/ajax-update-policy-userupload.do",
				type: "POST",
				data: info,
				cache: false,
				dataType: "json",
				success: function(msg){
					if(msg.result == "success") {
						alert("사용자 업로딩 정책이 수정 되었습니다");
					} else {
						alert(JS_MESSAGE[msg.result]);
					}
					updateUserUploadFlag = true;
				},
				error:function(request,status,error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        updateUserUploadFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}
	
	// Back Office 정보 저장
	var updateBackofficeFlag = true;
	function updatePolicyBackoffice() {
		if(updateBackofficeFlag) {
			updateBackofficeFlag = false;
			var info = $("#policyBackoffice").serialize() + "&policy_id=" + $("#policy_id").val();
			$.ajax({
				url: "/config/ajax-update-policy-backoffice.do",
				type: "POST",
				data: info,
				cache: false,
				dataType: "json",
				success: function(msg){
					if(msg.result == "success") {
						alert(JS_MESSAGE["update"]);
					} else {
						alert(JS_MESSAGE[msg.result]);
					}
					updateBackofficeFlag = true;
				},
				error:function(request,status,error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        updateBackofficeFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}
	
	// 사이트 정보 저장
	var updateSiteFlag = true;
	function updatePolicySite() {
		if(updateSiteFlag) {
			if(!isIP($("#server_ip").val())) {
				alert(JS_MESSAGE["policy.site.ip"]);
				$("#server_ip").focus();
				return false;
			}
			
			if($("#site_name").val() == "") {
				alert(JS_MESSAGE["policy.site.service.name"]);
				$("#site_name").focus();
				return;
			}
			if($("#site_admin_mobile_phone").val() == "") {
				alert(JS_MESSAGE["policy.site.admin.mobile"]);
				$("#site_admin_mobile_phone").focus();
				return;
			}
			if($("#site_admin_email").val() == "") {
				alert(JS_MESSAGE["policy.site.admin.email"]);
				$("#site_admin_email").focus();
				return;
			}
			
			updateSiteFlag = false;
			var info = $("#policySite").serialize() + "&policy_id=" + $("#policy_id").val();
			$.ajax({
				url: "/config/ajax-update-policy-site.do",
				type: "POST",
				data: info,
				cache: false,
				dataType: "json",
				success: function(msg){
					if(msg.result == "success") {
						alert(JS_MESSAGE["policy.site.update"]);
					} else {
						alert(JS_MESSAGE[msg.result]);
					}
					updateSiteFlag = true;
				},
				error:function(request,status,error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        updateSiteFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}
	
	// API KEY 찾기
	function findApiKey() {
		
	}
	
	// 제품 정보 저장
	var updateSolutionFlag = true;
	function updatePolicySolution() {
		if(updateSolutionFlag) {
			if($("#solution_name").val() == "") {
				alert(JS_MESSAGE["policy.product.name"]);
				$("#solution_name").focus();
				return;
			}
			if($("#solution_version").val() == "") {
				alert(JS_MESSAGE["policy.product.version"]);
				$("#solution_version").focus();
				return;
			}
			if($("#solution_manager").val() == "") {
				alert(JS_MESSAGE["policy.product.admin"]);
				$("#solution_manager").focus();
				return;
			}
			
			updateSolutionFlag = false;
			var info = $("#policySolution").serialize() + "&policy_id=" + $("#policy_id").val();
			$.ajax({
				url: "/config/ajax-update-policy-solution.do",
				type: "POST",
				data: info,
				cache: false,
				dataType: "json",
				success: function(msg){
					if(msg.result == "success") {
						alert(JS_MESSAGE["policy.solution.update"]);
					} else {
						alert(JS_MESSAGE[msg.result]);
					}
					updateSolutionFlag = true;
				},
				error:function(request,status,error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        updateSolutionFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}
</script>
</body>
</html>