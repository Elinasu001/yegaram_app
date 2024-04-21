<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
var selAcctType = "";
var accountAuthCmsYn = "";	// CMS계좌 인증여부
var accountAuthRcvYn = "";	// 출금계좌 인증여부
var ${reqDs.id}_Func = ({
	// 닫기  
	close : function(){},
	// 취소 (그만하기)
	cancel : function(){},
	// 확인 (처리 완료 버튼, 또는 처리완료 선택)
	confirm : function(result){
		// 레이어 업무 선택 및 입력 완료 처리 
		${reqDs.id}_Func.callback(result);
	},
	// 호출 화면 콜백 처리	
	callback : function(){
		
	},
	
	/*********************
	* 계좌 예금주 조회
	**********************/
	checkAccount : function(acctType){
		selAcctType = acctType;
		
		if(${reqDs.id}_Func.checkInput(selAcctType)){
			var selBkcd = $('#'+selAcctType+'_BANK_CD').val();
			var selBknm = $('#'+selAcctType+'_BANK_NM').text();
			var selAcno = $('#'+selAcctType+'_ACCT_NO').val();
			
			$("#BANK_CD").val(selBkcd);
			$("#ACCT_NO").val(selAcno);
			
			// TODO 엔트리 응답지연 (개발기 계좌없음) 으로 인한 테스트 코드 추가
			/*
			progressBar(true);
			setTimeout(function(){
				progressBar(false);	
				biz.acnoAuthConfirm(${reqDs.id}_Func.isAcctChkCallback, selBkcd, selBknm, selAcno);
			}, 3000);*/
			
			doAction("ACNO_AUTH",$("#${reqDs.id}_frm"), function(res){
				var respCd = res.APP_HEADER.respCd;
				var respMsg = res.APP_HEADER.respMsg;
				if(respCd == "N00000"){
					// 예금주 일치
					if(res.RES_CODE == "1000" && res.NAME_MATCH_YN == "Y"){
						biz.acnoAuthConfirm(${reqDs.id}_Func.isAcctChkCallback, selBkcd, selBknm, selAcno);			
					} else {
						biz.alert("입력하신 정보로 계좌를 찾을 수가 없어요. 은행과 계좌번호를 확인해주세요.","확인",function(){
							inputFocus($('#'+selAcctType+'_BANK_NM'));
						});
					}

				}else{
					biz.alert("처리 중 오류가 발생했습니다.[" + respMsg + "]","확인");
				}
			});
			
		}
	}

	/*********************
	* 계좌인증 완료
	**********************/
	, isAcctChkCallback : function(data){
		
		if("Y" == data){
			if(selAcctType == 'RCV'){
				accountAuthRcvYn = true;
			}else{
				accountAuthCmsYn = true;
			}
		}
		
		acnoAuthNextBtn();
	}
	
	/*********************
	* valid      
	**********************/
	, chkValid : function(){
		
		// 유효성체크
		if (!finalValidChk('${reqDs.id}')) return false;
		
		//송금계좌 인증여부 체크
		if(!accountAuthRcvYn){
			biz.alert("대출금이 입금될 계좌를 인증해주세요.","확인", function () {
				inputFocus($('#RCV_BANK_NM'));
			});
			return; 
		}
		   
		//CMS계좌 인증여부 체크
		if(!accountAuthCmsYn){
			biz.alert("이자등이 출금될 계좌를 인증해주세요.","확인", function () {
				inputFocus($('#CMS_BANK_NM'));
			});
			return; 
		}   
		
		${reqDs.id }_Func.nextStep();
	}
	   
	
	/*********************
	* 다음스텝
	**********************/     
	, nextStep : function(){
		var acnoAuthParam = {
			succYn : "Y"
			,RCV_BANK_CD : $("#RCV_BANK_CD").val()
			,RCV_BANK_NM : $("#RCV_BANK_NM").text()
			,RCV_ACCT_NO : $("#RCV_ACCT_NO").val()
			,CMS_BANK_CD : $("#CMS_BANK_CD").val()
			,CMS_BANK_NM : $("#CMS_BANK_NM").text()
			,CMS_ACCT_NO : $("#CMS_ACCT_NO").val()
		}
		${reqDs.id }_Func.confirm(acnoAuthParam);	
	}
	
	/*********************
	* 계좌 인증 valid
	**********************/
	, checkInput : function(selAcctType){
		var result = true;
		var acctTarget="";
		
		if(selAcctType == 'RCV'){
			acctTarget = '송금';
		}else{
			acctTarget = 'CMS';
		}
		if(UtilFunc.isNull($('#'+selAcctType+'_BANK_CD').val())){
			biz.alert(acctTarget+" 은행을 선택해주세요.","확인", function () {
				inputFocus($('#'+selAcctType+'_BANK_NM'));

			});
			result = false; 
		} else 
		if(UtilFunc.isNull($('#'+selAcctType+'_ACCT_NO').val())){
			biz.alert(acctTarget+" 계좌번호를 입력해주세요.","확인", function () {
				inputFocus($('#'+selAcctType+'_ACCT_NO'));
			});
			
			result = false; 
		} else 
		
		//기업은행 평생계좌 체크
		if($('#'+selAcctType+'_BANK_CD option:selected').val() == 'C008300003'
			&& !UtilFunc.isMobileNumChk( $('#'+selAcctType+'_ACCT_NO').val() )){
				hideSplash();
				biz.alert("평생계좌(핸드폰 번호로 구성)는 계좌 조회서비스의 이용이 불가하오니, 일반 계좌번호를 이용하여 주시기 바랍니다.","확인");
				result = false;
		}
		
		return result;
	}
            
});

$(function(){
	//라벨 이벤트
	dynamicInput();
	
	/*********************
	* 송금, CMS 계좌 - 타행계좌 동일 선택
	**********************/
	$('#CMS_ACCT_SET').click(function(){
		if(this.checked) {
      
			if(${reqDs.id}_Func.checkInput("RCV")){
				$("#CMS_BANK_NM").text($("#RCV_BANK_NM").text());
				$("#CMS_BANK_CD").val($("#RCV_BANK_CD").val());
				$("#CMS_ACCT_NO").val($("#RCV_ACCT_NO").val());
				$("#div_CMS_BANK_NM").addClass("on");
				$("label[for='CMS_ACCT_NO']").addClass("action");
				removeErr();
				validChk('${reqDs.id}');
				
				accountAuthCmsYn = true;
			} else {
				$("#CMS_BANK_NM").text("미선택");
				$("#CMS_BANK_CD").val("");
				$("#CMS_ACCT_NO").val("");
				$("#div_CMS_BANK_NM").removeClass("on");
				
				$(this).prop("checked",false);
				accountAuthCmsYn = false;
			}
			
		} else {
			$("#CMS_BANK_NM").text("미선택");
			$("#CMS_BANK_CD").val("");
			$("#CMS_ACCT_NO").val("");
			$("#div_CMS_BANK_NM").removeClass("on");
			
			$(this).prop("checked",false);
			accountAuthCmsYn = false;
		}
		
		acnoAuthNextBtn();
	});
});

// 다음버튼 활성화
function acnoAuthNextBtn() {
	if(accountAuthRcvYn && accountAuthCmsYn) {
		$("#${reqDs.id}_nextBtn").removeClass("disabled");
	} else {
		$("#${reqDs.id}_nextBtn").addClass("disabled");
	}
}

// 입금은행 선택 후 선택값 세팅
function srchRcvBankCallback(data){//type, val, name, code
	$("#RCV_BANK_NM").text(data.BKNM); //송금계좌 은행명
	$("#RCV_BANK_CD").val(data.BKCD); //송금계좌 은행코드
	$("#div_RCV_BANK_NM").addClass("on");
 	inputFocus($("#RCV_ACCT_NO"));
	validChk('${reqDs.id}');
}

// 출금은행 선택 후 선택값 세팅
function srchCmsBankCallback(data){
	$("#CMS_BANK_NM").text(data.BKNM); //CMS계좌 은행명
	$("#CMS_BANK_CD").val(data.BKCD);  //CMS계좌 은행코드
	$("#div_CMS_BANK_NM").addClass("on");
	inputFocus($("#CMS_ACCT_NO"));
	validChk('${reqDs.id}');
}

// 계좌 입력값 체크
function keyupVal(type) {
	if($('#CMS_ACCT_SET').prop('checked')){
		if($('#RCV_ACCT_NO').val() != $('#CMS_ACCT_NO').val()){
			$('#CMS_ACCT_SET').prop('checked', false);
		}				
	}
	
	if (this.value == "") {
		var labelObj = $("label[for='"+type+"_BANK_NM']");
		labelObj.removeClass("action");
	}
}

</script>

	<!-- s: 2023-06-12 재추가, 계좌인증 클릭 시 인증번호 팝업(#bankAccountNum) 노출 -->
	
<div class="content-wrap">
	<div class="pop-header">
		<h2 class="pop-title">${reqDs.title }</h2>
		<button type="button" name="button" class="btn-layer-close" onclick="javascript:${reqDs.id}_Func.close();">닫기</button>
	</div>
	<div class="pop-con-wrap">
		<form id="${reqDs.id}_frm" name="${reqDs.id}_frm" method="post">
		<input type="hidden" name="BANK_CD" id="BANK_CD"> 
		<input type="hidden" name="ACCT_NO" id="ACCT_NO"> 
		
		<div class="default-wrap"><!-- [퍼블] 클래스 변경 -->

			<div class="tit-wrap"><!-- [퍼블] 클래스 변경 -->
				<p class="txt"><strong>타행본인계좌인증</strong>을<br>같이 진행할게요</p>
			</div>

			<!-- s: 대출금 입금 계좌 정보 -->
			<div class="bank-input-warp">
				<!-- <p class="s-txt">대출금이 입금될 계좌정보를 입력해주세요</p> [퍼블] 삭제 -->
				<div class="form-wrap">
					<!-- <label for="ipt03" class="formlabel onbasic">은행</label> 2023-06-15 삭제 -->
					<div class="select-wrap" id="div_RCV_BANK_NM"><!-- 2023-06-15 클래스 type2 추가 -->
						<div class="select-box" tabindex="1" onclick="removeErr(this); biz.bank(srchRcvBankCallback);">
							<label for="RCV_BANK_CD">은행</label><!-- 2023-06-16 구조 추가 -->
							<span class="option" id="RCV_BANK_NM">미선택</span>
						</div>
						<input type="hidden" class="${reqDs.id}_validChk" name="RCV_BANK_CD" id="RCV_BANK_CD" value=""/>
					</div>
					<p class="error-txt">은행을 선택하세요</p>
				</div>
				<div class="form-wrap form-line mt0"><!-- 2023-06-15 클래스 mt0 추가 -->
					<label for="RCV_ACCT_NO" class="formlabel onbasic">계좌번호</label>
					<div class="input">
						<input type="tel" title="계좌번호" id="RCV_ACCT_NO" class="inp ${reqDs.id}_validChk" name="RCV_ACCT_NO" value="" placeholder="계좌번호을 입력해주세요" numberOnly pattern="[0-9]*" oninput="UtilFunc.inputMaxLength(this);" onkeyup="removeErr(this); validChk('${reqDs.id}'); keyupVal('RCV');" onclick="removeErr(this);" onchange="validChk('${reqDs.id}');" maxlength="20" required="">
						<button type="button" class="btn-certi" id="RCV_ACCT_NO_BTN" onclick="${reqDs.id}_Func.checkAccount('RCV');" >계좌인증</button>
					</div>
					<p class="error-txt">계좌번호를 입력해주세요</p>
				</div>
				<p class="info-txt">타행 본인인증계좌도 동시에 진행돼요</p>
			</div>
			<!-- e: 대출금 입금 계좌 정보 -->

			<!-- s: 이자 등 출금 계좌 정보 -->
			<div class="bank-input-warp">
				<!-- <p class="s-txt">이자 등이 출금될 계좌정보를 입력해주세요</p> [퍼블] 삭제 -->
				<div class="check-account"><!-- [퍼블] 클래스 변경 -->
					<input type="checkbox" id="CMS_ACCT_SET" name="check" value="">
					<label for="CMS_ACCT_SET">
						<span>계좌 같이 사용하기</span>
					</label>
				</div>

				<div class="form-wrap">
					<!-- <label for="ipt03" class="formlabel onbasic">은행</label> 2023-06-15 삭제 -->
					<div class="select-wrap" id="div_CMS_BANK_NM"><!-- 2023-06-15 클래스 type2 추가 -->
						<div class="select-box" tabindex="1" onclick="removeErr(this); biz.bank(srchCmsBankCallback);">
							<label for="CMS_BANK_CD">은행</label><!-- 2023-06-16 구조 추가 -->
							<span class="option" id="CMS_BANK_NM">미선택</span>
						</div>
						<input type="hidden" class="${reqDs.id}_validChk" name="CMS_BANK_CD" id="CMS_BANK_CD" value=""/>
					</div>
					<p class="error-txt">은행을 선택하세요</p>
				</div>
				<div class="form-wrap form-line mt0"><!-- 2023-06-15 클래스 mt0 추가 -->
					<label for="CMS_ACCT_NO" class="formlabel onbasic">계좌번호</label>
					<div class="input">
						<input type="tel" title="계좌번호" id="CMS_ACCT_NO" class="inp ${reqDs.id}_validChk" name="CMS_ACCT_NO" value="" placeholder="계좌번호을 입력해주세요" pattern="[0-9]*" oninput="UtilFunc.inputMaxLength(this);" onkeyup="removeErr(this); validChk('${reqDs.id}'); keyupVal('RCV');" onclick="removeErr(this);" onchange="validChk('${reqDs.id}');" maxlength="20" numberOnly required="">
						<button type="button" class="btn-certi" id="CMS_ACCT_NO_BTN" onclick="${reqDs.id}_Func.checkAccount('CMS');">계좌인증</button>
					</div>
					<p class="error-txt">계좌번호를 입력해주세요</p>
				</div>
				<p class="info-txt">이자등이 자동이체될 계좌(CMS계좌정보)를 입력해주세요</p>
			</div>

			<!-- s: 2023-06-14 버튼영역 수정 후 위치이동 -->
			<!--<div class="fixed-btn-wrap">
				<div class="btn-wrap">
					<a href="#none" class="btn disabled">다음</a>
				</div>
			</div>-->
			<!-- e: 2023-06-14 버튼영역 수정 후 위치이동 -->
			<!-- e: 이자 등 출금 계좌 정보 -->
		</div>
		</form>
	</div>
	<div class="fixed-btn-wrap">
           <div class="btn-wrap">
               <a href="#none" class="btn disabled" id="${reqDs.id}_procBtn" onclick="${reqDs.id}_Func.chkValid();">다음</a>
           </div>
       </div>
</div>
