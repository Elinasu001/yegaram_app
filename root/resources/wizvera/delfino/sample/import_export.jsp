<%@page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta name="viewport" content="width=device-width" />
		<title>가져오기/내보내기</title>
		
<%@ include file="../svc/delfino.jsp" %>		

    </head>
    <body>
    	<h2>내보내기</h2>
    	 <!-- <input type="button" value="내보내기" onclick="javascript:onExport();"/> -->
		 <button onclick="onExport();">내보내기</button>	
		<hr/>
		<h2>가져오기</h2>
    	 <!-- <input type="button" value="가져오기" onclick="javascript:onImport();"/> -->
    	 <button onclick="onImport();">가져오기</button>
    	 <script lanaguage="javascript" type="text/javascript">
    		function importCB(param) {
    			//status : 1:성공 , 0:취소, 기타:오류코드
    			if(param.status == 1)	{
    				alert("가져오기 완료");
    			}
   				else if(param.status == 0)
				{
    				alert("가져오기 취소");
    			}
   				else
   				{
   					alert("code = " + param.status + "message = " + param.message);
   				}
    		}
    		function exportCB(param){
    			//status : 1:성공 , 0:취소, 기타:오류코드
    			if(param.status == 1)	{
    				alert("내보내기 완료");
    			}
   				else if(param.status == 0)
				{
    				alert("내보내기  취소");
    			}
   				else
   				{
   					alert("code = " + param.status + "message = " + param.message);
   				}
    		}
    		function onImport() {
    			Delfino.importCertificateFromPC(importCB);
    		}
    		function onExport() {
    			Delfino.exportCertificateToPC(exportCB);
    		}
			/*    	 
			var import_export_result_callback = function(param)
			{
				alert("Status = "+param.status+" Message = "+param.message);
			}
    	 	function onImport()
    	 	{
    	 		try {
        	 		Delfino.importCertificateFromPC(import_export_result_callback);
    	 		}
    	 		catch(e){alert(e.description);}
    	 		
    	 		
    	 	}
    	 	function onExport()
    	 	{
    	 		try {
    	 			Delfino.exportCertificateToPC(import_export_result_callback);
    	 		}
    	 		catch(e){alert(e.description);}
    	 		
    	 	}
    	 	*/
    	 </script>
	</body>
</html>
