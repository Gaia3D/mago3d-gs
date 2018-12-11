package com.gaia3d.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gaia3d.config.CacheConfig;
import com.gaia3d.domain.CacheManager;
import com.gaia3d.domain.CacheName;
import com.gaia3d.domain.CacheParams;
import com.gaia3d.domain.CacheType;
import com.gaia3d.domain.Policy;
import com.gaia3d.domain.Project;
import com.gaia3d.domain.UserGroupRole;
import com.gaia3d.domain.UserSession;
import com.gaia3d.helper.GroupRoleHelper;
import com.gaia3d.service.ProjectService;
import com.gaia3d.service.RoleService;

import lombok.extern.slf4j.Slf4j;

/**
 * Project
 * @author jeongdae
 *
 */
@Slf4j
@Controller
@RequestMapping("/data/")
public class ProjectController {
	
	@Autowired
	CacheConfig cacheConfig;
	@Autowired
	private ProjectService projectService;
	@Autowired
	private RoleService roleService;
	
	/**
	 * Project 목록
	 * @param model
	 * @return
	 */
	@GetMapping(value = "list-project.do")
	public String projectList(Model model) {
		List<Project> projectList = projectService.getListProject(new Project());
		
		model.addAttribute("projectListSize", projectList.size());
		model.addAttribute("projectList", projectList);
		
		return "/data/list-project";
	}
	
	/**
	 * Ajax Project 목록
	 * @param request
	 * @return
	 */
	@PostMapping(value = "ajax-list-project.do")
	@ResponseBody
	public Map<String, Object> ajaxListProject(HttpServletRequest request) {
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		try {
			List<Project> projectList = projectService.getListProject(new Project());
			map.put("projectList", projectList);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
		
		map.put("result", result);
		return map;
	}
	
	/**
	 * Project 정보
	 * @param projectId
	 * @return
	 */
	@GetMapping(value = "ajax-project.do")
	@ResponseBody
	public Map<String, Object> ajaxProject(Long projectId) {
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		try {
						
			log.info("@@ projectId = {} ", projectId);
			if(projectId == null) {
				result = "input.invalid";
				map.put("result", result);
				return map;
			}
			
			Project project = projectService.getProject(projectId);
			map.put("project", project);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
		
		map.put("result", result);
		return map;
	}
	
	/**
	 * Project 등록 화면
	 * @param model
	 * @return
	 */
	@GetMapping(value = "input-project.do")
	public String inputProject(Model model) {
		Policy policy = CacheManager.getPolicy();
		
		model.addAttribute("policy", policy);
		model.addAttribute("project", new Project());
		
		return "/data/input-project";
	}
	
	/**
	 * Project key 중복 체크
	 * @param model
	 * @return
	 */
	@PostMapping(value = "ajax-project-key-duplication-check.do")
	@ResponseBody
	public Map<String, Object> ajaxProjectKeyDuplicationCheck(HttpServletRequest request, Project project) {
		
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		String duplication_value = "";
		
		log.info("@@ project = {}", project);
		try {
			if(project.getProject_key() == null || "".equals(project.getProject_key())) {
				result = "project.key.empty";
				map.put("result", result);
				return map;
			} else if(project.getOld_project_key() != null && !"".equals(project.getOld_project_key())) {
				if(project.getProject_key().equals(project.getOld_project_key())) {
					result = "project.key.same";
					map.put("result", result);
					return map;
				}
			}
			
			int count = projectService.getDuplicationKeyCount(project.getProject_key());
			log.info("@@ duplication_value = {}", count);
			duplication_value = String.valueOf(count);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
	
		map.put("result", result);
		map.put("duplication_value", duplication_value);
		
		return map;
	}
	
	/**
	 * Project 추가
	 * @param request
	 * @param project
	 * @return
	 */
	@PostMapping(value = "ajax-insert-project.do")
	@ResponseBody
	public Map<String, Object> ajaxInsertProject(HttpServletRequest request, Project project) {
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		try {
			log.info("@@ project = {} ", project);
			
			UserSession userSession = (UserSession)request.getSession().getAttribute(UserSession.KEY);
			// 사용자 그룹 ROLE 확인
			UserGroupRole userGroupRole = new UserGroupRole();
			userGroupRole.setUser_id(userSession.getUser_id());
			
			if(!GroupRoleHelper.isUserGroupRoleValid(roleService.getListUserGroupRoleByUserId(userGroupRole), UserGroupRole.PROJECT_INSERT)) {
				log.info("@@ 접근 권한이 없어 실행할 수 없습니다. RoleName = {}",  UserGroupRole.PROJECT_INSERT);
				map.put("result", "user.group.role.invalid");
				return map;
			}
			
			if(project.getProject_key() == null || "".equals(project.getProject_key())
					|| project.getProject_name() == null || "".equals(project.getProject_name())) {
				result = "input.invalid";
				map.put("result", result);
				return map;
			}
			
			projectService.insertProject(project);
			
			CacheParams cacheParams = new CacheParams();
			cacheParams.setCacheName(CacheName.PROJECT);
			cacheParams.setCacheType(CacheType.BROADCAST);
			cacheConfig.loadCache(cacheParams);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
		
		map.put("result", result);
		return map;
	}
	
	/**
	 * Project 수정 화면
	 * @param model
	 * @return
	 */
	@GetMapping(value = "modify-project.do")
	public String modifyProject(Model model, Long project_id) {
		
		Project project = projectService.getProject(project_id);
		project.setOld_project_key(project.getProject_key());
		
		model.addAttribute("project", project);
		
		return "/data/modify-project";
	}
	
	/**
	 * Project 수정
	 * @param request
	 * @param project
	 * @return
	 */
	@PostMapping(value = "ajax-update-project.do")
	@ResponseBody
	public Map<String, Object> ajaxUpdateProject(HttpServletRequest request, Project project) {
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		try {
			
			UserSession userSession = (UserSession)request.getSession().getAttribute(UserSession.KEY);
			// 사용자 그룹 ROLE 확인
			UserGroupRole userGroupRole = new UserGroupRole();
			userGroupRole.setUser_id(userSession.getUser_id());
			
			if(!GroupRoleHelper.isUserGroupRoleValid(roleService.getListUserGroupRoleByUserId(userGroupRole), UserGroupRole.PROJECT_UPDATE)) {
				log.info("@@ 접근 권한이 없어 실행할 수 없습니다. RoleName = {}",  UserGroupRole.PROJECT_UPDATE);
				map.put("result", "user.group.role.invalid");
				return map;
			}
						
			log.info("@@ project = {} ", project);
			if(project.getProject_id() == null || project.getProject_id().longValue() == 0l
					|| project.getProject_name() == null || "".equals(project.getProject_name())) {
				
				result = "input.invalid";
				map.put("result", result);
				return map;
			}
			
			projectService.updateProject(project);
			
			CacheParams cacheParams = new CacheParams();
			cacheParams.setCacheName(CacheName.PROJECT);
			cacheParams.setCacheType(CacheType.BROADCAST);
			cacheConfig.loadCache(cacheParams);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
		
		map.put("result", result);
		return map;
	}
	
	/**
	 * Project 삭제
	 * @param request
	 * @param project_id
	 * @param model
	 * @return
	 */
	@PostMapping(value = "ajax-delete-project.do")
	@ResponseBody
	public Map<String, Object> ajaxDeleteProject(HttpServletRequest request, Long project_id) {
		log.info("@@@@@@@ project_id = {}", project_id);
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		try {
			if(project_id == null || project_id.longValue() <=0) {
				map.put("result", "project.project_id.empty");
				return map;
			}
			
			UserSession userSession = (UserSession)request.getSession().getAttribute(UserSession.KEY);
			// 사용자 그룹 ROLE 확인
			UserGroupRole userGroupRole = new UserGroupRole();
			userGroupRole.setUser_id(userSession.getUser_id());
			
			// TODO get 방식으로 권한 오류를 넘겨준다.
			if(!GroupRoleHelper.isUserGroupRoleValid(roleService.getListUserGroupRoleByUserId(userGroupRole), UserGroupRole.PROJECT_DELETE)) {
				log.info("@@ 접근 권한이 없어 실행할 수 없습니다. RoleName = {}",  UserGroupRole.PROJECT_DELETE);
				map.put("result", "user.group.role.invalid");
				return map;
			}
	
			projectService.deleteProject(project_id);
				
			CacheParams cacheParams = new CacheParams();
			cacheParams.setCacheName(CacheName.PROJECT);
			cacheParams.setCacheType(CacheType.BROADCAST);
			cacheConfig.loadCache(cacheParams);
		} catch(Exception e) {
			e.printStackTrace();
			map.put("result", "db.exception");
		}
		
		map.put("result", result	);
		return map;
	}
	
//	/**
//	 * Project 삭제
//	 * @param request
//	 * @param project
//	 * @return
//	 */
//	@GetMapping(value = "delete-project.do")
//	public String deleteProject(HttpServletRequest request, @RequestParam("project_id")String project_id) {
//
//		log.info("@@ project_id = {} ", project_id);
//
//		UserSession userSession = (UserSession)request.getSession().getAttribute(UserSession.KEY);
//		// 사용자 그룹 ROLE 확인
//		UserGroupRole userGroupRole = new UserGroupRole();
//		userGroupRole.setUser_id(userSession.getUser_id());
//		
//		// TODO get 방식으로 권한 오류를 넘겨준다.
//		if(!GroupRoleHelper.isUserGroupRoleValid(roleService.getListUserGroupRoleByUserId(userGroupRole), UserGroupRole.PROJECT_DELETE)) {
//			log.info("@@ 접근 권한이 없어 실행할 수 없습니다. RoleName = {}",  UserGroupRole.PROJECT_DELETE);
//			return "redirect:/data/list-project.do";
//		}
//
//		projectService.deleteProject(Long.valueOf(project_id));
//			
//		CacheParams cacheParams = new CacheParams();
//		cacheParams.setCacheName(CacheName.PROJECT);
//		cacheParams.setCacheType(CacheType.BROADCAST);
//		cacheConfig.loadCache(cacheParams);
//	
//		return "redirect:/data/list-project.do";
//	}
}
