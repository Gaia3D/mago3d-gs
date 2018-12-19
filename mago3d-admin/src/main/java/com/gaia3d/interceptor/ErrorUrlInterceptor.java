package com.gaia3d.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import lombok.extern.slf4j.Slf4j;

/**
 * 보안 관련 체크 인터셉터
 * @author jeongdae
 *
 */
@Slf4j
@Component
public class ErrorUrlInterceptor extends HandlerInterceptorAdapter {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

    	String uri = request.getRequestURI();
    	log.info("-------------- ErrorUrlInterceptor Requst uri = {}", uri);
    	
    	if(uri.indexOf(".do") >= 0) {
    		log.info("## 확장자가 .do");
    		return true;
    	} else {
    		log.info("## 확장자가 do 아니어서 error 로 보냄 ");
    		response.sendRedirect("/error");
    		return false;
    	}
    }
}
