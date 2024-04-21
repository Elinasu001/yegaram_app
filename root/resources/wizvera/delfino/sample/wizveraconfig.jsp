<%@page import="com.wizvera.crypto.PolicyChecker"%>
<%@page import="com.wizvera.crypto.CACerts"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.wizvera.WizveraConfig"%>
<%@page import="java.security.cert.X509Certificate" %>
<%!
   public static String which(String className) {

    if (!className.startsWith("/")) {
      className = "/" + className;
    }
    className = className.replace('.', '/');
    className = className + ".class";

    java.net.URL classUrl =
      WizveraConfig.class.getResource(className);

    if (classUrl != null) {
	return classUrl.getFile();
    } else {
	return "Not Found";
    }
  }

%>
<%
	WizveraConfig wizConfig = WizveraConfig.getDefaultConfiguration();

	out.println("PKIXCert...:" + which("java.security.cert.PKIXCertPathBuilderResult") + "<br/>");
	out.println("WizveraConfig:" + which("com.wizvera.WizveraConfig") + "<br/>");
	out.println("CertificateVerifier:" + which("com.wizvera.crypto.CertificateVerifier") + "<br/>");

	// 설정 내용
	out.println("<h2>delfino.properties</h2>");
	Enumeration enu = wizConfig.propertyNames();

	out.println(wizConfig.getPath() + "<br/>");
	out.println("-----------------------<br/>");
	
	while(enu.hasMoreElements()) {
		String key = (String)enu.nextElement();
		String value = wizConfig.getProperty(key);
		out.println(key+"="+value+"<br/>");
	}
	
	// 설정에 따라 읽어온 서버 인증서개수
	out.println("<h2>CACerts</h2>");
	CACerts cacerts = wizConfig.getCACerts();	
	int count = cacerts.getSetOfX509Certificates().size();
	out.println("count :  " + count + "<br/>");
	out.println("-----------------------<br/>");
	Iterator<X509Certificate> it = cacerts.getSetOfX509Certificates().iterator();
	
	while(it.hasNext()) {
		X509Certificate cert = it.next();
		out.println(cert.getSubjectDN() + "<br/>");
	}
	
	//PolicyChecker policyChecker = wizConfig.getPolicyChecker();
%>
