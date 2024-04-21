<%@page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>전자서명</title>
<%@ include file="../svc/delfino.jsp" %>

<script>
//issuerCertFilter 제거.
DelfinoConfig.issuerCertFilter='';
</script>

</head>
<body>
	<h1>ucpidSign</h1>
    
    <!-- 실제로 전송되는 form -->	
   	<form name="form1" method="post">
   		<input type="hidden" name="signData">
   		<input type="hidden" name="userAgreement">
   		<input type="hidden" name="userAgreeInfos">
   	</form>
  
	<form name="ucpidForm">
		이름:<input type="checkbox" name="realName" checked /><br/>
		성별:<input type="checkbox" name="gender" checked/><br/>
		국적:<input type="checkbox" name="nationalInfo" checked/><br/>
		생년월일:<input type="checkbox" name="birthDate" checked/><br/>
		userAgreement:<br/><input type="text" name="agreement" value="개인정보 활용에 동의합니다." style="width: 320px; height: 300px;"/>
	</form>
	<button onclick="sign('sign')">Delfino.sign</button><br/>
	<button onclick="sign('ucpidSign')">Delfino.ucpidSign</button><br/>	
	<hr/>	
	
<script>
	function sign(name){
		// document.delfinoForm._action.value = "TEST_ucpidSign";
		document.form1.action = "ucpidSignAction.jsp";

		var userAgreeInfos = [];

		document.ucpidForm.realName.checked && userAgreeInfos.push('realName');
		document.ucpidForm.gender.checked && userAgreeInfos.push('gender');
		document.ucpidForm.nationalInfo.checked && userAgreeInfos.push('nationalInfo');
		document.ucpidForm.birthDate.checked && userAgreeInfos.push('birthDate');

		var userAgreement = document.ucpidForm.agreement.value;
		// var userAgreeInfos = ["realName", "gender", "nationalInfo", "birthDate"];

		document.form1.userAgreement = userAgreement;
		document.form1.userAgreeInfos = JSON.stringify(userAgreeInfos);

		if(name == 'sign') {
			Delfino.sign({userAgreement: userAgreement, userAgreeInfos: userAgreeInfos}, {dataType: 'ucpid'}, sign_complete);
		} else if(name == 'ucpidSign') {
			Delfino.ucpidSign(userAgreement, userAgreeInfos, sign_complete);
		}
	}
	
	function sign_complete(result){
		if(result.status==1){
			document.form1.signData.value = result.signData;

			document.form1.submit();
		}
		else if(result.status!=0){
			alert("서명 실패:" + result.message);
		}
	}
</script>

</body>
</html>
