package com.gaia3d.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gaia3d.config.CacheConfig;
import com.gaia3d.domain.CacheManager;
import com.gaia3d.domain.CacheName;
import com.gaia3d.domain.CacheParams;
import com.gaia3d.domain.DataInfo;
import com.gaia3d.domain.DataInfoAttribute;
import com.gaia3d.domain.DataInfoLog;
import com.gaia3d.domain.DataInfoObjectAttribute;
import com.gaia3d.domain.Policy;
import com.gaia3d.domain.Project;
import com.gaia3d.persistence.DataLogMapper;
import com.gaia3d.persistence.DataMapper;
import com.gaia3d.service.DataService;
import com.gaia3d.service.ProjectService;

import lombok.extern.slf4j.Slf4j;

/**
 * Data
 * @author jeongdae
 *
 */
@Slf4j
@Service
public class DataServiceImpl implements DataService {

	@Autowired
	private DataService dataService;
	@Autowired
	private ProjectService projectService;
	
	@Autowired
	private DataMapper dataMapper;
	@Autowired
	private DataLogMapper dataLogMapper;
	
	/**
	 * Data 수
	 * @param dataInfo
	 * @return
	 */
	@Transactional(readOnly=true)
	public Long getDataTotalCount(DataInfo dataInfo) {
		return dataMapper.getDataTotalCount(dataInfo);
	}
	
	/**
	 * 데이터 상태별 통계 정보
	 * @param status
	 * @return
	 */
	@Transactional(readOnly=true)
	public Long getDataTotalCountByStatus(String status) {
		return dataMapper.getDataTotalCountByStatus(status);
	}
	
	/**
	 * Data Object 총건수
	 * @param dataInfoObjectAttribute
	 * @return
	 */
	@Transactional(readOnly=true)
	public Long getDataObjectAttributeTotalCount(DataInfoObjectAttribute dataInfoObjectAttribute) {
		return dataMapper.getDataObjectAttributeTotalCount(dataInfoObjectAttribute);
	}
	
	/**
	 * Data 목록
	 * @param dataInfo
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<DataInfo> getListData(DataInfo dataInfo) {
		return dataMapper.getListData(dataInfo);
	}
	
	/**
	 * 프로젝트별 Data 목록
	 * @param dataInfo
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<DataInfo> getListDataByProjectId(DataInfo dataInfo) {
		return dataMapper.getListDataByProjectId(dataInfo);
	}
	
	/**
	 * Data 정보 취득
	 * @param data_id
	 * @return
	 */
	@Transactional(readOnly=true)
	public DataInfo getData(Long data_id) {
		return dataMapper.getData(data_id);
	}
	
	/**
	 * Data 정보 취득
	 * @param dataInfo
	 * @return
	 */
	@Transactional(readOnly=true)
	public DataInfo getDataByDataKey(DataInfo dataInfo) {
		return dataMapper.getDataByDataKey(dataInfo);
	}
	
	/**
	 * Data Attribute 정보 취득
	 * @param data_id
	 * @return
	 */
	@Transactional(readOnly=true)
	public DataInfoAttribute getDataAttribute(Long data_id) {
		return dataMapper.getDataAttribute(data_id);
	}
	
	/**
	 * Data Object Attribute 정보 취득
	 * @param data_object_attribute_id
	 * @return
	 */
	@Transactional(readOnly=true)
	public DataInfoObjectAttribute getDataObjectAttribute(Long data_object_attribute_id) {
		return dataMapper.getDataObjectAttribute(data_object_attribute_id);
	}
	
	/**
	 * Data Object 조회
	 * @param dataInfoObjectAttribute
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<DataInfoObjectAttribute> getListDataObjectAttribute(DataInfoObjectAttribute dataInfoObjectAttribute) {
		return dataMapper.getListDataObjectAttribute(dataInfoObjectAttribute);
	}
	
	/**
	 * 데이터 공간 정보 변경 요청
	 * @return
	 */
	@Transactional
	public int updateDataLocationAndRotation(DataInfoLog dataInfoLog) {
		Policy policy = CacheManager.getPolicy();
		if(Policy.DATA_CHANGE_REQUEST_DECISION_AUTO.equals(policy.getGeo_data_change_request_decision())) {
			// 자동이면 update 후 log
			dataInfoLog.setStatus(DataInfoLog.STATUS_COMPLETE);
			
			DataInfo dataInfo = new DataInfo();
			dataInfo.setData_id(dataInfoLog.getData_id());
			dataInfo.setLatitude(dataInfoLog.getLatitude());
			dataInfo.setLongitude(dataInfoLog.getLongitude());
			dataInfo.setHeight(dataInfoLog.getHeight());
			dataInfo.setHeading(dataInfoLog.getHeading());
			dataInfo.setPitch(dataInfoLog.getPitch());
			dataInfo.setRoll(dataInfoLog.getRoll());
			dataMapper.updateData(dataInfo);
			
			refreshDataCache();
		} else {
			// 대기 상태
			dataInfoLog.setStatus(DataInfoLog.STATUS_REQUEST);
		}
		
		return dataLogMapper.insertDataInfoLog(dataInfoLog);
	}
	
	/**
	 * @param cacheType
	 */
	private void refreshDataCache() {
		CacheParams cacheParams = new CacheParams();
		cacheParams.setCacheName(CacheName.DATA_INFO);
		
		Long projectId = cacheParams.getProject_id();
		
		Map<Long, List<DataInfo>> projectDataMap = null;
		Map<Long, String> projectDataJsonMap = null;
		if(projectId == null) {
			// 최초 로딩시
			projectDataMap = new HashMap<>();
			projectDataJsonMap = new HashMap<>();
			
			List<Project> projectList = projectService.getListProject(new Project());
			for(Project project : projectList) {
				DataInfo dataInfo = new DataInfo();
				dataInfo.setProject_id(project.getProject_id());
				List<DataInfo> dataInfoList = getListDataByProjectId(dataInfo);
				
				projectDataMap.put(project.getProject_id(), dataInfoList);
				projectDataJsonMap.put(project.getProject_id(), getProjectDataJson(project, dataInfoList));
			}
		}
		
		CacheManager.setProjectDataMap(projectDataMap);
		CacheManager.setProjectDataJsonMap(projectDataJsonMap);
	}
	
	private String getProjectDataJson(Project project, List<DataInfo> dataInfoList) {
		
		if(dataInfoList == null || dataInfoList.isEmpty()) return null;
		
		StringBuilder builder = new StringBuilder(256);
		
		int dataInfoCount = dataInfoList.size();
		int preDepth = 0;
		int brackets = 0;
		for(int i = 0; i < dataInfoCount; i++) {
			DataInfo dataInfo = dataInfoList.get(i);
			
			// 자식들 정보
			if(preDepth < dataInfo.getDepth()) {
				// 시작
				builder.append("{");
				// location 정보 및 attributes
				builder = getLocationAndAttributes(builder, dataInfo);
				// 자식 노드
				builder.append("\"children\"").append(":").append("[");
				brackets++;
			} else if(preDepth == dataInfo.getDepth()) {
				// 형제 노드, 닫는 처리
				builder.append("]");
				builder.append("}");
				
				builder.append(",");
				builder.append("{");
				// location 정보 및 attributes
				builder = getLocationAndAttributes(builder, dataInfo);
				// 자식 노드
				builder.append("\"children\"").append(":").append("[");
			} else {
				// 종료, 닫는처리
				int closeCount = preDepth - dataInfo.getDepth();
				for(int j=0; j<=closeCount; j++) {
					builder.append("]");
					builder.append("}");
					brackets--;
				}
				
				builder.append(",");
				builder.append("{");
				// location 정보 및 attributes
				builder = getLocationAndAttributes(builder, dataInfo);
				// 자식 노드
				builder.append("\"children\"").append(":").append("[");
			}
				
			if(dataInfoCount == (i+1)) {
				// 맨 마지막의 경우 괄호를 닫음
				for(int k=0; k<brackets; k++) {
					builder.append("]");
					builder.append("}");
				}
			}
			
			preDepth = dataInfo.getDepth();
		}
		
		log.info(" ************** {} json file **********", project.getProject_name());
		log.info(" ========= {} ", builder.toString());
		return builder.toString();
	}

	private StringBuilder getLocationAndAttributes(StringBuilder builder, DataInfo dataInfo) {
		builder.append("\"data_id\"").append(":").append("\"").append(dataInfo.getData_id()).append("\"").append(",");
		builder.append("\"data_key\"").append(":").append("\"").append(dataInfo.getData_key()).append("\"").append(",");
		builder.append("\"data_name\"").append(":").append("\"").append(dataInfo.getData_name()).append("\"").append(",");
		builder.append("\"parent\"").append(":").append(dataInfo.getParent()).append(",");
		builder.append("\"depth\"").append(":").append(dataInfo.getDepth()).append(",");
		builder.append("\"view_order\"").append(":").append(dataInfo.getView_order()).append(",");
		if(dataInfo.getMapping_type() != null) builder.append("\"mapping_type\"").append(":").append("\"").append(dataInfo.getMapping_type()).append("\"").append(",");
		if(dataInfo.getLatitude() != null) builder.append("\"latitude\"").append(":").append(dataInfo.getLatitude()).append(",");
		if(dataInfo.getLongitude() != null) builder.append("\"longitude\"").append(":").append(dataInfo.getLongitude()).append(",");
		if(dataInfo.getHeight() != null) builder.append("\"height\"").append(":").append(dataInfo.getHeight()).append(",");
		if(dataInfo.getHeading() != null) builder.append("\"heading\"").append(":").append(dataInfo.getHeading()).append(",");
		if(dataInfo.getPitch() != null) builder.append("\"pitch\"").append(":").append(dataInfo.getPitch()).append(",");
		if(dataInfo.getRoll() != null) builder.append("\"roll\"").append(":").append(dataInfo.getRoll()).append(",");
		builder.append("\"attributes\"").append(":").append(dataInfo.getAttributes()).append(",");
		
		return builder;
	}
}
