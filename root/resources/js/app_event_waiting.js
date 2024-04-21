/**
 * 비대면 정기적금 가입 이벤트 진행시 
 * 이벤트 순번대기 js
 */


var PageFunc = ({
	addLog : function(aMessage) {
		var curLog = $('#logDiv').html();
		curLog = this.getTime() + aMessage + "<br/>" + curLog;
		$('#logDiv').html(curLog);
	},
	clearLog : function() {
		$('#logDiv').html('');
	},
	getTime : function() {
		var date = new Date();
		var dttm = '';
		var temp = '';

		dttm += '[' + date.getFullYear();
		temp = ('00' + (date.getMonth()+1));
		dttm += '-' + temp.substring( temp.length-2 );
		temp = ('00' + date.getDate());
		dttm += '-' + temp.substring( temp.length-2 );
		temp = ('00' + date.getHours());
		dttm += ' ' + temp.substring( temp.length-2 );
		temp = ('00' + date.getMinutes());
		dttm += ':' + temp.substring( temp.length-2 );
		temp = ('00' + date.getSeconds());
		dttm += ':' + temp.substring( temp.length-2 );
		temp = (date.getMilliseconds() + '0000');
		dttm += '.' + temp.substring( 1, 5 );
		dttm += ']';

		return dttm;
	},
	init1 : function() {
		PageFunc.addLog("init[START]========================================");

		
		var ticketId = "";
		PageFunc.addLog("ticketId:" + ticketId);
		PageFunc.addLog("PageFunc.ticketId:" + PageFunc.ticketId);

		//setInterval(function() { PageFunc.checkTicket(ticketId); } , 1000);
		
		PageFunc.addLog("init[END]========================================");
	},
	init2 : function() {
		PageFunc.addLog("init[START]========================================");

		
		var ticketId = "";
		PageFunc.addLog("ticketId:" + ticketId);
		PageFunc.addLog("PageFunc.ticketId:" + PageFunc.ticketId);

		PageFunc.clearLog();
		PageFunc.issueTicket();
		//setInterval(function() { PageFunc.checkTicket(ticketId); } , 1000);
		
		PageFunc.addLog("init[END]========================================");
	},
	init4 : function(ticketId) {
		PageFunc.addLog("init[START]========================================");

		PageFunc.addLog('init4 ::: ' + ticketId);
		PageFunc.addLog("ticketId:" + ticketId);
		PageFunc.addLog("PageFunc.ticketId:" + PageFunc.ticketId);

		PageFunc.clearLog();
		PageFunc.doneTicket(ticketId);

		//setInterval(function() { PageFunc.checkTicket(ticketId); } , 1000);
		
		PageFunc.addLog("init[END]========================================");
	},
	startTimer : function() {
		PageFunc.timerId = setInterval(function() { PageFunc.checkTicket(); } , 1000);
	},
	stopTimer : function() {
		clearInterval( PageFunc.timerId );
	},
	timerId : null,
	ticketId : "",
	ticket : {},
	issueTicket : function() {
		PageFunc.addLog("issueTicket[START]========================================");

		//var url = "http://localhost:8081/issueTicket.do"
		var url = "https://dsr-next.goryosb.co.kr:18080/koeunjin/issueTicket.do"
		var reqData = {};

		PageFunc.ajaxAsync(url, reqData,function(data) {
			PageFunc.addLog("issueTicket :: [data]"+JSON.stringify(data));
			PageFunc.ticketId = data.ticket.ticketId;
			PageFunc.ticket = data.ticket;

			$('#ticketInfo').val(JSON.stringify(data));
			$('#ticketId').val(PageFunc.ticketId);
			$('#ticketNo').val(data.ticket.ticketNo);

			$('#prevWaitCnt').text('0');
			$('#totalWaitCnt').val('');
			$('#status').val('');
			
			PageFunc.addLog('issueTicket PageFunc.ticketId ::: ' + PageFunc.ticketId);
			PageFunc.addLog('issueTicket PageFunc.ticket ::: ' + PageFunc.ticket);
			
			PageFunc.checkTicket(PageFunc.ticketId);
			PageFunc.startTimer();
			}, null, 'issueTicket');
		
		PageFunc.addLog("issueTicket[END]========================================");
	},
	checkTicket : function(aTicketId) {
		PageFunc.addLog("checkTicket[START]========================================");
		PageFunc.addLog("aTicketId[" + aTicketId + "]");
		PageFunc.addLog("$('#ticketId').val()[" + $('#ticketId').val() + "]");

		if( $('#ticketId').val().length>1 ) { aTicketId = $('#ticketId').val(); }
		if( !aTicketId ) { aTicketId = PageFunc.ticketId; }
		PageFunc.addLog("aTicketId[" + aTicketId + "]");

		//var url = "http://localhost:8081/checkTicket.do"
		var url = "https://dsr-next.goryosb.co.kr:18080/koeunjin/checkTicket.do"
		var reqData = {};
		reqData.ticketId = aTicketId;
		reqData.ticketNo = $('#ticketNo').val();

		PageFunc.addLog('reqData.ticketId  ::::::::: ' + JSON.stringify(reqData.ticketId) );
		PageFunc.addLog('reqData.ticketNo  ::::::::: ' + JSON.stringify(reqData.ticketNo));
		
		PageFunc.ajaxAsync(url, reqData,function(data) {
			PageFunc.addLog('data.ticket.ticketId  ::::::::: ' + data.ticket.ticketId );
			PageFunc.addLog('data.ticket.status  ::::::::: ' + data.ticket.status );
			PageFunc.addLog('data.ticket  ::::::::: ' + data.ticket );
			
			PageFunc.addLog("[data]"+JSON.stringify(data));
			PageFunc.ticketId = data.ticket.ticketId;
			PageFunc.ticket = data.ticket;

			$('#ticketInfo').val(JSON.stringify(data));
			//고객한테 +1해서 표시
			$('#prevWaitCnt').text((data.ticket.prevWaitCnt) + 1);
			$('#totalWaitCnt').val(data.ticket.totalWaitCnt);
			$('#status').val(data.ticket.status);

			//if enter..
			if( data.ticket.status == 'ENTER' ) {
				PageFunc.stopTimer();
				PageFunc.enterTicket(PageFunc.ticketId);
				
				
			} else if( data.ticket.status == 'INVALID' ) {
				PageFunc.stopTimer();
			}
			}, null, 'checkTicket');
		
		PageFunc.addLog("checkTicket[END]========================================");
	},
	enterTicket : function(aTicketId) {
		PageFunc.addLog("enterTicket[START]========================================");
		PageFunc.addLog("aTicketId[" + aTicketId + "]");
		PageFunc.addLog("$('#ticketId').val()[" + $('#ticketId').val() + "]");

		if( $('#ticketId').val().length>1 ) { aTicketId = $('#ticketId').val(); }
		if( !aTicketId ) { aTicketId = PageFunc.ticketId; }
		PageFunc.addLog("aTicketId[" + aTicketId + "]");

		//var url = "http://localhost:8081/enterTicket.do"
		var url = "https://dsr-next.goryosb.co.kr:18080/koeunjin/enterTicket.do"
		var reqData = {};
		reqData.ticketId = aTicketId;

		PageFunc.ajaxAsync(url, reqData, function(data) {
			
			$('#frm #ticketId').val(aTicketId);
			$("#frm").attr("action", "/untact/callMemberOpenEventStep1.ysb").submit();
			//$('#aStep3').get(0).click();
			});		
		
		PageFunc.addLog("enterTicket[END]========================================");
	},
	doneTicket : function(aTicketId) {
		PageFunc.addLog("doneTicket[START]========================================");
		PageFunc.addLog("aTicketId[" + aTicketId + "]");
		PageFunc.addLog("$('#ticketId').val()[" + $('#ticketId').val() + "]");

		if( $('#ticketId').val().length>1 ) { aTicketId = $('#ticketId').val(); }
		if( !aTicketId ) { aTicketId = PageFunc.ticketId; }
		PageFunc.addLog("aTicketId[" + aTicketId + "]");

		//var url = "http://localhost:8081/doneTicket.do"
		var url = "https://dsr-next.goryosb.co.kr:18080/koeunjin/doneTicket.do"
		var reqData = {};
		reqData.ticketId = aTicketId;

		PageFunc.ajaxAsync(url, reqData, function(data) {
			console.log(JSON.stringify(data));
			$("#frm").attr('href', '/untact/callMemberOpenEventStep2.ysb');
		},function(data){
			console.log(JSON.stringify(data));
		});
		
		PageFunc.addLog("doneTicket[END]========================================");
	},
	//이벤트 취소 
	cancelEvent : function() {
		//done
		PageFunc.init4($('#ticketId').val());
		closePopup('eventWaiting');
	},
	ajaxAsync : function(aUrl, aData, aFnSuccess, aFnError, step) {
		PageFunc.addLog("ajaxAsync[START]========================================");
		PageFunc.addLog("[aUrl]" + aUrl);
		PageFunc.addLog("[aData]" + JSON.stringify(aData));
		PageFunc.addLog("[aFnSuccess]" + aFnSuccess);
		PageFunc.addLog("[aFnError]" + aFnError);
		
		$.ajax({
			url : aUrl,
			type : "POST",
			contentType: 'application/json',
			dataType : "json",
			data : JSON.stringify(aData),
			success : function(data) {
				if(step == 'issueTicket'){
					//이벤트 waiting 팝업 오픈 
					openPopup('eventWaiting');
				}
				
				PageFunc.addLog("ajaxAsync.success[START]========================================");
				PageFunc.addLog("[data]" + JSON.stringify(data));
				if( aFnSuccess ) 	aFnSuccess(data); 
				PageFunc.addLog("ajaxAsync.success[END]========================================");
				},
			error : function(xhr, status, error) {
				//step1 통신오류 
				if(step == 'issueTicket'){
					//서버통신오류 팝업오픈
					openPopup('serverErr');
				}
				
				PageFunc.addLog("ajaxAsync.error[START]========================================");
				var errorInfo = "ERROR[code:" + xhr.status + "\n" + "message:" + xhr.responseText + "\n" + "error:" + error + "]";
				if( aFnError ) 	aFnError(errorInfo, xhr.status); 
				PageFunc.addLog("ajaxAsync.error[END]========================================");
				}
		
			});
		PageFunc.addLog("ajaxAsync[END]========================================");
		}
});
