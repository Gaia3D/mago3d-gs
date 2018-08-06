<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="./externlib/jquery/jquery.js"></script>
<style type="text/css">
	.default-layout {
		width: 100%; min-width: 1420px; max-width: 1920px; margin: 0;
	}
	
	.left-navigation-layout {
		float:left; min-width:70px; min-height:500px;
	}
	.left-navigation-icons {
		float:left; width: 70px;
	}
	.menu-header {
		height: 70px;
	}
	.left-navigation-detail {
		margin-left: 70px; width: 220px;
	}
	.submenu-header {
		height: 70px;
	}
	
	.content-layout {
		margin-left: 220px; min-height:500px; overflow: hidden; background-color: #edf1f5;
	}
	.content-header {
		height: 70px;
		background-color: #4f5466;
	}
	
	#submenu-log {
		float: left;
	}
	
	.content-gnb {
		height: 70px;
		background-color: #ffffff;
	}
	.content-detail {
		margin: 10px;
		min-height: 450px;
		background-color: #ffffff;
	}
	.site-footer {
		height: 40px;
		vertical-align: center;
		padding: 15px 0px 0px 20px;
		background-color: #ffffff;
	}
</style>
</head>
<body>

<div class="default-layout">
	<div class="left-navigation-layout">
		<div class="left-navigation-icons">
			<div class="menu-header">
				<div id="menu-prefix" style="float: right; padding-right:10px; padding-top: 10px;"><img alt="Logo" src="/images/ko/logo_prefix.png" /></div>
			</div>
			<div>
				<div style="height: 90px;" ></div>
				<div style="height: 80px; text-align: center;" ><img alt="Logo" width="40px;" src="/images/ko/test.png" /></div>
				<div style="height: 80px; text-align: center;" ><img alt="Logo" width="40px;" src="/images/ko/test.png" /></div>
				<div style="height: 80px; text-align: center;" ><img alt="Logo" width="40px;" src="/images/ko/test.png" /></div>
				<div style="height: 80px; text-align: center;" ><img alt="Logo" width="40px;" src="/images/ko/test.png" /></div>
				<div style="height: 80px; text-align: center;" ><img alt="Logo" width="40px;" src="/images/ko/test.png" /></div>
			</div>
		</div>
		<div class="left-navigation-detail">
			<div class="submenu-header">
				<div id="menu-surfix" style="float: left; padding-top: 10px;"><img alt="Logo" src="/images/ko/logo_surfix.png" /></div>
			</div>
			<div>
				<div style="height: 30px;" ></div>
				<div style="height: 30px;" >Profile</div>
				<div style="height: 30px;" ></div>
				<div style="padding-left: 20px;" >
					<div style="height: 40px;">프로젝트 목록</div>
					<div style="height: 40px;">프로젝트 등록</div>
				</div>
				<div style="padding-left: 20px;" >
					<div style="height: 40px;">데이터 목록</div>
					<div style="height: 40px;">데이터 변경 요청 목록</div>
				</div>
				<div style="padding-left: 20px;" >
					<div style="height: 40px;">파일 업로딩</div>
					<div style="height: 40px;">업로딩한 파일 목록</div>
					<div style="height: 40px;">Converter 실행 결과</div>
					<div style="height: 40px;">F4D 파일 목록</div>
				</div>
				<div style="padding-left: 20px;" >
					<div style="height: 40px;">기본 설정</div>
					<div style="height: 40px;">mago3D 설정</div>
				</div>
			</div>
		</div>
	</div>
	<div class="content-layout">
		<div class="content-header">
			<div id="submenu-log">
				<a href="#" onclick="toggleMenu();">
					<img alt="Logo" src="/images/ko/menu-toogle.png" width="40px;" height="37px;" style="padding-top: 15px; padding-left: 20px;" />
				</a>
			</div>
			<div style="float: right; padding-top: 20px; padding-right: 50px; color: #ffffff;">도움말 | 로그아웃</div>
		</div>
		<div>
			<div class="content-gnb"></div>
			<div class="content-detail"></div>
			<div class="site-footer">Mago3D ⓒ Gaia3d Corp. All Rights Reserved</div>
		</div>
	</div>
</div>

<script type="text/javascript">
	var menu_status = 0;
	$(document).ready(function() {
		
	});
	
	function toggleMenu() {
		if(menu_status == 0) {
			$(".left-navigation-detail").css("display", "none");  
			$(".content-layout").css({"margin-left" : "70px"});
			menu_status = 1;
		} else {
			$(".left-navigation-detail").css("display", "");  
			//$("#contentArea").css({"margin-left" : "70px"});	
			menu_status = 0;
		}
	}
</script>
</body>
</html>
