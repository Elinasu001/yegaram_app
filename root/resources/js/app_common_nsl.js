/**
 * 자동 공통 JS
 */

$(function() {
	/*
	* 인풋박스 입력 제한 기능 
	*/
	// 숫자만 입력 numberOnly
	$("input[numberOnly]").on("keyup", function() {
		$(this).val($(this).val().replace(/[^0-9]/g, ""));
	});
	// 한글 입력 불가 noHangeul
	$("input[noHangeul]").on("keyup", function() {
		$(this).val($(this).val().replace(/[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, ""));
	});
	// 영문, 숫자만 입력 onlyAlpNum
	$("input[onlyAlpNum]").on("keyup", function() {
		// 한글 입력 불가
		$(this).val($(this).val().replace(/[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, ""));
		// 특수문자 입력 불가
		$(this).val($(this).val().replace(/[~?!@#\#$%^&*\()\=+,;:`"'\\]/g, ""));
	});
	// 영문만 입력 alphaOnly
	$("input[alphaOnly]").on("keyup", function() {
		$(this).val($(this).val().replace(/[^a-z\s]/gi, ""));		
	});
	
	// 대문자 영문, 숫자만 입력 onlyUpAlpNum
	$("input[onlyUpAlpNum]").on("keyup", function() {
		// 한글 입력 불가
		$(this).val($(this).val().replace(/[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, ""));
		// 특수문자 입력 불가
		$(this).val($(this).val().replace(/[~!@#\#$%^&*\()\-=+_']/g, ""));
		// 대문자불가
		$(this).val($(this).val().replace(/[A-Z]/g, ""));
	});
	
	// 한글만입력 hangeulOnly
	$("input[hangeulOnly]").on("keyup", function() {
		$(this).val($(this).val().replace(/[a-z0-9]|[ \[\]{}()<>?|`~!@#$%^&*-_+=,.;:\"'\\]/g, ""));
	});	
	
    $( "#telno2" ).on("keyup", function(){
      if(this.value.length>=4){
          $( "#telno3" ).focus();
          return false;
      }
    });
    
    $( "#a_telno2" ).on("keyup", function(){
      if(this.value.length>=4){
          $( "#a_telno3" ).focus();
          return false;
      }
    });
    
    $( "#p_telno2" ).on("keyup", function(){
      if(this.value.length>=4){
          $( "#p_telno3" ).focus();
          return false;
      }
    });
    $( "#telNo2" ).on("keyup", function(){
      if(this.value.length>=4){
          $( "#telNo3" ).focus();
          return false;
      }
    });
    
    $( "#a_telNo2" ).on("keyup", function(){
      if(this.value.length>=4){
          $( "#a_telNo3" ).focus();
          return false;
      }
    });
    
    $( "#p_telNo2" ).on("keyup", function(){
      if(this.value.length>=4){
          $( "#p_telNo3" ).focus();
          return false;
      }
    });
	
});


/**
 * android 인지 IOS인지 판단하기
 * return pc : pc
 * return and : android
 * return ios : iphone
 *  */
var getOsType = (function() {
	var s = navigator.userAgent.toLowerCase();
	
	var filter = "win16|win32|win64|mac";
	var result = false;

	if( navigator.platform  ){
		if( filter.indexOf(navigator.platform.toLowerCase())<0 ){
		//("모바일 기기에서 접속");
			if(s.indexOf('android') > -1) {
				result= "and";
			}else if(s.indexOf('iphone') > -1){
				result = "ios";
			}
		}else{
			//("PC에서 접속");
			result = "pc";
		}
	}
	//console.log('getOsType >>', result);
	return result;
});

//델피노 오류 코드 정리
var appDelfinoErr = ({
		"ERR_9210" : { cd : "9210", msg : "입력 파라미터가 올바르지 않습니다."}
		,"ERR_9220" : { cd : "9220", msg : "공동인증서 비밀번호 입력이 취소되었습니다."}
		,"ERR_9290" : { cd : "9290", msg : "오류가 발생했습니다.\n확인 후 다시 시도해주세요."}
		,"ERR_9291" : { cd : "9100", msg : "사용 가능한 공동인증서가 없습니다.\n공동인증서 가져오기를 통해 공동인증서를 등록 후 이용해주세요."}
});

// 세이프토큰 오류 코드 정리 패턴 
var safetokenErr = ({
	 "PATTERN_ERROR_STORE_CREDENTIAL"		:	{cd : "-10000" , msg : "패턴 인증 정보 저장에 실패했습니다."				}
	,"PATTERN_ERROR_ENCRYPT_CREDENTIAL"		:	{cd : "-10001" , msg : "패턴 인증 정보 암호화에 실패했습니다."				}
	,"PATTERN_ERROR_NOT_EXIST_CREDENTIAL"	:	{cd : "-10002" , msg : "패턴 인증으로 이용하려는 토큰에 패턴연동을 하지않았습니다."	}
	,"PATTERN_ERROR_AUTHENTICATION"			:	{cd : "-10003" , msg : "패턴 인증에 실패 했습니다."						}
	,"PATTERN_ERROR_GENERATE_SIGN"			:	{cd : "-10004" , msg : "패턴 인증 정보로 전자서명에 실패했습니다."			}
	,"PATTERN_ERROR_LOAD_CREDENTIAL"		:	{cd : "-10005" , msg : "패턴 인증 정보 로딩에 실패했습니다."				}
	,"PATTERN_ERROR_REMOVE_CREDENTIAL"		:	{cd : "-10006" , msg : "패턴 인증 정보 삭제에 실패했습니다."				}
	
	,"BIOMETRIC_ERROR_CANCELED"				:	{cd : "20001" , msg : "생체인증실패가많아일시적으로사용이중지되었습니다.잠시후다시시도하세요."	}
	,"BIOMETRIC_ERROR_HW_NOT_PRESENT"		:	{cd : "20002" , msg : "생체인증을지우원하지않는기기입니다."							}
	,"BIOMETRIC_ERROR_HW_UNAVAILABLE"		:	{cd : "20003" , msg : "생체인증장치를사용할수없습니다.잠시후다시시도하세요."				}
	,"BIOMETRIC_ERROR_LOCKOUT"				:	{cd : "20005" , msg : "생체인증실패가많아일시적으로사용이중지되었습니다.잠시후다시시도하세요."	}
	,"BIOMETRIC_ERROR_LOCKOUT_PERMANENT"	:	{cd : "20006" , msg : "생체인증실패가많아생체인증을사용할수없습니다.잠금화면해제후사용가능합니다."	}
	,"BIOMETRIC_ERROR_NO_BIOMETRICS"		:	{cd : "20007" , msg : "생체정보가등록되어있지않습니다.등록후이용하세요."					}
});

//공동인증서 이동 오류코드
var appCertRelayErr=({
    "ERR_9310" : { cd : "9310", msg : "입력 파라미터가 올바르지 않습니다."}
    ,"ERR_9320" : { cd : "9320", msg : "공동인증서 이동이 취소되었습니다."}
    ,"ERR_9391" : { cd : "9391", msg : "공동인증서가 존재하지 않습니다."}
    ,"ERR_9390" : { cd : "9390", msg : "공동인증서 가져오기에 실패하였습니다."}
    ,"ERR_9399" : { cd : "9399", msg : "오류가 발생했습니다.\n확인 후 다시 시도해주세요."}
});
//스크래핑 오류 코드
var appScrapErr = ({
		"ERR_9510" : { cd : "9510", msg : "입력 파라미터가 올바르지 않습니다."}
		,"ERR_9590" : { cd : "9590", msg : "주소 검색 시 오류가 발생하였습니다."}
		,"ERR_9591" : { cd : "9591", msg : "스크래핑 문서 결과가 없습니다."}
});
//OCR 오류 코드
var appOcrErr = ({
    "ERR_9490": {cd: "9490", msg: "서류첨부를 위해 사진 및 카래라롤 접근이 필요합니다.\n*[설정 어플리케이션 > 사진 및 카메라]에서 접근을 허용해주세요."}
    ,"ERR_9420": {cd: "9420", msg: "서류첨부가 취소되었습니다."}
});



/**
 * 스크래핑 용 주소  
 **/
var addrJusoListData = 
[
	 {"시도":"서울특별시", "시군구": ["강남구","강동구","강북구","강서구","관악구","광진구","구로구","금천구","노원구","도봉구","동대문구","동작구","마포구","서대문구","서초구","성동구","성북구","송파구","양천구","영등포구","용산구","은평구","종로구","중구","중랑구"]}
	,{"시도":"부산광역시" ,"시군구": ["강서구","금정구","기장군","남구","동구","동래구","부산진구","북구","사상구","사하구","서구","수영구","연제구","영도구","중구","해운대구"]}
	,{"시도":"대구광역시", "시군구":["남구","달서구","달성군","동구","북구","서구","수성구","중구"]}
	,{"시도":"인천광역시", "시군구": ["강화군","계양구","남동구","동구","미추홀구","부평구","서구","연수구","옹진군","중구"]}
	,{"시도":"광주광역시", "시군구": ["광산구","남구","동구","북구","서구"]}
	,{"시도":"대전광역시", "시군구": ["대덕구","동구","서구","유성구","중구"]}
	,{"시도":"울산광역시", "시군구": ["남구","동구","북구","울주군","중구"]}
	,{"시도":"경기도", "시군구": ["가평군","고양시","과천시","광명시","광주시","구리시","군포시","김포시","남양주시","동두천시","부천시","성남시","수원시","시흥시","안산시","안성시","안양시","양주시","양평군","여주시","연천군","오산시","용인시","의왕시","의정부시","이천시","파주시","평택시","포천시","하남시","화성시"]}
	,{"시군구": ["강릉시","고성군","동해시","삼척시","속초시","양구군","양양군","영월군","원주시","인제군","정선군","철원군","춘천시","태백시","평창군","홍천군","화천군","횡성군"],"시도":"강원도"}
	,{"시도":"충청북도", "시군구": ["괴산군","단양군","보은군","영동군","옥천군","음성군","제천시","증평군","진천군","청주시","충주시"]}
	,{"시도":"충청남도", "시군구": ["계룡시","공주시","금산군","논산시","당진시","보령시","부여군","서산시","서천군","아산시","예산군","천안시","청양군","태안군","홍성군"]}
	,{"시도":"전라북도", "시군구":["고창군","군산시","김제시","남원시","무주군","부안군","순창군","완주군","익산시","임실군","장수군","전주시","정읍시","진안군"]}
	,{"시도":"전라남도", "시군구": ["강진군","고흥군","곡성군","광양시","구례군","나주시","담양군","목포시","무안군","보성군","순천시","신안군","여수시","영광군","영암군","완도군","장성군","장흥군","진도군","함평군","해남군","화순군"]}
	,{"시도":"경상북도", "시군구": ["경산시","경주시","고령군","구미시","군위군","김천시","문경시","봉화군","상주시","성주군","안동시","영덕군","영양군","영주시","영천시","예천군","울릉군","울진군","의성군","청도군","청송군","칠곡군","포항시"]}
	,{"시도":"경상남도", "시군구": ["거제시","거창군","고성군","김해시","남해군","밀양시","사천시","산청군","양산시","의령군","진주시","창녕군","창원시","통영시","하동군","함안군","함양군","합천군"]}
	,{"시도":"제주특별자치도", "시군구": ["서귀포시","제주시"]}
	,{"시도":"세종특별자치시","시군구": ["세종특별자치시"]}
];
/**
 * 스크래핑 용 주소 (변경 전) 
 **/
var addrJusoListData_org = [
	{"시도":"서울특별시","시군구":["강남구","강동구","강북구","강서구","관악구","광진구","구로구","금천구","노원구","도봉구","동대문구","동작구","마포구","서대문구","서초구","성동구","성북구","송파구","양천구","영등포구","용산구","은평구","종로구","중구","중랑구"]},
	{"시도":"부산광역시","시군구":["강서구","금정구","기장군","남구","동구","동래구","부산진구","북구","사상구","사하구","서구","수영구","연제구","영도구","중구","해운대구"]},
	{"시도":"대구광역시","시군구":["남구","달서구","달성군","동구","북구","서구","수성구","중구"]},
	{"시도":"인천광역시","시군구":["강화군","계양구","남구","남동구","동구","부평구","서구","연수구","옹진군","중구"]},
	{"시도":"광주광역시","시군구":["광산구","남구","동구","북구","서구"]},
	{"시도":"대전광역시","시군구":["대덕구","동구","서구","유성구","중구"]},
	{"시도":"울산광역시","시군구":["남구","동구","북구","울주군","중구"]},
	{"시도":"세종특별자치시","시군구":[]},
	{"시도":"경기도","시군구":["가평군","고양시 덕양구","고양시 일산동구","고양시 일산서구","과천시","광명시","광주시","구리시","군포시","김포시","남양주시","동두천시","부천시","성남시 분당구","성남시 수정구","성남시 중원구","수원시 권선구","수원시 영통구","수원시 장안구","수원시 팔달구","시흥시","안산시 단원구","안산시 상록구","안성시","안양시 동안구","안양시 만안구","양주시","양평군","여주시","연천군","오산시","용인시 기흥구","용인시 수지구","용인시 처인구","의왕시","의정부시","이천시","파주시","평택시","포천시","하남시","화성시"]},
	{"시도":"강원도","시군구":["강릉시","고성군","동해시","삼척시","속초시","양구군","양양군","영월군","원주시","인제군","정선군","철원군","춘천시","태백시","평창군","홍천군","화천군","횡성군"]},
	{"시도":"충청북도","시군구":["괴산군","단양군","보은군","영동군","옥천군","음성군","제천시","증평군","진천군","청주시 상당구","청주시 서원구","청주시 흥덕구","청주시 청원구","충주시"]},
	{"시도":"충청남도","시군구":["계룡시","공주시","금산군","논산시","당진시","보령시","부여군","서산시","서천군","아산시","예산군","천안시 동남구","천안시 서북구","청양군","태안군","홍성군"]},
	{"시도":"전라북도","시군구":["고창군","군산시","김제시","남원시","무주군","부안군","순창군","완주군","익산시","임실군","장수군","전주시 덕진구","전주시 완산구","정읍시","진안군"]},
	{"시도":"전라남도","시군구":["강진군","고흥군","곡성군","광양시","구례군","나주시","담양군","목포시","무안군","보성군","순천시","신안군","여수시","영광군","영암군","완도군","장성군","장흥군","진도군","함평군","해남군","화순군"]},
	{"시도":"경상북도","시군구":["경산시","경주시","고령군","구미시","군위군","김천시","문경시","봉화군","상주시","성주군","안동시","영덕군","영양군","영주시","영천시","예천군","울릉군","울진군","의성군","청도군","청송군","칠곡군","포항시 남구","포항시 북구"]},
	{"시도":"경상남도","시군구":["거제시","거창군","고성군","김해시","남해군","밀양시","사천시","산청군","양산시","의령군","진주시","창녕군","창원시 마산합포구","창원시 마산회원구","창원시 성산구","창원시 의창구","창원시 진해구","통영시","하동군","함안군","함양군","합천군"]},
	{"시도":"제주특별자치도","시군구":["서귀포시","제주시"]}
];


var certAllowList =
    ['1.2.410.200005.1.1.1' //금결원, 개인, 상호연동
        , '1.2.410.200005.1.1.5' //금결원, 법인, 상호연동
        , '1.2.410.200004.5.1.1.5' //코스콤, 개인, 상호연동
        , '1.2.410.200004.5.1.1.7' //코스콤, 법인, 상호연동
        , '1.2.410.200004.5.2.1.2' //정보인증, 개인, 상호연동
        , '1.2.410.200004.5.2.1.1' //정보인증, 법인, 상호연동
        , '1.2.410.200004.5.4.1.1' //전자인증, 개인, 상호연동
        , '1.2.410.200004.5.4.1.2' //전자인증, 법인, 상호연동
        , '1.2.410.200012.1.1.1' //무역정보, 개인, 상호연동
        , '1.2.410.200012.1.1.3' //무역정보, 법인, 상호연동
        , '1.2.410.200005.1.1.4' //금결원, 개인, 용도제한(은행/보험/카드/민원)
        , '1.2.410.200005.1.1.2' //금결원, 법인, 용도제한(은행/보험/카드/민원)
        , '1.2.410.200005.1.1.6.1']; //금결원, 법인, 용도제한(기업뱅킹)


function jobJoinDayUpdate() {
	   
	if($('#job_join_day').is(':visible')) {
	    	 var value = $('#job_join_day').val();
	    	 var job_period = '';
	    	 if(value.length == 8 && new Date([value.substr(0, 4), value.substr(4, 2), value.substr(6)].join('-')) != 'Invalid Date') {
	    	 var current = new Date();
	    	 var inputYear = value.substr(0, 4);
	    	 var inputMonth = value.substr(4, 2);
	    	 var months = (current.getFullYear() - Number(inputYear)) * 12 + (current.getMonth() + 1) - Number(inputMonth) + 1;
	    	 job_period = months < 0 ? 0 : months;
	    	 }
	    	 $('#job_period').val(job_period);
	}
}

/**
 * 자동대출 전용
 * 연도, 월, 일 셋팅
 * @param cnt  : 연도를 가져올 범위 설정
 * @param id
 * @returns 
 */
function setYearMonthNon(cnt) {
	var currentYear = UtilFunc.getCurrentDttm().substring(0,4);
	var currentMonth = UtilFunc.getCurrentDttm().substring(4,6);
	var lastDay = new Date(currentYear, currentMonth, 0).getDate();

	if(UtilFunc.isNull(cnt)){
		cnt = new Number(10);  
	}
	var year = $("#job_join_day1");
	$(year).empty();
    $(year).append("<option value='' selected='selected'>-선택-</option>");
	var strYear = new Number(currentYear)+1;
	for(var i = 0; i<Number(cnt); i++){
		strYear = strYear-1;
         $(year).append("<option value='" + strYear + "'>" + strYear + "년</option>");
    }
	var mon = $("#job_join_day2");
	$(mon).empty();
	$(mon).append("<option value=''selected='selected'>-선택-</option>");
	for(var i = 1; i<Number(13); i++){
		var strMon = i;
		if(i<10) strMon = '0'+i;  
		$(mon).append("<option value='" + strMon + "'>" + strMon + "월</option>");
	}
	//일
	var day = $("#job_join_day3");
	$(day).empty();
	$(day).append("<option value='' selected='selected'>-선택-</option>");
	for (var i = 1; i < Number(lastDay+1); i++) {
		var strDay = i;
		if(i<10) strDay = "0" + strDay;	
		$(day).append("<option value='" + strDay + "'>" + strDay + "일 </option>");
	}
}


/**
 * 연도, 월, 일 셋팅
 * @param cnt  : 연도를 가져올 범위 설정
 * @param id
 * @returns
 */
 function setYearMonth(cnt) {
	var currentYear = UtilFunc.getCurrentDttm().substring(0,4);
	var currentMonth = UtilFunc.getCurrentDttm().substring(4,6);
	var lastDay = new Date(currentYear, currentMonth, 0).getDate();


	if(UtilFunc.isNull(cnt)){
		cnt = new Number(10);
	}
	var year = $("#job_join_day1");
	$(year).empty();
	var strYear = new Number(currentYear)+1;
	for(var i = 0; i<Number(cnt); i++){
		strYear = strYear-1;
    $(year).append("<option value='" + strYear + "'>" + strYear + "년</option>");
    }
	var mon = $("#job_join_day2");
	$(mon).empty();
	$(mon).append("<option value=''>-선택-</option>");
	for(var i = 1; i<Number(13); i++){
		var strMon = i;
		if(i<10) strMon = '0'+i;
		$(mon).append("<option value='" + strMon + "'>" + strMon + "월</option>");
	}
	//일
	var day = $("#job_join_day3");
	$(day).empty();
	$(day).append("<option value=''>-선택-</option>");
	for (var i = 1; i < Number(lastDay+1); i++) {
		var strDay = i;
		if(i<10) strDay = "0" + strDay;	
		$(day).append("<option value='" + strDay + "'>" + strDay + "일 </option>");
	}
}

/**
 * 일자설정
 * @param year
 * @param month
 * @returns
 */
function setDay( year , month) {
	
	var lastDay = new Date(year, month, 0).getDate()+1;

	var day = $("#job_join_day3");
	$(day).empty();
	
	for (var i = 1; i < Number(lastDay); i++) {
		var strDay = i;
		if(i<10) strDay = "0" + strDay;	
		$(day).append("<option value='" + strDay + "'>" + strDay + "일 </option>");
	}
}

/**
 * 월 변경 시 일자 변경
 * @returns
 */
function fnChgMonth(){
	console.log('입사일 변경');
	var year = $("#job_join_day1").val();
	var month = $("#job_join_day2").val();
	console.log('year>>', year);
	console.log('month>>', month);
	if( !UtilFunc.isNull(year) && !UtilFunc.isNull(month)){
		setDay(year, month);
	}
}
//입사월 변경 시 keyup
$("#job_join_day2").keyup(function(e){
	$("#job_join_day2").trigger('change');
});


/**
 * 연도, 월, 일 셋팅 
 * 온라인햇살론 연월일 선택값
 * @param cnt  : 연도를 가져올 범위 설정
 * @param id
 * @returns
 */
function setYearMonth2(cnt) {
	var currentYear = UtilFunc.getCurrentDttm().substring(0,4);
	var currentMonth = UtilFunc.getCurrentDttm().substring(4,6);
	var lastDay = new Date(currentYear, currentMonth, 0).getDate();

	if(UtilFunc.isNull(cnt)){
		cnt = new Number(10);
	}
	var year = $("#job_join_day1");
	$(year).empty();
	var strYear = new Number(currentYear)+1;
	$(year).append("<option value=''>선택하세요</option>");
	
	for(var i = 0; i<Number(cnt); i++){
		strYear = strYear-1;
		$(year).append("<option value='" + strYear + "'>" + strYear + "년</option>");
	}
	
	var mon = $("#job_join_day2");
	$(mon).empty();
	$(mon).append("<option value=''>선택하세요</option>");
	
	for(var i = 1; i<Number(13); i++){
		var strMon = i;
		if(i<10) strMon = '0'+i;
		$(mon).append("<option value='" + strMon + "'>" + strMon + "월</option>");
	}
}


/**
 * 전화번호 파싱
 * @returns
 */
function getTelNo(telNo){
	
	if(UtilFunc.isNull(telNo)) return;
	
	var tel3 = telNo.substr(telNo.length-4);
	var midIdx = telNo.indexOf(tel3);
	var tel1 = ''; 
	var tel2 ='';
	if(telNo.startsWith('02')){
		//서울
		tel1 = telNo.substr(0,2);
		tel2 = telNo.substring(2,midIdx);
	}else{
		//지방
		tel1 = telNo.substr(0,3);
		tel2 = telNo.substring(3,midIdx);
	}
	console.log(tel1+tel2+tel3);
    return [tel1, tel2, tel3];	
}

//[공통] 통신 오류 발생 시 메시지
function ajax_error(res, code){
	hideSplash();
	hideSplash();	
	if (code == 9901) { //세션에러가 발생하면
		window.location= '/error/sessionError.ysb?E=9901';
		return;
	}
	if (code == 9902) { //세션 중복에러가 발생하면
		window.location= '/error/sessionError.ysb?E=9902';
		return;
	}	
	if (code == 9903) { //비정상접근 에러가 발생하면
		window.location= '/error/sessionError.ysb?E=9903';
		return;
	}
	if (code == 9904) { //비정상접근 에러가 발생하면
		window.location= '/error/sessionError.ysb?E=9904';
		return;
	}	
	
	customAlert({title:"알림", message:"서비스중 오류가 발생하였습니다.\n잠시 후 다시 시도해 주세요.", btn_txt1:"닫기"}, ''
    	, function(){
			return false;	
    	}
    );
	return false;	
}

function bizErrorAlert(result) {
	customAlert({
		title : '알림 ',
		code : result.resultCode,
		message : result.resultMsg,
		btn_txt1 : "확인"
	});
}
/**
오류알림 후 이동 url:확인, url2:취소
*/
function bizErrorMoveAlert(result, url, url2) {
	customAlert({
		title : '알림 ',
		code : result.resultCode,
		message : result.resultMsg,
		type: 'confirm',
		btn_txt1: "취소", 
		btn_txt2: "확인"
	}, function () {
       	$(location).attr("href", url);
     }, function () {
    	 if(url2 != 'undefined'){
    		 $(location).attr("href", url2);
    	 }
     });
}

function stopToMainAlert() {
	if($("#customAlertLayer").is(':visible')){
		$('#customAlertLayer .c-cancle').trigger('click');
	}
	
	customAlert({
        title: "알림",
        message: "중단하시겠습니까? \n중단하시면 메인으로 이동합니다.",
        type: 'confirm',
        btn_txt1: "취소",
        btn_txt2: "확인"
     }, 
     function () {
    	 commonMoveUrl('move',"/main.ysb");
     }, function () {

 	}
);
}

function stopToFirstAlert(url) {
	if($("#customAlertLayer").is(':visible')){
		$('#customAlertLayer .c-cancle').trigger('click');
	}
	
	customAlert({
        title: "알림",
        message: "중단하시겠습니까? \n중단하시면 처음으로 이동합니다.",
        type: 'confirm',
        btn_txt1: "취소",
        btn_txt2: "확인"
     }, 
     function () {
      	commonMoveUrl('move',url);
     }, function () {

 	}
);
}

var customAlertShow = false;
/**
 * customAlert
 * @param _option.title : 제목
 * @param _option.message : 내용
 * @param _option.type : confirm or anything
 * @param _option.btn_txt1 : 버튼명
 * @param _option.btn_txt2 : 버튼명
 * @param _callback1 : 확인버튼
 * @param _callback1 : 취소버튼
 * @return
 *
 */
function customAlert(_option,_callback1,_callback2){

	if (!customAlertShow) {
		customAlertShow = true;		
	} else {
		return;
	}
    var _html = "";
    _html += "<div id=\"customAlertLayer\" class=\"custom-alert-layer\">";
    _html +=     "<p class=\"title\">"+_option.title+"</p>";
    _html +=     "<p class=\"message\">";
    if(_option.code != "undefined" && _option.code != null && "000" != _option.code && "500" != _option.code) {
    	_html +=     "["+_option.code+"]";
    }
    _html +=     _option.message+"</p>";
    _html +=     "<div class=\"btn-wrap flex-con\">";
    if(_option.type == "confirm"){
        if(typeof _option.btn_txt1 != "undefined"){
            _html +=         "<button type=\"button\" name=\"button\" class=\"col1 btn md darkgray c-cancle\">"+_option.btn_txt1+"</button>";
        }else{
            _html +=         "<button type=\"button\" name=\"button\" class=\"col1 btn md darkgray c-cancle\">취소</button>";
        }
        if(typeof _option.btn_txt2 != "undefined"){
            _html +=         "<button type=\"button\" name=\"button\" class=\"col2 btn md gray active c-confirm\">"+_option.btn_txt2+"</button>";
        }else{
            _html +=         "<button type=\"button\" name=\"button\" class=\"col2 btn md gray active c-confirm\">확인</button>";
        }
    }else{
        if(typeof _option.btn_txt1 != "undefined"){
            _html +=         "<button type=\"button\" name=\"button\" class=\"col1 btn md darkgray c-cancle\">"+_option.btn_txt1+"</button>";
        }else if(typeof _option.btn_txt2 != "undefined"){
        	_html +=         "<button type=\"button\" name=\"button\" class=\"col1 btn md gray active c-cancle\">"+_option.btn_txt2+"</button>";
        }
    }

    _html +=     "</div>";
    _html += "</div>";
    $('body').append(_html.replace(/(\n|\r\n)/g, '<br>'));
    // addBlock("fixed");
    layerFunc($('#customAlertLayer'));
    $('#customAlertLayer .c-confirm').on('click',function(){
    	customAlertShow = false;
        if (typeof _callback1 === "function") {
            _callback1();
        }
        customAlertDel();
    });
    $('#customAlertLayer .c-cancle').on('click',function(){
    	customAlertShow = false;
        if (typeof _callback2 === "function") {
            _callback2();
        }
        customAlertDel();
    });
    function customAlertDel(){
    	customAlertShow = false;
        deleteBlock("fixed");
        $('#customAlertLayer').fadeOut().empty().remove();
    }
}

/**
 * 메세지 alert표시후 obj(input box)에 focus 주기 
 */ 
function focusCommonMsg(msg, obj) {
	customAlert({title : "[알림]", message : msg, btn_txt1:"닫기"}, '', 
	    function(){
			if (obj && !obj.is(":disabled") && "readonly" != obj.attr("readonly")) {
				obj.focus();
			}
			return false;	
		}
	);
}

/**
 * 메세지 alert표시
 */ 
function simpleCommonMsg(msg) {
	customAlert({title : "알림 ", message : msg, btn_txt1:"확인"}, '', '');
}

/**
* 중앙정렬 위치
* @param containerSize : 컨테이너의 크기
* @param targetSize : 컨테이너에 들어 있는 오브젝트의 크기
* @return
*/
function getCenterAlignPos( containerSize, targetSize ) {
  var pos = ( containerSize - targetSize ) / 2;
  return pos;
}

/**
 * 해당 포인트를 기준으로 중간에 걸칠경우
 * @param centerPos : 기준선
 * @param targetSize : 오브젝트의 크기
 * @return
 *
 */
function getCenterPos( centerPos, targetSize ) {
  var pos = centerPos - ( targetSize / 2 );
  return pos;
}

/**
 * 랜덤값 간단하게 뽑아오기
 * @param min : 가장 적은값
 * @param max  : 가장 높은값
 * @return
 *
 */
function getRandom( min, max ){
	return Math.floor(Math.random()*(max-min))+min;
}

//스플래시 보여주기
function showSplash(){
	  var num = Math.floor(Math.random() * 2)  + 1;
	  addLoading(num);
}

function addLoading(_num){
	var _num = Math.floor(Math.random() * 2 ) + 1;
	var _html = "";
	_html += "<div id=\"loadingLayer\" class=\"loading-layer\">";
	_html += "</div>";
	if ( $('.loading-layer:visible').length != 0 ){
		hideSplash();
	}
	$('body').append(_html);
	if(_num == 2){
	 $("#loadingLayer").addClass('type2');
	}
	$("#loadingLayer").animateSprite({
	  fps: 5,
	  loop: true,
	  complete: function(){
	  }
	});
	layerOpenFunc($('#loadingLayer'));
	if ( $('.layerpopup:visible').length >= 1 ){
		$('#loadingLayer').prev('.block').css('z-index',30);
	}
}

//스플래시 제거
function hideSplash(){
    $('#loadingLayer').fadeOut().empty().remove();
    if ( $('.layerpopup:visible').length >= 1 ){
      $('.block').eq(0).fadeOut().empty().remove();
    } else {
      deleteBlock();
    }
}
function deleteBlock(){
	  //layerClose
	  //$('#wrap').css({'position':'','top':''});
	  $('.block').trigger('click');

	  $('.block').fadeOut(300);
	  $('.block').detach();
	  $('body, html, #wrap').css({'height':'','overflow':''});
	}

function deleteBlock(_full){
    if(_full == 'fixed'){
        $('.block2').fadeOut(300);
    	$('.block2').remove();
    }else{
        $('.block').fadeOut(300);
    	$('.block').detach();
    }
	$('body, html, #wrap').css({'height':'','overflow':''});
	//$('body').css({'position':'relative','overflow-x':'hidden'}); 2020-07-09 
	$('body').removeAttr('style'); //2020-07-09
    $(window).scrollTop(winScrollTop);//180607추가
}

//레이어팝업 높이 판단하여 block와 position 컨트롤
function layerOpenFunc(_target){
    if(_target.outerHeight() > $(window).height()){
        _target.css({'position':'absolute','top':'50px','left':getCenterAlignPos($(window).width(), _target.outerWidth())});
        addBlock('full');
    }else{
        _target.css({'position':'fixed','top':getCenterAlignPos($(window).height(), _target.outerHeight()),'left':getCenterAlignPos($(window).width(), _target.outerWidth())});
        addBlock();
    }

    /* 약관전체보기 팝업 */
    if ( $('#agreementallLayer:visible').length == 1 ) {
      var ctsTotal = $('#agreementallLayer .con').length;
      var idx = $('#agreementallLayer .con').index();

      $('#agreementallLayer .con').hide();
      $('#agreementallLayer .con').eq(idx-1).show();

      $('.all-agree .total').html(ctsTotal);
      $('.all-agree .view').html(idx);

      $('.ctrl-box button').click(function(){
        if ($(this).hasClass('btn-next')) {
          if (idx < ctsTotal) {
            idx++;
            $('.all-agree .view').html(idx);
            $('#agreementallLayer .con').hide();
            $('#agreementallLayer .con').eq(idx-1).show();
          }
        }else{
          if (idx > 1) {
            idx--;
            $('.all-agree .view').html(idx);
            $('#agreementallLayer .con').hide();
            $('#agreementallLayer .con').eq(idx-1).show();
          }
        }
        idx = idx;
      });
    }

    /* 레이어팝업이 중복으로 뜰때 */
    if ( $('.layerpopup:visible').length > 1 ) {
      $('.block:nth(0)').css('z-index',30);
    }
}

function commonCodeErrorMsg(code, msg) {
	customAlert({title : "알림 [" + code + "]", message : msg, btn_txt1:"닫기"});
}

//메인화면으로 이동
function goMain() {
	commonMoveUrl('move',"/main.ysb");
}

//메인화면으로 이동
function goMainMenu() {
    commonMoveUrl('move',"/main.ysb?MENU_SHOW=Y");
}

//비대면계좌개설 메인화면으로 이동 
function goUntactDepositMain(str) {
	
	customAlert(
		{title:"알림", message:"예적금계좌개설을 취소하시겠습니까?", type:"confirm", btn_txt1:"취소", btn_txt2:"확인"}
		,function(){ 
			if (str == 'list') {
				$(location).attr("href", "/deposit/srchSbUntactDepstProdList.ysb"); 
			}
			else {
				$(location).attr("href", "/deposit/callUntactDepositOpenGuide.ysb"); 
			}
			return; 
		}
		,function(){ return; }
	);
}

/**
 * 알람후 로그인 페이지로 이동
 * @param msg : 표시할 메세지
 * @param afterUrl : 로그인후 이동할 페이지url
 * @returns
 */

function goLoginWithParam(msg, afterUrl) {
	customAlert({
        title: "알림",
        message: msg,
        type: 'confirm',
        btn_txt1: "취소",
        btn_txt2: "확인"
     	}, 
	    function () {
     		if ( typeof afterUrl != 'undefined' && !UtilFunc.isEmpty(afterUrl)) {
     			$(location).attr("href", "/login/login.ysb?AFTER_URL="+afterUrl);
     		} else {
     			$(location).attr("href", "/login/login.ysb");
     		}
     		return;
	    }, 
	    function () {}
	);
}



function moveUrlAction(url) {
	showSplash();
	window.location = url;
}

var subMoveUrl = '';
var nowShowPageName = '';
function commonMoveUrl(type, purl) {

	AjaxFunc.showLoading = true;
	var params = {
		url : purl.split("&")[0]
		, pin : FuncDeviceToken.getIsExistPinCsno()
		, motp : FuncDeviceToken.getIsExistMotpCsno()
		, appAuth : FuncDeviceToken.getIsExistAppAuthCsno()
		, type : type
	}
	
	if (type != 'move') {
		hideSplash();
	}	
	
	AjaxFunc.ajaxAsync(
		'/common/moveUrl.ajax'
		,params
		,function(result) {
			if(result.resultSuccess) {
				if (type == 'move') {
					moveUrlAction(purl);
				} else {
					hideSplash();
				}
 			} else {			
				var p_moveUrl = result.data.moveUrl;
 				var p_cancelUrl = result.data.cancelUrl;
				subMoveUrl = p_moveUrl;
 				if(result.data.actionType=='LOA' || result.data.actionType=='LOB') {
 			        customAlert({
 			            title: "알림",
 			            message: result.data.msg,
 			            type: 'confirm',
 			            btn_txt1: "취소",
 			            btn_txt2: "확인"
 			        }, function () {
	 			   		AjaxFunc.ajaxAsync(
	 			   			'/login/logout.ajax'
	 			   			, ""
	 			   			, function(result){
	 			   				moveUrlAction(p_moveUrl);
	 			   			}
	 			   			, ajax_error
	 			   		)
	 			    }, function () { 
	 			    	if (p_cancelUrl != '') {
	 			    	    //취소처리변경
	 			    		//moveUrlAction(p_cancelUrl);
	 			    	}
	 			    });
 				} else if(result.data.actionType=='LIA') {
 			        customAlert({
 			            title: "알림",
 			            message: result.data.msg,
 			            type: 'confirm',
 			            btn_txt1: "취소",
 			            btn_txt2: "확인"
 			        }, function () {
 			        	$('.menu-close').trigger('click');
 			        	if (nowShowPageName != 'LOGIN') {
 			        		AuthFunc.showAuthAllPopLoginAfterUrl = purl;
 			        		AuthFunc.showAuthSubAllPop(mainSubLoginCallBack);
 			        	}
	 			    }, function () { 
	 			    	if (p_cancelUrl != '') {
	 			    		if (nowShowPageName != 'LOGIN') {//로그인페이지에서는 표시하지 않음
	 			    		    //취소처리변경 
	 			    			//moveUrlAction(p_cancelUrl);
	 			    		}
	 			    	}
	 			    });
 				} else if(result.data.actionType=='LIB') {
 			        customAlert({
 			            title: "알림",
 			            message: result.data.msg,
 			            type: 'confirm',
 			            btn_txt1: "취소",
 			            btn_txt2: "확인"
 			        }, function () {
 			        	$('.menu-close').trigger('click');
 			        	AuthFunc.showAuthAllPopLoginAfterUrl = purl;
 			        	AuthFunc.showAuthAllPop(mainSubLoginCallBack);
	 			    }, function () { 
	 			    	if (p_cancelUrl != '') {
	 			    	    //취소처리변경
	 			    		//moveUrlAction(p_cancelUrl);
	 			    	}
	 			    });
 				} else if(result.data.actionType=='LIC') {
 			        customAlert({
 			            title: "알림",
 			            message: result.data.msg,
 			            type: 'confirm',
 			            btn_txt1: "취소",
 			            btn_txt2: "확인"
 			        }, function () {
 			        	$('.menu-close').trigger('click');
 			        	AuthFunc.showAuthAllPopLoginAfterUrl = purl;
 			        	AuthFunc.showAuthAllPop(mainSubLoginCallBack2);
	 			    }, function () { 
	 			    	if (p_cancelUrl != '') {
	 			    	    //취소처리변경
	 			    		//moveUrlAction(p_cancelUrl);
	 			    	}
	 			    });
 				} else if(result.data.actionType=='NIA') {
 			        customAlert({
 			            title: "알림",
 			            message: result.data.msg,
 			            type: 'confirm',
 			            btn_txt1: "취소",
 			            btn_txt2: "확인"
 			        }, function () {
 			        	moveUrlAction(p_moveUrl);
	 			    }, function () { 
	 			    	if (p_cancelUrl != '') {
	 			    	    //취소처리변경
	 			    		//moveUrlAction(p_cancelUrl);
	 			    	}
	 			    });
 				} else if(result.data.actionType=='NIB' || result.data.actionType=='NIC') {
 			    	customAlert({
 			    		title : '알림 ',
 			    		message : result.data.msg,
 			    		btn_txt1 : "확인"
 			    	}, function () {
 			        }, function () {
 			        	moveUrlAction(p_moveUrl);
 			        });
 				}  else if(result.data.actionType=='A1' || result.data.actionType=='A2' || result.data.actionType=='A3' || result.data.actionType=='A4' || result.data.actionType=='A5' || result.data.actionType=='A6'|| result.data.actionType=='A10' || result.data.actionType=='A11') {
 					customAlert({
 			            title: "알림",
 			            message: result.data.msg,
 			            type: 'confirm',
 			            btn_txt1: "취소",
 			            btn_txt2: "이동"}, 
		            function () {
 			            moveUrlAction(p_moveUrl);
 			        }, function () {
 			            //취소처리변경
 			        	//moveUrlAction(p_cancelUrl);
 			        }); 
 				} else if(result.data.actionType=='A7' || result.data.actionType=='A8' || result.data.actionType=='A9') {
 			    	customAlert({
 			    		title : '알림 ',
 			    		message : result.data.msg,
 			    		btn_txt1 : "확인"
 			    	}, function () {
 			        }, function () {
 			        	moveUrlAction(p_moveUrl);
 			        });
 				} else if(result.data.actionType=='AFN') {
 					customAlert({
 			    		title : '알림 ',
 			    		message : result.data.msg,
 			    		btn_txt1 : "확인"
 			    	}, function () {
 			        }, function () {
 			    		moveUrlAction(p_moveUrl);
 			        });
 				}else if(result.data.actionType=='SMN' ||	//보안매체 여부 > 보안매체가 등록되어있지 않을 때
 						  result.data.actionType=='SMO' ||	//보안매체 여부 > OTP 없을때
 						  result.data.actionType=='SMM' ||	//보안매체 여부 > MOTP등록 시> OTP일때 
 						  result.data.actionType=='SMSA' || 	//보안매체 여부 + 간편인증여부 > 둘다 미보유
 						 result.data.actionType=='SMM2') {	//SECU_MEDI가 M이나 토큰이 없을때
 			        customAlert({
 			            title: "알림",
 			            message: result.data.msg,
 			            type: 'confirm',
 			            btn_txt1: "취소",
 			            btn_txt2: "이동"}, 
		            function () {
 			            moveUrlAction(p_moveUrl);
 			        }, function () {
	 			    	if (p_cancelUrl != '') {
	 			    	    //취소처리변경  
	 			    		//moveUrlAction(p_cancelUrl);
	 			    	} 			        	
 			        });
 				} else if(result.data.actionType=='CDA' ||	// 법인사업자 체크
 						  result.data.actionType=='CDB' ||
 						  result.data.actionType=='CDC' ) {	
 			    	customAlert({
 			    		title : '알림 ',
 			    		message : result.data.msg,
 			    		btn_txt1 : "확인"
 			    	}
 			    	, ''
 			    	, function () {
 			    		moveUrlAction(p_moveUrl);
 			        });
 				} else if(result.data.actionType=='CDSM' ) {	//보안매체 여부 + 간편인증여부 > 둘다 미보유
 			        customAlert({
 			            title: "알림",
 			            message: result.data.msg,
 			            type: 'confirm',
 			            btn_txt1: "취소",
 			            btn_txt2: "이동"}, 
		            function () {
 			            moveUrlAction(p_moveUrl);
 			        }, function () {
 			            //취소처리변경
 			        	//moveUrlAction(p_cancelUrl);
 			        });
 				}else if(result.data.actionType=='CTC') {

 				} else if(result.data.actionType=='AUC') {
 					AuthFunc.showAuthAllPopLoginAfterUrl = p_moveUrl;
 					AuthFunc.showAuthAllPop(dummyCallBack);
 				}
 			}
		}
		,ajax_error
	);		
}

function dummyCallBack() {
	window.location = AuthFunc.showAuthAllPopLoginAfterUrl;
}

function mainSubLoginCallBack(result) {
	var result = JSON.parse(result);
	if(result.resultSuccess) {
		moveUrlAction(subMoveUrl);
	}
}

function mainSubLoginCallBack2(result) {
	window.location = "/main.ysb";
}

function goLogout() {
	customAlert(
		{ title: "알림",
          message: "로그아웃 하시겠습니까?",
          type: 'confirm',
          btn_txt1: "취소",
          btn_txt2: "확인"}, 
	      function () {
        	  window.location = "/login/logout.ysb";
	      },
	      function () {
	      }
	 );
}

function autoLogout() {
	showSplash();
	window.location = "/login/logout.ysb";
}

function loginExtend() {
	AjaxFunc.ajaxAsync(
		'/login/autoLoginExtend.ajax'
		, {}
		, function(data) {
			closePopup('autoLayPop');	
			initautoSessionCloseTimer();
			return;
		}
		,ajax_error
   	);
}


//공통 닫기버튼
function closeKeyAction() {
	stopToMainAlert();
}


function btnReloadAction() {
    var shotCon = false;
    var contentWrapH = $('#contentsWrap').outerHeight() - 25;
    var contentH = $('.contents').outerHeight();
    var windowH = $(window).height();
    if ($('#fixedBtnWrap').length > 0) {

        if (contentH < windowH) {
            shotCon = true;
            $('#fixedBtnWrap').addClass('active');
        }
        $(window).scroll(function() {
            if (!shotCon) {
                if ($(this).scrollTop() > 5) {
                    $('#fixedBtnWrap').addClass('active');
                } else {
                    $('#fixedBtnWrap').removeClass('active');
                }
            }
        });
    }

    if ( window.iphoneX === true ) {
      $('#contentsWrap').css('padding-bottom', 'calc( env(safe-area-inset-bottom) + 70px )');
      if( windowH > contentH  ){
        $('#fixedBtnWrap').addClass('active');
      }
    }else {
      $('#contentsWrap').css('padding-bottom', '70px'); //2020-06-17
    }	
}
