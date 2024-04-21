<%@ page import="java.security.cert.X509Certificate" %>
<%@ page import="org.bouncycastle.jce.provider.BouncyCastleProvider"%>
<%@ page import="org.bouncycastle.asn1.kisa.KISAObjectIdentifiers"%>
<%@ page import="java.security.Security"%>

<%@ page import="com.wizvera.crypto.PKCS7EnvelopedDataKtriGenerator"%>
<%@ page import="com.wizvera.crypto.compatibility.PKCS7EnvelopedDataKtriHelper"%>
<%@ page import="com.wizvera.crypto.CertUtil"%>
<%@ page import="com.wizvera.crypto.PKCS7EnvelopedDataResult"%>
<%@ page import="com.wizvera.util.CipherUtil"%>
<%@ page import="java.io.*"%>


<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<%! 
	static {
		//Security.addProvider(new BouncyCastleProvider());	// BC 프로바이더 추가
	}
%>
<%
	//암호화용 금결원 인증서
	String certPEM = "" 
		+ "-----BEGIN CERTIFICATE-----\n"
		+ "MIIE9jCCA96gAwIBAgIEFyOkvDANBgkqhkiG9w0BAQsFADBSMQswCQYDVQQGEwJr\n"
		+ "cjEQMA4GA1UECgwHeWVzc2lnbjEVMBMGA1UECwwMQWNjcmVkaXRlZENBMRowGAYD\n"
		+ "VQQDDBF5ZXNzaWduQ0EgQ2xhc3MgMTAeFw0xNDA5MDMxNTAwMDBaFw0xNjA5MjEx\n"
		+ "NDU5NTlaMGoxCzAJBgNVBAYTAmtyMRAwDgYDVQQKDAd5ZXNzaWduMQ8wDQYDVQQL\n"
		+ "DAZzZXJ2ZXIxEDAOBgNVBAsMB3llc3NpZ24xDTALBgNVBAsMBEtGVEMxFzAVBgNV\n"
		+ "BAMMDnd3dy5rZnRjLm9yLmtyMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC\n"
		+ "AQEAtdV5dPRgp36MU4XvPU3is0Itq9JtM6pfXBKuI0EahzajJFxjASRQkh1Zdqha\n"
		+ "1HLQI8FiuVPASLMX1ksnQt37Fi7ltfguEiIHLIfL71RbkTgsf5b3mCO98DiRefJG\n"
		+ "XnQ7dWj1MY1PU3m8zsgJjrFpR0e/5XRw71ChABpOq8TNbULs9LbJzfK4HLN0kChq\n"
		+ "WcgVCl2rKpFjnBsJlg9ziTecHM2YDMTvG1tQEb+bHJ4V+B4i9+IbRuqbr6ITj3AZ\n"
		+ "D7lcv3vE/oecW75OIzEPL2nomtT+IVUwcmM8XgDcLBU91j/p/pVvVN6FmlVf/28H\n"
		+ "V/ij1QI70UrQNh+QOQcc7rArFQIDAQABo4IBujCCAbYwgY8GA1UdIwSBhzCBhIAU\n"
		+ "UgQyn4+dIXK6+jOYqGF+JzMkjV+haKRmMGQxCzAJBgNVBAYTAktSMQ0wCwYDVQQK\n"
		+ "DARLSVNBMS4wLAYDVQQLDCVLb3JlYSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eSBD\n"
		+ "ZW50cmFsMRYwFAYDVQQDDA1LSVNBIFJvb3RDQSA0ggIQAzAdBgNVHQ4EFgQUraqu\n"
		+ "d/gTGJJbo7RLGKaVU+F0HB4wDgYDVR0PAQH/BAQDAgUgMBkGA1UdIAEB/wQPMA0w\n"
		+ "CwYJKoMajJpFAQEDMCoGA1UdEQQjMCGgHwYJKoMajJpECgEBoBIwEAwOd3d3Lmtm\n"
		+ "dGMub3Iua3IwcgYDVR0fBGswaTBnoGWgY4ZhbGRhcDovL2RzLnllc3NpZ24ub3Iu\n"
		+ "a3I6Mzg5L291PWRwNHA0MjY3OCxvdT1BY2NyZWRpdGVkQ0Esbz15ZXNzaWduLGM9\n"
		+ "a3I/Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlzdDA4BggrBgEFBQcBAQQsMCowKAYI\n"
		+ "KwYBBQUHMAGGHGh0dHA6Ly9vY3NwLnllc3NpZ24ub3JnOjQ2MTIwDQYJKoZIhvcN\n"
		+ "AQELBQADggEBAMADb21Xj9cALgXqTqdS4c69Au0jmvuVIJrpFldnNSdCyZkK7pcI\n"
		+ "PWEUjUwVErHKwb9mahSPqvZ5daqTPcQnMBNCLN1DEg3+sE/W2wifDgrjpyVIWIyt\n"
		+ "SkP7X2679g+ROcqfkfZ/Wlgqbi12g77SJErYVMeBmPc0KXHAMP2SEB1H8I9nIOeO\n"
		+ "wYbmoGQ4/NDsU0+MHF4k5fwKMlzLGyKpsmmO39EluIY/739xjjZ1wZDhDxw2zOv6\n"
		+ "PSqOgOf9Wb8Y3e5XJ+HJuMDEzJrxAUkvvu3fVUjAFpeMl9OPN+dzpXyIRqLr/sMf\n"
		+ "Ne2FICx0MGNH/nM2gzlkuangVviYa+gls18=\n" 
		+ "-----END CERTIFICATE-----\n";
%>


<%
	String action = request.getParameter("_action");
	
	if("sign".equals(action)){ //결제
		String signedAndEnvelopedData = request.getParameter("signedAndEnvelopedData");
		out.println("1. signedAndEnvelopedData:["+signedAndEnvelopedData+"]");
	} else { //인증
		String data = request.getParameter("data");
		certPEM = request.getParameter("certPEM"); //certPEM = certPEM.replaceAll("\r", "");
		
		try {
			X509Certificate cert = CertUtil.loadCertificateFromString(certPEM); //String:암호화용 금겨원인증서를 X509Certifcate로 변환
			//X509Certificate cert = CertUtil.loadCertificate("C:\\cert.pem"); //File:암호화용 금결원인증서를 X509Certifcate로 변환

			PKCS7EnvelopedDataKtriGenerator generator = PKCS7EnvelopedDataKtriHelper.getPKCS7EnvelopedDataKtriGenerator();	
			PKCS7EnvelopedDataResult result = generator.genPKCS7EnvlopedDataKtri(data.getBytes(), KISAObjectIdentifiers.id_seedCBC.getId(), cert); // EnvelopedData 생성(SEED_CBC모드)
			
			byte[] iv = result.getIv();				// 암호화에 사용된 IV(Initialization Vector)값
			byte[] key = result.getCek();			// 컨텐츠를 암호화한 값
			byte[] content = result.getContent();	// EnvelopedData 메시지 중 ContentType을 제외한 content를 DER 인코딩한 값
			//byte[] envelopedData = result.getEnvelopedData();	// EnvelopedData 전체 메시지를 DER 인코딩한 값
			
			out.println("1.1. 암호화에 사용된 IV(Initialization Vector)값: "+com.wizvera.util.Base64.encode(iv)+"</br>");
			out.println("1.2. 컨텐츠를 암호화한 값: "+com.wizvera.util.Base64.encode(key)+"</br>");
			out.println("1.3. EnvelopedData 메시지 중 ContentType을 제외한 content를 DER 인코딩한 값: "+com.wizvera.util.Base64.encode(content)+"</br>"); //Base64 인코딩 출력
			//out.println("5. EnvelopedData 전체 메시지를 DER 인코딩한 값: "+envelopedData+"</br>");
			
			
			//금결원에서 받은 암호화된 데이터
			byte[] encData = CipherUtil.encryptWithSymmetricKey("금결원에서 받은 암호화된 데이터".getBytes(), key, iv, "SEED", "SEED/CBC/PKCS5Padding");
			out.println("2.1. 암호화된 데이터: " + com.wizvera.util.Base64.encode(encData)+"</br>");
			//out.println("2.1. 암호화된 데이터: " + com.wizvera.util.Hex.encode(encData)+"</br>");

			//데이타 목호화
			byte[] decData = CipherUtil.decryptWithSymmetricKey(encData, key, iv, "SEED", "SEED/CBC/PKCS5Padding");
			out.println("2.2. 복호화된 데이터: " + new String(decData)+"</br>");
			
			
		}catch(Exception e){
			e.printStackTrace();
	        out.println("<br/><hr/><b>Exception - ERR(?)</b>");
	        out.println("<br/>FileName: " + request.getServletPath());
	        out.println("<br/>getMessage: " + e.getMessage());
	        java.io.StringWriter sw = new java.io.StringWriter();
	        java.io.PrintWriter pw = new java.io.PrintWriter(sw);
	        e.printStackTrace(pw);
	        out.println("<br><br><b>printStackTrace</b><br>");
	        out.println("<font size='2'>" + sw.toString() + "<font>");
		}	
		
	}
%>


