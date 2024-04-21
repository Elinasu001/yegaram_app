<%@page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="initial-scale=1.0; width=device-width" />
	<title>전자서명</title>
<%@ include file="../svc/delfino.jsp" %>
</head>
<body>
	<h1>전자서명</h1>
   	<h3>Message Digest 전자서명</h3>
   	<form name="delfinoForm" method="post" action="mdSignAction.jsp">
		<input type="hidden" name="PKCS7">
		<input type="hidden" name="VID_RANDOM">
	</form>

	<button onclick="Delfino.mdSign('b0e5036fdb1f65006449b245fc46986945fc64433a3d709074f9160480f1a1b7', complete_sign);return false">MD전자서명</button><br/>
	
	<button onclick="Delfino.mdMultiSign(['b0e5036fdb1f65006449b245fc46986945fc64433a3d709074f9160480f1a1b7',
	'22e5036fdb1f65006449b245fc46986945fc64433a3d709074f9160480f1a1b7',
	'dfaeerewre4f65006449b245fc46986945fc64433a3d709074f9160480f1a1b7'],
	complete_multiSign);return false">MD멀티전자서명</button><br/>

	<button onclick="Delfino.addMdSigner('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',
	complete_addMdSigner);return false">MD다자서명</button><br/>
	

	<script>
		function complete_sign(result){
			if(result.status==1){
				alert(result.signData);
				document.delfinoForm.PKCS7.value = result.signData;
				document.delfinoForm.submit();				
			}
			else if(result.status!=0){
				alert("서명 실패:" + result.message + ":" + result.status);
			}
		}
		
		function complete_multiSign(result){
			if(result.status==1){
				for(var i=0; i<result.signData.length; i++){
					var msg = result.signData.length + " - " + (i+1) + "\n\n";
					msg += result.signData[i];
					alert(msg);
				}
				
				document.delfinoForm.PKCS7.value = result.signData.join(",");
				document.delfinoForm.submit();
			}
		    else if(result.status!=0){
				alert("서명 실패:" + result.message + ":" + result.status);
			}
		}

		function complete_addMdSigner(result){
			if(result.status==1){
				// alert(result.signData);
				document.delfinoForm.action = "signTestAction.jsp"
				document.delfinoForm.PKCS7.value = result.signData;
				document.delfinoForm.submit();				
			}
			else if(result.status!=0){
				alert("서명 실패:" + result.message + ":" + result.status);
			}
		}
	</script>
</body>
</html>
