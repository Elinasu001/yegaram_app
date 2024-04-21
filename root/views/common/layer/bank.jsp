<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
var BANK_HTML_TEMP = '<li class="bank_#VALUE#"><a href="#none" onclick="javascript:${reqDs.id}_Func.confirm(#VALUE2#, #NAME#);">#NAME2#</a></li>';
var ${reqDs.id}_Func = ({
	// 닫기  
	close : function(){},
	// 취소 (그만하기)
	cancel : function(){},
	// 확인 (처리 완료 버튼, 또는 처리완료 선택)
	confirm : function(bkcd, bknm){
		var resJson = {
		  	 BKCD: bkcd
			,BKNM: bknm	
		};
		// 레이어 업무 선택 및 입력 완료 처리 
		${reqDs.id}_Func.callback(resJson);
	},
	// 호출 화면 콜백 처리	
	callback : function(){},
	
	//은행사 증권사 탭처리
	changeTab : function(obj){
		// 컨텐츠
		$(".tab-content").addClass("dp-none");
		$("#"+$(obj).data("tab")).removeClass("dp-none");
		
		// 탭
		$(".bankTab").removeClass("on");
		$(obj).addClass("on");
	},
	
	//은행검색
	searchBank : function(){
		
		var bankSearchForm = makeForm("bankSearchForm");
		addFormData(bankSearchForm, "upperCode", "C008300000");
		addFormData(bankSearchForm, "keyword", $("#keyword").val());
		doAction("CODE_SELECT", bankSearchForm, function(resJson){
			if (resJson.record.length > 0) /*검색결과 있을경우*/{
				
				//퍼블요소 추가
				$(".tabs-wrap").addClass("vs-hidden");
				$("#searchUl").addClass("active");
				$("#searchUl").empty();
				
				//은행리스트 출력
				var searchHtml = "";
				$.each(resJson.record, function(i,v){
					var tempbank = BANK_HTML_TEMP;
					tempbank = tempbank.replace("#VALUE#", v.VALUE);
					tempbank = tempbank.replace("#VALUE2#", "'" + v.VALUE + "'");
					tempbank = tempbank.replace("#NAME#", "'" + v.NAME + "'");
					tempbank = tempbank.replace("#NAME2#", v.NAME);
					searchHtml += tempbank;
				});
				$("#searchUl").html(searchHtml);
				
			} else /*검색결과 없을경우*/{
				
				//퍼블요소 추가
				$(".tabs-wrap").removeClass("vs-hidden");
				$("#searchUl").removeClass("active");	
			}
			
		},false);
	},
	
	//검색어 삭제
	delSearch : function(){
		//퍼블요소 추가
		$(".tabs-wrap").removeClass("vs-hidden");
		$("#searchUl").removeClass("active");	
		
		$("#keyword").val("");
	}
});

</script>
<div class="content-wrap banklistWrap">
            <div class="pop-header"><h2 class="pop-title">${reqDs.title }</h2></div><!-- [퍼블] 태그 수정 : span ==> h2.pop-title -->
            <button type="button" name="button" class="btn-layer-close" data-focus="btn-layer-close" onclick="javascript:${reqDs.id}_Func.close();">닫기</button>
            <div class="ly-scroll-con type-high non-scroll"><!-- [D] type-high 추가 시 높게 올라오는 case -->
                <!-- s: 검색 영역 -->
				<div class="search-area type-box"><!-- [퍼블] 클래스 변경 -->
					<div class="form-wrap">
						<div class="input">
							<input type="search" title="" id="keyword" class="" name="keyword" value="" placeholder="은행검색" required="" onkeyup="${reqDs.id}_Func.searchBank();">
						</div>
						<button type="button" class="btn-search" onclick="${reqDs.id}_Func.searchBank();">검색</button>
						<button type="button" class="btn-delete" onclick="javascript:${reqDs.id}_Func.delSearch();">검색어 삭제</button>
						
						<ul class="bank_list" id="searchUl"><!-- D: 클래스 active 추가시 .bank_list 영역 노출 -->
							<li class="sb"><a href="#none">sb저축은행</a></li>
						</ul>
					</div>
				</div>

				<!-- // e: 검색 영역 -->
				<section class="tabs-wrap">
					<div class="tabs">
						<ul class="tab-item">
							<li class="bankTab on" data-tab="tab-cont01" onclick="javascript:${reqDs.id}_Func.changeTab(this)"><a href="#none" title="선택됨">은행</a></li><!-- [퍼블] 텍스트 변경 -->
							<li data-tab="tab-cont02" class="bankTab" onclick="javascript:${reqDs.id}_Func.changeTab(this)"><a href="#none">증권사</a></li>
						</ul>
						<div class="scroll-area">
							<div id="tab-cont01" class="tab-content">
								<ul class="bank_list col2">
									<c:forEach var="item" items="${resDs.record }">
										<c:if test="${!item.VALUE.startsWith('2')}">
										<li class="bank_${item.VALUE }"><a href="#none" onclick="javascript:${reqDs.id}_Func.confirm('${item.VALUE }', '${item.NAME }');">${item.NAME }</a></li>
										</c:if>
									</c:forEach>
								</ul>
							</div>
							<div id="tab-cont02" class="tab-content dp-none">
								<ul class="bank_list col2">
								<c:forEach var="item" items="${resDs.record }">
									<c:if test="${item.VALUE.startsWith('2')}">
										<li class="bank_${item.VALUE }"><a href="#none" onclick="javascript:${reqDs.id}_Func.confirm('${item.VALUE }', '${item.NAME }');">${item.NAME }</a></li>
									</c:if>
								</c:forEach>
								</ul>
							</div>
						</div>
					</div>
				</section>

            </div>
        </div>