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
						<div class="main_content_title">
					    	<ul>
					        	<li>스케줄 처리 결과</li>
					        </ul>
					    </div>
						<ul>
							<li style="line-height: 30px;">
				<c:if test="${method_mode eq 'insert'}">등록 되었습니다.</c:if>
				<c:if test="${method_mode eq 'update'}">수정 되었습니다.</c:if>
				<c:if test="${method_mode eq 'delete'}">삭제 되었습니다.</c:if>
					  		</li>
				<c:if test="${method_mode eq 'insert' || method_mode eq 'update'}">
					  		<li style="line-height: 30px;">
					  			<span style="display:inline-block; width: 200px;">스케줄명</span>
					 			<span>${schedule.name}</span>
					  		</li>
					  		<li style="line-height: 30px;">
					  			<span style="display:inline-block; width: 200px;">시스템 그룹 고유키</span>
					 			<span>${schedule.system_group_id}</span>
					  		</li>
					  		<li style="line-height: 30px;">
					  			<span style="display:inline-block; width: 200px;">계정 그룹 고유키</span>
					 			<span>${schedule.account_group_id}</span>
					  		</li>
					  		<li style="line-height: 30px;">
					  			<span style="display:inline-block; width: 200px;">스케줄 실행 Quartz 표현식</span>
					 			<span>${schedule.expression}</span>
					  		</li>
					  		<li style="line-height: 30px;">
					  			<span style="display:inline-block; width: 200px;">시작 시간 yyyymmddhh24miss</span>
					 			<span>${schedule.start_date}</span>
					  		</li>
					  		<li style="line-height: 30px;">
					  			<span style="display:inline-block; width: 200px;">종료 시간 yyyymmddhh24miss</span>
					 			<span>${schedule.end_date}</span>
					  		</li>
					  		<li style="line-height: 30px;">
					  			<span style="display:inline-block; width: 200px;">설명</span>
					 			<span>${schedule.description}</span>
					  		</li>
					  		<li style="line-height: 30px;">
					  			<span style="display:inline-block; width: 200px;">등록자 아이디</span>
					 			<span>${schedule.user_id}</span>
					  		</li>
					  		<li style="line-height: 30px;">
					  			<span style="display:inline-block; width: 200px;">실행 주체</span>
					 			<span>${schedule.execute_server}</span>
					  		</li>
					  		<li style="line-height: 30px;">
					  			<span style="display:inline-block; width: 200px;">사용유무</span>
					 			<span>${schedule.use_yn}</span>
					  		</li>
					  		<li style="line-height: 30px;">
					  			<span style="display:inline-block; width: 200px;">등록일</span>
					 			<span>${schedule.viewRegisterDate}</span>
					  		</li>
				</c:if>
					  		<li style="text-align: center;">
					  			<a href="/schedule/list-schedule.do">목록</a>
					  		</li>
					 	</ul>
			 	
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
		
	});
</script>
</body>
</html>