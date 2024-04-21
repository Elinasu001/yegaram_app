<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.wizvera.vpcg.*"%>
<%@ page import="java.util.Properties"%>
<%@ page import="java.io.*"%>
<%!
    VpcgSignResultService vpcgSignResultService;

    public void jspInit() {
        Properties properties = new Properties();
        ServletConfig servletConfig = getServletConfig();
        ServletContext context = servletConfig.getServletContext();
        FileInputStream fin = null;
        Reader in = null;
        boolean useDelfinoConfig = true;
        try{
            if (useDelfinoConfig) {
                //com.wizvera.WizveraConfig delfinoConfig = new com.wizvera.WizveraConfig(getServletConfig().getServletContext().getRealPath("WEB-INF") + "/lib/delfino.properties");
                com.wizvera.WizveraConfig delfinoConfig = com.wizvera.WizveraConfig.getDefaultConfiguration();
  		        vpcgSignResultService = new VpcgSignResultServiceImpl(delfinoConfig.getVpcgConfig());
            } else {
                String wizveraHome = System.getProperty("wizvera.home");
                if(wizveraHome==null){
                    throw new RuntimeException("missing 'wizvera.home' system property");
                }
                String vpcgConfigFile = wizveraHome + "/vpcg/conf/delfino-vpcg.properties";
                fin = new FileInputStream(vpcgConfigFile);
                in = new InputStreamReader(fin, "UTF-8");

                properties.load(in);
  		        vpcgSignResultService = new VpcgSignResultServiceImpl(new VpcgConfig(properties));
            }
        }catch(Exception e){
            throw new RuntimeException("delfino-vpcg.properties load fail", e);
        }finally{
            try{
                if(fin!=null) fin.close();
            }catch(IOException ignore){}
            try{
                if(in!=null) in.close();
            }catch(IOException ignore){}
        }
    }
    String escapeHtml(String source){
        if(source==null) return null;
        return source.replace("<", "&lt;").replace("&", "&amp;");
    }
%>
<%

    if(request.getCharacterEncoding()==null){
        request.setCharacterEncoding("utf-8");
    }
    if("signResult".equals(request.getParameter("action"))){
        String signResult = request.getParameter("signResult");

    	System.out.printf("signResult: [%s]\n", signResult);
    	out.println("<hr/>signResult:<br/>");
    	out.println(signResult);
    	VpcgSignResult vpcgSignResult=null;
        try{
            vpcgSignResult = vpcgSignResultService.getSignResult(signResult);
            out.println("<hr/>signedData:<br/>");
            out.println(vpcgSignResult.getSignedData());

            out.println("<hr/>vidRandom:<br/>");
            out.println(vpcgSignResult.getVidRandom());

            out.println("<hr/>ci:<br/>");
            out.println(vpcgSignResult.getCi());

            out.println("<hr/>provider:<br/>");
            out.println(vpcgSignResult.getProvider());
            out.println("<hr/>signType:<br/>");
            out.println(vpcgSignResult.getSignType());
            out.println("<hr/>txId :<br/>");
            out.println(vpcgSignResult.getTxId());

            out.println("<hr/>completedAt:<br/>");
            out.println(vpcgSignResult.getCompletedAt());

            out.println("<hr/>rawResponse:<br/>");
            out.println(vpcgSignResult.getRawResponse());



        }catch(VpcgSignResultException e){
            e.printStackTrace();
            out.println("<hr/>errorCode:<br/>");
            out.println(e.getErrorCode());
            out.println("<hr/>getErrorMessage:<br/>");
            out.println(e.getErrorMessage());
            out.println("<hr/>getRawResponse:<br/>");
            out.println(e.getRawResponse());
        }

        //saveTxInfo
        if(vpcgSignResult!=null){
            try{
                String userId = "userId-1";
                String serviceCode = "svcCode-1";
                vpcgSignResultService.saveTxInfo(vpcgSignResult.getTxId(), userId, serviceCode);
                out.println("<hr/>saveTxInfo:<br/>");
                out.println(String.format("txId:%s, userId:%s, serviceCode:%s", vpcgSignResult.getTxId(), userId, serviceCode));
            }catch(VpcgSignResultException e){
                e.printStackTrace();
                out.println("<hr/>saveTxInfo.errorCode:<br/>");
                out.println(e.getErrorCode());
                out.println("<hr/>saveTxInfo.getErrorMessage:<br/>");
                out.println(e.getErrorMessage());
            }
        }

        return;
    }
%>
<!DOCTYPE HTML>
<html>
<head>
    <title>VeraPort CG</title>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
    <meta name='viewport' content='initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, width=device-width' />
    <script src="../jquery/jquery-1.6.4.min.js"></script>
</head>
<body>

<h2>kakao/toss</h2>
<form id="request-sign">

    CI: <input type="text" name="userCi" value=''><br/>

    또는 <br/>

    전화번호: <input type="text" name="userPhone" value=''><br/>
    이름: <input type="text" name="userName" value=''><br/>
    생년월일(YYYYMMDD): <input type="text" name="userBirthday" value=''><br/>

    또는 <br/>
    Naver code : <input type="text" name="userAuthCode" value=''><br/>
    <hr/>

    원문: <textarea name="data" rows="4" cols="30">ABC가나다123</textarea>
        <textarea name="multiData" disabled rows="4" cols="30">[{"title":"대출계약서","data":"델피노+test+다중전자서명1"},{"title":"출금이체동의서","data":"두번째+test+다중전자서명2"}]</textarea><br/>

    원문타입: <select name='dataType'>
                  <option value='TEXT'>TEXT</option>
                  <option value='MARKDOWN'>MARKDOWN (kakao only)</option>
                  <option value='HTML'>HTML (toss only)</option>
                  <option value='SHA256_MD'>SHA256_MD (PDF only)</option>
              </select><br/>

    title: <input type="text" name="title" value='전자서명'><br/>
    triggerType : <select name='triggerType'>
        <option value='MESSAGE'>MESSAGE</option>
        <option value='SCHEME'>SCHEME</option>
    </select><br/>
    signType : <select name='signType' onchange="javascript:fnSignType();">
            <option value='AUTH'>AUTH</option>
            <option value='AUTH2'>AUTH2</option>
            <option value='SAUTH' selected>SAUTH</option>
            <option value='LOGIN'>LOGIN</option>
            <option value='SIMPLE'>SIMPLE</option>
            <option value='CONFIRM'>CONFIRM</option>
            <option value='MULTI'>*MULTI</option>
            <option value='PDF'>*PDF</option>
            <option value='PDF_MULTI'>*PDF_MULTI</option>
    </select><br/>
    provider : <select name='provider'>
        <option value='kakao'>kakao</option>
        <option value='kakaotalk' selected>kakaotalk</option>
        <option selected value='toss'>toss</option>
        <option value='naver'>naver</option>
        <option value='naver2'>naver2</option>
        <option value='pass'>pass</option>
        <option value='payco'>payco</option>
        <option value='shinhan'>shinhan</option>
        <option value='kb'>kb</option>
        <option value='hanaonesign'>hanaonesign</option>
        <option value='nh'>nh</option>
        <option value='dream'>dream</option>
    </select><br/>
</form>
<hr/>

<button onclick="config()">설정요청</button><br/>

<button onclick="preRequestSign()">서명요청</button><br/>

<form id="status-sign">
provider:<input type="text" name="provider" id="provider"><br/>
txId:<input type="text" name="txId" id="txId"><br/>
signType:<input type="text" name="signType" id="signType"><br/>
</form>
<button onclick="statusSign()">서명상태</button><br/>
<hr/>

<script type="text/javascript" language="javascript">
function fnSignType() {
	var frm = document.getElementById('request-sign');
	var signType = frm.signType.value;

	var org_DATA = "ABC가나다123";
	var org_mDATA = "[{\"title\":\"대출계약서\",\"data\":\"델피노+test+다중전자서명1\"},{\"title\":\"출금이체동의서\",\"data\":\"두번째+test+다중전자서명2\"}]";
	var org_PDF = "7d0a4d4755ea913e900387df2d7ba3a8550ae76c6dd0f1f390a022c19781a30b";
	var org_mPDF = "[{\"title\":\"PDF서명1\",\"data\":\"7d0a4d4755ea913e900387df2d7ba3a8550ae76c6dd0f1f390a022c19781a30b\"},{\"title\":\"PDF서명2\",\"data\":\"b0e5036fdb1f65006449b245fc46986945fc64433a3d709074f9160480f1a1b7\"}]";
	if ("PDF" == signType) {
		frm.data.disabled = false;
		frm.multiData.disabled = true;
		frm.title.value = "PDF:전자서명";
		frm.dataType.value = "SHA256_MD";
		frm.data.value = org_PDF;
	} else if ("PDF_MULTI" == signType) {
		frm.data.disabled = true;
		frm.multiData.disabled = false;
		frm.title.value = "PDF:복수전자서명";
		frm.dataType.value = "SHA256_MD";
		frm.multiData.value = org_mPDF;
	} else if ("MULTI" == signType) {
		frm.data.disabled = true;
		frm.multiData.disabled = false;
		frm.title.value = "복수전자서명";
		if (frm.dataType.value == "SHA256_MD") frm.dataType.value = "TEXT";
		frm.multiData.value = org_mDATA;
	} else if ("SIMPLE" == signType) {
		frm.data.disabled = false;
		frm.multiData.disabled = true;
		frm.title.value = "일반전자서명";
		if (frm.dataType.value == "SHA256_MD") frm.dataType.value = "TEXT";
		frm.data.value = "account=%EC%B6%9C%EA%B8%88%EA%B3%84%EC%A2%8C%EB%B2%88%ED%98%B8&recvBank=%EC%9E%85%EA%B8%88%EC%9D%80%ED%96%89&recvAccount=%EC%9E%85%EA%B8%88%EA%B3%84%EC%A2%8C%EB%B2%88%ED%98%B8&recvUser=%EB%B0%9B%EB%8A%94%EB%B6%84&amount=%EC%9D%B4%EC%B2%B4%EA%B8%88%EC%95%A1";
	} else if ("CONFIRM" == signType) {
		frm.data.disabled = false;
		frm.multiData.disabled = true;
		frm.title.value = "사용자확인전자서명";
		if (frm.dataType.value == "SHA256_MD") frm.dataType.value = "TEXT";
		frm.data.value = " (1)거래일자: 2015.10.08\n (2)거래시간: 10:18:59\n (3)출금계좌번호: 120245101777\n (4)입금은행: 신한\n (5)입금계좌번호: 40612170477\n (6)수취인성명: 홍길동\n (7)이체금액: 20,000(원)\n (8)CMS코드:  \n (9)받는통장에 표시내용:  \n (10)출금통장메모:  \n (11)중복이체여부: 해당없음 100%";
	} else {
		frm.data.disabled = false;
		frm.multiData.disabled = true;
		if (frm.dataType.value == "SHA256_MD") frm.dataType.value = "TEXT";
		frm.data.value = "login=certLogin&delfinoNonce=IJEO3%2B8ZOYi2JJG1Zp9ve6eCJ6U%3D&__CERT_STORE_MEDIA_TYPE=" + frm.provider.value;
		frm.title.value = "전자서명";
	}
}
function fnSignResult() {
    
    var frm = document.getElementById('signForm');
    frm.action = location.pathname + "?action=signResult";
    frm.method = "post";
    frm.target = "signResult";

    if (confirm("Delfino SDK를 이용한 서명검증을 하시겠습니까?")) {
	    frm.PKCS7.value = frm.signResult.value; 
	    frm.action = "../demo/signResultVpcg.jsp?_action=TEST_VPCG";
    }
    
    var x = (window.screen.availWidth - 900) / 2;
    var y = (window.screen.availHeight - 740) / 2;
    var style = "top=" + y + ", left=" + x + ", width=900, height=740, resizable=1, scrollbars=0";
    window.open("", 'signResult' ,  style);
    
    frm.submit();      
}
</script>

<form method="post" id="signForm">
    <input type="hidden" name="PKCS7" value="">
    signResult<input type="text" name="signResult" id="sign-result"><br/>
    <input type="button" value="signResult" onclick="javascript:fnSignResult();" >
</form>
<hr/>

app scheme: <a id="app-scheme" href=""></a>
<hr/>

서명요청 결과
<div id="req-result" style="width:600px"></div>
<hr/>

상태요청 결과
<div id="status-result" style="width:600px"></div>

<hr/>
<button onclick="clearResult()">clear</button><br/>
<hr/>

<script type="text/javascript" language="javascript">
    function setDefaultUser(userPhone, userName, userBirthday) {
        document.getElementById("request-sign").userPhone.value = userPhone;
        document.getElementById("request-sign").userName.value = userName;
        document.getElementById("request-sign").userBirthday.value = userBirthday;
    }
    
    if (!window.origin) window.origin = window.location.protocol + "//" + window.location.hostname + (window.location.port ? ':' + window.location.port: '');
    var VPCG_SERVICE = "../svc/delfino_vpcgRequest.jsp?origin=" + encodeURIComponent(origin);
    var VPCG_NAVER = VPCG_SERVICE + "&provider=naver";
    var vpcgWin = null;

    function requestAuthNaver(){
        vpcgWin = window.open(VPCG_NAVER + "&action=requestAuth", "vpcgNaverWin", "width=500, height=600");
    }

    function preRequestSign(){
        if($('#request-sign [name="provider"]').val() == "naver" && $('#request-sign [name="triggerType"]').val() == "MESSAGE"){
            requestAuthNaver();
        }
        else{
            requestSign();
        }
    }

    function config(){
        var params = {nonce : "12345678901234567890"};
        var jqxhr = $.get(VPCG_SERVICE + "&action=config", params, function(result) {
            console.log(result);
            alert(JSON.stringify(result))
        }, "json")
        .fail( function(result) {
            console.log(result);
            alert(result.responseText);
        });
    }

    function requestSign(){
        $("#req-result").html("");
        $("#txId").val("");
        $("#provider").val("");

        $("#app-scheme").attr("href", "#");
        $("#app-scheme").html("");

        var params = $("#request-sign").serialize();

        var jqxhr = $.post(VPCG_SERVICE + "&action=requestSign", params, function(result) {
            console.log(result);

            if(result.error){
                $("#req-result").html('<span style="color: red">' + JSON.stringify(result) + '</span>');

                if(result.error.provider=="naver" && result.error.code=="not_allowed_client"){
                    vpcgWin = window.open(VPCG_NAVER + "&action=requestAuth&auth_type=reprompt", "vpcgNaverWin", "width=500, height=600");
                }

                return;
            }

            $("#req-result").html('<span style="color: blue">' + JSON.stringify(result) + '</span>');

            $("#txId").val(result.txId);
            $("#provider").val(result.provider);
            $("#signType").val(result.signType);
            //if(result.provider == "naver2") $("#sign-result" ).val(JSON.stringify(result));
            if(result.provider == "kb") $("#sign-result" ).val(JSON.stringify(result));
            if(result.provider == "shinhan") $("#sign-result" ).val(JSON.stringify(result));
            if(result.provider == "hanaonesign") $("#sign-result" ).val(JSON.stringify(result));
            if(result.provider == "nh") $("#sign-result" ).val(JSON.stringify(result));
            if(result.provider == "dream") $("#sign-result" ).val(JSON.stringify(result));

            if(result.provider == "kakaotalk"){
                var appScheme = result.appScheme;
                $("#app-scheme").attr("href", appScheme);
                $("#app-scheme").html(appScheme);
            }
            if(result.provider == "kakao"){
                var appScheme = "kakaotalk://kakaopay/cert/sign?tx_id=" + result.txId;
                $("#app-scheme").attr("href", appScheme);
                $("#app-scheme").html(appScheme);
            }
            if(result.provider == "toss"){
                var type= (result.signType=="LOGIN" ||result.signType=="AUTH")? "user" : "doc";

                var appScheme = "supertoss://tossCert/sign/"+type+" ?_minVerIos=4.84.0&_minVerAos=4.84.0&callbackUrl=veraportcgoc://verportcg/toss&txId=" + result.txId;
                $("#app-scheme").attr("href", appScheme);
                $("#app-scheme").html(appScheme);
            }
            if(result.provider == "naver" && result.pollingPageUrl){
                vpcgWin = window.open(result.pollingPageUrl, "vpcgNaverWin", "width=500, height=600");
            }
        }, "json")
        .fail( function(result) {
            try{
                var responseJSON = JSON.parse(result.responseText);
                $("#req-result").html('<span style="color: red">' + JSON.stringify(responseJSON) + '</span>');
                if(responseJSON.error && responseJSON.error.provider=="naver" &&
                (responseJSON.error.code=="not_allowed_client" || responseJSON.error.code=="empty_ci_profile")){
                    vpcgWin = window.open(VPCG_NAVER + "&action=requestAuth&auth_type=reprompt", "vpcgNaverWin", "width=500, height=600");
                }
            }catch(e){
                console.error(e);
                $("#req-result").html('<span style="color: red">' + result.responseText + '</span>');
            }
        });
    }

    function statusSign(){
        $("#status-result").html("");
        $("#sign-result" ).val("");

        var params = $("#status-sign").serialize() ;
        params += "&action=statusSign";
        params += "&dummy=" + new Date().getTime();

        $.get(VPCG_SERVICE, params, function(result) {
                console.log(result);
                $("#status-result").html('<span style="color: blue">' + JSON.stringify(result) + '</span>');
				if(result.status === "COMPLETED"){
					$("#sign-result").val(JSON.stringify(result));
				}
            }, "json")
            .fail( function(result) {
                $("#status-result").html('<span style="color: red">' + result.responseText + '</span>');
            });
    }
    function clearResult(){
        $("#req-result").html("");
        $("#txId").val("");
        $("#provider").val("");

        $("#status-result").html('');
        $("#sign-result" ).val("");

        $("#app-scheme").attr("href", "#");
        $("#app-scheme").html("");
    }

    function VPCGPostMessage(result){
        console.log(result);

        if(result.error){
            $("#req-result").html('<span style="color: red">' + JSON.stringify(result) + '</span>');
            if(vpcgWin!=null) vpcgWin.close();
            vpcgWin = null;
            return;
        }
        $("#req-result").html('<span style="color: blue">' + JSON.stringify(result) + '</span>');

        if(result.action == 'authCallback'){
             $('#request-sign [name="userAuthCode"]').val(result.code);
             requestSign();
             return;
        }

        if(result.action == 'signCallback'){
            if(vpcgWin!=null) vpcgWin.close();
            vpcgWin = null;

            $("#sign-result").val(JSON.stringify(result));
        }
    }
</script>
</body>
</html>