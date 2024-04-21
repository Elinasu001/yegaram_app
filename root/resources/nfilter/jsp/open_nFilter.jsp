<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="net.nshc.nfilter.openweb.OpenWebNFilterConfig" %>

<!-- OWN default script -->
<script language="JavaScript" type="text/javascript" src="<%=request.getContextPath()%>/resources/nfilter/js/jquery-1.12.4.min.js" charset="<%=OpenWebNFilterConfig.getFileEncoding()%>"></script>
<script> var own = $.noConflict() </script>
<script language="JavaScript" type="text/javascript" src="<%=request.getContextPath()%>/resources/nfilter/js/jquery-ui.js" charset="<%=OpenWebNFilterConfig.getFileEncoding()%>"></script>
<script language="JavaScript" type="text/javascript" src="<%=request.getContextPath()%>/resources/nfilter/js/open_nFilter.js" charset="<%=OpenWebNFilterConfig.getFileEncoding()%>"></script>
<script language="JavaScript" type="text/javascript" src="<%=request.getContextPath()%>/resources/nfilter/js/secretUtil.js" charset="<%=OpenWebNFilterConfig.getFileEncoding()%>"></script>

<script type="text/javascript" charset="<%=OpenWebNFilterConfig.getFileEncoding()%>">

    nshc.contextPath = "<%=request.getContextPath()%>";
    nshc.CSSPath = nshc.contextPath + "/resources/nfilter/css";
    nshc.imgPath = nshc.contextPath + "/resources/nfilter/image";
    nshc.randomIdLength = <%=OpenWebNFilterConfig.getRandomIdLength()%>;
    nshc.serviceNameKeypadManager = "<%=OpenWebNFilterConfig.getServiceNameKeypadManager()%>";
    nshc.algName = "<%=OpenWebNFilterConfig.getAlgName()%>";
    nshc.keyLength = "<%=OpenWebNFilterConfig.getKeyLength()%>";
    nshc.uuSessionUse = <%=OpenWebNFilterConfig.getUnusedSessionUse()%>;
    nshc.NSCryptoUse = <%=OpenWebNFilterConfig.getNscryptoUse()%>;

</script>
