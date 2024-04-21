/**
 * 예가람저축은행 javascript 공통 Utils 
 * 
 * 1. UtilFunc 공통util모음
 */
var UtilFunc = ({

    /**
     * YYYYMMDD 일자 String을 Date 타입으로 구한다
     * @strYYYYMMDD "20170331" or "2017-03-31"
     * @return new Date(2017, 3, 31)
     */
    getDate: function (strYYYYMMDD) {
        strYYYYMMDD = strYYYYMMDD.trim();

        var d;
        if (strYYYYMMDD && strYYYYMMDD.length == 8) {
            d = new Date(parseInt(strYYYYMMDD.substring(0, 4)), parseInt(strYYYYMMDD.substring(4, 6)) - 1, parseInt(strYYYYMMDD.substring(6, 8)));
        } else if (strYYYYMMDD && strYYYYMMDD.length == 10) {
            d = new Date(parseInt(strYYYYMMDD.substring(0, 4)), parseInt(strYYYYMMDD.substring(5, 7)) - 1, parseInt(strYYYYMMDD.substring(8, 10)));
        } else {
            d = null;
        }
        return d;
    },
    /***
     * YYYYMMDD 일자 String을 Display 용으로 구한다
     * @strYYYYMMDD "20170331" or "2017-03-31"
     * @return "2017-03-31"
     */
    getDateDisp: function (strYYYYMMDD) {
        strYYYYMMDD = strYYYYMMDD.trim();

        var d;
        if (strYYYYMMDD && strYYYYMMDD.length == 8) {
            d = strYYYYMMDD.substring(0, 4) + "-" + strYYYYMMDD.substring(4, 6) + "-" + strYYYYMMDD.substring(6, 8);
        } else if (strYYYYMMDD && strYYYYMMDD.length == 10) {
            d = "" + parseInt(strYYYYMMDD.substring(0, 4)) + "+" + (parseInt(strYYYYMMDD.substring(5, 7)) - 1) + "+" + parseInt(strYYYYMMDD.substring(8, 10));
        } else if (strYYYYMMDD && strYYYYMMDD.length == 14) {
            d = strYYYYMMDD.substring(0, 4) + "-" + strYYYYMMDD.substring(4, 6) + "-" + strYYYYMMDD.substring(6, 8) + " " + strYYYYMMDD.substring(8, 10) + ":" + strYYYYMMDD.substring(10, 12) + ":" + strYYYYMMDD.substring(12, 14);
        } else {
            d = strYYYYMMDD
        }
        return d;
    },
    
    /***
     * YYYYMMDD 일자 String을 Display 용으로 구한다
     * @strYYYYMMDD "20170331" or "2017.03.31"
     * @return "2017.03.31"
     */
    getDateDisp2: function (strYYYYMMDD) {
        strYYYYMMDD = strYYYYMMDD.trim();

        var d;
        if (strYYYYMMDD && strYYYYMMDD.length == 8) {
            d = strYYYYMMDD.substring(0, 4) + "." + strYYYYMMDD.substring(4, 6) + "." + strYYYYMMDD.substring(6, 8);
        } else if (strYYYYMMDD && strYYYYMMDD.length == 10) {
            d = "" + parseInt(strYYYYMMDD.substring(0, 4)) + "+" + (parseInt(strYYYYMMDD.substring(5, 7)) - 1) + "+" + parseInt(strYYYYMMDD.substring(8, 10));
        } else if (strYYYYMMDD && strYYYYMMDD.length == 14) {
            d = strYYYYMMDD.substring(0, 4) + "." + strYYYYMMDD.substring(4, 6) + "." + strYYYYMMDD.substring(6, 8) + " " + strYYYYMMDD.substring(8, 10) + ":" + strYYYYMMDD.substring(10, 12) + ":" + strYYYYMMDD.substring(12, 14);
        } else {
            d = strYYYYMMDD
        }
        return d;
    },
    
    /***
     * YYYYMMDD 일자 String을 Display 용으로 구한다
     * @strYYYYMMDD "201703" or "2017.03"
     * @return "2020-05-04"
     */
    getDateDisp3: function (strYYYYMM) {
    	strYYYYMM = strYYYYMM.trim();
        var d;
        if (strYYYYMM && strYYYYMM.length == 6) {
            d = strYYYYMM.substring(0, 4) + "." + strYYYYMM.substring(4, 6);
        } else {
            d = strYYYYMM
        }
        return d;
    },
    
    /**
     * Date 타입에서 YYYYMMDD String 형태로 구한다
     * @d new Date(2017, 3, 31)
     * @return "20170331"
     */
    getDateStr: function (d) {
        var strDate;
        var str;
        var pad = '00';

        strDate = d.getFullYear();

        pad = '00';
        str = '' + (d.getMonth() + 1);
        strDate = strDate + pad.substring(0, pad.length - str.length) + str;

        pad = '00';
        str = '' + d.getDate();
        strDate = strDate + pad.substring(0, pad.length - str.length) + str;

        return strDate;
    },
    /**
     * Date 타입에서 YYYY-MM-DD String 형태로 구한다
     * @d new Date(2017, 3, 31)
     * @return "2017-03-31"
     */
    getDateStrWithHyphen: function (d) {
        var strDate;
        var str;
        var pad = '00';

        strDate = d.getFullYear();
        strDate = strDate + "-";

        pad = '00';
        str = '' + (d.getMonth() + 1);
        strDate = strDate + pad.substring(0, pad.length - str.length) + str;
        strDate = strDate + "-";

        pad = '00';
        str = '' + d.getDate();
        strDate = strDate + pad.substring(0, pad.length - str.length) + str;

        return strDate;
    },
    /**
     * Date 타입에서 YYYY-MM-DD String 형태로 구한다
     * @d new Date(2017, 3, 31)
     * @return "2017.03.31"
     */
    getDateStrWithDot: function (d) {
        var strDate;
        var str;
        var pad = '00';

        strDate = d.getFullYear();
        strDate = strDate + ".";

        pad = '00';
        str = '' + (d.getMonth() + 1);
        strDate = strDate + pad.substring(0, pad.length - str.length) + str;
        strDate = strDate + ".";

        pad = '00';
        str = '' + d.getDate();
        strDate = strDate + pad.substring(0, pad.length - str.length) + str;

        return strDate;
    },
    /**
     * Date 타입에서 YYYY-MM-DD String 형태로 구한다 요일추가
     * @d new Date(2017, 3, 31)
     * @return "2017-03-31 (수)"
     */
    getFullDateStrWithHyphen: function (d) {
        var strDate;
        var str;
        var pad = '00';

        strDate = d.getFullYear();
        strDate = strDate + "-";

        pad = '00';
        str = '' + (d.getMonth() + 1);
        strDate = strDate + pad.substring(0, pad.length - str.length) + str;
        strDate = strDate + "-";

        pad = '00';
        str = '' + d.getDate();
        strDate = strDate + pad.substring(0, pad.length - str.length) + str;

        var week = new Array('(일)', '(월)', '(화)', '(수)', '(목)', '(금)', '(토)');

        strDate = strDate + " " + week[d.getDay()];

        return strDate;
    },
    
    /**
     * 날짜 더하기
     */
    addDays: function (d, days) {
        d.setTime(d.getTime() + (86400000 * days));
        return d;
    },
    
    /**
     * 날짜(달) 더하기
     * @param date, int - months
     * @return date
     */
    addMonths: function (date, Months) {
    	date.setMonth(date.getMonth() + Months);
        return date;
    },

    /**
     * 현재시각정보
     */
    getCurrentDttm: function () {
        var dttm = '';
        var date = new Date();
        dttm = UtilFunc.paddingLeft(date.getFullYear(), '0', 4)+"";
        dttm += UtilFunc.paddingLeft(date.getMonth() + 1, '0', 2)+"";
        dttm += UtilFunc.paddingLeft(date.getDate(), '0', 2)+"";
        dttm += UtilFunc.paddingLeft(date.getHours(), '0', 2)+"";
        dttm += UtilFunc.paddingLeft(date.getMinutes(), '0', 2)+"";
        dttm += UtilFunc.paddingLeft(date.getSeconds(), '0', 2)+"";
        return dttm;
    },
    
    /***
     * HH:MM:SS 시간 String을 Display 용으로 구한다
     * @strHHMMSS "111111"
     * @return "11:11:11"
     */
    getTimeDisp: function (strHHMMSS) {
        strHHMMSS = strHHMMSS.trim();
        var h;
        
        if (strHHMMSS && (strHHMMSS.length == 6 || strHHMMSS.length == 8)) {
        	h = strHHMMSS.substr(0, 2) + ":" + strHHMMSS.substr(2, 2) + ":" + strHHMMSS.substr(4, 2);
        } else if (strHHMMSS && strHHMMSS.length == 4) {
        	h = strHHMMSS.substr(0, 2) + ":" + strHHMMSS.substr(2, 2);
        } else {
            h = strHHMMSS
        }
        
        
        return h;
    },
    
    paddingLeft: function (value, paddingchar, len) {
        return (value.toString().length < len) ? UtilFunc.paddingLeft(paddingchar + value, len) : value;
    },
    /**
     * JSONData를 CSV파일로 다운로드
     *
     * downloadCsvFileFromJson( jsonData, saveFileName, true );
     *
     * @param jsonData            json 형태의 데이터 { items : { [key:value] , ... } }
     * @param saveFileName    저장할 파일이름
     * @param showLabel            컬럼헤더 표시여부
     */
    downloadCsvFileFromJson: function (jsonData, saveFileName, showLabel) {
        //If JSONData is not an object then JSON.parse will parse the JSON string in an Object
        var arrData = typeof jsonData != 'object' ? JSON.parse(jsonData) : jsonData;

        var CSV = '';
        //Set Report title in first row or line
        //CSV += ReportTitle + '\r\n\n';

        //This condition will generate the Label/Header
        if (showLabel) {
            var row = "";
            //This loop will extract the label from 1st index of on array
            for (var index in arrData[0]) {
                //Now convert each value to string and comma-seprated
                row += $.trim(index) + ',';
            }
            row = row.slice(0, -1);
            //append Label row with line break
            CSV += row + '\r\n';
        }

        //1st loop is to extract each row
        for (var i = 0; i < arrData.length; i++) {
            var row = "";
            //2nd loop will extract each column and convert it in string comma-seprated
            for (var index in arrData[i]) {
                row += '"' + arrData[i][index] + '",';
            }
            row.slice(0, row.length - 1);
            //add a line break after each row
            CSV += row + '\r\n';
        }

        if (CSV == '') {
            alert("Invalid data");
            return;
        }

        //파일제목 시간넣기
        var downloadDate = UtilFunc.getCurrentDttm();

        //Generate a file name
        var fileName = saveFileName.replace(/ /g, "_");		//downloadDate+"_";
        //this will remove the blank-spaces from the title and replace it with an underscore
        fileName += "_" + downloadDate;
        //Initialize file format you want csv or xls
        //var uri = 'data:text/csv;charset=utf-8,\uFEFF' + encodeURI(CSV);
        var uri = 'data:text/csv;charset=utf-8,\uFEFF' + encodeURIComponent(CSV);

        // Now the little tricky part.
        // you can use either>> window.open(uri);
        // but this will not work in some browsers
        // or you will not get the correct file extension

        //this trick will generate a temp <a /> tag
        var link = document.createElement("a");
        link.href = uri;

        //set the visibility hidden so it will not effect on your web-layout
        link.style = "visibility:hidden";
        link.download = fileName + ".csv";

        //this part will append the anchor tag and remove it after automatic click
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);
    },
    /**
     * Text에서 숫자만 추출
     */
    getOnlyNumber: function (value) {
        return (value) ? value.replace(/[^0-9]/g, "") : value;
    },
    /**
     * 팝업윈도우 호출 (부모 가운데)
     */
    popupWindow: function (url, title, w, h, frmPost) {
        wLeft = window.screenLeft ? window.screenLeft : window.screenX;
        wTop = window.screenTop ? window.screenTop : window.screenY;

        var left = wLeft + (window.innerWidth / 2) - (w / 2);
        var top = wTop + (window.innerHeight / 2) - (h / 2);
        map = window.open(url, title, 'toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no, copyhistory=no, width=' + w + ', height=' + h + ', top=' + top + ', left=' + left);
        if (map && frmPost) {
            frmPost.submit();
        }
    },
    popupModalWindow: function (url, title, w, h) {
        Ext.onReady(function () {
            Ext.create('Ext.window.Window', {
                title: title,
                height: h,
                width: w,
                minWidth: w,
                minHeight: h,
                layout: 'fit',
                itemId: 'popUpWin',
                modal: true,
                shadow: false,
                resizable: true,
                constrainHeader: true,
                items: [{
                    xtype: 'box',
                    autoEl: {
                        tag: 'iframe',
                        src: url,
                        frameBorder: '0'
                    }
                }]
            }).show();
        });
    },
    closeModalWindow: function () {
        Ext.ComponentQuery.query('#popUpWin')[0].close();
    },
    getPhoneNumberWithHyphen: function (num, mask) {
        var formatNum = "";
        if (typeof num !== 'string') return formatNum;
        num = num.replace(/\-/g, "");

        if (typeof mask === 'undefined') {
            mask = false;
        }

        if (num.length === 11) {
            if (mask) {
                formatNum = num.replace(/(\d{3})(\d{3,4})(\d{4})/g, "$1-$2-****");
            } else {
                formatNum = num.replace(/(\d{3})(\d{3,4})(\d{4})/g, "$1-$2-$3");
            }
        } else if (num.length === 8) {
            formatNum = num.replace(/(\d{4})(\d{4})/g, "$1-$2");
        } else {
            if (num.indexOf("02") === 0) {
            	if (mask) {
            		formatNum = num.replace(/(\d{2})(\d{3,4})(\d{4})/g, "$1-$2-****");
            	} else {
            		formatNum = num.replace(/(\d{2})(\d{3,4})(\d{4})/g, "$1-$2-$3");
            	}
            } else {
                if (mask) {
                    formatNum = num.replace(/(\d{3})(\d{3,4})(\d{4})/g, "$1-$2-****");
                } else {
                    formatNum = num.replace(/(\d{3})(\d{3,4})(\d{4})/g, "$1-$2-$3");
                }
            }
        }
        return formatNum;
    }
    
    /**
     * 현재날짜 정보 
     * return : 2018년 04월 23일
     * 20180423
     **/
    ,getCurrentDateStr: function () {
    	
        var dttm = '';
        var date = new Date();
        dttm = UtilFunc.paddingLeft(date.getFullYear(), '0', 4)+"년 ";
        dttm += UtilFunc.paddingLeft(date.getMonth() + 1, '0', 2)+"월 ";
        dttm += UtilFunc.paddingLeft(date.getDate(), '0', 2)+"일";
        return dttm;
    }
    
	//////////////////////////////////////////////////////////////////////////////////////////////////////
	//null : true
    //not null : false
    /**
     * null 체크
     * return : null : true, not null : false
     **/
	   ,isNull : function(data_value) {
	      
	  	var result = false;
	  	if (typeof data_value == "undefined" || data_value == null || data_value == "") {
	  		result = true; 
	    }
	  	return result;
	  },
	//////////////////////////////////////////////////////////////////////////////////////////////////////
    getDateDiffInDays: function(d1, d2) {
        var t2 = d2.getTime();
        var t1 = d1.getTime();

        return parseInt((t2-t1)/(24*3600*1000));
    },

    getDateDiffInWeeks: function(d1, d2) {
        var t2 = d2.getTime();
        var t1 = d1.getTime();

        return parseInt((t2-t1)/(24*3600*1000*7));
    },

    getDateDiffInMonths: function(d1, d2) {
        var d1Y = d1.getFullYear();
        var d2Y = d2.getFullYear();
        var d1M = d1.getMonth();
        var d2M = d2.getMonth();

        return (d2M+12*d2Y)-(d1M+12*d1Y);
    },

    getDateDiffInYears: function(d1, d2) {
        return d2.getFullYear()-d1.getFullYear();
    },
    /** 1000 단위로 콤마를 삽입한다. null 또는 공백이면 0리턴 */
    getAmtFormatInZero : function (value) {
    	if( value==null || value==undefined || value=='0') return '0'; 
    	return UtilFunc.gridFormatterThousandNumber(value);
	},
    /** 1000 단위로 콤마를 삽입한다. */
    gridFormatterThousandNumber : function (value) {
    	value = value.replace(/,/g, '');
    	if(!!Number(value)) { // 숫자타입 확인.
    		var length = value.length;
    		return value.split('')
			.map(function(v, idx) { return idx != 0 && (length - idx) % 3 == 0 ? ',' + v : v})
			.join('');
    	}
    	return '';
	}, /** 생년월일을 입력받아 올해 (만)나이를 계산한다 (YYYYMMDD, YYMMDD)**/
	getAge : function (value) {
		var age = -1;
		
		if(!value || (value.length != 6 && value.length != 8)) {	return age; }

		var today = new Date();
		var year, monthIndex;
		if( value.length == 6 ) {
			monthIndex = 2;
			year = value.substr(0, 2);
			if(year <= today.getFullYear() % 100) {
				year = '20' + year;
			}else {
				year = '19' + year;
			}
		}else {
			monthIndex = 4;
			year = value.substr(0,4);
		}
		
		var birthDate = new Date([year, value.substr(monthIndex, 2), value.substr((monthIndex+2))].join('/'));
		age = today.getFullYear() - birthDate.getFullYear();
		
		if(today < birthDate.setFullYear(today.getFullYear())) age--;
		return age;
	}
	
	/**
	* 현재날짜 정보 
	* return : 20180423
	* 20180423
	**/
	,getCurrentDateOnly: function () {
		var tmpYear = '';
		var tmpMonth = '';
		var tmpDay = '';
		var dttm = '';
		var date = new Date();

		tmpYear  = date.getFullYear();
		tmpMonth = UtilFunc.paddingLeft(date.getMonth() + 1, '0', 2);
		tmpDay   = UtilFunc.paddingLeft(date.getDate(), '0', 2);
 
		dttm = tmpYear+""+tmpMonth+""+tmpDay;

		return dttm;
	}
	
	/**
	* 현재날짜 시간 정보 
	* return : YYYY.MM.DD HH:MI:SS
	* 20200507
	**/
	,getCurrentDateAndTime: function () {
		var tmpYear = '';
		var tmpMonth = '';
		var tmpDay = '';
		var tmpHour = '';
		var tmpMinute = '';
		var tmpSecond = '';
		var dttm = '';
		var date = new Date();

		tmpYear  = date.getFullYear();
		tmpMonth = UtilFunc.paddingLeft(date.getMonth() + 1, '0', 2);
		tmpDay   = UtilFunc.paddingLeft(date.getDate(), '0', 2);
		tmpHour  = date.getHours();
		tmpMinute = UtilFunc.paddingLeft(date.getMinutes(), '0', 2);
		tmpSecond = UtilFunc.paddingLeft(date.getSeconds(), '0', 2);
		dttm = tmpYear+"."+tmpMonth+"."+tmpDay + " " + tmpHour + ":" + tmpMinute + ":" + tmpSecond;

		return dttm;
	}
	
	/**
	* device 정보 가져오기
	* 
	* device.uuid         : 6d1c9e8a6a89fc05 / E95195B9-75AF-4279-B2AC-F7DBEA52D264
	* device.platform     : Android / iOS
	* device.manufacturer : samsung / Apple
	* device.model        : SM-G920S / iPhone10,6
	**/
	, getDeviceInfo: function () {
		var deviceInfo = 'Android samsung SM-G920S';
		if (systemDevice == 'app') {
			deviceInfo = device.platform + " " + device.manufacturer + " " + device.model;
		} 
		return deviceInfo;
	}
	
	/**
	* 휴대폰 번호 유형 체크
	* return
	* true(휴대폰번호 아님), false(휴대폰번호 형태)
	**/
	, isMobileNumChk : function(data){
		var pattern = /^(01[016789]{1})-?[0-9]{3,4}-?[0-9]{4}$/;
		return !pattern.test(data);
	}
	
	/**
	* 차량번호 형식 체크
	* return
	* true(차량번호 형태), false(차량번호 아님)
	**/
	, isCarNumChk : function(value){
		var data = value.replace(/ /g, '');
		
		var carPattern1 = /^[0-9]{2}[가-힣]{1}[\s]*[0-9]{4}$/;  //12가1234
		var carPattern2 = /^[0-9]{3}[가-힣]{1}[\s]*[0-9]{4}$/;  //123가1234
		var carPattern3 = /^[가-힣]{2}[\s]*[0-9]{2}[가-힣]{1}[\s]*[0-9]{4}$/;  //서울12가1234
		
		if(!carPattern1.test(data) && !carPattern2.test(data) && !carPattern3.test(data)){
 			return false;
		}else{
 			return true;
		}
	}
	
	/**
	* 금액 한글 변환
	* return
	* 
	**/
	, viewKorean :function(num){
		
		if (!Number(num)) return "";
		
		var hanA = new Array("", "일", "이", "삼", "사", "오", "육", "칠", "팔", "구", "십");
		var danA = new Array("", "십", "백", "천", "", "십", "백", "천", "", "십", "백", "천", "", "십", "백", "천");
		var result = "";
		
		for(var i=0;i<num.length;i++){
			var str = "";
			var han = hanA[num.charAt(num.length-(i+1))];
			if(han != "")	str += han+danA[i];
			if(i == 4)		str += "만";
			if(i == 8)		str += "억";
			if(i == 12)		str += "조";
			result = str + result;
		}
		
		if(num != 0) result = result;
		
		return result;
	}
	
	/**
	 * 빈값 체크
	 */
	, isEmpty : function (val){
		if(val == "" || val == null || val == undefined || (val != null && typeof val == "object" && !Object.keys(val).length)){
			return true;
		} else {
			return false;
		}
	},
	
	/**
	 * @param string
	 * @return {string} 30,000 -> 30000
	 */
	replaceAll: function (str, searchStr, replaceStr) {
	    return str.split(searchStr).join(replaceStr);
	},
	
	/**
	 * @param String, type
	 * @return 포멧된 String
	 */
	formmatList : function (str, type){
		if(UtilFunc.isNull(str)) return "";
		var getStr = '';
		if (type == "acct"){
			getStr = str.substr(0,3) + "-" + str.substr(3,2) + "-" + str.substr(5, 2) + "-" + str.substr(7);
		}
		if (type == "dateDot"){
			getStr = str.substr(0,4) + "." + str.substr(4,2) + "." + str.substr(6);
		}
		if (type == "datetime"){
			getStr = str.substr(0,4) + "." + str.substr(4,2) + "." + str.substr(6,2) + " " + str.substr(8,2) + ":" + str.substr(10,2) + ":" + str.substr(12,2);
		}
		if(type == "phone"){
			if(str.length == 10) {
				getStr = str.substr(0,3) + "-" + str.substr(3,6) + "-" + str.substr(6);
			} else {
				getStr = str.substr(0,3) + "-" + str.substr(3,4) + "-" + str.substr(7);
			}
		}
		if(type == "ssn"){ //사업자번호
			getStr = str.substr(0,3) + "-" + str.substr(3,2) + "-" + str.substr(5);
		}
		return getStr;
	},
	
	/**
	 * @param String
	 * @return 은행명
	 */
	getBankName : function(bankCode){
		if(typeof bankCode == "undefined" || bankCode == null || bankCode == "") {
			return "";
		} else if(bankCode == "004"){
			return "KB국민";
		} else if(bankCode == "003"){
			return "기업은행";
		} else if(bankCode == "011"){
			return "농협";
		} else if(bankCode == "012"){
			return "농협(지역)";
		} else if(bankCode == "088"){
			return "신한(구조흥포함)";
		} else if(bankCode == "008"){
			return "수출입";
		} else if(bankCode == "071"){
			return "우체국";
		} else if(bankCode == "023"){
			return "SC(스탠다드차타드)";
		} else if(bankCode == "081"){
			return "KEB하나(구회환포함)";
		} else if(bankCode == "027"){
			return "한국씨티(구한미)";
		} else if(bankCode == "020"){
			return "우리";
		} else if(bankCode == "039"){
			return "경남";
		} else if(bankCode == "034"){
			return "광주";
		} else if(bankCode == "031"){
			return "대구";
		} else if(bankCode == "055"){
			return "도이치";
		} else if(bankCode == "032"){
			return "부산";
		} else if(bankCode == "002"){
			return "산업";
		} else if(bankCode == "007"){
			return "수협";
		} else if(bankCode == "037"){
			return "전북";
		} else if(bankCode == "035"){
			return "제주";
		} else if(bankCode == "045"){
			return "새마을금고";
		} else if(bankCode == "052"){
			return "모간스탠리";
		} else if(bankCode == "048"){
			return "신용협동조합";
		} else if(bankCode == "054"){
			return "홍콩상하이(HSBC)";
		} else if(bankCode == "050" || bankCode == "000"){
//			return "상호저축은행중앙회";
			return "저축은행";
		} else if(bankCode == "059"){
			return "미쓰비시도쿄UFJ은행";
		} else if(bankCode == "060"){
			return "뱅크오브아메리카";
		} else if(bankCode == "089"){
			return "케이뱅크";
		} else if(bankCode == "090"){
			return "카카오뱅크";
		} else if(bankCode == "057"){
			return "제이피모간체이스";
		} else if(bankCode == "061"){
			return "비엔피파리바";
		} else if(bankCode == "064"){
			return "산림조합";			
		} else if(bankCode == "062"){
			return "중국공상";	
		} else if(bankCode == "247"){
			return "NH투자증권";	
		} else if(bankCode == "209"){
			return "유안타증권";	
		} else if(bankCode == "218"){
			return "KB증권";	
		} else if(bankCode == "238"){
			return "미래에셋대우";	
		} else if(bankCode == "240"){
			return "삼성증권";	
		} else if(bankCode == "243"){
			return "한국투자증권";	
		} else if(bankCode == "261"){
			return "교보증권";	
		} else if(bankCode == "262"){
			return "하이투자증권";	
		} else if(bankCode == "263"){
			return "현대차투자증권";	
		} else if(bankCode == "266"){
			return "SK증권";	
		} else if(bankCode == "269"){
			return "한화투자증권";	
		} else if(bankCode == "270"){
			return "하나금융투자";	
		} else if(bankCode == "278"){
			return "신한금융투자";	
		} else if(bankCode == "280"){
			return "유진투자증권";	
		} else if(bankCode == "287"){
			return "메리츠종합금융증권";	
		} else if(bankCode == "291"){
			return "신영증권";	
		} else if(bankCode == "265"){
			return "이베스트투자증권";	
		} else if(bankCode == "292"){
			return "케이프증권(구LIG)";	
		} else if(bankCode == "264"){
			return "키움증권";	
		} else if(bankCode == "267"){
			return "대신증권";	
		} else if(bankCode == "279"){
			return "DB금융투자";	
		} else if(bankCode == "227"){
			return "케이티비투자증권";	
		} else {
			return "가상증권사";
		}
	},
	
	/**
	 * @param String
	 * @return (저축)은행명
	 */
     getSavingBankName : function(bankCode, acno, callback){
        // alert(bankCode+" "+acno);
		if(bankCode == "050" || bankCode == "000"){
            // alert("저축은행인 경우 상호명 확인");
			var param = {MNRC_ACNO_16 : acno, MNRC_BANK : bankCode} // 계좌번호, 은행코드
			AjaxFunc.ajaxAsync(
				'/common/getBankNM.ajax'
				, param
				, function(result) {
					if(result.data != "") {
                        // alert("저축은행인 경우 상호명 확인 : " + result.data);
                        if (typeof callback === "function") callback(result.data+UtilFunc.getBankName(bankCode));
						else return result.data+UtilFunc.getBankName(bankCode);
					}
				}
				, function() {
                    // alert("저축은행 상호명 조회 실패");
                    if (typeof callback === "function") callback(bankCode);
					else return UtilFunc.getBankName(bankCode);
				}
			);
		} else {
            // alert("저축은행이 아닌 경우");
            if (typeof callback === "function") callback(bankCode);
			return UtilFunc.getBankName(bankCode);
		}
	},
	
	/**
	 * @param String, type
	 * @return 숫자외 입력
	 */
	alertNumChk : function (obj){
		var orgVal = $(obj).val();
    	
    	var numChk = /^[0-9]*$/;				//한글입력 체크
    	if(!numChk.test(orgVal)){
    		customAlert({title : '알림', message:"숫자만 입력가능합니다.", btn_txt1:"닫기"}, '', function(){
    			$(obj).val('');
    			$(obj).focus(); 
			});
    		$(obj).val('');
    		return false;
    	} else {
    		return true;
    	}
	}
	
	/**
	 * @param input
	 * @return 인풋항목 슬라이드 열기 및 포커스 이동 (대출신청관련)
	 */
	, inputSlideAndFocus : function (targetInput, type){
		if(targetInput.closest('.slide-list-wrap').hasClass('on')){
			if(type == 'radio'){
				targetInput.eq(0).focus();
			}else{
				targetInput.focus();
			}
		}else{
			targetInput.closest('.slide-list-wrap').addClass('on');
			targetInput.closest('.slide-list-area').removeAttr('style');
			if(type == 'radio'){
				targetInput.eq(0).focus();
			}else{
				targetInput.focus();
			}
		}
	}
	
	/**
	 * @param input
	 * @return 아코디언 인풋항목 입력 완료 시, 다음 아코디언으로 열기 및 이동 (대출신청관련)
	 */
	, inputSlideOpenAndMove : function (targetInput, step){
		
		if(UtilFunc.isNull(step)){
			// 현재 아코디언 active 제거 후 다음 아코디언 열기
			targetInput.closest('.step-list').removeClass('active');
			targetInput.closest('.step-list').next().addClass('on active');
		}else{
			// 첫번째 아코디언으로 다음 아코디언 열기
			targetInput.closest('.step-list').next().addClass('on active');
		}
		targetInput.closest('.step-list').next().find('.slide-list-area').removeAttr('style');
		scrollT();
	}
	
	, inputMaxLength: function (input) {
		if (input.value.length > input.maxLength) {
			input.value = input.value.slice(0, input.maxLength);
		}
	}
});



var calcFunc = ({

	/**
	 * @param {number} money
	 * @return {string} 30000 -> 30,000
	 */
	addComma: function (money) {
	    money = removeComma(money);
	    money = Math.floor(money);
	    if (money == 0 || isNaN(money)) {
	        return '0';
	    }

	    var chgstr = String(money);
	    var li = chgstr.length - 3;
	    var retstr = "";
	    var i;

	    for (i = li; i >= 1; i = i - 3) {
	        retstr = "," + chgstr.substring(i, i + 3) + retstr;
	    }

	    retstr = chgstr.substring(0, i + 3) + retstr;
	    return retstr;
	},

	/**
	 * @param {number} money
	 * @return {string} 30,000 -> 30000
	 */
	removeComma: function (money) {
	    return money.replace(/,/g, '');
	},
	
	/**
	 * @param {number} number, 3
	 * @return {string} 12.345678 -> 12.345
	 */
	 floorNumber: function (number, digit) {
		 var index = number.indexOf(".");
		 return number.substring(0,index+digit+1);
	 }
	
});



var maskingFunc = ({
	  checkNull : function (str) {
	    if(typeof str == "undefined" || str == null || str == "") {
	      return true;
	    } else {
	      return false;
	    }
	  },

	  /*
	  이메일 마스킹
	  원본 데이터 : abcdefg12345@naver.com
	  변경 데이터 : ab**********@naver.com
	  */
	  email : function(str) {
	    var originStr = str;
	    var emailStr = originStr.match(/([a-zA-Z0-9._-]+@[a-zA-Z0-9._-]+\.[a-zA-Z0-9._-]+)/gi);
	    var strLength;

	    if(this.checkNull(originStr) == true || this.checkNull(emailStr) == true) {
	      return originStr;
	    } else {
	      strLength = emailStr.toString().split('@')[0].length - 3;
	      return originStr.toString().replace(new RegExp('.(?=.{0,' + strLength + '}@)', 'g'), '*');
	    }
	  },

	  /*
	  주민등록 번호 마스킹 (Resident Registration Number, RRN Masking)
	  ex1)
	  원본 데이터 : 990101-1234567,
	  변경 데이터 : 990101-1******
	  ex2)
	  원본 데이터 : 9901011234567,
	  변경 데이터 : 990101-1******
	  */
	  rrn : function(str) {
	    var originStr = str;
	    var rrnStr;
	    var maskingStr;
	    var strLength;
	    if(this.checkNull(originStr) == true) {
	      return originStr;
	    }
	    rrnStr = originStr.match(/(?:[0-9]{2}(?:0[1-9]|1[0-2])(?:0[1-9]|[1,2][0-9]|3[0,1]))-[1-4]{1}[0-9]{6}\b/gi);
	    if(this.checkNull(rrnStr) == false) {
	      strLength = rrnStr.toString().split('-').length;
	      maskingStr = originStr.toString().replace(rrnStr,rrnStr.toString().replace(/(-?)([1-4]{1})([0-9]{6})\b/gi,"$1$2******"));
	    } else {
	      rrnStr = originStr.match(/\d{13}/gi);
	      if(this.checkNull(rrnStr) == false) {
	        strLength = rrnStr.toString().split('-').length;
	        maskingStr = originStr.toString().replace(rrnStr,rrnStr.toString().replace(/([0-9]{6})$/gi,"******"));
	        maskingStr = maskingStr.slice(0,6) + "-" + maskingStr.slice(6);
	      } else {
	        return originStr;
	      }
	    }
	    return maskingStr;
	  },
	  
	  /*
	   사업자번호 마스킹
	   원본 데이터 : 123-45-67890
	   변경 데이터 : 123-45-*****
	   */
	  crno : function(str) {
		  var formatNum = "";
		  if (typeof str !== 'string') return formatNum;
		  str = str.replace(/\-/g, "");
		  
		  formatNum = str.replace(/(\d{3})(\d{2})(\d{5})/g, "$1-$2-*****");
		  
		  return formatNum;
	  },
	  
	  /*
	  아이디 마스킹
	  원본 데이터 : test1234
	  변경 데이터 : te******
	  */
	  id : function(str) {

	    if(this.checkNull(str) == true) {
	    	return str;
	    } else {
	    	return str.replace(new RegExp('(?<=.{2}).', 'g'), '*');
	    }
	  },
	  
	  
});

var calDate = ({

    /**
     * 기준일자와 선택 날짜일자의 개월일을 구한다
     * @strYYYYMMDD "20170331"
     * @return MM, DD
     */
	getTermsMonthDay: function (strYYYYMMDD) {
	   var day = strYYYYMMDD;
	   if(typeof(day) == 'number') {
		   day = String(day);
	   }
	   
	   var choiceday = day;
	   var today = UtilFunc.getCurrentDateOnly();
	   
	   var date1_yy = Number(choiceday.substring(0, 4));
	   var date1_mm = Number(choiceday.substring(4, 6));
	   var date1_dd = Number(choiceday.substring(6, 8));
	   var date2_yy = Number(today.substring(0, 4));
	   var date2_mm = Number(today.substring(4, 6));
	   var date2_dd = Number(today.substring(6, 8));
	   
	   var chw_DAY = "0";
	   if(((date1_yy % 4 == 0) && (date1_yy % 100 != 0)) || (date1_yy % 400 == 0)) {
		   chw_DAY = "29";
	   } else {
		   chw_DAY = "28";
	   }
	   
	   var diff_MM = (date1_yy - date2_yy)*12 + (date1_mm - date2_mm);
	   var diff_DD = date1_dd - date2_dd;
	   
	   if(diff_DD < 0) {
		   diff_MM = diff_MM -1;
		   diff_DD = diff_DD + new Date(date2_yy, date2_mm, 0).getDate();
	   }
	   
	   return {
		   "MM":diff_MM,
		   "DD":diff_DD
	   }
	   
	}
	
});
