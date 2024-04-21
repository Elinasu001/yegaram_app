<%@page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.wizvera.etax.SignAndEncrypt"%>
<%@ page import="com.wizvera.util.Base64"%>

<html>
<body>

	<%
		request.setCharacterEncoding("UTF-8");
		// 이전 페이지로부터 XML Signature를 적용할 전자세금계산서 원본 XML을 읽어옴.
		String signedTaxInvoiceXml = request.getParameter( "signData" );
		String vidRandom = request.getParameter( "VID_RANDOM" );

		// Validation
		String orgTaxInvoice = null;
		boolean result = false;
		try {
			SignAndEncrypt sae = SignAndEncrypt.getInstance();
			byte[] rValue = Base64.decode(vidRandom);
			boolean checkSignerCertValidation = false;
			result = sae.validateSignature( signedTaxInvoiceXml, rValue, checkSignerCertValidation );
		}
		catch (Exception e) {
			out.println( "<p/>" );
			out.println( "Error Occured:" + e.getMessage() );
			out.println( "<p/>" );
			e.printStackTrace();
		}
		
		String validationResult = null;
	%>
		검증 결과 :
	<%
		if( result ){
			validationResult = "검증 성공";
		}else{
			validationResult = "검증 실패";
		}
	%> 
		<b><%=validationResult%></b><br/>
		<b>vidRandom:<%=vidRandom%></b>
</body>
</html>