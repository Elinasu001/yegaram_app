<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"
%><%@ page import="com.wizvera.vpcg.agent.RewriteAgent"
%><%@ page import="java.io.*"
%><%@ page import="java.net.*"
%><%@ page import="java.util.*"
%><%!
    boolean DEBUG_MODE = true;
    boolean Request_STDOUT_LOG = false;
    boolean Agent_STDOUT_LOG = false;
    RewriteAgent rewriteAgent = null;
    public void jspInit() {
        ServletContext context = getServletConfig().getServletContext();
        int connectionTimeout = 2000;
        int readTimeout = 1000;
        String vpcgRequestUrl = "";
        String vpcgAccessToken = "";
        String vpcgGatewayUrl = null;
        String vpcgProxyIp = null;
        Integer vpcgProxyPort = null;
        try {
            //com.wizvera.WizveraConfig delfinoConfig = new com.wizvera.WizveraConfig(getServletConfig().getServletContext().getRealPath("WEB-INF") + "/lib/delfino.properties");
            com.wizvera.WizveraConfig delfinoConfig = com.wizvera.WizveraConfig.getDefaultConfiguration();

            vpcgRequestUrl = delfinoConfig.getVpcgRequestUrl();
            connectionTimeout = delfinoConfig.getVpcgConnectionTimeout();            
            readTimeout = delfinoConfig.getVpcgReadTimeout();
            vpcgAccessToken = delfinoConfig.getVpcgAccessToken();
            vpcgGatewayUrl = delfinoConfig.getVpcgGatewayUrl();
            vpcgProxyIp = delfinoConfig.getVpcgProxyIp();
            vpcgProxyPort = delfinoConfig.getVpcgProxyPort();

            System.out.println("##############################################################################");
            System.out.println("### VeraPort-CG(delfino_vpcgAgent.jsp) config info");
            System.out.println("### delfino.properties [" + delfinoConfig.getPath() + "]");
            System.out.println("### vpcg.use [" + delfinoConfig.getUseVPCG() + "]");
            System.out.println("### vpcg.mode [" + delfinoConfig.getVpcgMode() + "]");
            System.out.println("### vpcg.request.url [" + vpcgRequestUrl + "]");
            System.out.println("### vpcg.result.url [" + delfinoConfig.getVpcgResultUrl() + "]");
            System.out.println("### vpcg.connection.timeout [" + connectionTimeout + "]");
            System.out.println("### vpcg.read.timeout [" + readTimeout + "]");
            System.out.println("### vpcg.access.token [" + vpcgAccessToken + "]");
            System.out.println("##############################################################################");

            if (vpcgGatewayUrl != null || vpcgProxyIp != null) {
                System.out.println("### vpcg.gateway.url [" + vpcgGatewayUrl + "]");
                System.out.println("### vpcg.proxy.ip [" + vpcgProxyIp + "]");
                if (vpcgProxyIp != null) {
                    System.out.println("### vpcg.proxy.port [" + vpcgProxyPort + "]");
                    rewriteAgent = new RewriteAgent(context, vpcgRequestUrl, vpcgAccessToken, new Proxy(Proxy.Type.HTTP, new InetSocketAddress(vpcgProxyIp, vpcgProxyPort)), vpcgGatewayUrl);
                } else {
                    rewriteAgent = new RewriteAgent(context, vpcgRequestUrl, vpcgAccessToken, null, vpcgGatewayUrl);
                }
                System.out.println("##############################################################################");
            }
            else {
                rewriteAgent = new RewriteAgent(context, vpcgRequestUrl, vpcgAccessToken);
            }
            //rewriteAgent = new RewriteAgent(context, vpcgRequestUrl);

            rewriteAgent.CONNECT_TIMEOUT = connectionTimeout; //1000 * 20;
            rewriteAgent.READ_TIMEOUT = readTimeout; //1000 * 10;

            rewriteAgent.LOGGING = true;
            rewriteAgent.ACCESS_LOGGING = true;
            rewriteAgent.DATA_LOGGING = true;

            rewriteAgent.STDOUT_LOG = Agent_STDOUT_LOG;
            rewriteAgent.SERVLET_LOG = true;

        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("delfino-vpcgAgent.jsp init fail(" + vpcgRequestUrl + ")", e);
        }
    }
    public String getRequestParameter(HttpServletRequest request, String tag) {
        StringBuffer sb = new StringBuffer();
        java.util.Enumeration he3 = request.getParameterNames();
        sb.append(tag); //request.getContextPath() + request.getServletPath();
        sb.append("###########################################################################" + tag);
        sb.append("#" + request.getRequestURI() + " " + request.getMethod() + "][" + request.getRemoteAddr() + "]" + tag);
        //request.getContextPath() + request.getServletPath()

        while (he3.hasMoreElements()) {
            String name = (String)he3.nextElement();
            String[] value = request.getParameterValues(name);
            if (value == null) {
                sb.append("#   [" + name + "] = [null]" + tag);
            } else {
                for (int i=0; i<value.length; i++) {
                    sb.append("#   [" + name + "] = [" + value[i] + "]" + tag);
                }
            }
        }
        sb.append("###########################################################################");
        return sb.toString();
    }
    public void printVpcgRequestInfo(HttpServletRequest request) {
        java.text.DateFormat logDate = new java.text.SimpleDateFormat("[yyyy/MM/dd HH:mm:ss] ");
        String requestInfo = logDate.format(new java.util.Date()) + "[VPCG-AGENT]";
        requestInfo += "[" + request.getParameter("provider") + "] ";
        requestInfo += "signType[" + request.getParameter("signType") + "] ";
        requestInfo += "action[" + request.getParameter("action") + "] ";
        if (Request_STDOUT_LOG) System.out.println(getRequestParameter(request, "\n")); //TODO: request trace
        System.out.println(requestInfo);
    }
%><%
    if(request.getCharacterEncoding()==null){
        request.setCharacterEncoding("utf-8");
    }
    response.setHeader("Access-Control-Allow-Origin","*");
    if (DEBUG_MODE) printVpcgRequestInfo(request);
    out.clear(); out=pageContext.pushBody(); //IllegalStateException: UT010006
    rewriteAgent.rewrite(request, response, session);
%>