<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- // s : 전체메뉴 -->
<div id="menuWrap" class="menuWrap">
	<div class="all-menu-wrap">
		<div class="all-menu-header">
			<div class="all-menu-info">
				<c:if test="${empty SS_LOGIN.LOGIN_YN }">
				<a href="#none"	onclick="javascript:biz.login(function(res){doReload();});"><span><b>로그인</b></span> &gt;</a>
				</c:if>
				
				<c:if test="${!empty SS_LOGIN.LOGIN_YN }">
				<!-- D : 로그인 시 노출 -->
				<a href="#none"><span><b>${SS_LOGIN.CUST_NM }</b>님</span> 반가워요!</a>
				<!-- D : 로그인 시 노출 // -->
				</c:if>
				
				<ul>
					<li><a onclick="" class="btn-home">홈으로</a></li>
					<li><a onclick="doActionMenu('usr/mng/usrChng','USR_INFO_MNG');" class="btn-mypage">마이페이지</a></li>
					<li><a onclick="doActionMenu('etc/mng/envMng');" class="btn-option">설정</a></li>
					<li><a class="btn-menu-close">닫기</a></li>
				</ul>
			</div>
			<ul class="top-menu">
				<c:forEach var="item" items="${resDs.REC }">
					<c:if test="${item.UPPER_CODE eq 'TOP'}">
						<c:if test="${empty item.URI and item.DISP_YN eq 'Y'}">
							<li><a href="#none" onclick="openPopup('${item.CODE}_Pop');">${item.NAME }</a></li>
						</c:if>
						<c:if test="${not empty item.URI and item.DISP_YN eq 'Y'}">
							<li><a href="#none" onclick="doActionMenu('${item.URI}','${item.LINK_TARGET }');">${item.NAME }</a></li>
						</c:if>
					</c:if>
				</c:forEach>
			</ul>
			<button type="button" class="btn-allopen" onclick="openPopup('all-menu-view');">메뉴펼쳐보기</button>
		</div>
		<div class="all-menu-area">
			<div class="menuDepth1">
				<ul>
					<c:forEach var="item" items="${resDs.REC }" varStatus="status">
						<c:if test="${item.UPPER_CODE eq 'ROOT'}">
							<li <c:if test="${status.first}">class="on"</c:if>>
							<a href="#none" data-focus="${item.CODE }">${item.NAME }</a>
							</li>
						</c:if>
					</c:forEach>
				</ul>
			</div>
			<div class="menuDepth2">
				<c:set var="TEMP_CODE" value="" />
				<c:forEach var="item" items="${resDs.REC }" varStatus="status">
					<c:if test="${item.UPPER_CODE eq 'ROOT'}">
						<c:if test="${TEMP_CODE ne item.CODE }">
							<ul class="${item.CODE } <c:if test='${empty TEMP_CODE}'>on </c:if>">
								<c:set var='TEMP_CODE' value='${item.CODE }'/>
								
								<c:forEach var="i" items="${resDs.REC }">
									<c:if test="${TEMP_CODE eq i.UPPER_CODE and i.DISP_YN eq 'Y'}">
										<li><a href="#" onclick="javascript:doActionMenu('${i.URI}','${i.LINK_TARGET }');">${i.NAME }</a></li>
									</c:if>	
								</c:forEach>
							</ul>	
						</c:if>
					</c:if>
				</c:forEach>
			</div>
		</div>
	</div>
</div>
<!-- e : 전체메뉴 // -->
					
<!-- // s : 메뉴 펼쳐보기 팝업 -->
<div id="all-menu-view" class="layerpopup laypop-all" tabindex="0" data-focus-prev="btn-menu-close">
	<div class="pop-header none-bor">
		<h2 class="pop-title">전체메뉴</h2>
		<button type="button" name="button" class="btn-layer-close" onclick="closePopup('all-menu-view')">닫기</button>
	</div>
	<div class="pop-con-wrap">
		<div class="search-wrap">
			<div class="search-area">
				<div class="form-wrap">
					<div class="input">
						<input type="search" title="" id="MENU_SEARCH_TEXT" class="" name="" value="" placeholder="검색어를 입력하세요." required=""/>
					</div>
					<button type="button" class="btn-search" onclick="javascript:fnMenuSearch();">검색</button>
					<button type="button" class="btn-delete">검색어 삭제</button>
				</div>
			</div>
			<ul class="tab-slidemenu">
				<c:forEach var="item" items="${resDs.REC }" varStatus="status">
					<c:if test="${item.UPPER_CODE eq 'TOP' or item.UPPER_CODE eq 'ROOT'}">
						<c:if test="${empty item.URI and item.DISP_YN eq 'Y'}">
							<li <c:if test="${status.first}">class="on"</c:if>><a href="#none" data-focus="${item.CODE}">${item.NAME }</a></li>
						</c:if>
					</c:if>
				</c:forEach>
			</ul>
		</div>
		
		<div class="listmenu-box" id="MENU_SEARCH_AREA">
			
			<div class="result-area nodata" id="jobSearchNoData" style="display:block"> <!-- [퍼블] ㅗ싀추가 -->
				<p lass="desc">일치하는 검색 결과가 없어요</p>
			</div>

			<c:forEach var="item" items="${resDs.REC }" varStatus="status">
				<c:if test="${item.UPPER_CODE eq 'ROOT' or item.UPPER_CODE eq 'TOP'}">
					<c:if test="${TEMP_CODE ne item.CODE and item.URI eq '' and item.DISP_YN eq 'Y'}">
						<ul id="${item.CODE }">
							<li class="tit">${item.NAME }</li>
							<c:set var='TEMP_CODE' value='${item.CODE }'/>
							
							<c:forEach var="i" items="${resDs.REC }">
								<c:if test="${TEMP_CODE eq i.UPPER_CODE}">
									<c:if test="${not empty i.URI and i.DISP_YN eq 'Y'}">
										<li><a href="#" onclick="javascript:doActionMenu('${i.URI}','${i.LINK_TARGET }');">${i.NAME }</a></li>
									</c:if>
									<c:if test="${empty i.URI and i.DISP_YN eq 'Y'}">
										<li>
											<span>${i.NAME }</span>
											<ul>
											<c:forEach var="di" items="${resDs.REC }">
												<c:if test="${di.UPPER_CODE eq i.CODE and di.DISP_YN eq 'Y'}">
													<li><a href="#none" onclick="javascript:doActionMenu('${di.URI}','${di.LINK_TARGET }');">${di.NAME }</a></li>
												</c:if>
											</c:forEach>
											</ul>
										</li>
									</c:if>
								</c:if>	
							</c:forEach>
						</ul>	
					</c:if>
				</c:if>
			</c:forEach>
		</div>
	</div>
</div>
<!-- e : 메뉴 펼쳐보기 팝업 // -->

<c:forEach var="item" items="${resDs.REC }">
	<c:if test="${item.UPPER_CODE eq 'TOP' and item.URI eq ''}">
		<div id="${item.CODE }_Pop" class="layerpopup laypop-all" tabindex="0" data-focus-prev="btn-menu-close">
			<div class="pop-header">
				<h2 class="pop-title">${item.NAME }</h2>
				<button type="button" name="button" class="btn-layer-close" onclick="closePopup('${item.CODE }_Pop');">닫기</button>
			</div>
			<div class="pop-con-wrap">
				<div class="default-wrap"> <!-- [퍼블] mt40 제거-->
					<p class="gnb-tit">${item.ABBR }</p>
					<div class="listmenu-box">
						<ul>
							<c:forEach var="i" items="${resDs.REC }">
								<c:if test="${item.CODE eq i.UPPER_CODE }">
									<c:if test="${not empty i.URI and i.DISP_YN eq 'Y'}">
										<li><a href="#" onclick="javascript:doActionMenu('${i.URI}','${i.LINK_TARGET }');">${i.NAME }</a></li>
									</c:if>
									<c:if test="${empty i.URI and i.DISP_YN eq 'Y'}">
										<li>
											<span>${i.NAME }</span>
											<ul>
											<c:forEach var="di" items="${resDs.REC }">
												<c:if test="${di.UPPER_CODE eq i.CODE and di.DISP_YN eq 'Y'}">
													<li><a href="#none" onclick="javascript:doActionMenu('${di.URI}','${di.LINK_TARGET }');">${di.NAME }</a></li>
												</c:if>
											</c:forEach>
											</ul>
										</li>
									</c:if>
								</c:if>
							</c:forEach>
						</ul>
					</div>
				</div>
					<!-- //e: 검색 결과 영역 -->
			</div>
		</div>
	</c:if>
</c:forEach>

<script>
function fnMenuSearch() {
	var liTag = $("#MENU_SEARCH_AREA").find('li');
	var searchText = $("#MENU_SEARCH_TEXT").val(); 
	$.each(liTag, function(idx, item){
		var temp = $(item).find("a")[0];
		var checkHtml = $(temp).html()+"";
		if (checkHtml.indexOf(searchText) > -1) {
			$(this).show();
		} else {
			$(this).hide();
		}
	});
}


// 전체메뉴 스크립트 depth1
$('.all-menu-area .menuDepth1 li').click(function(){
	var menuOn = $(this).children('a').attr('data-focus');
	$(this).addClass('on').siblings().removeClass('on');
	$('.all-menu-area .menuDepth2 .' + menuOn + '').addClass('on').siblings().removeClass('on');
});

// 메뉴 펼쳐보기 스크립트 <!-- [퍼블] 스크립트 수정 -->
$('.tab-slidemenu li').click(function(){
	var currMenu = $(this).children('a').attr('data-focus');
	var currMenuOffset = $('#' + currMenu + '').offset().top + $('.listmenu-box').scrollTop() - 192;

	$(this).addClass("on").siblings().removeClass("on");
	$('.listmenu-box').animate({ scrollTop : currMenuOffset }, 300);
	$(".tab-slidemenu").animate({ scrollLeft : $(this).offset().left + $(".tab-slidemenu").scrollLeft() - 20 });
});

// 전체메뉴 open
function openMenu(id){
	var t = $('#' + id);
	var currentTop = $(window).scrollTop();
	t.animate({ left : 0 });
	$('body').addClass('on');
	$('body').css({ 'position' : 'fixed', 'top' : -currentTop });
	t.find('.btn-menu-close').click(function(){
		closeMenu(id);
		$('body').removeAttr('style').removeClass('on');
		$(window).scrollTop(currentTop);
	});
}

// 전체메뉴 close
function closeMenu(){
	$('.menuWrap').animate({ left:'100%' });
}
</script>
<!-- [퍼블] 스타일 삭제-->