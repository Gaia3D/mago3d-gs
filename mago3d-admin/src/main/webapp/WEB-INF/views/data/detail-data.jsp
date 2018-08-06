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
						<div class="tabs">
							<ul>
								<li><a href="#data_info_tab"><spring:message code='user.input.information'/></a></li>
							</ul>
							<div id="data_info_tab">
								<form:form id="dataInfo" modelAttribute="dataInfo" method="post" onsubmit="return false;">
								<form:hidden path="data_id"/>
								<form:hidden path="depth"/>
								<form:hidden path="old_data_key"/>
								<table class="inner-table scope-row">
									<col class="col-label" />
									<col class="col-data" />
									<tr>
										<th class="col-label" scope="row"><spring:message code='data.project.name'/></th>
										<td class="col-data">${dataInfo.project_name }</td>
									</tr>	
									<tr>
										<th class="col-label" scope="row"><spring:message code='data.project.parent.node'/></th>
										<td class="col-data">${dataInfo.parent_name}</td>
									</tr>	
									<tr>
										<th class="col-label" scope="row">Key</th>
											<td class="col-data">${dataInfo.data_key }</td>
									</tr>	
									<tr>
										<th class="col-label" scope="row"><spring:message code='data.name'/></th>
										<td class="col-data">${dataInfo.data_name }</td>
									</tr>
									<tr>
										<th class="col-label" scope="row"><spring:message code='data.mapping.type'/></th>
										<td class="col-data">${dataInfo.mapping_type }</td>
									</tr>
									<tr>
										<th class="col-label" scope="row"><spring:message code='latitude'/></th>
										<td class="col-data">${dataInfo.latitude }</td>
									</tr>	
									<tr>
										<th class="col-label" scope="row"><spring:message code='longitude'/></th>
										<td class="col-data">${dataInfo.longitude }</td>
									</tr>
									<tr>
										<th class="col-label" scope="row"><spring:message code='height'/></th>
										<td class="col-data">${dataInfo.height }</td>
									</tr>
									<tr>
										<th class="col-label" scope="row">Heading</th>
										<td class="col-data">${dataInfo.heading }</td>
									</tr>
									<tr>
										<th class="col-label" scope="row">Pitch</th>
										<td class="col-data">${dataInfo.pitch }</td>
									</tr>
									<tr>
										<th class="col-label" scope="row">Roll</th>
										<td class="col-data">${dataInfo.roll }</td>
									</tr>
									<tr>
										<th class="col-label" scope="row"><spring:message code='properties'/></th>
										<td class="col-data">${dataInfo.attributes }</td>
									</tr>
									<tr>
										<th class="col-label" scope="row"><spring:message code='description'/></th>
										<td class="col-data">${dataInfo.description }</td>
									</tr>			
								</table>
								</form:form>
							</div>
							
							
						</div>
						
						<div class="button-group">
							<div class="center-buttons">
								<a href="/data/list-data.do?${listParameters}" class="button"><spring:message code='list'/></a>
								<a href="/data/modify-data.do?data_id=${dataInfo.data_id }&amp;${listParameters}" class="button"><spring:message code='modified'/></a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>
	
<script type="text/javascript" src="/externlib/jquery/jquery.js"></script>
<script type="text/javascript" src="/externlib/jquery-ui/jquery-ui.js"></script>	
<script type="text/javascript" src="/js/${lang}/common.js"></script>
<script type="text/javascript" src="/js/${lang}/message.js"></script>
<script type="text/javascript" src="/js/navigation.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$( ".tabs" ).tabs();
	});
</script>
</body>
</html>