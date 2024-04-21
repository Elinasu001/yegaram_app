<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.*"%>
<%@page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<%! 
String escape(String str){
	str = str.replaceAll("%", "%25");
	str = str.replaceAll("&", "%26");
	str = str.replaceAll("=", "%3D");
	str = str.replaceAll("\\+", "%2B");
	return str;
}

String noescape(String str){
	return str;
}
%>
<%
String data1 = URLEncoder.encode("출금계좌번호", "utf8") + "=" + URLEncoder.encode("111111-22-333333", "utf8");
data1 += "&" + URLEncoder.encode("이체금액", "utf8") + "=" + URLEncoder.encode("10,000", "utf8");
data1 += "&" + URLEncoder.encode("수수료", "utf8") + "=" + URLEncoder.encode("0", "utf8");
data1 += "&" + URLEncoder.encode("송금메모", "utf8") + "=" + URLEncoder.encode("", "utf8");
data1 += "&" + URLEncoder.encode("입금은행", "utf8") + "=" + URLEncoder.encode("국민", "utf8");
data1 += "&" + URLEncoder.encode("입금계좌번호", "utf8") + "=" + URLEncoder.encode("444444-55-666666", "utf8");
data1 += "&" + URLEncoder.encode("받는분", "utf8") + "=" + URLEncoder.encode("김모군", "utf8");

String data2 = escape("출금계좌번호") + "=" + escape("111111-22-333333");
data2 += "&" + escape("이체금액") + "=" + escape("10,000");
data2 += "&" + escape("수수료") + "=" + escape("0");
data2 += "&" + escape("송금메모") + "=" + escape("123 123%= & +end");
data2 += "&" + escape("입금은행") + "=" + escape("국민");
data2 += "&" + escape("입금계좌번호") + "=" + escape("444444-55-666666");
data2 += "&" + escape("받는분") + "=" + escape("김모군");

String data3 = noescape("출금계좌번호") + "=" + noescape("111111-22-333333");
data3 += "&" + noescape("이체금액") + "=" + noescape("10,000");
data3 += "&" + noescape("수수료") + "=" + noescape("0");
data3 += "&" + noescape("송금메모") + "=" + noescape("123 123%= & +end");
data3 += "&" + noescape("입금은행") + "=" + noescape("국민");
data3 += "&" + noescape("입금계좌번호") + "=" + noescape("444444-55-666666");
data3 += "&" + noescape("받는분") + "=" + noescape("김모군");

String data4 = escape("출금계좌번호") + "=" + escape("1: 111111-22-333333");
data4 += "&" + escape("이체금액") + "=" + escape("2: 10,000");
data4 += "&" + escape("수수료") + "=" + escape("3: 0");
data4 += "&" + escape("송금메모") + "=" + escape("4: 123 123%= & +end");
data4 += "&" + escape("입금은행") + "=" + escape("5: 국민");
data4 += "&" + escape("입금계좌번호") + "=" + escape("6: 444444-55-666666");
data4 += "&" + escape("받는분") + "=" + escape("7: 김모군");
data4 += "&" + escape("이체금액") + "=" + escape("8: 10,000");
data4 += "&" + escape("수수료") + "=" + escape("9: 0");
data4 += "&" + escape("송금메모") + "=" + escape("10: 123 123%= & +end");
data4 += "&" + escape("입금은행") + "=" + escape("11: 국민");
data4 += "&" + escape("입금계좌번호") + "=" + escape("12: 444444-55-666666");
data4 += "&" + escape("받는분") + "=" + escape("13: 김모군");

session.setAttribute("confirmSign.data1", data1);
session.setAttribute("confirmSign.data2", data2);
session.setAttribute("confirmSign.data3", data3);
session.setAttribute("confirmSign.data4", data4);
%>

<!DOCTYPE HTML>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>전자서명</title>
<%@ include file="../svc/delfino.jsp" %>

</head>
<body>
	<h1>사용자 확인 전자서명 - form-urlencoding 스트링</h1>
	<form name="delfinoForm" method="post" action="confirmSign-formstring-withoutformatAction.jsp">
		<input type="hidden" name="PKCS7">
		<input type="hidden" name="VID_RANDOM">
		<input type="hidden" name="charset">
		<input type="hidden" name="data">
	</form>	
	<pre><%=data1%></pre>
	<button onclick="confirmSign1()">전자서명</button> key,value urlencoding(urlencoding시 charset은 utf8만 가능)<br/>
	<pre><%=data2%></pre>	
	<button onclick="confirmSign2()">전자서명</button> [default:utf8] key,value %,&,=,+만 urlencoding<br/>
	<button onclick="confirmSign3()">전자서명</button> [euckr] key,value %,&,=,+만 urlencoding<br/>
	<pre><%=data3%></pre>
	<button onclick="confirmSign4()">전자서명</button> key,valu urlencoding 하지 않아서 에러[-9201]<br/>
	<pre><%=data4%></pre>
	<button onclick="confirmSign5()">전자서명</button> 중복키값 존재 value 순서 중요<br/>
	<script>
	
	function confirmSign1(){
		document.delfinoForm.data.value = "data1";
		Delfino.confirmSign('<%=data1%>', complete);		
	}
	function confirmSign2(){
		document.delfinoForm.data.value = "data2";
		document.delfinoForm.charset.value = "utf8";
		Delfino.confirmSign('<%=data2%>', complete);		
	}
	function confirmSign3(){
		document.delfinoForm.data.value = "data2";
		document.delfinoForm.charset.value = "euckr";
		Delfino.confirmSign('<%=data2%>',{encoding:'euckr'}, complete);		
	}
	function confirmSign4(){
		document.delfinoForm.data.value = "data3";
		Delfino.confirmSign('<%=data3%>', complete)		
	}
	function confirmSign5(){
		document.delfinoForm.data.value = "data4";
		document.delfinoForm.charset.value = "utf8";
		Delfino.confirmSign('<%=data4%>', complete);		
	}
	
	function complete(result){
		if(result.status==0) return;
		if(result.status==1){
			document.delfinoForm.PKCS7.value = result.signData;
			document.delfinoForm.VID_RANDOM.value = result.vidRandom;
			document.delfinoForm.submit();
		}
		else{
			alert("error:" + result.message + "[" + result.status + "]");
		}
	}
	</script>
	
</body>
</html>
