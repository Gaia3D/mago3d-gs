package com.gaia3d.controller;

import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gaia3d.domain.CacheManager;
import com.gaia3d.domain.Issue;
import com.gaia3d.domain.Policy;
import com.gaia3d.util.DateUtil;
import com.gaia3d.util.FormatUtil;
import com.gaia3d.util.StringUtil;

import lombok.extern.slf4j.Slf4j;

/**
 * 메인
 * @author jeongdae
 *
 */
@Slf4j
@Controller
@RequestMapping("/main/")
public class MainController {
	
	/**
	 * 사용자 메인 페이지에서 Issue 조회
	 * @param model
	 * @return
	 *
	 */	
	@RequestMapping(value = "index.do")
	public String index(HttpServletRequest request, Model model) {
		Policy policy = CacheManager.getPolicy();
		boolean isActive = true;
		String today = DateUtil.getToday(FormatUtil.VIEW_YEAR_MONTH_DAY_TIME);
		
		model.addAttribute("today", today);
		model.addAttribute("widgetInterval", policy.getContent_main_widget_interval());
		return "/main/index";
	}
	
	private String getSearchParameters(Issue issue) {
		StringBuilder builder = new StringBuilder(100);
		builder.append("&");
		builder.append("search_word=" + StringUtil.getDefaultValue(issue.getSearch_word()));
		builder.append("&");
		try {
			builder.append("search_value=" + URLEncoder.encode(StringUtil.getDefaultValue(issue.getSearch_value()), "UTF-8"));
		} catch(Exception e) {
			e.printStackTrace();
			builder.append("search_value=");
		}
		builder.append("&");
		builder.append("start_date=" + StringUtil.getDefaultValue(issue.getStart_date()));
		builder.append("&");
		builder.append("end_date=" + StringUtil.getDefaultValue(issue.getEnd_date()));
		return builder.toString();
	}
}
