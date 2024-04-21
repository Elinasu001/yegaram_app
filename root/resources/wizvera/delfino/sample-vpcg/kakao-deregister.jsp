<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.wizvera.vpcg.*"%>
<%@ page import="com.wizvera.vpcg.agent.*"%>
<%@ page import="java.util.Properties"%>
<%@ page import="java.io.*"%>
<!DOCTYPE HTML>
<html>
<head>
    <title>VeraPort CG</title>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
</head>
<body>

<h2>kakao: 이용등록해제</h2>

<form name="deregisterForm" method="post" action="kakao-deregister.jsp">
    <input type="hidden" name="_action" value="deregister"/>
    service_user_id: <input type="text" name="service_user_id" value=''><br/>
</form>
<button onclick="TEST_deregister()">이용등록해제요청</button><br/>

<script type="text/javascript">
function TEST_deregister() {
	if (confirm("카카오페이 이용등록 해제요청을 하시겠습니까?")) document.deregisterForm.submit();
}
</script>

<hr/>
<%
	String action = request.getParameter("_action");
	String service_user_id = request.getParameter("service_user_id");
    if("deregister".equals(action) && service_user_id != null && !"".equals(service_user_id)) {
	    out.println("<br/>-. <b>이용등록해제요청: service_user_id[" + service_user_id + "]</b>");
		try {
			com.wizvera.service.VpcgSignResultAddedService.deregister("kakao", service_user_id);
		    out.println("<br/>-. <b>vpcgSignResultService.deregister: " + service_user_id + ": OK</b>");
        /* }catch(VpcgSignResultException e){
            e.printStackTrace();
            out.println("<hr/>errorCode:<br/>");
            out.println(e.getErrorCode());
            out.println("<hr/>getErrorMessage:<br/>");
            out.println(e.getErrorMessage());
            out.println("<hr/>getRawResponse:<br/>");
            out.println(e.getRawResponse());
        } */
	    } catch (Exception e) {
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

</body>
</html>