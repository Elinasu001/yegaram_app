<!-- demon only jsp! do NOT use this jsp for REAL SITE !! -->
<%!
	///////////////////////////////////////////////////////////////////////////////
	// !! SITE ONLY !!
	private void makeDemoPropertiesFile(String webInfPath, String configFile) {
		java.util.Properties demoProperties = new java.util.Properties();
		
		final String certstoredir = webInfPath + java.io.File.separatorChar + "certstore-real";
		final String oidfile = webInfPath + java.io.File.separatorChar + "real-oid.txt";
		//final String oidfile = webInfPath + java.io.File.separatorChar + "test-oid.txt";
		
		demoProperties.put("cacertificates.path", certstoredir);
		demoProperties.put("oidfile.path", oidfile);
		
		demoProperties.put("e2e.custom.code", "109");
		
		demoProperties.put("server.certificate.path", "/someWhere/someCert.der");
		demoProperties.put("server.privatekey.path", "/soemWhere/someKey.key");
		demoProperties.put("server.privatekey.password", "encryptedPassword");
		
		try {
			java.io.FileOutputStream fos = new java.io.FileOutputStream(configFile);
			demoProperties.store(fos,"delfino-demo delfino.properties");
			System.out.println(configFile);
			System.out.println("-------------------------------------");
			//log
			demoProperties.store(System.out,"delfino-demo delfino.properties");
			fos.close();
		} catch (java.io.IOException e) {
			System.out.println("failed to create delfino.properties.");
			e.printStackTrace();
		}
	}
%>
<%
{
	String webInfPath = getServletConfig().getServletContext().getRealPath("WEB-INF");
	String configFile = webInfPath + java.io.File.separatorChar + "lib" + java.io.File.separatorChar + "delfino.properties";
	
	if (new java.io.File(configFile).exists() == false) {
		makeDemoPropertiesFile(webInfPath, configFile);
	} 
}
%>