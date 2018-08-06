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
	<link rel="stylesheet" href="/css/${lang}/style.css" />
	<link type="text/css" rel="stylesheet" href="/externlib/${lang}/axisj/ui/arongi/font-awesome.min.css" />	
	<script src="/externlib/jquery/jquery.js"></script>
	<script src="/externlib/jquery-ui/jquery-ui.js"></script>	
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
						<div class="content-header row">
							<h3 class="content-title u-pull-left">
								<spring:message code='project'/> (<a href="#" onclick="reloadProjectCache();"><spring:message code='cache.update'/></a>)
								
							</h3>
						</div>
						<div class="list">
							<div class="list-header row">
								<em><fmt:formatNumber value="${projectListSize}" type="number"/></em> 건
							</div>
							<table class="list-table scope-col">
									<col class="col-number" />
									<col class="col-name" />
									<col class="col-name" />
									<col class="col-number" />
									<col class="col-toggle" />
									<col class="col-toggle" />
									<col class="col-toggle" />
									<col class="col-toggle" />
									<col class="col-toggle" />
									<col class="col-number" />
									<col class="col-functions" />
									<col class="col-functions" />
									<col class="col-date" />
									<col class="col-functions" />
									<thead>
										<tr>
											<th scope="col" class="col-number"><spring:message code='number'/></th>
											<th scope="col" class="col-name">Key</th>
											<th scope="col" class="col-name"><spring:message code='data.project.name'/></th>
											<th scope="col" class="col-number"><spring:message code='order'/></th>
											<th scope="col" class="col-toggle"><spring:message code='default.value'/></th>
											<th scope="col" class="col-toggle"><spring:message code='code.use.not'/></th>
											<th scope="col" class="col-toggle"><spring:message code='latitude'/></th>
											<th scope="col" class="col-toggle"><spring:message code='longitude'/></th>
											<th scope="col" class="col-toggle"><spring:message code='height'/></th>
											<th scope="col" class="col-number"><spring:message code='movement.time'/></th>
											<th scope="col" class="col-functions"><spring:message code='data.management'/></th>
											<th scope="col" class="col-functions"><spring:message code='user.group.control.roll'/></th>
											<th scope="col" class="col-date"><spring:message code='search.insert.date'/></th>
											<th scope="col" class="col-functions"><spring:message code='code.modify.delete'/></th>
										</tr>
									</thead>
									<tbody>
<c:if test="${empty projectList }">
										<tr>
											<td colspan="14" class="col-none"><spring:message code='data.project.does.not.exist'/></td>
										</tr>
</c:if>
<c:if test="${!empty projectList }">
	<c:forEach var="project" items="${projectList}" varStatus="status">
										<tr>
											<td class="col-number">${status.index + 1}</td>
											<td class="col-name">${project.project_key }</td>
											<td class="col-number">${project.project_name }</td>
											<td class="col-number">${project.view_order}</td>
											<td class="col-toggle">${project.default_yn}</td>
											<td class="col-toggle">${project.use_yn}</td>
											<td class="col-toggle">${project.latitude}</td>
											<td class="col-toggle">${project.longitude}</td>
											<td class="col-toggle">${project.height}</td>
											<td class="col-toggle">${project.duration}</td>
											<td class="col-functions"><a href="#" onclick="viewDataList('${project.project_id}', '${project.project_name}'); return false;"><spring:message code='view'/></a></td>
											<td class="col-functions"><a href="/data/modify-project.do?project_id=${project.project_id}"><spring:message code='view'/></a></td>
											<td class="col-date">${project.viewInsertDate }</td>
											
											<td class="col-functions">
												<span class="button-group">
													<a href="/data/modify-project.do?project_id=${project.project_id}" class="image-button button-edit"><spring:message code='modified'/></a>
													<a href="#" onclick="deleteProject('${project.project_id}'); return false;" class="image-button button-delete">
														<spring:message code='delete'/>
													</a>
												</span>
											</td>
										</tr>
	</c:forEach>
</c:if>
									</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>
	
	<!-- Dialog -->
	<div id="dataDialog" class="dataDialog">
		<table class="list-table scope-col">
			<col class="col-number" />
			<col class="col-name" />
			<col class="col-id" />
			<col class="col-name" />
			<col class="col-toggle" />
			<col class="col-toggle" />
			<col class="col-toggle" />
			<col class="col-toggle" />
			<thead>
				<tr>
					<th scope="col" class="col-number"><spring:message code='number'/></th>
					<th scope="col" class="col-number">Depth</th>
					<th scope="col" class="col-id"><spring:message code='key'/></th>
					<th scope="col" class="col-name"><spring:message code='name'/></th>
					<th scope="col" class="col-toggle"><spring:message code='latitude'/></th>
					<th scope="col" class="col-toggle"><spring:message code='longitude'/></th>
					<th scope="col" class="col-toggle"><spring:message code='height'/></th>
					<th scope="col" class="col-toggle"><spring:message code='properties'/></th>
				</tr>
			</thead>
			<tbody id="projectDataList">
			</tbody>
		</table>
	</div>
	
<script type="text/javascript">
	$(document).ready(function() {
	});
	
	var dataDialog = $( ".dataDialog" ).dialog({
		autoOpen: false,
		height: 600,
		width: 1200,
		modal: true,
		overflow : "auto",
		resizable: false
	});
	
	// 데이터 목록
	function viewDataList(projectId, projectName) {
		dataDialog.dialog( "open" );
		dataDialog.dialog( "option", "title", projectName);
		drawDataList(projectId);
	}
	
	function drawDataList(projectId) {
		if(projectId === "") {
			alert(JS_MESSAGE["project.project_id.empty"]);
			return false;
		}
		var info = "project_id=" + projectId;
		$.ajax({
			url: "/data/ajax-list-data-by-project-id.do",
			type: "POST",
			data: info,
			cache: false,
			dataType: "json",
			success: function(msg){
				if(msg.result == "success") {
					var content = "";
					var dataList = msg.dataList;
					var projectDataNone = "<spring:message code='data.does.not.exist'/>";
					if(dataList == null || dataList.length == 0) {
						content = content
							+ 	"<tr>"
							+ 	"<td colspan=\"8\" class=\"col-none\">" + projectDataNone +	"</td>"
							+ 	"</tr>";
					} else {
						dataListCount = dataList.length;
						var preViewDepth = "";
						var preDataId = 0;
						var preDepth = 0;
						for(i=0; i<dataListCount; i++ ) {
							var dataInfo = dataList[i];
							var viewAttributes = dataInfo.attributes;
							var viewDepth = getViewDepth(preViewDepth, dataInfo.data_id, preDepth, dataInfo.depth);
							if(viewAttributes !== null && viewAttributes !== "" && viewAttributes.length > 20) viewAttributes = viewAttributes.substring(0, 20) + "...";
							content = content 
								+ 	"<tr>"
								+ 	"	<td class=\"col-number\">" + (i + 1) + " </td>"
								+ 	"	<td class=\"col-id\">" + viewDepth + "</td>"
								+ 	"	<td class=\"col-id\">" + dataInfo.data_key + "</td>"
								+ 	"	<td class=\"col-name\">" + dataInfo.data_name + "</td>"
								+ 	"	<td class=\"col-toggle\">" + dataInfo.latitude + "</td>"
								+ 	"	<td class=\"col-toggle\">" + dataInfo.longitude + "</td>"
								+ 	"	<td class=\"col-toggle\">" + dataInfo.height + "</td>"
								+ 	"	<td class=\"col-toggle\">" + viewAttributes + "</td>"
								+ 	"	</tr>";
								
							preDataId = dataInfo.data_id;
							preDepth = dataInfo.depth;
							preViewDepth = viewDepth;
						}
					}
					
					$("#projectDataList").empty();
					$("#projectDataList").html(content);
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
	
	function getViewDepth(preViewDepth, dataId, preDepth, depth) {
		var result = "";
		if(depth === 1) return result + dataId;
		
		if(preDepth === depth) {
			// 형제
			if(preViewDepth.indexOf(".") >= 0) {
				result =  preViewDepth.substring(0, preViewDepth.lastIndexOf(".") + 1) + dataId;
			} else {
				result = dataId;
			}
		} else if(preDepth < depth) {
			// 자식
			result = preViewDepth + "." + dataId;				
		} else {
			result =  preViewDepth.substring(0, preViewDepth.lastIndexOf("."));
			result =  result.substring(0, result.lastIndexOf(".") + 1) + dataId;
		}
		return result;
	}
	
	// project 삭제
	var deleteProjectFlag = true;
	function deleteProject(project_id) {
		if(confirm(JS_MESSAGE["delete.confirm"])) {
			if(deleteProjectFlag) {
				deleteProjectFlag = false;
				var info = "project_id=" + project_id;
				$.ajax({
					url: "/data/ajax-delete-project.do",
					type: "POST",
					data: info,
					cache: false,
					dataType: "json",
					success: function(msg){
						if(msg.result == "success") {
							alert(JS_MESSAGE["delete"]);	
							location.reload();
						} else {
							alert(JS_MESSAGE[msg.result]);
						}
						deleteProjectFlag = true;
					},
					error:function(request,status,error){
				        alert(JS_MESSAGE["ajax.error.message"]);
				        deleteProjectFlag = true;
					}
				});
			} else {
				alert(JS_MESSAGE["button.dobule.click"]);
				return;
			}
		}
	}
</script>
</body>
</html>