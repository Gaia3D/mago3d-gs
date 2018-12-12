<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="geo_tab">
	<form:form id="policyGeo" modelAttribute="policy" method="post" onsubmit="return false;">
	<table class="input-table scope-row">
		<col class="col-label l" />
		<col class="col-input" />
		
		<tr>
  			<th>
		  		<form:label path="geo_view_library" cssClass="nessItem"><spring:message code='config.geo.viewlibrary'/></form:label>
 			</th>
 			<td>
	  			<select id="geo_view_library" name="geo_view_library" class="select">
	  				<option value="cesium" selected>Cesium</option>
	  				<option value="worldwind">WorldWind</option>
	  			</select>
	  		</td>
  		</tr>
  		<tr>
			<th class="col-label l" scope="row">
				<form:label path="geo_cesium_ion_token"><spring:message code='config.geo.cesiu.ion.token'/></form:label>
			</th>
			<td class="col-input">
				<form:input path="geo_cesium_ion_token" cssClass="l" />
				<form:errors path="geo_cesium_ion_token" cssClass="error" />
			</td>
		</tr>
  		<tr>
			<th class="col-label l" scope="row">
				<form:label path="geo_data_path"><spring:message code='config.data.folder'/></form:label>
			</th>
			<td class="col-input">
				<form:input path="geo_data_path" cssClass="l" />
				<span class="table-desc"><spring:message code='config.directory'/></span>
				<form:errors path="geo_data_path" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="geo_data_default_projects"><spring:message code='config.geo.project.loading'/></form:label>
			</th>
			<td class="col-input">
				<form:input path="geo_data_default_projects_view" cssClass="l" />
				<form:hidden path="geo_data_default_projects" />
				<input type="button" id="projectFind" value="<spring:message code='search'/>" />
			</td>
		</tr>
		<tr>
  			<th>
		  		<span><spring:message code='config.geo.data.change.request.decision'/></span>
 			</th>
 			<spring:message code='config.geo.data.change.request.decision.auto' var='auto'/>
 			<spring:message code='config.geo.data.change.request.decision.confirm' var='confirm'/>
 			<td class="col-input radio-set">
 				<form:radiobutton path="geo_data_change_request_decision" value="0" label="${auto}" />
				<form:radiobutton path="geo_data_change_request_decision" value="1" label="${confirm}" />
	  		</td>
  		</tr>
  		<tr>
  			<th>
		  		<span><spring:message code='config.init.camera.move'/></span>
 			</th>
 			<td class="col-input radio-set">
 				<form:radiobutton path="geo_init_camera_enable" value="true" label="${use}" />
				<form:radiobutton path="geo_init_camera_enable" value="false" label="${noUse}" />
	  		</td>
  		</tr>
  		<tr>
			<th class="col-label l" scope="row">
				<form:label path="geo_init_latitude"><spring:message code='config.init.camera.lattiude'/></form:label>
			</th>
			<td class="col-input">
				<form:input path="geo_init_latitude" cssClass="m" />
				<form:errors path="geo_init_latitude" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="geo_init_longitude"><spring:message code='config.init.camera.longitude'/></form:label>
			</th>
			<td class="col-input">
				<form:input path="geo_init_longitude" cssClass="m" />
				<form:errors path="geo_init_longitude" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="geo_init_height"><spring:message code='config.init.camera.height'/></form:label>
			</th>
			<td class="col-input">
				<form:input path="geo_init_height" cssClass="m" />
				<form:errors path="geo_init_height" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="geo_init_duration"><spring:message code='config.init.camera.time'/></form:label>
			</th>
			<td class="col-input">
				<form:input path="geo_init_duration" cssClass="m" />
				<span class="table-desc"><spring:message code='config.second.unit'/></span>
				<form:errors path="geo_init_duration" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="geo_lod0"><spring:message code='config.geo.lod0'/></form:label>
			</th>
			<td class="col-input">
				<form:input path="geo_lod0" cssClass="m" />&nbsp;M
				<form:errors path="geo_lod0" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="geo_lod1"><spring:message code='config.geo.lod1'/></form:label>
			</th>
			<td class="col-input">
				<form:input path="geo_lod1" cssClass="m" />&nbsp;M
				<form:errors path="geo_lod1" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="geo_lod2"><spring:message code='config.geo.lod2'/></form:label>
			</th>
			<td class="col-input">
				<form:input path="geo_lod2" cssClass="m" />&nbsp;M
				<form:errors path="geo_lod2" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="geo_lod3"><spring:message code='config.geo.lod3'/></form:label>
			</th>
			<td class="col-input">
				<form:input path="geo_lod3" cssClass="m" />&nbsp;M
				<form:errors path="geo_lod3" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="geo_lod4"><spring:message code='config.geo.lod4'/></form:label>
			</th>
			<td class="col-input">
				<form:input path="geo_lod4" cssClass="m" />&nbsp;M
				<form:errors path="geo_lod4" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="geo_lod5"><spring:message code='config.geo.lod5'/></form:label>
			</th>
			<td class="col-input">
				<form:input path="geo_lod5" cssClass="m" />&nbsp;M
				<form:errors path="geo_lod5" cssClass="error" />
			</td>
		</tr>
	</table>
	<div class="button-group">
		<div class="center-buttons">
			<a href="#" onclick="updatePolicyGeo();" class="button"><spring:message code='save'/></a>
		</div>
	</div>
	</form:form>
</div>

<!-- Dialog -->
<div id="dataDialog" class="dataDialog" title="<spring:message code='search'/>">
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
		<col class="col-date" />
		<thead>
			<tr>
				<th scope="col" class="col-checkbox"><input type="checkbox" id="chk_all" name="chk_all" /></th>
				<th scope="col" class="col-name">Key</th>
				<th scope="col" class="col-name"><spring:message code='data.project.name'/></th>
				<th scope="col" class="col-number"><spring:message code='order'/></th>
				<th scope="col" class="col-toggle"><spring:message code='default.value'/></th>
				<th scope="col" class="col-toggle"><spring:message code='status'/></th>
				<th scope="col" class="col-toggle"><spring:message code='latitude'/></th>
				<th scope="col" class="col-toggle"><spring:message code='longitude'/></th>
				<th scope="col" class="col-toggle"><spring:message code='height'/></th>
				<th scope="col" class="col-number"><spring:message code='movement.time'/></th>
				<th scope="col" class="col-date"><spring:message code='data.insert.date'/></th>
			</tr>
		</thead>
		<tbody id="projectList">
		</tbody>
	</table>
	<div class="button-group">
		<input type="button" id="projectSelect" class="button" value="<spring:message code='select'/>"/>
	</div>
</div>
