<%@page import="co.gnbsoftec.common.util.StringUtils"%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
var ${reqDs.id}_Func = ({
	// 닫기  
	close : function(){},
	// 취소 (그만하기)
	cancel : function(){},
	// 확인 (처리 완료 버튼, 또는 처리완료 선택)
	confirm : function(){
		var email = $("#${reqDs.id}_email_pop").val();
		
		if(PageValidate.isNotEmail(email)){
			biz.alert("이메일 형식이 올바르지 않습니다.");
			
		} else {			
			// 레이어 업무 선택 및 입력 완료 처리 
			${reqDs.id}_Func.callback(email);
		}
		
	},
	// 호출 화면 콜백 처리	
	callback : function(){}
});

// 이메일포맷에 아이디 세팅
function emailFormat(str){
	if (str.indexOf("@") != -1) {
		if (!$(".email-list").hasClass("active")) $(".email-list").addClass("active");
		var id = str.split("@")[0];
		$(".inputId").text(id);
		
	} else {
		if ($(".email-list").hasClass("active")) $(".email-list").removeClass("active");
	}
}

// 이메일포맷 클릭시 인풋에 선택값 세팅
function setEmail(obj){
	$(".email-list").removeClass("active");
	$("#${reqDs.id}_email_pop").val($(obj).text());
}

// 이메일입력 인풋 초기화
function resetEmail(){
	$("#${reqDs.id}_email_pop").val("");
}

</script>
<div class="content-wrap">
	<div class="pop-header">
		<h2 class="pop-title">이메일 주소를 입력해주세요</h2>
		<button type="button" name="button" class="btn-layer-close" data-focus="btn-layer-close">닫기</button>
	</div>

	<div class="default-wrap"><!-- D: 2023-06-16 .ly-scroll-con 영역을 클래스 default-wrap 으로 수정 -->
		<div class="txtbox-wrap">
			<p>서명이 완료되면 전자계약서를 입력한 이메일로 보내 드릴게요</p><!-- [퍼블] 텍스트 변경 / 해당 텍스트 노출 안할시 div.txtbox-wrap 자체 주석처리 가능할까요? -->
		</div><!-- [퍼블] div.txtbox-wrap 닫힘태그 이동 -->
		<div class="form-wrap type-box"><!-- [퍼블] 클래스 변경 -->
			<div class="input">
				<input type="text" id="${reqDs.id}_email_pop" class="inp" pattern=".+@\." onkeyup="emailFormat(this.value);" placeholder="이메일 주소를 입력해 주세요" name value required><!-- [퍼블] placeholder 값 변경 -->
			</div>
			<button type="button" class="btn-delete" onclick="resetEmail();">검색어 삭제</button>

			<p class="error-txt">이메일을 입력해주세요</p>
		</div>
		<!--  [퍼블] div.form-wrap 바깥으로 위치이동 -->
		<ul class="email-list"><!-- D: 클래스 active로 제어 -->
			<li><a href="#none" onclick="setEmail(this);"><span class="inputId"></span>@gmail.com</a></li>
			<li><a href="#none" onclick="setEmail(this);"><span class="inputId"></span>@naver.com</a></li>
			<li><a href="#none" onclick="setEmail(this);"><span class="inputId"></span>@nate.com</a></li>
			<li><a href="#none" onclick="setEmail(this);"><span class="inputId"></span>@daum.net</a></li>
			<li><a href="#none" onclick="setEmail(this);"><span class="inputId"></span>@nate.com</a></li>
		</ul>
		<!--  // [퍼블] div.form-wrap 바깥으로 위치이동 -->
	</div>

	<div class="fixed-btn-wrap">
		<div class="btn-wrap type-popup">
			<a href="#none" class="btn"  id="${reqDs.id}_nextBtn" onclick="javascript:${reqDs.id}_Func.confirm();">확인</a>
		</div>
	</div>
</div>