  // 소프트캠프 초기화
  function scskiscomplete(){
    if(navigator.appName.indexOf("Microsoft Internet Explorer") != -1) {
      SecukeyInsert();
      SetExtE2EFields();
      //SetPassNoPaste();
      isInstallSCSK();
    }
  }

  // E2E Type 필드 추가
  function SecukeyTypeInsert(){
    try{
      var e2eTypeHtml = "<input type='hidden' name='e2eType' value='"+ secukey.ini7e2estate()+"'/>"
      $("form").each(function(i) {
        $(this).prepend(e2eTypeHtml);
      });
    }catch(e){}
  }

  // E2E Type 필드 확인 후 추가
  function SecukeyTypeInsertForm(formObj){
    try{
      var frmObj = $(formObj);
      if(!frmObj.find("[name='e2eType']").is("input")){
        var e2eTypeHtml = "<input type='hidden' name='e2eType' value='"+ secukey.ini7e2estate()+"'/>"
        frmObj.prepend(e2eTypeHtml);
      }
    }catch(e){}
  }

  // Object DOM 추가
  function SecukeyInsert(){
    var os_ver           = window.navigator.appVersion;
    var scsk_script      = "";
    var SCSKDownloadRoot = "https://dobank.kbstar.com/ocom/";
    var SCSKScriptVer    = "";
    var INI7CustomCode   = "109";			//고객사 코드 - 국민은행(109)
    var SCSKE2E_ETC      = "SOCIALID1;SOCIALID2;SOCIALID3;SOCIALID4;SOCIALID5;SOCIALID6;SOCIALID7;SOCIALID8;SOCIALID9;주민번호2;hpnum3;cardNum2;cardNum3;homenum3;officenum3;주민등록번호2;"; // Password Type 중 E2E예외 목록
    var url              = document.location.href;
    var protocal         = (url.indexOf("https") == -1) ? "http://" : "https://";
    var INI7SeedURL      = protocal + location.host + "/";
    var INI7ExtReqExtURL = protocal + location.host + "/";
    if(os_ver.toLowerCase().indexOf("wow64")>0){		// 64bit OS - 32 bit IE
      SCSKScriptVer    = "4,0,6031,74";
      SCSKDownloadRoot = SCSKDownloadRoot + "SCSK4_WOW64.cab";
    }else if(os_ver.toLowerCase().indexOf("win64")>0){		// 64bit OS - 64 bit IE : 지원불가
      //alert("32bit Internet Explorer를 사용하십시오.");
    }else if(os_ver.toLowerCase().indexOf("nt 6")>0){			// Windows Vista
      SCSKScriptVer    = "4,0,6031,74";
      SCSKDownloadRoot = SCSKDownloadRoot + "SCSK4_VISTA.cab";
    }else if(os_ver.toLowerCase().indexOf("windows 98")>0 || os_ver.toLowerCase().indexOf("winme")>0 || os_ver.toLowerCase().indexOf("windows me")>0){		// Windows 98, ME : Ansi 모듈
      SCSKScriptVer    = "4,0,31,74";
      SCSKDownloadRoot = SCSKDownloadRoot + "SCSK4_9X.cab";
    } else {		// etc : Unicode 모듈
      SCSKScriptVer    = "4,0,31,74";
      SCSKDownloadRoot = SCSKDownloadRoot + "SCSK4.cab";
    }

    SCSKDownloadRoot = "";

    if(os_ver.toLowerCase().indexOf("win64")>0){		// 64bit OS - 64 bit IE : 지원불가
      //alert("32bit Internet Explorer를 사용하십시오.");
    }else{
      scsk_script = scsk_script + '<object classid="CLSID:39Fc0Cf9-86F3-4502-B773-D16706EDEC83" codebase="'+SCSKDownloadRoot+'#version='+SCSKScriptVer+'" width="0" height="0" id="secukey">';
      scsk_script = scsk_script + '<param name="USEICON"          value="1">';
      scsk_script = scsk_script + '<param name="OPTION"           value="642">';									    // 130 + 512 = 642
      scsk_script = scsk_script + '<param name="SiteCode"         value="5136">';								      // 이걸지정해야 Initech 7 적용됨
      scsk_script = scsk_script + '<param name="INI7CustomCode"   value="' + INI7CustomCode + '">';		// 이걸지정해야 Initech 7 적용됨
      scsk_script = scsk_script + '<param name="INI7SeedURL"      value="' + INI7SeedURL + '">';			// 이걸지정해야 Initech 7 적용됨
      scsk_script = scsk_script + '<param name="INI7ExtReqExtURL" value="' + INI7ExtReqExtURL + '">';	// 이걸지정해야 Initech 7 적용됨
      scsk_script = scsk_script + '<param name="EteExtBkColor"    value="16763905">';						      // rgb를 십진수로 변환해서 넘기면 됨.
      scsk_script = scsk_script + '<param name="ETEOPTIONFLDS"    value="'+SCSKE2E_ETC+'">';          // E2E 를 적용되지 않는 필드 지정
      scsk_script = scsk_script + '<param name="SETUPPER"         value="1">';                        // 모든 패스워드가 대문자로 치환이 되도록 수정함 2011-10-21
      scsk_script = scsk_script + '<param name="HACKOPTION"       value="17">';
      scsk_script = scsk_script + '</object>';
    }
    var newDiv = document.createElement("div");
    with (newDiv.style){
      position = "absolute";
      left     = -1;
      top      = -1;
      width    = 0;
      height   = 0;
    }
    newDiv.setAttribute("name", "scsk_div");
    newDiv.setAttribute("id", "scsk_div");
    newDiv.innerHTML = scsk_script;
    document.appendChild(newDiv);
  }

  // 붙여넣기 허용
  function SetPassNoPaste(){
    var FormCount = 0;
    var count = 0;
    for(i=0;i<99;i++){
      if(document.forms[i] == "[object]"){ FormCount++; }else{continue;}
    }
    for(j=0;j<FormCount;j++){
      obj = document.forms[j];
      var len = obj.elements.length;
      for(k=0; k<len; k++){
        if(obj.elements[k].type=="password" && (check_name_password(obj.elements[k].name))){
          if(obj.elements[k].value != ""){
            obj.elements[k].value = "";
            count++;
          }
          obj.elements[k].attachEvent("onpaste", function(){alert("패스워드 필드는 붙여넣기 할 수 없습니다.");;return false;});	// 패스워드
        }
        if((obj.elements[k].name == "입금계좌번호" || obj.elements[k].name == "이체금액") && typeof(scsk_exte2e_start) == "function"){
        //if(obj.elements[k].name == "입금계좌번호" && typeof(scsk_exte2e_start) == "function"){
        //obj.elements[k].attachEvent("onpaste", function(){alert("보안상의 문제로 붙여넣기 할 수 없습니다.");;return false;});	// 메모리변조
        }
      }
    }
    if(count > 0){
      alert("키보드 보안 프로그램이 정상적으로 시작되었습니다.\n\n보안 프로그램 시작 이전에 입력된 패스워드 정보는 다시 입력해 주시기 바랍니다.");
    }
  }

  // 메모리변조 방지를 적용하기 위한 함수 1
  function SetExtE2EFields(){
    try{
      SecukeyTypeInsert();
      secukey.SetExtE2EFields(document);
    }catch(e){}
  }

  // 메모리변조 방지를 적용하기 위한 함수 2 : input의 elememt로 등록하기.
  function SetSCSKEtEExtbyID(form,input,hidden){
    input.autocomplete  = "off";      //자동완성 기능 끄기
    input.style.imeMode = "disabled";	//한글입력 막기.
    secukey.AddETEExtInput(document, input, hidden);
    SetExtE2EFields(form);
  }

  // 메모리변조 방지를 적용하기 위한 함수 3 : input 의 name으로 등록하기.
  function SetSCSKEtEExtbyName(form,inputname,hiddenname){
    var inputelement  = null;
    var hiddenelement = null;
    len = form.elements.length;
    for(i=0; i<len; i++){
      if(form.elements[i].name==inputname){
        // 메모리변조 방지 대상 필드가 text 가 아닌 경우에 대한 예외처리 - by sgun 2008-03-12
        if(form.elements[i].type == "text"){
          inputelement=form.elements[i];
        }else{
          return false;
        }
      }else if(form.elements[i].name==hiddenname){
        hiddenelement = form.elements[i];
      }
    }
    if(inputelement && hiddenelement){
      SetSCSKEtEExtbyID(form, inputelement,hiddenelement);
    }
  }

  // E2E 필드여부 확인
  function getE2EFieldName(){
    var retVal = "";
    try{
      if(document.secukey.INI7E2ESTATE == "0"){
        retVal = "_E2E123_";
      }
      return retVal;
    }catch(e){ return retVal;	}
  }

  // 설치 여부 판단 후 통합설치 페이지로 이동
  function isInstallSCSK(){
    if(typeof(document.secukey) == "undefined" || document.secukey.object == null) {
      alert("안전한 인터넷뱅킹을 위하여 보안프로그램 설치가 필요합니다. \n[확인]을 클릭하시면 설치페이지로 이동합니다.");
      document.location.href="/quics?page=C023664&P_name=SCSK4&url=" + encodeURIComponent(window.location.href);
    }
  }

  // 초기화
  $(function(){ scskiscomplete(); });
