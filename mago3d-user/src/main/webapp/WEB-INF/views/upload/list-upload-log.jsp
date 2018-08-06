<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>main | mago3D User</title>
	<link rel="stylesheet" href="/externlib/sufee-template/css/bootstrap.min.css">
	<link rel="stylesheet" href="/externlib/sufee-template/css/font-awesome.min.css">
	<link rel="stylesheet" href="/externlib/sufee-template/css/themify-icons.css">
	<link rel="stylesheet" href="/externlib/sufee-template/scss/style.css">
	<link rel="stylesheet" href="/externlib/jquery-ui/jquery-ui.css" />
	<link rel="stylesheet" href="/css/ko/style.css">
	<link rel="stylesheet" href="/css/${lang}/font/font.css" />
	<link rel="stylesheet" href="/images/${lang}/icon/glyph/glyphicon.css" />
</head>
<body>
	
<%@ include file="/WEB-INF/views/layouts/menu.jsp" %>

<div id="right-panel" class="right-panel">

	<%@ include file="/WEB-INF/views/layouts/header.jsp" %>
	<%@ include file="/WEB-INF/views/layouts/page_header.jsp" %>
			
	<div class="content mt-3" style="min-height: 750px; background-color: white;">
	
		<div class="page-content">
			<div class="filters">
   				<form:form id="searchForm" modelAttribute="uploadLog" method="post" action="/upload/list-upload-log.do" onsubmit="return searchCheck();">
				<div class="input-group row">
					<div class="input-set">
						<label for="search_word"><spring:message code='search.word'/></label>
						<select id="search_word" name="search_word" class="select">
							<option value=""><spring:message code='select'/></option>
		          			<option value="file_name">파일 이름</option>
						</select>
						<select id="search_option" name="search_option" class="select">
							<option value="0"><spring:message code='search.same'/></option>
							<option value="1"><spring:message code='search.include'/></option>
						</select>
						<form:input path="search_value" type="search" cssClass="m" />
					</div>
					<div class="input-set">
						<label for="start_date"><spring:message code='search.date'/></label>
						<input type="text" class="s date" id="start_date" name="start_date" />
						<span class="delimeter tilde">~</span>
						<input type="text" class="s date" id="end_date" name="end_date" />
					</div>
					<div class="input-set">
						<label for="order_word"><spring:message code='search.order'/></label>
						<select id="order_word" name="order_word" class="select">
							<option value=""> <spring:message code='search.basic'/> </option>
							<option value="file_name"> 파일 이름 </option>
							<option value="insert_date"> <spring:message code='search.insert.date'/> </option>
						</select>
						<select id="order_value" name="order_value" class="select">
	                		<option value=""> <spring:message code='search.basic'/> </option>
		                	<option value="ASC"> <spring:message code='search.ascending'/> </option>
							<option value="DESC"> <spring:message code='search.descending.order'/> </option>
						</select>
						<select id="list_counter" name="list_counter" class="select">
	                		<option value="10"> <spring:message code='search.ten.count'/> </option>
		                	<option value="50"> <spring:message code='search.fifty.count'/> </option>
							<option value="100"> <spring:message code='search.hundred.count'/> </option>
						</select>
					</div>
					<div class="input-set">
						<input type="submit" value="<spring:message code='search'/>" />
					</div>
				</div>
				</form:form>
			</div>
			<div class="list">
				<form:form id="listForm" modelAttribute="uploadLog" method="post">
				<div class="list-header">
					<div class="list-desc u-pull-left">
						<spring:message code='all.d'/> <em><fmt:formatNumber value="${pagination.totalCount}" type="number"/></em><spring:message code='search.what.count'/> 
						<fmt:formatNumber value="${pagination.pageNo}" type="number"/> / <fmt:formatNumber value="${pagination.lastPage }" type="number"/> <spring:message code='search.page'/>
					</div>
					<div class="list-functions u-pull-right">
						<div style="padding-bottom: 3px;" class="button-group">
							<a href="#" onclick="converterFiles(); return false;" class="button">F4D 일괄 변환</a>	
						</div>
					</div>
				</div>
				<table class="list-table scope-col">
						<col class="col-checkbox" />
						<col class="col-number" />
						<col class="col-name" />
						<col class="col-functions" />
						<col class="col-functions" />
						<col class="col-number" />
						<col class="col-functions" />
						<col class="col-functions" />
						<col class="col-functions" />
						<thead>
							<tr>
								<th scope="col" class="col-checkbox"><input type="checkbox" id="chk_all" name="chk_all" /></th>
								<th scope="col" class="col-number"><spring:message code='number'/></th>
								<th scope="col" class="col-name">파일명</th>
								<th scope="col" class="col-id">파일 경로</th>
								<th scope="col" class="col-name">사이즈</th>
								<th scope="col" class="col-name">F4d 변환횟수</th>
								<th scope="col" class="col-date"><spring:message code='insert.date'/></th>
								<th scope="col" class="col-functions">변환</th>
								<th scope="col" class="col-functions">수정 / 삭제</th>
							</tr>
						</thead>
						<tbody>
<c:if test="${empty uploadLogList }">
							<tr>
								<td colspan="9" class="col-none">파일 업로딩 이력이 존재하지 않습니다.</td>
							</tr>
</c:if>
<c:if test="${!empty uploadLogList }">
<c:forEach var="uploadLog" items="${uploadLogList}" varStatus="status">
							<tr>
								<td class="col-checkbox">
									<input type="checkbox" id="upload_log_id_${uploadLog.upload_log_id}" name="upload_log_id" value="${uploadLog.upload_log_id}" />
								</td>
								<td class="col-number">${pagination.rowNumber - status.index }</td>
								<td class="col-name">${uploadLog.file_name }</td>
								<td class="col-name">${uploadLog.file_path}</td>
								<td class="col-name">${uploadLog.file_size}</td>
								<td class="col-name">${uploadLog.converter_count}</td>
								<td class="col-name">${uploadLog.viewInsertDate }</td>
								<td class="col-functions">
									<span class="button-group">
										<a href="#" onclick="converterFile('${uploadLog.upload_log_id}'); return false;" class="button">F4D 변환</a>
									</span>
								</td>
								<td class="col-functions">
									<span class="button-group">
										<a href="/data/modify-data.do?data_id=${uploadLog.upload_log_id }&amp;pageNo=${pagination.pageNo }${pagination.searchParameters}" 
											class="image-button button-edit"><spring:message code='modified'/></a>
										<a href="/data/delete-data.do?data_id=${uploadLog.upload_log_id }" onclick="return deleteWarning();" 
											class="image-button button-delete"><spring:message code='delete'/></a>
									</span>
								</td>
							</tr>
</c:forEach>
</c:if>
						</tbody>
				</table>
				</form:form>
				
			</div>
			<%@ include file="/WEB-INF/views/common/pagination.jsp" %>
		</div>
	</div>
	
	<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>
</div>

<%-- F4D Converter Job 등록 --%>
<div class=dialog_converter_job title="F4D Converter Job 등록">
	<form id="converterJobForm" name="converterJobForm" action="" method="post">
		<input type="hidden" id="check_ids" name="check_ids" value="" />
		<table class="inner-table scope-row">
			<col class="col-sub-label xl" />
			<col class="col-data" />
			<tbody>
				<tr>
					<th class="col-sub-label x">제목</th>
					<td>
						<div class="inner-data">
							<input type="text" id="title" name="title" class="l" />
						</div>
					</td>
				</tr>
			</tbody>
		</table>
		<div class="button-group">
			<a href="#" onclick="saveConverterJob(); return false;" class="button">저장</a>
		</div>
	</form>
</div>
<%-- F4D Converter Job 등록 --%>

<script src="/externlib/jquery/jquery.js"></script>
<script type="text/javascript" src="/externlib/jquery-ui/jquery-ui.js"></script>
<script src="/externlib/sufee-template/js/plugins.js"></script>
<script src="/externlib/sufee-template/js/main.js"></script>
<script src="/js/${lang}/message.js"></script>
<script type="text/javascript">
	jQuery.noConflict();

	//전체 선택 
	jQuery("#chk_all").click(function() {
		jQuery(":checkbox[name=upload_log_id]").prop("checked", this.checked);
	});
	
	var dialogConverterJob = jQuery( ".dialog_converter_job" ).dialog({
		autoOpen: false,
		height: 240,
		width: 600,
		modal: true,
		resizable: false,
		close: function() { location.reload(); }
	});
	
	// F4D Converter Button Click
	function converterFile(upload_log_id) {
		jQuery("#check_ids").val(upload_log_id + ",");
		
		dialogConverterJob.dialog( "open" );
	}
	
	// All F4D Converter Button Click
	function converterFiles() {
		var checkedValue = "";
		jQuery("input:checkbox[name=upload_log_id]:checked").each(function(index){
			checkedValue += jQuery(this).val() + ",";
		});
		if(checkedValue === "") {
			alert("파일을 선택해 주십시오.");
			return;
		}
		jQuery("#check_ids").val(checkedValue);
		
		dialogConverterJob.dialog( "open" );
	}
	
	// F4D Converter 일괄 변환
	var saveConverterJobFlag = true;
	function saveConverterJob() {
		if(jQuery("#title").val() == null || jQuery("#title").val() == "") {
			alert("제목을 입력하여 주십시오.");
			return false;
		}
		
		if(saveConverterJobFlag) {
			saveConverterJobFlag = false;
			var info =jQuery("#converterJobForm").serialize();
			jQuery.ajax({
				url: "/converter/ajax-insert-converter-job.do",
				type: "POST",
				data: info,
				dataType: "json",
				success: function(msg){
					if(msg.result == "success") {
						alert(JS_MESSAGE["insert"]);	
					} else {
						alert(JS_MESSAGE[msg.result]);
					}
					
					jQuery("#check_ids").val("");
					jQuery("#title").val("");
					jQuery(":checkbox[name=upload_log_id]").prop("checked", false);
					dialogConverterJob.dialog( "close" );
					saveConverterJobFlag = true;
				},
				error:function(request,status,error){
					alert(JS_MESSAGE["ajax.error.message"]);
					dialogConverterJob.dialog( "close" );
					saveConverterJobFlag = true;
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
