<%@page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="com.wizvera.eti.SignAndEncryptor"%>
<html>
<body>

	<%
		request.setCharacterEncoding("UTF-8");
		// 이전 페이지로부터 XML Signature를 적용할 전자세금계산서 원본 XML을 읽어옴.
		String taxInvoiceXml = request.getParameter( "data" );
		System.out.println(taxInvoiceXml);
		//out.println( taxInvoiceXml );

		// XML Signature를 적용
		String signedData = null;
		try {
			SignAndEncryptor sae = SignAndEncryptor.getInstance();
			signedData = sae.sign( taxInvoiceXml );
		}
		catch (Exception e) {
			out.println( "<p/>" );
			out.println( "Error Occured:" + e.getMessage() );
			out.println( "<p/>" );
			e.printStackTrace();
		}

		//out.println( "<br/> orgData<br/>" + taxInvoiceXml );
	%>
		XML Signature가 적용된 서명 데이터<BR /><BR />
		<TEXTAREA cols="150" rows="25" readonly="readonly"><%=signedData%></TEXTAREA>
</body>
</html>
