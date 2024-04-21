<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>   
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<!-- 데모용 include SITE에선 제거하세요. -->
<%@ include file="_demo_only.jsp" %>
<%
	String lang = request.getParameter("LANG");
	if(lang!=null){
		session.setAttribute("LANG", lang);
	}
%>

<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width" />
		<title>Login</title>
<%@ include file="../svc/delfino.jsp" %>
    </head>
    <body>
<!-- veraport asp start -->
<script type="text/javascript" src="http://code.jquery.com/jquery-1.8.2.js"> </script> 
<script type="text/javascript" src="http://192.168.0.4/vasites/customer/lWeE74/veraport/veraport20.js" > </script> 
<script type="text/javascript" src="http://192.168.0.4/vasites/customer/lWeE74/veraport/veraport20_multi.js" > </script> 
<script type="text/javascript"> VPASP_InstallMust() </script>
<!-- veraport asp end --> 

    	<a href="wizveraconfig.jsp">설정보기</a>
    	<a href="../../kb/delfino_info.html">info</a>
    	<a href="pkcs7.html">PKCS7_Dump</a>
		<a href="index.jsp?LANG=KOR">한국어</a> <a href="index.jsp?LANG=ENG" >영어</a> <a href="index.jsp?LANG=CHN">중국어</a> <a href="index.jsp?LANG=JPN">일본어</a>
    	
    	<h4> 로그인 및 서명 </h4>
    	<a href="login.jsp">로그인</a>
		<a href="sign.jsp">전자서명</a><br/>
		<a href="signKeyValue.jsp">전자서명 KeyValue</a>
		<a href="multiSign.jsp">다중서명</a>
		<a href="addSigner.jsp">다자서명</a>
		<br/>
		<a href="signTest.jsp">signTest</a>
		<a href="xmldsigkec.jsp">XMLDsig</a>
    	<h4> 발급 갱신</h4>
		<a href="cmp.jsp">CMP</a><br/>
		
    	<h4> 기타</h4>
		<a href="import_export.jsp">가져오기/내보내기</a>
		<a href="showcertificate.jsp">쇼인증서</a>
		<br/><button onclick="Delfino.manageCertificate()">인증서관리</button>
		
    	<h4> E2E  </h4>
		<a href="../../e2e/softcamp/e2e.jsp">E2E-softcamp</a>
		
		<script language="javascript">
			function goDelfino(url)
			{
				var encUrl = encodeURIComponent(url);
				window.location.href = "kbmobileweb://"+encUrl;
			}
		</script>
		
		<h4>모바일(아이폰)</h4>
		<a href="kbmobileweb://http%3a%2f%2fdemo.wizvera.com">초기화면</a>
		<a href="#" onclick="javascript:goDelfino('http://demo.wizvera.com');">js</a>
		<br>
		<a href="kbmobileweb://http%3a%2f%2fdemo.wizvera.com%2fdelfino-demo%2fdelfino%2fsample%2flogin.jsp">로그인</a>
		<a href="#" onclick="javascript:goDelfino('http://demo.wizvera.com/delfino-demo/delfino/sample/login.jsp');">js</a>
		<br>
		<a href="kbmobileweb://http%3a%2f%2fdemo.wizvera.com%2fdelfino-demo%2fdelfino%2fsample%2fimport_export.jsp">가져오기 내보내기</a>
		<a href="#" onclick="javascript:goDelfino('http://demo.wizvera.com/delfino-demo/delfino/sample/import_export.jsp');">js</a>
		<br>
		<a href="kbmobileweb://http%3a%2f%2fdemo.wizvera.com%2fdelfino-demo%2fdelfino%2fsample%2fshowcertificate.jsp">쇼인증서</a>
		<a href="#" onclick="javascript:goDelfino('http://demo.wizvera.com/delfino-demo/delfino/sample/showcertificate.jsp');">js</a>
		<br>

	<script>
	function openPop(type){
	  var openUrl = "popup.jsp";
	  var param   = "펀드종목코드=바보멍충이";
	  
	  if (type == 1)
	  	window.open(openUrl, "테스트팝업");
	  else {
        document.getElementById('TEST_POPUP').submit();
	  }
	}
	</script>
	
	<form id=TEST_POPUP name=TEST_POPUP method="get" action="popup.jsp" target="_blank">
	</form>

		<h4> 새창 </h4>
		<a href="popup.jsp">새창</a>
		<input type="submit" value="submitPopup(open)" onclick="javascript:openPop(1); return false;"/>
		<input type="submit" value="submitPopup(target)" onclick="javascript:openPop(2); return false;"/>
		<a href="popup.jsp" onclick="window.open(this.href,'','width=870,height=630,top=0,left=0,scrollbars=yes');return false;" target="_blank" class="link_blank">타켓오픈</a></li>
		
		<h4> 다운로드 </h4>
		
		<a href="./oFileDownloadTest.jsp">다운로드</a>
		<a href="http://www.wizvera.com/test/dn.xls">xls</a>
		<a href="http://www.wizvera.com/test/dn.doc">doc</a>
		<a href="http://www.wizvera.com/test/dn.ppt">ppt</a>
		<a href="http://www.wizvera.com/test/dn.hwp">hwp</a>
		<a href="http://www.wizvera.com/test/dn.txt">txt</a>
		
		<h4> 폼데이터</h4>
		<a href="formdata.jsp">폼데이터</a>
		
		
		<h4> <a href="#" onclick="getMACAddress();return false"> MAC address </a>  
		</h4>
		<script>
		function getMACAddress(){
			alert(Delfino.getMACAddress());
		}		
		</script>
		
		
		<h4>
		<a href="index.jsp" id="minibank" onclick="return openMiniBank(this.href);">모바일오픈</a>
		</h4>
		<script>
		function openMiniBank(linkUrl){
			var url = linkUrl;
			var attribute = "width=508,height=580,toolbar=no,status=no,menubar=no, resizable=no,top=0,left=0,scrollbars=no";
		      if((navigator.userAgent.match(/iPhone/i)) || (navigator.userAgent.match(/iPod/i)) || navigator.userAgent.match(/Android/i) || (navigator.userAgent.match(/iPad/i))) {
		          return true;
		      } else {
		    	  alert("Windows Open");
			     window.open(url,"minibank",attribute);
		          return false;
		      }
		}
		</script>
		
    </body>
</html>
