<%-- --------------------------------------------------------------------------
 - File Name   : sign.jsp(전자서명 샘플)
 - Include     : delfino.jsp
 - Author      : WIZVERA
 - Last Update : 2023/01/13
-------------------------------------------------------------------------- --%>
<%@page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%
    java.text.DateFormat logDate = new java.text.SimpleDateFormat("[yyyy/MM/dd HH:mm:ss] ");
    System.out.println(logDate.format(new java.util.Date())+request.getRequestURI()+" "+request.getMethod()+"[" + request.getRemoteAddr() + "]");
%>
<%
    boolean isVeraPortCG = false;
    java.net.URL _clasUrl1 = this.getClass().getResource("/com/wizvera/crypto/pkcs7/PKCS7VerifyWithVpcg.class");
    java.net.URL _clasUrl2 = this.getClass().getResource("/com/wizvera/vpcg/VpcgSignResult.class");
    if (_clasUrl1 != null && _clasUrl2 != null) isVeraPortCG = true;
%>
<%
    String result_target = "testResult";
    String result_action = "signResult.jsp";
    if (isVeraPortCG) result_action = "signResultVpcg.jsp"; //통합인증 데모

    if ("on".equals(request.getParameter("debug"))) {
        result_target = "";
        result_action = "../svc/delfino_checkResult.jsp?debug=on";
    }
    boolean addNonce = ("true".equals(request.getParameter("addNonce"))) ? true : false;
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta http-equiv="Expires" content="-1" />
    <meta http-equiv="Progma" content="no-cache" />
    <meta http-equiv="cache-control" content="no-cache" />
<%
    if ("on".equals(session.getAttribute("delfino_mobile_demo"))) {
        out.println("    <meta name='viewport' content='initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, width=device-width' />");
    }
%>
    <title>WizIN-Delfino Sample</title>
    <style type="text/css">
        label { width: 80px; display: inline-block; text-align: right;}
    </style>

    <%@ include file="../svc/delfino.jsp"%>


<%  //폼, form-urlencoding 전자서명에서 사용되는  format 값으로 세션에 저장 후 서명검증시 사용
    com.wizvera.service.util.KeyValueFormatter confirmFormatter = new com.wizvera.service.util.KeyValueFormatter();
    confirmFormatter.add("account", "출금계좌번호");
    confirmFormatter.add("recvBank", "입금은행");
    confirmFormatter.add("recvAccount", "입금계좌번호");
    confirmFormatter.add("recvUser", "받는분");
    confirmFormatter.add("amount", "이체금액");
    String confirmFormat = confirmFormatter.toString();
    session.setAttribute("TEST_confirmSign_form", confirmFormat);
%>

<% //form-urlencoding 문자열 전자서명에서  사용되는 Key,Value쌍을 가진 서명데이타 원문값
    com.wizvera.service.util.KeyValueFormatter dataFormatter = new com.wizvera.service.util.KeyValueFormatter();
    dataFormatter.add("account", "111111-22-333333");
    dataFormatter.add("recvAccount", "444444-55-666666");
    dataFormatter.add("amount", "10,000");
    dataFormatter.add("recvUser", "김모군");
    dataFormatter.add("recvBank", "국민");
    dataFormatter.add("etc", "표시안됌");
    String signData = dataFormatter.toString();
%>

</head>

<body>
    <h1>전자서명 <span style="font-size: small;"><a href="./index.jsp">home</a></span></h1>
    <form name="inputForm">
      <span style="font-size: small;">이체나 약관동의시 사용되는 전자서명 기능을 확인합니다.
        <a href="javascript:Delfino.setPolicyOidCertFilter('');Delfino.setIssuerCertFilter('');alert('인증서필터링이 제거되엇습니다.');">인증서필터링해제</a>
        <a href="javascript:Delfino.resetCertificate();alert('인증서 캐쉬가 초기화되었습니다.');">캐쉬초기화</a>
        <a href="javascript:location.href=location.pathname+'?addNonce=true';">AddNonce</a>
        <br/>인증서로그인시 사용된 인증서만 보여집니다.
        <a href="javascript:Delfino.manageCertificate();">공동인증서관리</a>
        &nbsp;
        <select name="certStatusCheckType">
          <option value="NONE" selected="selected">NONE</option>
          <option value="CRL">CRL</option>
          <option value="OCSP">OCSP</option>
        </select>
        <input type="checkbox" name="resetCertificate"/>인증수단캐쉬초기화
      </span>
    </form>

    <script type="text/javascript">
    var TEST_addNonce = <%=addNonce%>;
    if (TEST_addNonce && !DelfinoConfig.useNonceOption) alert("DelfinoConfig.useNonceOption set 'true'");
    </script>

    <script type="text/javascript">
    //<![CDATA[

    //전자서명시 호출되는  CallBack 함수
    function TEST_complete(result){
        window.__result = result;
        if(result.status==1){
            document.delfinoForm.PKCS7.value = result.signData;
            document.delfinoForm.VID_RANDOM.value = result.vidRandom;
            document.delfinoForm.submit();
        }
        else{
            if(result.status==0) return; //사용자취소
            if(result.status==-10301) return; //구동프로그램 설치를 위해 창을 닫을 경우
            //if (Delfino.isPasswordError(result.status)) alert("비밀번호 오류 횟수 초과됨"); //v1.1.6,0 over & DelfinoConfig.passwordError = true
            alert("error:" + result.message + "[" + result.status + "]");
        }
    }

    function TEST_getUserInfo() {
        var userInfo = {};
        if (typeof(document.vpcgUserInfoForm) == "object") {
            var frm = document.vpcgUserInfoForm;
            if (frm.TEST_userName.value != "" && frm.TEST_userBirthday.value != "" && frm.TEST_userPhone.value != "") {
                userInfo.userName = frm.TEST_userName.value;
                userInfo.userBirthday = frm.TEST_userBirthday.value;
                userInfo.userPhone = frm.TEST_userPhone.value;
            }
        }
        return userInfo;
    }

    //사용자확인 전자서명: 폼
    function TEST_confirmSign_form(signForm) {
        document.delfinoForm._action.value = "TEST_confirmSign_form";
        document.delfinoForm.certStatusCheckType.value = document.inputForm.certStatusCheckType.value; //유효성검증설정

        var signOptions = {cacheCert:true};
        if (document.inputForm.resetCertificate.checked) signOptions.resetCertificate = true; //TODO: 인증서캐쉬 초기화
        if (Delfino.getModule() == "G10") signOptions.userInfo = TEST_getUserInfo(); //TODO: 핀테크인증사용자정보 TEST용
        if(TEST_addNonce) signOptions.addNonce = true; //nonce값 추가하기

        var confirmFormat = "<%=confirmFormat%>";
        Delfino.confirmSign(signForm, confirmFormat, signOptions, TEST_complete);
    }

    //사용자확인 전자서명: form-urlencoding 스트링
    function TEST_confirmSign_formString() {
        document.delfinoForm._action.value = "TEST_confirmSign_formString";
        document.delfinoForm.certStatusCheckType.value = document.inputForm.certStatusCheckType.value; //유효성검증설정

        var signOptions = {cacheCert:true};
        if (document.inputForm.resetCertificate.checked) signOptions.resetCertificate = true; //TODO: 인증서캐쉬 초기화
        if (Delfino.getModule() == "G10") signOptions.userInfo = TEST_getUserInfo(); //TODO: 핀테크인증사용자정보 TEST용
        if(TEST_addNonce) signOptions.addNonce = true; //nonce값 추가하기

        var signData = "<%=signData%>";
        var confirmFormat = "<%=confirmFormat%>";
        Delfino.confirmSign(signData, confirmFormat, signOptions, TEST_complete);
    }


<%
    String confirmFormatString = "출금계좌번호:이체금액;bold:입금은행:입금계좌번호:받는분:";
    String signDataString = "524902-01-055983:10,000:홍콩은행:097-21-0441-120:김모군:안보여줌";
    session.setAttribute("TEST_confirmSign_string", confirmFormatString); //포맷검증을 위해 세션에 저장
%>
    //사용자 확인 전자서명: 문자열
    function TEST_confirmSign_string() {
        document.delfinoForm._action.value = "TEST_confirmSign_string";
        document.delfinoForm.certStatusCheckType.value = document.inputForm.certStatusCheckType.value; //유효성검증설정

        var signOptions = {cacheCert:true};
        if (document.inputForm.resetCertificate.checked) signOptions.resetCertificate = true; //TODO: 인증서캐쉬 초기화
        if (Delfino.getModule() == "G10") signOptions.userInfo = TEST_getUserInfo(); //TODO: 핀테크인증사용자정보 TEST용
        if(TEST_addNonce) {
            alert("문자열 전자서명은 addNonce옵션을 지원하지 않습니다");
            //signOptions.addNonce = true; //미지원
        }

        var confirmFormatString = "<%=confirmFormatString%>";
        var signDataString = "<%=signDataString%>";
        Delfino.confirmSign({data:signDataString, dataType:'strings'}, confirmFormatString, signOptions, TEST_complete);
    }


<%
    String formattedSignData  = " (1)거래일자: 2015.10.08\n (2)거래시간: 10:18:59\n (3)출금계좌번호: 120245101777\n (4)입금은행: 신한\n (5)입금계좌번호: 40612170477\n";
    formattedSignData += " (6)수취인성명: 홍길동\n (7)이체금액: 20,000(원)\n (8)CMS코드:  \n (9)받는통장에 표시내용:  \n (10)출금통장메모:  \n (11)중복이체여부: 해당없음 100%";
    formattedSignData = formattedSignData.replace("\n", "\\n");
    session.setAttribute("TEST_confirmSign_formattedText", formattedSignData); //서명데이타검증을 위해 세션에 저장
%>
    //사용자 확인 전자서명: formattedText
    function TEST_confirmSign_formattedText() {
        document.delfinoForm._action.value = "TEST_confirmSign_formattedText";
        document.delfinoForm.certStatusCheckType.value = document.inputForm.certStatusCheckType.value; //유효성검증설정

        var signOptions = {cacheCert:true};
        if (document.inputForm.resetCertificate.checked) signOptions.resetCertificate = true; //TODO: 인증서캐쉬 초기화
        if (Delfino.getModule() == "G10") signOptions.userInfo = TEST_getUserInfo(); //TODO: 핀테크인증사용자정보 TEST용
        if(TEST_addNonce) signOptions.addNonce = true; //nonce값 추가하기

        var formattedSignData  = "<%=formattedSignData%>";
        Delfino.confirmSign({data:formattedSignData, dataType:'formattedText'}, signOptions, TEST_complete);
    }


<%
    String withoutformatSignData = "account=524902-01-055983&amount=10000&recvBank=홍콩은행&recvAccount=097-21-0441-120&받는분=김모군";
    session.setAttribute("TEST_confirmSign_withoutFormat", withoutformatSignData); //서명데이타검증을 위해 세션에 저장
%>
    //사용자 확인 전자서명: withoutFormat
    function TEST_confirmSign_withoutFormat() {
        document.delfinoForm._action.value = "TEST_confirmSign_withoutFormat";
        document.delfinoForm.certStatusCheckType.value = document.inputForm.certStatusCheckType.value; //유효성검증설정

        var signOptions = {cacheCert:true};
        if (document.inputForm.resetCertificate.checked) signOptions.resetCertificate = true; //TODO: 인증서캐쉬 초기화
        if (Delfino.getModule() == "G10") signOptions.userInfo = TEST_getUserInfo(); //TODO: 핀테크인증사용자정보 TEST용
        if(TEST_addNonce) signOptions.addNonce = true; //nonce값 추가하기
        //signOptions.encoding = "euckr";

        var withoutformatSignData = "<%=withoutformatSignData%>";
        Delfino.confirmSign(withoutformatSignData, signOptions, TEST_complete);
    }


<%
    String withoutConfirmSignData  = "전문형태의 전자서명에 사용 01 201금융 보험 부동산 서비스 04 100%";
    //withoutConfirmSignData = java.net.URLEncoder.encode(withoutConfirmSignData, "UTF-8");
    //withoutConfirmSignData = "data=" + java.net.URLEncoder.encode(withoutConfirmSignData, "UTF-8");
    session.setAttribute("TEST_withoutConfirmSign", withoutConfirmSignData); //서명데이타검증을 위해 세션에 저장
%>
    //서명확인창 없이 서명: Delfino.sign()
    function TEST_withoutConfirmSign() {
        document.delfinoForm._action.value = "TEST_withoutConfirmSign";
        document.delfinoForm.certStatusCheckType.value = document.inputForm.certStatusCheckType.value; //유효성검증설정

        var signOptions = {cacheCert:true};  //사용한 인증서 캐쉬 하기: plugin 기본값
        //signOptions = {cacheCert:false}; //사용한 인증서 캐쉬 안하기: handler 기본값
        //signOptions = {cacheCertFilter:false, cacheCert:false}; //인증서캐쉬 설정 무시하고 사용한 인증서 캐쉬 안하기
        //signOptions = {resetCertificate:true, cacheCert:true};  //인증서캐쉬 초기화 후 사용한 인증서 캐쉬 하기
        //signOptions = {resetCertificate:true, cacheCert:true, signedAttribute: 'signingTime'};  //인증서캐쉬 초기화 후 사용한 인증서 캐쉬 하기+서명시간추가하기
        //signOptions = {resetCertificate:true, policyOidCertFilter: "1.2.410.200005.1.1.4"}; //인증서캐쉬 초기화 후 특정인증서OID만 사용하기

        if (document.inputForm.resetCertificate.checked) signOptions.resetCertificate = true; //TODO: 인증서캐쉬 초기화
        if (Delfino.getModule() == "G10") signOptions.userInfo = TEST_getUserInfo(); //TODO: 핀테크인증사용자정보 TEST용
        if(TEST_addNonce) signOptions.addNonce = true; //nonce값 추가하기

        signOptions.signTitle = "일반전자서명"; //핀테크인증
        var signData = "<%=withoutConfirmSignData%>";
        Delfino.sign(signData, signOptions, TEST_complete);
    }

<%
    String multiSignData  = "델피노 test 다중전자서명1" + "|" + "두번째 test 다중전자서명2";
    session.setAttribute("TEST_multiSign", multiSignData); //서명데이타검증을 위해 세션에 저장
%>
    //복수전자서명: Delfino.multiSign()
    function TEST_multiSign() {
        document.delfinoForm._action.value = "TEST_multiSign";
        document.delfinoForm.certStatusCheckType.value = document.inputForm.certStatusCheckType.value;
        document.delfinoForm.SIGN_Delimeter.value = DelfinoConfig.multiSignDelimiter;

        var signOptions = {cacheCert:true};
        if (document.inputForm.resetCertificate.checked) signOptions.resetCertificate = true; //TODO: 인증서캐쉬 초기화
        if (Delfino.getModule() == "G10") signOptions.userInfo = TEST_getUserInfo(); //TODO: 핀테크인증사용자정보 TEST용

        signOptions.signTitle = "대출계약서" + DelfinoConfig.multiSignDelimiter + "출금이체동의서"; //핀테크인증
        var multiSignData = "<%=multiSignData%>";

        //signOptions.signTitle = ["대출계약서", "출금이체동의서"];
        //multiSignData = multiSignData.split("|");
        Delfino.multiSign(multiSignData, signOptions, TEST_complete);
    }

    //]]>
    </script>

    <form name="delfinoForm" method="post" target="<%=result_target%>" action="<%=result_action%>">
        <input type="hidden" name="PKCS7" />
        <input type="hidden" name="VID_RANDOM" />
        <input type="hidden" name="_action" />
        <input type="hidden" name="certStatusCheckType" />
        <input type="hidden" name="SIGN_Delimeter" value="" />
        <input type="hidden" name="TEST_addNonce" value="<%=addNonce%>" />
    </form>

    <h2>1. 사용자확인 전자서명</h2>
    <form method="post" name="sign" action="signResult.jsp" onsubmit="TEST_confirmSign_form(this);return false;">
        <label>출금계좌</label> <input type="text" size="15" name="account" value="111111-22-333333" />
        <label>입금은행</label> <input type="text" size="15" name="recvBank" value="국민" />
        <br/>
        <label>입금계좌</label> <input type="text" size="15" name="recvAccount" value="444444-55-666666" />
        <label>받는분</label>  <input type="text" size="15" name="recvUser" value="김모군" />
        <br/>
        <label>이체금액</label> <input type="text" size="15" name="amount" value="10,000" />
        <label>기타</label>    <input type="text" size="15" name="etc" value="서명창표시되지않음" />
        <input type="submit" value="폼 전자서명" />
    </form>
    <br/>
    <input type="button" value="form-urlencoding 전자서명" onclick="javascript:TEST_confirmSign_formString();" />
    <input type="button" value="문자열 전자서명" onclick="javascript:TEST_confirmSign_string();" />
    &nbsp;&nbsp;
    <input type="button" value="withoutFormat 서명" onclick="javascript:TEST_confirmSign_withoutFormat();" />
    <input type="button" value="formattedText 서명" onclick="javascript:TEST_confirmSign_formattedText();" />

    <h2>2. 일반 전자서명 </h2>
    <input type="button" value="SIMPLE:서명확인창 없이 서명" onclick="javascript:TEST_withoutConfirmSign();" />
    <input type="button" value="MULTI:복수서명" onclick="javascript:TEST_multiSign();" />
    &nbsp;
    <input type="button" value="PDF:서명" onclick="javascript:TEST_mdSign();" />
    <input type="button" value="PDF_MULTI:복수서명" onclick="javascript:TEST_mdMultiSign();" />
    <br/>

    <script type="text/javascript">
<%
    String mdSignData  = "7d0a4d4755ea913e900387df2d7ba3a8550ae76c6dd0f1f390a022c19781a30b";
    session.setAttribute("TEST_mdSign",  mdSignData); //PDF해쉬값을 세션에 저장해놓고 서명검증 후 비교확인
%>
    //PDF전자서명: Delfino.mdSign()
    function TEST_mdSign() {
        document.delfinoForm._action.value = "TEST_mdSign";
        document.delfinoForm.certStatusCheckType.value = document.inputForm.certStatusCheckType.value;

        var signOptions = {cacheCert:true};
        if (document.inputForm.resetCertificate.checked) signOptions.resetCertificate = true; //TODO: 인증서캐쉬 초기화
        if (Delfino.getModule() == "G10") signOptions.userInfo = TEST_getUserInfo(); //TODO: 핀테크인증사용자정보 TEST용

        signOptions.signTitle = "PDF서명"; //핀테크인증
        var mdSignData = "<%=mdSignData%>"; //PDF: SHA-256 hash값
        Delfino.mdSign(mdSignData, TEST_complete, signOptions);
    }

<%
    String mdMultiSignData = "7d0a4d4755ea913e900387df2d7ba3a8550ae76c6dd0f1f390a022c19781a30b" + "|" + "b0e5036fdb1f65006449b245fc46986945fc64433a3d709074f9160480f1a1b7";
    session.setAttribute("TEST_mdMultiSign", mdMultiSignData); //PDF해쉬값을 세션에 저장해놓고 서명검증 후 비교확인
%>
    //PDF복수전자서명: Delfino.mdMultiSign()
    function TEST_mdMultiSign() {
        document.delfinoForm._action.value = "TEST_mdMultiSign";
        document.delfinoForm.certStatusCheckType.value = document.inputForm.certStatusCheckType.value;
        document.delfinoForm.SIGN_Delimeter.value = DelfinoConfig.multiSignDelimiter;

        var signOptions = {cacheCert:true};
        if (document.inputForm.resetCertificate.checked) signOptions.resetCertificate = true; //TODO: 인증서캐쉬 초기화
        if (Delfino.getModule() == "G10") signOptions.userInfo = TEST_getUserInfo(); //TODO: 핀테크인증사용자정보 TEST용

        signOptions.signTitle = "PDF서명1" + DelfinoConfig.multiSignDelimiter + "PDF서명2"; //핀테크인증
        var mdMultiSignData = "<%=mdMultiSignData%>";

        signOptions.signTitle = ["PDF서명1", "PDF서명2"];
        mdMultiSignData = mdMultiSignData.split("|");
        Delfino.mdMultiSign(mdMultiSignData, TEST_mdSign_complete, signOptions);
    }
    function TEST_mdSign_complete(result){
        window.__result = result;
        if(result.status==1){
            alert("PDF복수서명결과: \n" + JSON.stringify(result.signData));
        }
        else{
            if(result.status==0) return; //사용자취소
            if(result.status==-10301) return; //구동프로그램 설치를 위해 창을 닫을 경우
            //if (Delfino.isPasswordError(result.status)) alert("비밀번호 오류 횟수 초과됨"); //v1.1.6,0 over & DelfinoConfig.passwordError = true
            alert("error:" + result.message + "[" + result.status + "]");
        }
    }
    </script>

<!--
    <h2>3. 다국어 설정
      <span style="font-size: small;">
        <a href="javascript:Delfino.setLang('KOR');alert('한국어로 설정되었습니다');">한국어</a>
        <a href="javascript:Delfino.setLang('ENG');alert('영어로 설정되었습니다');">영어</a>
        <a href="javascript:Delfino.setLang('CHN');alert('중국어로 설정되었습니다');">중국어</a>
        <a href="javascript:Delfino.setLang('JPN');alert('일본어로 설정되었습니다');">일본어</a>
      </span>
    </h2>
    <br/>
-->

    <hr/>
    <form name="vpcgUserInfoForm">
    <h2>Result <span style="font-size: small;">[<%=result_action%>] [<a href="./login.jsp">login</a>]&nbsp;&nbsp;
        cgUserInfo
        <input type="text" name="TEST_userName" size="2" placeholder="이름" value="" />
        <input type="text" name="TEST_userBirthday" size="5" placeholder="생년월일" value="" />
        <input type="text" name="TEST_userPhone" size="8" placeholder="휴대폰번호" value="" />
        <a href="javascript:document.vpcgUserInfoForm.reset();">X</a>
    </span></h2>
    </form>
    <script type="text/javascript">
    document.vpcgUserInfoForm.TEST_userName.value     = "<%=((session.getAttribute("TEST_userName")==null)     ? "" : session.getAttribute("TEST_userName"))%>";
    document.vpcgUserInfoForm.TEST_userBirthday.value = "<%=((session.getAttribute("TEST_userBirthday")==null) ? "" : session.getAttribute("TEST_userBirthday"))%>";
    document.vpcgUserInfoForm.TEST_userPhone.value    = "<%=((session.getAttribute("TEST_userPhone")==null)    ? "" : session.getAttribute("TEST_userPhone"))%>";
    </script>

    <table width="100%" border="1" align="center" cellpadding="0" cellspacing="0">
      <tr><td bgcolor="#FFFFFF" height="350">
        <iframe name='testResult' id='testResult' frameborder='0' width='100%' height='100%' src='<%=result_action%>?_action=TEST_TEST'></iframe>
      </td></tr>
    </table>

  <hr />
  <div style="font-size:9pt;" align="left">
    <%=logDate.format(new java.util.Date())%>
    <script type="text/javascript">try {document.write("["+(DC_platformInfo.Mobile?"mobile,":"")+(DC_platformInfo.x64?DC_platformInfo.name+",":"")+DC_browserInfo.name+","+DC_browserInfo.version+"]");} catch(err) {document.write("<b>"+err+"</b>");}</script>
    Copyright &#169; 2008-2015, <a href='http://help.wizvera.com' target="_new">WIZVERA</a> Co., Ltd. All rights reserved
    <script type="text/javascript">
        try {top.document.title = "[" + Delfino.getModule() + "]" + top.document.title;} catch(err) {}
        var hostname = document.location.hostname;
        if (hostname.indexOf("wizvera.com") > 0) {
            var idx = hostname.indexOf(".");
            var oldHost = hostname.substring(0, idx);
            var newHost = oldHost + "2";
            if (hostname.indexOf("2") > 0 || hostname.indexOf("1") > 0) newHost = hostname.substring(0, idx-1);
            document.write("&nbsp;&nbsp;<a href='" + window.location.href.replace(oldHost, newHost) + "'>" + newHost + "</a>");

            var newProtocol = ("https:" == window.location.protocol) ? "http:" : "https:";
            var newSite = window.location.href.replace(window.location.protocol, newProtocol);
            if ("https:" == newProtocol) {
                newSite = newSite.replace(":8080", ":8443");
            } else {
                newSite = newSite.replace(":8443", ":8080");
            }
            document.write(" <a href='" + newSite + "'>" + newProtocol + "</a>");
            document.write(" <br/>[" + navigator.userAgent + "] [<a href='javascript:alert(document.cookie);'>cookie</a>]");
        }
    </script>
  </div>

</body>
</html>
