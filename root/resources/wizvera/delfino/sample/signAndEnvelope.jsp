<%@page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width" />
		<title>signedAndEnvelopedData</title>
<%@ include file="../svc/delfino.jsp" %>
	<script>
		//var data = "|ep_approve_no`20000011|ep_serial_no`0000000|ep_amount`9999|ep_bank_code`020|ep_account_no`44400000000000|ep_resident_no`7305301000000|ep_msg_type`EFT|ep_password`9999|ep_client_ip`200.200.30.100|ep_so_gubun`O|ep_so_value`319997|ep_so_serial`2999|hd_ep_type`SECUCERT|ep_secu_serial_no`079697|ep_pg_wallet_version`PG_INCS_201|ep_rvalue`SvEqXeIMVasojZhdXBhOiFsjcrc=";
		var data = "|ep_approve_no`20000011|ep_serial_no`0000000|ep_amount`9999|ep_bank_code`020|ep_account_no`44400000000000|ep_resident_no`7305301000000|ep_msg_type`EFT|ep_password`9999|ep_client_ip`200.200.30.100|ep_so_gubun`O|ep_so_value`319997|ep_so_serial`2999|hd_ep_type`SECUCERT|ep_secu_serial_no`079697|ep_pg_wallet_version`PG_INCS_201";
		
		var cert = ""
					+"-----BEGIN CERTIFICATE-----\n"
					+"MIIE9jCCA96gAwIBAgIEFyOkvDANBgkqhkiG9w0BAQsFADBSMQswCQYDVQQGEwJr\n"
			        +"cjEQMA4GA1UECgwHeWVzc2lnbjEVMBMGA1UECwwMQWNjcmVkaXRlZENBMRowGAYD\n"
			        +"VQQDDBF5ZXNzaWduQ0EgQ2xhc3MgMTAeFw0xNDA5MDMxNTAwMDBaFw0xNjA5MjEx\n"
			        +"NDU5NTlaMGoxCzAJBgNVBAYTAmtyMRAwDgYDVQQKDAd5ZXNzaWduMQ8wDQYDVQQL\n"
			        +"DAZzZXJ2ZXIxEDAOBgNVBAsMB3llc3NpZ24xDTALBgNVBAsMBEtGVEMxFzAVBgNV\n"
			        +"BAMMDnd3dy5rZnRjLm9yLmtyMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC\n"
			        +"AQEAtdV5dPRgp36MU4XvPU3is0Itq9JtM6pfXBKuI0EahzajJFxjASRQkh1Zdqha\n"
			        +"1HLQI8FiuVPASLMX1ksnQt37Fi7ltfguEiIHLIfL71RbkTgsf5b3mCO98DiRefJG\n"
			        +"XnQ7dWj1MY1PU3m8zsgJjrFpR0e/5XRw71ChABpOq8TNbULs9LbJzfK4HLN0kChq\n"
			        +"WcgVCl2rKpFjnBsJlg9ziTecHM2YDMTvG1tQEb+bHJ4V+B4i9+IbRuqbr6ITj3AZ\n"
			        +"D7lcv3vE/oecW75OIzEPL2nomtT+IVUwcmM8XgDcLBU91j/p/pVvVN6FmlVf/28H\n"
			        +"V/ij1QI70UrQNh+QOQcc7rArFQIDAQABo4IBujCCAbYwgY8GA1UdIwSBhzCBhIAU\n"
			        +"UgQyn4+dIXK6+jOYqGF+JzMkjV+haKRmMGQxCzAJBgNVBAYTAktSMQ0wCwYDVQQK\n"
			        +"DARLSVNBMS4wLAYDVQQLDCVLb3JlYSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eSBD\n"
			        +"ZW50cmFsMRYwFAYDVQQDDA1LSVNBIFJvb3RDQSA0ggIQAzAdBgNVHQ4EFgQUraqu\n"
			        +"d/gTGJJbo7RLGKaVU+F0HB4wDgYDVR0PAQH/BAQDAgUgMBkGA1UdIAEB/wQPMA0w\n"
			        +"CwYJKoMajJpFAQEDMCoGA1UdEQQjMCGgHwYJKoMajJpECgEBoBIwEAwOd3d3Lmtm\n"
			        +"dGMub3Iua3IwcgYDVR0fBGswaTBnoGWgY4ZhbGRhcDovL2RzLnllc3NpZ24ub3Iu\n"
			        +"a3I6Mzg5L291PWRwNHA0MjY3OCxvdT1BY2NyZWRpdGVkQ0Esbz15ZXNzaWduLGM9\n"
			        +"a3I/Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlzdDA4BggrBgEFBQcBAQQsMCowKAYI\n"
			        +"KwYBBQUHMAGGHGh0dHA6Ly9vY3NwLnllc3NpZ24ub3JnOjQ2MTIwDQYJKoZIhvcN\n"
			        +"AQELBQADggEBAMADb21Xj9cALgXqTqdS4c69Au0jmvuVIJrpFldnNSdCyZkK7pcI\n"
			        +"PWEUjUwVErHKwb9mahSPqvZ5daqTPcQnMBNCLN1DEg3+sE/W2wifDgrjpyVIWIyt\n"
			        +"SkP7X2679g+ROcqfkfZ/Wlgqbi12g77SJErYVMeBmPc0KXHAMP2SEB1H8I9nIOeO\n"
			        +"wYbmoGQ4/NDsU0+MHF4k5fwKMlzLGyKpsmmO39EluIY/739xjjZ1wZDhDxw2zOv6\n"
			        +"PSqOgOf9Wb8Y3e5XJ+HJuMDEzJrxAUkvvu3fVUjAFpeMl9OPN+dzpXyIRqLr/sMf\n"
					+"Ne2FICx0MGNH/nM2gzlkuangVviYa+gls18=\n" 
					+"-----END CERTIFICATE-----\n";
	</script>
    </head>
    <body>
    	<h2>전자서명(Enveloped)</h2>

		<h3>1. 인증</h3>
		<form action="signAndEnvelopeAction.jsp" method="post" name="envelopedForm" target="testResult1">
    		<input type="hidden" name="certPEM"/>
			<input type="hidden" name="_action" value="enveloped"/>
			데이터 : <input type="text" name="data" size="150" value="|ep_approve_no`20000011|ep_serial_no`0000000|ep_amount`9999|ep_bank_code`020|ep_account_no`44400000000000|ep_resident_no`7305301000000|ep_msg_type`EFT|ep_password`9999|ep_client_ip`200.200.30.100|ep_so_gubun`O|ep_so_value`319997|ep_so_serial`2999|hd_ep_type`SECUCERT|ep_secu_serial_no`079697|ep_pg_wallet_version`PG_INCS_201|ep_rvalue`SvEqXeIMVasojZhdXBhOiFsjcrc="/>
    	</form>
		<button onclick="envelopeData()">인증</button>
		<br><br>
		<script>
			function envelopeData(){
				data = document.envelopedForm.data.value;
				document.envelopedForm.certPEM.value = cert;
				document.envelopedForm.submit();
			}
		</script>
		
		<table width="100%" border="1" align="center" cellpadding="0" cellspacing="0">
			<tr><td bgcolor="#FFFFFF" height="200">
				<iframe name='testResult1' id='testResult1' frameborder='0' width='100%' height='100%' ></iframe>
			</td></tr>
		</table>
		<hr>


		<h3>2. 결제</h3>
    	<form action="signAndEnvelopeAction.jsp" method="post" name="signForm" target="testResult2">
    		<input type="hidden" name="signedAndEnvelopedData" />
			<input type="hidden" name="_action" value="sign" />
    	</form>
		<button onclick="signAndEnvelope()">signedAndEnvelopedData</button>
		
		<script>
	    function TEST_complete(result){
	        if(result.status==0) return;
	        if(result.status!=1){
	            alert("error:" + result.message + "[" + result.status + "]");
	            return;
	        }
			document.signForm.signedAndEnvelopedData.value = result.signedAndEnvelopedData;
            document.signForm.submit();
	    }
		
	    //encodig : base64, hex , base64AndUrlEncoding
		function signAndEnvelope(){
			//Delfino.signAndEnvelope(data, cert, TEST_complete);
			//Delfino.signAndEnvelope(data, cert, {appendVidRandom : { encoding: 'hex', key: '|ep_rvalue`'}} , TEST_complete);
			Delfino.signAndEnvelope(data, cert, {appendVidRandom : { encoding: 'base64', key: '&vidRandom='} },TEST_complete);
		}
		</script>
		
		<table width="100%" border="1" align="center" cellpadding="0" cellspacing="0">
			<tr><td bgcolor="#FFFFFF" height="100">
				<iframe name='testResult2' id='testResult2' frameborder='0' width='100%' height='100%'></iframe>
			</td></tr>
		</table>
		

	</body>
</html>
