// KCB Gateway �������� ��� �Լ�
function OkCert3_sendKCBGateway(sequence, response) {
	console.log("sequence:::"+sequence+ ", response:::"+response);
	var responseArr = response.split("$!");
	var responseObj = {
		kcbrqstmsg : responseArr[0],
		encinfo : responseArr[1]
	};
	if( window.XDomainRequest && navigator.appVersion.indexOf("MSIE 10") == -1) { // IE 8, 9 ó��
		var xdr = new XDomainRequest();
		xdr.onload = function() {
			OkCert3_sendServer(sequence+1, this.responseText, responseObj.encinfo);	// ���� : ���� �ܰ� ����
		}
		xdr.onerror = function () {
			OkCert3_errorCallback("OkCert3_sendKCBGateway - xdr Error. responseText: " + xdr.responseText, sequence);
			return;
		}
		try {
			xdr.open("post", OkCert3info.KCBgatewayURL);	// async
		} catch (err) {
			OkCert3_errorCallback("OkCert3_sendKCBGateway - xdr Open Fail. Error description: " + err.description, sequence);
			return;
		}
		try {
			xdr.send(responseObj.kcbrqstmsg);
		} catch (err) {
			OkCert3_errorCallback("OkCert3_sendKCBGateway - xdr Send Fail. Error description: " + err.description, sequence);
			return;
		}
	}
	else {
		if (window.XMLHttpRequest)	var xhttp = new XMLHttpRequest();
		else 						var xhttp = new ActiveXObject("Microsoft.XMLHTTP");	// IE5,6 ó��
		xhttp.onreadystatechange = function() {
			console.log("readyState:::"+this.readyState);
			if (this.readyState == 4) {
				console.log("status:::"+this.status);
				if(this.status == 200) OkCert3_sendServer(sequence+1, this.responseText, responseObj.encinfo);	// ���� : ���� �ܰ� ����
				else {
					OkCert3_errorCallback("OkCert3_sendKCBGateway - xhttp Request Fail. status: "	// ���� (400����, 404���� ��)
											+ this.status + " , statusText: " + this.statusText, sequence);
					return;
				}
			}
		};
		try {
			xhttp.open("post", OkCert3info.KCBgatewayURL);	// async
		} catch (err) {
			OkCert3_errorCallback("OkCert3_sendKCBGateway - xhttp Open Fail. Error description: " + err.description, sequence);
			return;
		}
		try {
			xhttp.send(responseObj.kcbrqstmsg);
		} catch (err) {
			OkCert3_errorCallback("OkCert3_sendKCBGateway - xhttp Send Fail. Error description: " + err.description, sequence);
			return;
		}
	}
}
// Ajax ó�����ִ� ȸ���� ���� ���������� ��� �Լ�
function OkCert3_sendServer(sequence, kcbresponse, encinfo) {
	kcbresponse = kcbresponse.replace(/-/gi,"$1").replace(/_/gi,"$2"); // ȸ���� ���� ���͸� ȸ�ǿ�

	if (window.XMLHttpRequest)	var xhttp = new XMLHttpRequest();
	else 						var xhttp = new ActiveXObject("Microsoft.XMLHTTP");		// IE5,6 ó��
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4) {
			if (this.status == 200) {
				if (sequence == 4) OkCert3_setResult(this.responseText);				// sequence=4 �����ܰ��� ��� �Ϸ�ó��
				else 			OkCert3_sendKCBGateway(sequence, this.responseText );	// ���� : KCB�� ��û
			}
			else {
				OkCert3_errorCallback("OkCert3_sendServer - xhttp Request Fail. status: "	// ���� (400����, 404���� ��)
										+ this.status + " , statusText: " + this.statusText, sequence);
				return;
			}
		} 
	};
	try {
		xhttp.open("post", OkCert3info.serverURL);			// async
	} catch (err) {
		OkCert3_errorCallback("OkCert3_sendServer - xhttp Open Fail. Error description: " + err.description, sequence);
		return;
	}
	xhttp.setRequestHeader( 'Content-Type', 'application/x-www-form-urlencoded' );
	try {
		xhttp.send("sequence="+sequence+"&kcbresponse="+kcbresponse+"&encinfo="+encinfo
					+"&svcnm="+OkCert3info.svcnm+"&service="+OkCert3info.service+"&target="+OkCert3info.target
					+"&CP_CD="+OkCert3info.CP_CD+"&param="+OkCert3info.param);
	} catch (err) {
		OkCert3_errorCallback("OkCert3_sendServer - xhttp Send Fail. Error description: " + err.description, sequence);
		return;
	}
}