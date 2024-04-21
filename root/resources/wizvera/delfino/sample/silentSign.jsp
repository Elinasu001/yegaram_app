<%@page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>silent 테스트</title>
	<%@ include file="../svc/delfino.jsp" %>
</head>
<body>
	<h2>자동서명(silentSign)</h2>
<script>

var data = [];
var index = 0;

for(var i = 0; i < 10; ++i){
	data[i] = "a" + i;
}

function sign()
{
	Delfino.sign(data[0], {ssid:null, silentSign:true}, silentSignComplete);
	index=1;
}

function silentSignComplete(result){
	if(result.status==0) return;
	
	if(result.status==1){
		
		//처리
		console.log("cnt:" + index);
		jQuery("#signdata").append("<li>" + result.signData +"</li>");
		
		if(index < data.length){
			Delfino.sign(data[index], {ssid:result.ssid, silentSign:true}, silentSignComplete);
			index++;
		}
		else{
			Delfino.endSign(result.ssid, endSilentSignComplete);
		}
	}
	else{
		alert("error:" + result.message + "[" + result.status +"]");
	}
}

function endSilentSignComplete(result){
	if(result.status==1){
		alert("success:" + index);
	}
	else{
		alert("error:" + result.message + "[" + result.status +"]");
	}
}

function xmldsigSilentSignComplete(result){
	if(result.status==0){
		return;
	}
	if(result.status!=1){
		alert(result.status + ":" + result.message);
		return;
	}
	console.log("cnt:" + index);
	if(index < data.length){
		Delfino.sign(document.xmlForm.xml.value, {silentSign:true, dataType: "xml", signType:"xmldsig-kec", ssid:result.ssid}, xmldsigSilentSignComplete);
		index++;
	}
	else{
		Delfino.endSign(result.ssid, endSilentSignComplete);
		
		//document.signForm.signData.value = result.signData;
		//document.signForm.VID_RANDOM.value = result.vidRandom;
		//document.signForm.submit();
	}
}

function silentSignXmldsig(){			
	Delfino.sign(document.xmlForm.xml.value, {silentSign:true, dataType: "xml", signType:"xmldsig-kec", ssid:null}, xmldsigSilentSignComplete);			
}		

</script>
<h3>1. pkcs7 자동서명</h3>
<button onclick="sign()">자동 서명</button>
<ol id='signedData'></ol>
<br/>
<h3>2. xmldsig 자동서명</h3>
    	<form name="xmlForm">
    	입력:<textarea rows="10" cols="80" name="xml"><?xml version="1.0" encoding="UTF-8"?><TaxInvoice xmlns="urn:kr:or:kec:standard:Tax:ReusableAggregateBusinessInformationEntitySchemaModule:1:0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="urn:kr:or:kec:standard:Tax:ReusableAggregateBusinessInformationEntitySchemaModule:1:0 http://www.kec.or.kr/standard/Tax/TaxInvoiceSchemaModule_1.0.xsd">
  <ExchangedDocument>
    <ID/>
    <IssueDateTime>20120308133300</IssueDateTime>    
  </ExchangedDocument>    
  <TaxInvoiceDocument>
    <IssueID>2011021041000001900049c0</IssueID>
    <TypeCode>0201</TypeCode>    
<DescriptionText>이관전 마지막1 비고 테스트임당...ㅎㅎㅎ 젠장 비점 그만오삼..</DescriptionText>    
    <IssueDateTime>20110210</IssueDateTime>
    <AmendmentStatusCode>01</AmendmentStatusCode>    
    <PurposeCode>01</PurposeCode>
    <ReferencedImportDocument>
    	<ID>ABCDEFGHIJKLMN</ID>
    	<ItemQuantity>500</ItemQuantity>
    	<AcceptablePeriod>
    		<StartDateTime>20091101</StartDateTime>
    		<EndDateTime>20091231</EndDateTime>
    	</AcceptablePeriod>
    </ReferencedImportDocument>    
  </TaxInvoiceDocument>
  <TaxInvoiceTradeSettlement>
    <InvoicerParty>
      <ID>3525734275</ID>
      <TypeCode>제조</TypeCode>      
      <NameText>㈜수다</NameText>      
      <ClassificationCode>즞</ClassificationCode>      
      <SpecifiedOrganization>
        <TaxRegistrationID>0001</TaxRegistrationID>
      </SpecifiedOrganization>
      <SpecifiedPerson>
        <NameText>김철수</NameText>
      </SpecifiedPerson>
      <DefinedContact>
      	<DepartmentNameText>글로비스 네트웍 구축(본사 추가 구축)</DepartmentNameText>
      	<PersonNameText>류주희</PersonNameText>
      	<TelephoneCommunication>123456789012</TelephoneCommunication>
      	<URICommunication>rjh1019@nate.com</URICommunication>
      </DefinedContact>      
      <SpecifiedAddress>
        <LineOneText><![CDATA[경기도 시흥시 대야동 573-2 모비딕빌딩8층]]></LineOneText>
      </SpecifiedAddress>
    </InvoicerParty>
    <InvoiceeParty>
      <ID>3525734275</ID>    	
      <TypeCode>제조</TypeCode>      
      <NameText>비어만세</NameText>      
      <ClassificationCode>서비스</ClassificationCode>      
      <SpecifiedOrganization>
        <TaxRegistrationID>0</TaxRegistrationID>
        <BusinessTypeCode>01</BusinessTypeCode>        
      </SpecifiedOrganization>
      <SpecifiedPerson>
        <NameText>전종우</NameText>
      </SpecifiedPerson>
      <SpecifiedAddress>
        <LineOneText>서울시 서초구 서초동</LineOneText>
      </SpecifiedAddress>
    </InvoiceeParty>
    <BrokerParty>
      <ID>3525734275</ID>
      <TypeCode>서비스</TypeCode>      
      <NameText>(주)미영</NameText>      
      <ClassificationCode>기타서비스</ClassificationCode>      
      <SpecifiedOrganization>
        <TaxRegistrationID>800</TaxRegistrationID>      	
      </SpecifiedOrganization>
      <SpecifiedPerson>
        <NameText>홍길동</NameText>
      </SpecifiedPerson>
      <DefinedContact>
      	<DepartmentNameText>수탁시스템</DepartmentNameText>
      	<PersonNameText>김수탁</PersonNameText>
      	<TelephoneCommunication>555555555555</TelephoneCommunication>
      	<URICommunication>kimsutck@hanmail.net</URICommunication>
      </DefinedContact>      
      <SpecifiedAddress>
        <LineOneText>서울특별시 서초구 반포동 143-99김수탁사무실</LineOneText>
      </SpecifiedAddress>
    </BrokerParty>           
    <SpecifiedMonetarySummation>
      <ChargeTotalAmount>-223630</ChargeTotalAmount>
      <TaxTotalAmount>0</TaxTotalAmount>
      <GrandTotalAmount>-246000</GrandTotalAmount>
    </SpecifiedMonetarySummation>
  </TaxInvoiceTradeSettlement>
  <TaxInvoiceTradeLineItem>
    <SequenceNumeric>1</SequenceNumeric>
    <InvoiceAmount>1000000</InvoiceAmount>    
    <ChargeableUnitQuantity>0</ChargeableUnitQuantity>    
    <NameText>연필</NameText>
    <PurchaseExpiryDateTime>20090701</PurchaseExpiryDateTime>    
    <UnitPrice>
      <UnitAmount>100.</UnitAmount>
    </UnitPrice>    
  </TaxInvoiceTradeLineItem>
                 
</TaxInvoice></textarea>
    	</form>
    	<form action="xmldsigkecAction.jsp" method="post" name="signForm">
    		출력:<textarea rows="10" cols="80" name="signData"></textarea>
    		<input type="hidden" name="VID_RANDOM"/>
    		<input type="submit"/>
    	</form>
    	
		<button onclick="silentSignXmldsig()">자동서명</button>
</body>
</html>