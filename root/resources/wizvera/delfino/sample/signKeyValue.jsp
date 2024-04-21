<%@page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width" />
		<title>전자서명</title>
<%@ include file="../svc/delfino.jsp" %>		
    </head>
    <body>
    	<h2>전자서명</h2>
			<form name="form" method="post" action="signKeyValueAction.jsp">
			<input type="hidden" name="PKCS7">
			<input type="hidden" name="VID_RANDOM">
			<input type="hidden" name="etc1" value="asdf"/>
			<input type="hidden" name="etc2" value="12345"/>
		</form>
		
		<button onclick="sign()">서명 </button>
		<script>
			function signCallback(pkcs7, vid_random){				
				document.form.PKCS7.value = pkcs7;
				document.form.VID_RANDOM.value = vid_random;				
				document.form.submit();
			}
			
			function sign(){				
				var delimeter = ":";
				//var keys = "출금계좌번호:이체금액:수수료:내 통장 표시내용:입금은행:입금계좌번호:수취인:수취인 통장 표시내용:출금계좌번호";
				//var values = "1234-1234-1234:10,000:100::국민은행:4321-4321-4321:아무개::2234-1234-1234";
				//var formats = "출금계좌번호:이체금액:수수료:내 통장 표시내용:입금은행:입금계좌번호:수취인:수취인 통장 표시내용:출금계좌번호";
				
				
				var keys = "출금계좌번호:이체지정년월일:이체시간:이체건수:입금은행코드:입금계좌번호:이체금액:출금계좌번호:입금은행코드:입금계좌번호:이체금액";
				var values = "524902-01-055983:2011년 09월 29일:13시 30분:2:004:097-21-0441-120:1:524902-01-055983:004:462202-01-376564:2";
				var formats = "출금계좌:이체지정일:이체지정시각:이체건수:입금은행코드(1):입금계좌번호(1):이체금액(1)::입금은행코드(2):입금계좌번호(2):이체금액(2)";
				
				
				
				Delfino.signKeyValue(keys, values, formats, delimeter, signCallback);
			}
			
			function signWithoutConfirm(){				
				var delimeter = ":";
				var keys = "출금계좌번호:이체금액:수수료:내 통장 표시내용:입금은행:입금계좌번호:수취인:수취인 통장 표시내용";
				var values = "1234-1234-1234:10,000:100::국민은행:4321-4321-4321:아무개:";
				var formats = ":::::::";
				
				Delfino.signKeyValue(keys, values, formats, delimeter, signCallback);
			}
			function signWithoutConfirmTest(){				
				var option = "1";
				var values = "01:201금융 보험 부동산 서비스04:서울시 중구 남대문 2가 9-105:105861004906:테스트성명07:11108:11109:201816869310:400011:40012:2011081713:공인인증서14:400015:116:081717:18:19:20:21:22:23:24:25:26:27:28:29:130:111";
				digiSignWithoutConfirm(option, values, signCallback)
			}
			function signWithoutConfirmTest2(){				
				Delfino.setPolicyOidCertFilter("");
				var data = "01:201금융 보험 부동산 서비스04:서울시 중구 남대문 2가 9-105:105861004906:테스트성명07:11108:11109:201816869310:400011:40012:2011081713:공인인증서14:400015:116:081717:18:19:20:21:22:23:24:25:26:27:28:29:130:111";
				Delfino.signData(data, signCallback);
			}
			
		</script>
		
		<button onclick="signWithoutConfirm()">서명 확인 창 없이 서명 </button>
		<button onclick="signWithoutConfirmTest()">서명 확인 창 없이 서명(test) </button>
		<button onclick="signWithoutConfirmTest2()">서명 확인 창 없이 서명(test2) </button>
		
		
		
		<br/><br/><br/>
		<a href="javascript:popup();">Popup 실행</a><br/>
		<br/>위 팝업실행후 아래 테스트 하세요<br/>
		<a href="javascript:signClose();">Test1: signClose</a><br/>
		<a href="javascript:closeSign();">Test2: closeSign</a><br/>
		<br/>
		<a href="javascript:opener.openerSign();">Test3: openerSign</a><br/>
		
		<script>
		var pop = null;
		function popup(){
			var attribute = "width=508,height=580,toolbar=no,status=no,menubar=no, resizable=no,top=0,left=0,scrollbars=no";
    	    pop = window.open("signKeyValue.jsp","test", attribute);
		}
		function signClose(){
			opener.sign();
			this.close();
		}
		function closeSign(){
			this.close();
			opener.sign();
		}
		function openerSign(){
			if (pop != null) pop.close();
			sign();
		}
		
		
		</script>
		
		
	</body>
</html>