/**
 * 예가람저축은행 javascript 공통 Function 
 * 
 * 1. AjaxFunc Ajax call 처리를 위한 Function 집합
 * 2. DaumMap daumMap 처리를 위한 Function 집합
 * 3. StoreFunc 앱스토어 이동 처리를 위한 Function 집합
 * 4. PageValidate 입력항목에 대한 기본적인 Validate 기능
 * 5. TermsFunc 약관 팝업 공통 함수
 * 6. FuncKeypad APP보안키패드 호출함수
 * 7. LayerFunc Layer 팝업처리를 위한 Function 집합
 * 8. JusoFunc 주소팝업공통
 * 9. ARS 팝업 공통
 * 9. OcrFunc Ocr을 통한 신분증인식 
 * 10. BankAndStockSelFunc 뱅킹 및 증권사 선택 공통팝업 
 * 11. FuncPopup 공통팝업
 * 12. ARIA 암/복호화 모듈
 * 13. 애드브릭스 호출 함수 adbrix
 * 14. 페이크파인더 호출 함수
 * 15. 카카오AD 호출 함수 KakaoAd
 */

// 이이슬 : 아리아 암/복호화 공통 만들기  
var termsInfoList = null;
var prodSvrTermsCode = "T000800003"; //개인(신용)정보 수집·이용·제공 동의서(상품서비스 안내)

/**
 * 1. AjaxFunc
 * + Ajax call 처리를 위한 Function 집합
 */
var AjaxFunc = ({
	showLoading : true,
	ajaxAsyncHtml : function(ajax_url, ajax_data, ajax_successFn, ajax_errorFn) {
		if (AjaxFunc.showLoading) {
			showSplash();
		}
		$.ajax({
			dataType : "html",
			type : "POST",
			url : ajax_url,
			data : ajax_data,
			success : function(data) {
				if (AjaxFunc.showLoading) {
					hideSplash();
					hideSplash();
				}				
				if( ajax_successFn ) {
					ajax_successFn(data);
				}
			},
			error : function(xhr, status, error) {	
				hideSplash();				
				var errorInfo = "receive Error:::code:" + xhr.status + "\n" + "message:" + xhr.responseText + "\n" + "error:" + error;
				if( ajax_errorFn ) {
					ajax_errorFn(errorInfo, xhr.status);
				}else {
					alert(errorInfo);
				}
			}
		});
	},	
	ajaxAsync : function(ajax_url, ajax_data, ajax_successFn, ajax_errorFn) {
		if (AjaxFunc.showLoading) {
			showSplash();
		}
		$.ajax({
			dataType : "json",
			type : "POST",
			url : ajax_url,
			data : ajax_data,
			success : function(data) {
				if (AjaxFunc.showLoading) {
					hideSplash();
					hideSplash();
				}
				if( ajax_successFn ) {
					ajax_successFn(data);
				}
			},
			error : function(xhr, status, error) {	
				hideSplash();
				var errorInfo = "receive Error:::code:" + xhr.status + "\n" + "message:" + xhr.responseText + "\n" + "error:" + error;
				if( ajax_errorFn ) {
					ajax_errorFn(errorInfo, xhr.status);
				}else {
					alert(errorInfo);
				}
			}
		});
	},
	ajaxAsyncMultipart : function(ajax_url, ajax_data, ajax_successFn, ajax_errorFn) {
		if (AjaxFunc.showLoading) {
			showSplash();
		}
		$.ajax({
			//contentType: "application/json; charset=UTF-8",
			dataType : "json",
			type : "POST",
			url : ajax_url,
			data : ajax_data,
            enctype: 'multipart/form-data',
			processData : false,
			contentType: false,
			success : function(data) {
				if (AjaxFunc.showLoading) {
					hideSplash();
				}
				if( ajax_successFn ) {
					ajax_successFn(data);
				}else {
					alert('receive Success');
				}
			},
			error : function(xhr, status, error) {
				hideSplash();	
				var errorInfo = "receive Error:::code:" + xhr.status + "\n" + "message:" + xhr.responseText + "\n" + "error:" + error;
				if( ajax_errorFn ) {
					ajax_errorFn(errorInfo, xhr.status);
				}else {
					alert(errorInfo);
				}
			}
		});
	},
	ajaxAsyncJson : function(ajax_url, ajax_data, ajax_successFn, ajax_errorFn) {
		if (AjaxFunc.showLoading) {
			showSplash();
		}
		$.ajax({
			contentType: "application/json; charset=UTF-8",
			dataType : "json",
			type : "POST",
			url : ajax_url,
			data : ajax_data,
			success : function(data) {
				if (AjaxFunc.showLoading) {
					hideSplash();
				}
				if( ajax_successFn ) {
					ajax_successFn(data);
				}else {
					//alert('receive Success');
				}
			},
			error : function(xhr, status, error) {	
				hideSplash();
				var errorInfo = "receive Error:::code:" + xhr.status + "\n" + "message:" + xhr.responseText + "\n" + "error:" + error;
				if( ajax_errorFn ) {
					ajax_errorFn(errorInfo, xhr.status);
				}else {
					alert(errorInfo);
				}
			}
		});
	},
});


/**
 * 2. daumMap
 * + daumMap 처리를 위한 Function 집합
 */
var DaumMap = {
    //if map이 null 이면 init이 안된상태
    map: null,
    //지도상에 표시된 마커들
    markers: [],

    //@{name},@{address} 를 포함하여 HTML문으로 작성
    infoContents: null,
    loadingMarkerCount: 0,

    /**
     *  @param {string} mapId HTML상의 map id
     *  @param {string} infoContents 마커를 표시할 주소(this.infoContents 참조)
     */
    init: function (mapId, infoContents) {
        var container = document.getElementById(mapId); //지도를 담을 영역의 DOM 레퍼런스
        var options = { //지도를 생성할 때 필요한 기본 옵션
            center: new daum.maps.LatLng(33.450701, 126.570667), //지도의 중심좌표.
            level: 3 //지도의 레벨(확대, 축소 정도)
        };
        this.map = new daum.maps.Map(container, options); //지도 생성 및 객체 리턴
        this.infoContents = infoContents;
    },

    /**
     *  @param {string} markerName 마커에 표시할 이름
     *  @param {string} markerAddress 마커를 표시할 주소
     *  @param {boolean} isCenter 해당 마커를 바로 센터로 이동할지 여부
     */
    addMarkBank: function (markerName, markerAddress, isCenter) {
        this.loadingMarkerCount += 1;
        var map = this.map;
        var markers = this.markers;
        // 인포윈도우로 장소에 대한 설명을 표시합니다
        var infoContents;
        if (this.infoContents) {
            infoContents = this.infoContents.replace('@{name}', markerName).replace('@{address}', markerAddress);
        } else {
            infoContents = '<div style="width:150px;text-align:center;padding:6px 0;">' + markerName + '</div>'
        }

        if (typeof daum === 'undefined') {
            return;
        }

        // 주소-좌표 변환 객체를 생성합니다
        var geocoder = new daum.maps.services.Geocoder();

        // 주소로 좌표를 검색합니다
        geocoder.addressSearch(markerAddress, function (result, status) {
            // 정상적으로 검색이 완료됐으면
            if (status === daum.maps.services.Status.OK) {
                var coords = new daum.maps.LatLng(result[0].y, result[0].x);

                // 결과값으로 받은 위치를 마커로 표시합니다
                var marker = new daum.maps.Marker({map: map, position: coords});
                // marker.infoWindow = new daum.maps.InfoWindow({content: infoContents, removable: false});
                marker.address = markerAddress;
                markers.push(marker);

                // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
                if (isCenter) {
                    // marker.infoWindow.open(map, marker);
                    map.panTo(coords);
                }

                // 마커에 클릭이벤트를 등록합니다
                daum.maps.event.addListener(marker, 'click', function () {
                    // 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
                    // marker.infoWindow.open(map, marker);
                });
            } else {
                //console.log("해당 주소의 위치를 가져오지 못했습니다:" + markerAddress);
            }
            daumMap.loadingMarkerCount -= 1;
        });
    },

    /**
     *  @param {string} address 찾고자 하는 marker의 address
     *  @return {object} 마커 객체(Nullable)
     */
    findMarker: function (address) {
        for (var i = 0; i < this.markers.length; i++) {
            if (this.markers[i].address === address) {
                return this.markers[i];
            }
        }
        return null;
    },

    /**
     *  해당 주소의 마커로 이동
     */
    goMarker: function (address) {
        var marker = this.findMarker(address);
        if (marker) {
            // marker.infoWindow.open(daumMap.map, marker);
            daumMap.map.setLevel(3);
            daumMap.map.panTo(marker.getPosition());
        } else {
            if (this.loadingMarkerCount === 0) {
               // console.log('해당 마커를 찾을 수 없습니다.');
            }
        }
    }
};

/**
 * 3. storeFunc
 * + 앱스토어 이동 처리를 위한 Function 집합
 */
var StoreFunc = {
    /**
     * 각 운영체제별 코드화
     */
    os: {android: 1, iOS: 2, unknown: 9999},

    /**
     * 각 스토어별 아이디(해당 아이디를 통해 스토어로 이동)
     * 현재 iOS의 경우 스토어에 등록이 되지 않은 상태이므로 임시로 다른 어플리케이션의 ID부여
     */
    storeId: {android: "co.kr.goryosb.nsl.app", iOS: "1571863170", onestore: "0000760205"},

    /**
     * 각 스토어별 ID정보를 수동으로 변경 하고 싶을경우 사용
     * @param android 안드로이드 페키지명
     * @param iOS 앱스토어 ID
     */
    setStoreId: function (android, iOS, onestore) {
        this.storeId.android = android || this.storeId.android;
        this.storeId.iOS = iOS || this.storeId.iOS;
        this.storeId.onestore = onestore || this.storeId.onestore;
    },

    /**
     * 운영체제별 식별자를 가져오는 함수
     * @returns {number} 해당 브라우저의 OS를 가져온다(this.os return)
     */
    getMobileOS: function () {

        var userAgent = navigator.userAgent || navigator.vendor || window.opera;

        if (/android/i.test(userAgent)) {
            return this.os.android;
        }

        if (/iPad|iPhone|iPod/.test(userAgent) && !window.MSStream) {
            return this.os.iOS;
        }

        return this.os.unknown;
    },

    /**
     * 운영제체에 맞는 스토어 URL을 가져오기 위한 함수
     *
     * @param operationSystem 가져올 OS별 Store
     * @returns {object} 이동할 스토어 url을 리턴(없을경우 null을 리턴)
     */
    getStoreUrl: function (operationSystem) {
        if (this.os.android === operationSystem) {
            if (this.os.android === this.getMobileOS()) {
                return 'market://details?id=' + this.storeId.android;
            } else {
                return 'http://play.google.com/store/apps/details?id=' + this.storeId.android;
            }
        } else if (this.os.iOS === operationSystem) {
            return 'http://itunes.apple.com/app/id' + this.storeId.iOS;
        } else {
            return null;
        }
    },
    
    /**
     * SB톡톡플러스 맞는 스토어 URL을 가져오기 위한 함수
     *
     * @param operationSystem 가져올 OS별 Store
     * @returns {object} 이동할 스토어 url을 리턴(없을경우 null을 리턴)
     */
    getSbbPlusStoreUrl: function (operationSystem) {
        if (this.os.android === operationSystem) {
            if (this.os.android === this.getMobileOS()) {
                return 'market://details?id=kr.or.sbbank.plus';
            } else {
                return 'http://play.google.com/store/apps/details?id=kr.or.sbbank.plus';
            }
        } else if (this.os.iOS === operationSystem) {
            return 'http://itunes.apple.com/app/id1469002262';
        } else {
            return null;
        }
    },    

    /**
     * 운영제체에 맞는 스토어로 자동 이동
     *
     * @param operationSystem 이동할 OS별 Store (넣지 않을경우 자동으로 이동 찾아서)
     * @returns {boolean} 해당 스토어 이동 여부(false의 경우 별도의 로직 처리 필요)
     */
    goStore: function (operationSystem) {
        operationSystem = operationSystem || this.getMobileOS();
        var redirectUrl = this.getStoreUrl(operationSystem);
        if (redirectUrl !== null) {
            window.open(redirectUrl, '_system');
            return true;
        } else {
            return false;
        }
    },

	/**
	* 운영체제 및 다운받은 스토어 URL로 이동하기 위한 함수
	*
	* @param operationSystem 단말기 OS
	* @param storeInstaller 다운받은 스토어 인스톨러
	*
	* 1) Google Play Store(구글 플레이스토어)
	* com.android.vending
	* 
	* 2) ONE STORE(원스토어)
	* SKT : com.skt.skaf.A000Z00040
	* KT : com.kt.olleh.storefront
	* LGU+ : android.lgt.appstore || com.lguplus.appstore
	* 
	* 3) Galaxy Apps(갤럭시 앱스)
	* com.sec.android.app.samsungapps
	* 
	* 4) Samsung Smart Switch
	* com.sec.android.easyMover.Agent
	* 
	* 5) Android Package Installer
	* com.google.android.packageinstaller
	* 
	* 6) Samsung Mate Agent
	* com.samsung.android.mateagent
	* 
	* 7) error
	* notInstalled : 설치 안됨
	* unknown : adb 설치등 알수 없음 (안드로이드 스튜디오 등에서 직접 넣음)
	*
	* @returns {boolean} 해당 스토어 이동 여부
	*/
	goStoreUrl: function (operationSystem, storeInstaller) {
		operationSystem = operationSystem || this.getMobileOS();
		
		if (this.os.android === operationSystem) {
			if (this.os.android === this.getMobileOS()) {
				if(storeInstaller.indexOf('skt') > -1 || storeInstaller.indexOf('kt') > -1 || storeInstaller.indexOf('lg') > -1 )  // 원스토어
					FuncPopup.open('onestore://common/product/' + StoreFunc.storeId.onestore, '', '_system', '');
				else // 플레이스토어
					FuncPopup.open('market://details?id=' + StoreFunc.storeId.android, '', '_system', '');
					
				return true;
			} else {
				if(storeInstaller.indexOf('skt') > -1 || storeInstaller.indexOf('kt') > -1 || storeInstaller.indexOf('lg') > -1 )  // 원스토어
					FuncPopup.open('http://m.onestore.co.kr/mobilepoc/apps/appsDetail.omp?prodId=' + StoreFunc.storeId.onestore, '', '_system', '');	
				else // 플레이스토어
					FuncPopup.open('http://play.google.com/store/apps/details?id=' + StoreFunc.storeId.android, '', '_system', '');	
					
				return true;
			}
		} else if (this.os.iOS === operationSystem) {
			FuncPopup.open('http://itunes.apple.com/app/id' + this.storeId.iOS, '', '_system', '');
			return true;
		} else {
			return false;
		}
	}
};


/**
 *  4. PageValidate
 *  + 입력항목에 대한 기본적인 Validate 기능
 */
var PageValidate = (function(PageValidate) {
	/* validate  실행 */
	PageValidate.validate = function(rules) {
//		var result = true;
		var result = { result : true, fields : [], alert : function() {
			if(this.fields.length <= 0) return;
			var _this = this;
			customAlert({title : '안내', message : this.fields[0].field + this.fields[0].message, btn_txt1:'닫기' }, '', function() {

				var focusid = _this.fields[0].focus ? '.' + _this.fields[0].focus : '#' + _this.fields[0].id;
				var offset = $(focusid).offset();
				if(offset) {
					$('html, body').animate({scrollTop: offset.top - 80}, 400, function(){
						$(focusid).focus();
					});
				}else {
					$(focusid).focus();
				}

			});
		}, focus: function() {
			if(this.fields.length <= 0) return;
			location.href = '#' + _this.fields[0].id + "_fc";
		}};
		$.each(rules, function() {
			var ruleArray = this.validate;
			for(var index in ruleArray) {
				var rule = ruleArray[index];
				var ruleObj = ruleMap[rule];
				if(typeof ruleObj == 'undefined' || typeof ruleObj.func != 'function') {
					continue;
				}

				var value = this.type == 'radio' ? $('[name="' + this.id + '"]:checked').val() : $('#' + this.id).val();

				if(ruleObj.func.call(this, value)) {
					var strTitle = "[알림]";
					var _id = this.id;
					//null일 경우 팝업 타이틀 설정
					if(typeof strTitle =='undefined' || strTitle =='' || strTitle ==null) {
						strTitle = this.fieldName;
					}
					customAlert({title: strTitle, message: this.fieldName +ruleObj.message, btn_txt1:"닫기"}
					,''
					, function() {
						$('#' + _id).focus();
					}
					);
				//	$('#' + _id).focus();
					result = false;
					return false;		// break;
				}
			}
		});
		return result;
	};
	/* null 체크 */
	PageValidate.isNull = function(data) {
		return data == null || data.length == 0 ? true : false;
	};
	/* 숫자 체크 */
	PageValidate.isNumber = function(data) {
		var pattern = /^[0-9]+$/;
		return !pattern.test(data);
	};
	/* 전화번호 체크 */ //2016.03.30 자리수체크수정 이수지
	PageValidate.isTelNo = function(data) {
		var pattern = /^\d{2,3}-\d{3,4}-\d{4}$/;
		return !pattern.test(data);
	};
	/* 전화 번호 가운데 자리 */
	PageValidate.isTelNo2 = function(data) {
		var pattern = /^\d{3,4}$/;
		return !pattern.test(data);
	};
	/* 전화 번호 마지막 자리 */
	PageValidate.isTelNo3 = function(data) {
		var pattern = /^\d{4}$/;
		return !pattern.test(data);
	};
	/* 일자 체크 */
	PageValidate.isDate = function(data) {
		var pattern = /^\d{4}-\d{2}-\d{2}$/;
		return !pattern.test(data);
	};
	/* 일자 체크_8자리 */
	PageValidate.isDate8 = function(data) {
		var pattern = /^\d{8}$/;
		return !pattern.test(data);
	};
	/* 검색기간 체크 */
	PageValidate.searchDate = function(obj1,obj2) {
		return obj2 < obj1 ? false : true;
	};
	/* 이메일 체크 */
	PageValidate.isNotEmail = function(data) {
		return ! /[0-9a-zA-Z][_0-9a-zA-Z-]*@[_0-9a-zA-Z-]+(\.[_0-9a-zA-Z-]+){1,2}$/.test( data );
	};
	/* 아이디 체크 */
	PageValidate.isNotValidId = function(val) {
		return ! /^[a-zA-Z]{1}[_0-9a-zA-Z-]{3,}$/.test( val );
	};
	/* IP 체크 */
	PageValidate.isNotValidIp = function(val) {
		return ! /^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$/.test( val );
	};
	/* 주민번호 앞자리 체크 */
	PageValidate.isNotValidJumin1 = function(data) {
		var pattern = /^\d{6}$/;
		return !pattern.test(data);
	};
	/* 주민번호 뒷자리 체크 */
	PageValidate.isNotValidJumin2 = function(data) {
		var pattern = /^[0-9a-zA-Z]{7}$/;
		return !pattern.test(data);
	};

    PageValidate.isBirthDay = function (data) {
        if (!/^(\d){8}$/.test(data)) return true;
        var y = Number(data.substr(0, 4)),
            m = Number(data.substr(4, 2)),
            d = Number(data.substr(6, 2));
        if (y < 1900 || y > 3000) {
            // 사용가능 하지 않은 년도 체크
           return true;
        }

        if (m < 1 || m > 12) {
            // 사용가능 하지 않은 달 체크
            return true;
        }

        // 해당달의 마지막 일자 구하기
        var nMaxDay = new Date(new Date(y, m, 1) - 86400000).getDate();
        return d < 1 || d > nMaxDay;

    };


    /* validate rule */

	var ruleMap = {
		  'NotNull' : {func : PageValidate.isNull, message : '을(를) 입력해주세요' }
		, 'Check' : {func : PageValidate.isNull, message : '을(를) 선택해주세요.' }
		, 'Confirm' : {func : PageValidate.isNull, message : '을(를) 확인해주세요.' }
		, 'Number' : {func : PageValidate.isNumber, message : '을(를) 숫자로 입력해주세요' }
		, 'TelNo' : {func : PageValidate.isTelNo, message : '을(를) 올바르게 입력해주세요.(숫자, - 를 포함한 숫자만 입력해주세요)'}
		, 'TelNo2' : {func : PageValidate.isTelNo2, message : ' 가운데 자리를 3자리 이상 입력해 주세요.'}
		, 'TelNo3' : {func : PageValidate.isTelNo3, message : ' 끝자리를 4자리 입력해주세요.'}
		, 'Date' : {func : PageValidate.isDate, message : '을(를) 올바르게 입력해주세요.(날짜(yyyy-mm-dd)를 입력해주세요)'}
		, 'Date8' : {func : PageValidate.isDate8, message : '을(를) 올바르게 입력해주세요.(날짜(yyyymmdd)를 입력해주세요)'}
		, 'BirthDay' : {func : PageValidate.isBirthDay, message : '을(를) 올바르게 입력해주세요.(현재 날짜보다 미래일 수 없습니다.)'}
		, 'Email' : {func : PageValidate.isNotEmail, message : '을(를) 올바르게 입력해주세요.(이메일형식)'}
		, 'ID' : {func : PageValidate.isNotValidId, message : '을(를) 올바르게 입력해주세요.(영문으로 시작, 8자이상)'}
		, 'IP' : {func : PageValidate.isNotValidIp, message : '을(를) 올바르게 입력해주세요.(ex. 127.0.0.1)'}
		, 'Jumin1' : {func : PageValidate.isNotValidJumin1, message : ' 앞 6자리를 입력해 주세요.'}
		, 'Jumin2' : {func : PageValidate.isNotValidJumin2, message : ' 뒤 7자리를 입력해 주세요.'}
	};
	return PageValidate;
})(window.PageValidate || {});


/**
 *  5. TermsFunc
 *  + 약관 팝업 공통 함수
 */
var TermsFunc = ({

    //약관로딩 시 전체 체크
    initCheckTrue: function () {

        // [체크] 시 팝업 로드
        $('input:checkbox[name=check]').each(function () {

            var chkVal = $(this).is(':checked');
            var propId = $(this).prop('id');
            $("#" + propId).prop('checked', true);
            $("#" + propId).parent().addClass("c-on");
        });
        //[전체선택] 동의
        $('input:checkbox[name=checkAll]').each(function () {

            var propId = $(this).prop('id');
            $("#" + propId).prop('checked', true);
            $("#" + propId).parent().addClass("c-on");
        });
    }

    //약관리스트 조회
    , getTermsList: function () {
        termsInfoList = JSON.parse(sessionStorage.getItem("termsInfoList"));
        return termsInfoList;
    }

    //동의 할 약관 정보 설정
    , setTermsList: function (code, agreeYn) {

        termsInfoList = JSON.parse(sessionStorage.getItem("termsInfoList"));

        if (UtilFunc.isNull(code) || UtilFunc.isNull(agreeYn)) {
            //console.log('약관 정보 없음.');
            return false;
        }
        var temsInfoTmp = [];
        for (var i = 0; i < termsInfoList.length; i++) {
            temsInfoTmp[i] = termsInfoList[i];
            if (code == termsInfoList[i].TERMS_CODE) {
                temsInfoTmp[i].AGREE_YN = agreeYn;
            }
        }
        sessionStorage.setItem('termsInfoList', JSON.stringify(temsInfoTmp));
    }

    /** [약관정보 동의 여부]
     * input :  약관코드
     * output : 체크가 다 되어 있을 경우 true, 아니면 false
     */
    , checkTermsAgrYn: function (termsCode) {

        // 선택약관

        var result = "N";
        if (prodSvrTermsCode == termsCode) {

            result = "";
            for (var idx = Number(1); idx < 8; idx++) {
                var chkVal = $("#check" + idx).is(":checked");
                //console.log('chkVal', chkVal);
                var dim = result == "" ? "" : "|";
                result += dim;
                //console.log(result);
                result += chkVal ? 'Y' : 'N';
                //console.log('result', result);
            }

        } else {
            //약관 정보 동의 체크
            $('input:checkbox[name=check]').each(function () {
                if ($(this).is(':checked')) {
                    result = "Y";
                } else {
                    result = "N";
                }
            });
        }
        //debugger;
        //console.log(' [약관정보 동의 여부] checkTermsAgrYn  '+ result);
        return result;
    }
    , hasNext: function () {
        return this.getParameters("single")!=='true';
    }
    , getParameters: function (paramName) {
        // 리턴값을 위한 변수 선언
        var returnValue;

        // 현재 URL 가져오기
        var url = location.href;

        // get 파라미터 값을 가져올 수 있는 ? 를 기점으로 slice 한 후 split 으로 나눔
        var parameters = (url.slice(url.indexOf('?') + 1, url.length)).split('&');

        // 나누어진 값의 비교를 통해 paramName 으로 요청된 데이터의 값만 return
        for (var i = 0; i < parameters.length; i++) {
            var varName = parameters[i].split('=')[0];
            if (varName.toUpperCase() == paramName.toUpperCase()) {
                returnValue = parameters[i].split('=')[1];
                return decodeURIComponent(returnValue);
            }
        }
    }

    /** [약관정보 다음 버튼]
     * input :  약관코드
     * output : 다음약관코드 / 닫기
     */
    , next: function (termsInfo) {

        var termsCode = termsInfo.TERMS_CODE;
        //1. 동의여부
        var agreeYn = termsInfo.AGREE_YN;
        //필수 여부 TODO: 필수여부 sql 수정
        var needYn = termsInfo.NEED_YN;

        if (UtilFunc.isNull(termsCode)) return false;

        var agreeYn = TermsFunc.checkTermsAgrYn(termsCode);

        // 팝업호출 시 넘어온 약관 정보
        TermsFunc.getTermsList();

        //2. 다음 약관으로 이동하기 위해 다음 약관 정보 조회
        var flag = false;
        var nextCd = "";
        for (var i = 0; i < termsInfoList.length; i++) {
            var curTems = termsInfoList[i].TERMS_CODE;
            if (termsCode == curTems) {
                flag = true;
                continue;
            }
            if (flag && UtilFunc.isNull(nextCd)) {
                nextCd = curTems;
                break;
            }
        }

        //3. 메시지 출력
        if (agreeYn == "N" && needYn == "Y") {

            customAlert({title: termsInfo.TERMS_NAME + ' 약관에 동의해주세요', message: "", btn_txt1: "확인"});
            return;
        }

        TermsFunc.setTermsList(termsCode, agreeYn);
        if (flag && UtilFunc.isNull(nextCd)) {
            var closeData = sessionStorage.getItem("termsInfoList");
            window.shouldClose = true;
            window.shouldCloseData = closeData;
        }
        if (!UtilFunc.isNull(nextCd)) {
            // 다음페이지로 이동
            if (/T0002/.test(nextCd)) {
                location.href = nextCd;
            } else {
                location.href = '/loan/nonstopTerms/' + nextCd;
            }
        }

    }

    /** [약관정보 닫기 버튼]
     * input :  약관코드
     * output : 동의 여부(Y/N)
     */
    , close: function (termsInfo) {

        var termsCode = termsInfo.TERMS_CODE;
        //1. 동의여부
        var agreeYn = "";

        if (UtilFunc.isNull(termsCode)) return;
        var agreeYn = TermsFunc.checkTermsAgrYn(termsCode);
        // 팝업호출 시 넘어온 약관 정보
        TermsFunc.getTermsList();
        TermsFunc.setTermsList(termsCode, agreeYn);

        var closeData = sessionStorage.getItem("termsInfoList");
        window.shouldClose = true;
        window.shouldCloseData = closeData;

    } //close

});


/**
 *  6. FuncKeypad
 *  + APP보안키패드 호출함수
 */
var FuncKeypad= ({

	input : null, // input name
	plainInput : null, // plainInput name
	decYn : null, // 복호화 여부
	type : null, //keypad type
	checkMaxLengthYn : true, //keypad type

	/*
	 * 주민등록번호 뒷자리 호출함수
	 */
	juminKeyboard: function(inputNm) {
		FuncKeypad.initKeyboard(inputNm);
		FuncKeypad.showKeyboard('1', inputNm, '','' , '주민등록번호 뒷자리를 입력해주세요', '7', false);
	}

	/*
	 * 보안카드번호 앞자리 호출함수
	 */
	, securityFirstKeyboard: function(inputNm, num) {
		FuncKeypad.initKeyboard(inputNm);
		FuncKeypad.showKeyboard('1', inputNm, '','' , '보안카드번호 [' + num +'] 앞자리 2자리를 입력해주세요', '2', true);
	}
	
	/*
	 * 보안카드번호 뒷자리 호출함수
	 */
	, securityNextKeyboard: function(inputNm, num) {
		FuncKeypad.initKeyboard(inputNm);
		FuncKeypad.showKeyboard('1', inputNm, '','' , '보안카드번호 [' + num +'] 뒷자리 2자리를 입력해주세요', '2', true);
	}	
	
	/*
	 * 사업자번호 뒷자리 호출함수
	 */
	, businessNumKeyboard: function(inputNm) {
		FuncKeypad.initKeyboard(inputNm);
		FuncKeypad.showKeyboard('1', inputNm, '','' , '사업자번호 뒷자리를 입력해주세요', '5', false);
	}
	
	/*
	 * 비밀번호 호출함수
	 */
	, passwordKeyboard: function(inputNm) {
		FuncKeypad.initKeyboard(inputNm);
		FuncKeypad.showKeyboard('3', inputNm, '','' , '비밀번호를 입력해주세요', '12', false);
	}
	
	/*
	 * 비밀번호 확인 호출함수
	 */
	, passwordConfirmKeyboard: function(inputNm) {
		FuncKeypad.initKeyboard(inputNm);
		FuncKeypad.showKeyboard('3', inputNm, '','' , '비밀번호(확인)를 입력해주세요', '12', false);
	}	
	
	/*
	 * 핀번호 호출함수
	 */	
	, pinKeyboard: function(inputNm) {
		FuncKeypad.initKeyboard(inputNm);
		FuncKeypad.showKeyboard('4', inputNm, '','' , '001', '6', false);
	}
	
	/*
	 * 계좌비밀번호 호출함수
	 */
	, accountKeyboard: function(inputNm) {
		FuncKeypad.initKeyboard(inputNm);
		FuncKeypad.showKeyboard('1', inputNm, '','' , '계좌 비밀번호를 입력해주세요', '4', false);
	}	
	
	/*
	 * 초기 비밀번호 6자리 호출함수
	 */
	, firstPasswordKeyboard: function(inputNm) {
		FuncKeypad.initKeyboard(inputNm);
		FuncKeypad.showKeyboard('1', inputNm, '','' , '초기 비밀번호를 입력해주세요', '6', false);
	}	
	
	/*
	 * OTP 호출함수
	 */
	, otpKeyboard: function(inputNm) {
		FuncKeypad.initKeyboard(inputNm);
		FuncKeypad.showKeyboard('1', inputNm, '','' , 'OTP번호를 입력해주세요', '6', false);
	}
	
	, initKeyboard: function(inputNm) {
	    $("#"+inputNm).val('');//암호화된 주민번호
		$("#"+inputNm+"Plain").val('');//plainText
		$("#"+inputNm+"Dummy").val('');//dummyText
	}	

	/* 함수명 : 키패드 사용 함수
	 * type : 숫자 = 1, 문자,순자 혼용 = 3
	 * inputNm : 화면에 출력할 input ID
	 * _callback1 : 성공 시 호출할 함수명
	 * _callback2 : 실패 시 호출할 함수명
	 * title : 보안키패드에 보여지는 명칭
	 * maxLength : 보안키패드에서 입력되는 최대 길이
	 * decYn : 복호화 사용 여부 (decYn Y:복호화 한 값, N : 암호화 된 값. )
	 * (※decYn 제외 다 필수)
	 */
	, showKeyboard : function(type, inputNm, _callback1, _callback2, title, maxLength, pcheckMaxLengthYn) {

		var succFuc = FuncKeypad.succFuc;
		var errorFuc = FuncKeypad.errorFuc;
		FuncKeypad.checkMaxLengthYn = pcheckMaxLengthYn;
		FuncKeypad.input = inputNm;
		FuncKeypad.decYn = 'N';
		FuncKeypad.type = type;

		var ln = maxLength;

		if(typeof _callback1 === "function"){
			succFuc = _callback1;
		}
		if(typeof _callback2 === "function"){
			errorFuc = _callback2;
		}

        AjaxFunc.ajaxAsyncHtml(
            '/common/getKeyboardServerKey.ajax'
            , {}
            , function(result) {
                if(type == '0'){
                    nFilter.showKeypad(0,0,succFuc,errorFuc,'NonSTOP',title ,maxLength,result);
                }else if(type == '1'){  // 숫자
                    nFilter.showKeypad(0,1,succFuc,errorFuc,'NonSTOP',title ,maxLength,result);
                }else if(type == '2'){  //[사용X]
                    nFilter.showKeypad(1,0,succFuc,errorFuc,'NonSTOP',title ,maxLength,result);
                }else if(type == '3'){  //  문자
                    nFilter.showKeypad(1,1,succFuc,errorFuc,'NonSTOP',title ,maxLength,result);
                }else if(type == '4') {
                    nFilter.showKeypad(2,1,succFuc,errorFuc,'NonSTOP',title ,maxLength,result);
                }
            },ajax_error
        );  	    
	    
	}
	, succFuc : function succFuc(res){

	 	var resObj = JSON.parse(res);
	    var dummyText = resObj.dummyText;
	    var encText = resObj.encText;
	    var plainText = resObj.plainText; // 앱으로 전송할 데이터
	    var maxLen = resObj.maxLen;
	    if (FuncKeypad.checkMaxLengthYn) {
		    if(dummyText.length == maxLen){
			    $("#"+FuncKeypad.input).val(encText);//암호화된 주민번호
				$("#"+FuncKeypad.input+"Plain").val(plainText);//plainText
				$("#"+FuncKeypad.input+"Dummy").val(dummyText);//dummyText
		    }
	    } else {
		    $("#"+FuncKeypad.input).val(encText);//암호화된 주민번호
			$("#"+FuncKeypad.input+"Plain").val(plainText);//plainText
			$("#"+FuncKeypad.input+"Dummy").val(dummyText);//dummyText	    	
	    }
	    $(".fixed-btn-wrap").attr('style','position:fixed !important; bottom:0; left:0px; width:100%; z-index:20;'); /* 2020-08-31 */
	}
	, errorFuc : function (e){
		$(".fixed-btn-wrap").attr('style','position:fixed !important; bottom:0; left:0px; width:100%; z-index:20;'); /* 2020-08-31 */
		//var err = JSON.parse(e);
		/*	customAlert({title: "알림", message: err.resultText , btn_txt1:"닫기"}, '', function() {
			hideSplash();
			});	*/
	}

});


/**
 *  LayerFunc
 *  + Layer 팝업처리를 위한 Function 집합
 *  + inc_layer_popup.jsp 가 include 되어 있어야 함
 */
var LayerFunc = ({
    bFade: false,

    /**
     * html
     */
    openHtml: function (innerHtml, title, fnOk, fnCancel, btnTitleOk, btnTitleCancel) {
        //var layer_id = 'layer_popup_message_dynamic';
        var layer_id = 'layer_popup_message_ok';
        if (fnCancel) {
            layer_id = 'layer_popup_message_okcancel';
        }
        LayerFunc.coreOpenLayer(true, layer_id, innerHtml, title, fnOk, fnCancel, true, btnTitleOk, btnTitleCancel);
    },
    /**
     * 처리중...
     */
    progress: function (message) {
        // this.addLoading(Math.round(Math.random() + 1));
        this.loading();
        /*var layer_id = 'layer_popup_progress';
        if (!message) {
            message = '처리중';
        }
        ;
        LayerFunc.coreOpenLayer(false, layer_id, message, null, null, null, false);*/
    },
    /**
     * alert 창 표시
     *
     * @parameter    message : 표시할 메시지
     *                <br/> okFn : OK버튼 클릭시 수신할 함수
     *                <br/> cancelFn : Cancel버튼 클릭 시 수신할 함수
     *                <br/> title : 메시지창 타이틀문구
     */
    alert: function (message, okFn, cancelFn, title) {
        this.removeLoading();
        //layer_popup_message_ok
        //layer_popup_message_okcancel
        var layer_id = 'layer_popup_message_ok';
        if (cancelFn) {
            layer_id = 'layer_popup_message_okcancel';
        }

        LayerFunc.coreOpenLayer(false, layer_id, message, title, okFn, cancelFn, false);
    },
    /**
     * Layer 즉시 Open
     *
     * layerOpen --> openLayer
     *
     * @parameter layer_id
     */
    layerOpen: function (layer_id, message, okFn, cancelFn, title, bClickOut) {
        LayerFunc.coreOpenLayer(false, layer_id, message, title, okFn, cancelFn, bClickOut);
    },
    /**
     * Layer 즉시 없애기
     *
     * layerClear -> clearLayer
     */
    layerClear: function (id) {
        this.removeLoading();
    },
    coreClearLayer: function () {
        if (LayerFunc.bFade) $('.layer').fadeOut();
        else $('.layer').hide();
    },
    /**
     * @bFade : fade 효과 여부
     * @parameters    bFade(필수) : fade 효과 여부
     *                    <br/> layer_id(필수) : layer id
     *                    <br/> message(필수) : 메시지내용
     *                    <br/> title : 메시지창 타이틀 (default: '안내')
     *                    <br/> fnOk : OK버튼 클릭시 수신할 함수
     *                    <br/> fnCancel : Cancel버튼 클릭시 수신할 함수
     *                    <br/> bClickOut : 배경 클릭시 창 닫을지 안 닫을지 (default: false)
     */
    coreOpenLayer: function (bFade, layer_id, message, title, fnOk, fnCancel, bClickOut, btnTitleOk, btnTitleCancel) {
        if (title == null || title == undefined) title = null;
        if (fnOk == null || fnOk == undefined) fnOk = null;
        if (fnCancel == null || fnCancel == undefined) fnCancel = null;
        if (bClickOut == null || bClickOut == undefined) bClickOut = false;

        LayerFunc.bFade = bFade;

        var layer = $('.layer');
        var temp = $('#' + layer_id);
        var bg = $('#layer_bg').hasClass('bg');	//dimmed 레이어를 감지하기 위한 boolean 변수

        layer.children('.pop-layer').hide();
        temp.show();

        if (LayerFunc.bFade) layer.fadeIn();
        else layer.show();

        // 화면의 중앙에 레이어를 띄운다.
        if (temp.outerHeight() < $(document).height()) temp.css('margin-top', '-' + temp.outerHeight() / 2 + 'px');
        else temp.css('top', '0px');
        if (temp.outerWidth() < $(document).width()) temp.css('margin-left', '-' + temp.outerWidth() / 2 + 'px');
        else temp.css('left', '0px');

        temp.find('a.cbtn').click(function (e) {
            e.preventDefault();
            if (bg) {
                LayerFunc.coreClearLayer();	//'bg' 클래스가 존재하면 레이어를 사라지게 한다.
            }
        });

        if (title) {
            temp.find('.title-l').html(title);
        }
        if (message) {
            temp.find('.ctxt').html(message);
        }
        //btnTitleOk, btnTitleCancel
        if (btnTitleOk) {
            temp.find('a.okbtn').html(btnTitleOk);
        }
        if (btnTitleCancel) {
            temp.find('a.cancelbtn').html(btnTitleCancel);
        }
        temp.find('a.okbtn').unbind("click");
        temp.find('a.okbtn').click(function (e) {
            e.preventDefault();
            if (fnOk) fnOk();
            LayerFunc.coreClearLayer();
        });

        temp.find('a.cancelbtn').unbind("click");
        temp.find('a.cancelbtn').click(function (e) {
            e.preventDefault();
            if (fnCancel) fnCancel();
            LayerFunc.coreClearLayer();
        });

        if (bClickOut) {
            $('.layer .bg').click(function (e) {	//배경을 클릭하면 레이어를 사라지게 하는 이벤트 핸들러
                e.preventDefault();
                LayerFunc.coreClearLayer();
            });
        }
    },
    /**
     * FadeIn 효과
     * layerFadeOpen -> openLayerFade
     */
    layerFadeOpen: function (layer_id, message, okFn, cancelFn, title, bClickOut) {
        LayerFunc.coreOpenLayer(true, layer_id, message, title, okFn, cancelFn, true);
    },
    /**
     * FadeOut 효과
     *
     * layerFadeClear -> clearLayerFade
     * */
    layerFadeClear: function () {
        $('.layer').fadeOut();
    },

    addLoading: function (_num) {
        var _html = "";
        _html += "<div id=\"loadingLayer\" class=\"loading-layer\">";
        _html += "</div>";
        $('body').append(_html);
        if (_num == 2) {
            $("#loadingLayer").addClass('type2');
        }
        $("#loadingLayer").animateSprite({
            fps: 5,
            loop: true,
            complete: function () {
                // use complete only when you set animations with 'loop: false'
                //alert("animation End");
            }
        });
        $('html').addClass('scroll-y');
        $('body').append('<div class="block"></div>').css({'height': '100%', 'overflow': 'hidden'});
    },
    removeLoading: function () {
        $('#loadingLayer').fadeOut().empty().remove();
        $('html').removeClass('scroll-y');
        $('body, html, #wrap').css({'height': '', 'overflow': ''});
        $('.block').remove();
    },
    loading: function () {
        this.addLoading(Math.round(Math.random() + 1));
    }
});



/**
 * 9.JusoFunc 
 * 주소검색 공통기능 
 */
var JusoFunc = {
    resultCallback: null,
    showJusoPop : function (callback){
    	if (typeof callback === 'function') {
    		JusoFunc.resultCallback = callback;
    	}    	
    	var jusoUrl = '/common/juso/juso.ysb';
    	if (systemDevice == 'pc') {
    		FuncPopup.open(jusoUrl, '', '_blank', '');
    	} else {
    		FuncPopup.open(jusoUrl, '', '' ,'jusoResult', '');
    	}
    }
};

/**
 * 9.BankAndStockSelFunc 
 * 뱅킹 및 증권사 선택 공통팝업 
 * 
 * param1 stype 1 : 일반, 2:지역농축협 표시, 3:국세표시
 * param2 callback : 콜백함수
 */
var BankAndStockSelFunc = {
    resultCallback: null,
    showPop : function (stype, callback) {
    	if (typeof callback === 'function') {
    		BankAndStockSelFunc.resultCallback = callback;
    	}    	
		var param = {
			selType : stype	
		}		
   		AjaxFunc.ajaxAsyncHtml(
			'/common/getBankAndStockInfo.ajax'
			,param
			,function(data){
				$("#selBank").html(data);
				openPopup('selBank');
				fnTab();
				return;
			}
			,ajax_error
   		);
    }
};

/**
 * 10.AccountSelFunc 
 * 최근입금, 자주쓰는, 내계좌선택 공통팝업
 * 
 * param1 sel 1 : 내계좌, 2:지역농축협 표시, 3:국세표시
 * param2 callback : 콜백함수
 */
var AccountSelFunc = {
    resultCallback: null,
    showPop : function (sel ,flag, callback) {
    	if (typeof callback === 'function') {
    		AccountSelFunc.resultCallback = callback;
    	}    	
		var param = {selNo : sel, flag : flag}
		//flag 입금지정 계좌 화면 유무 Y/N 
   		AjaxFunc.ajaxAsyncHtml(
			'/common/getAccountInfo.ajax'
			,param
			,function(data){
				hideSplash();
				$("#accTrans").html(data);
				openPopupUp('accTrans');
				return;
			}
			,ajax_error
   		);
    }
};

/**
 * 11.JobSelFunc 
 * 직업선텍 공통팝업
 * 
 * param1 callback : 콜백함수
 */
var JobSrchFunc = {
    resultCallback: null,
    showPop : function (callback) {
    	if (typeof callback === 'function') {
    		JobSrchFunc.resultCallback = callback;
    	}    	
		var param = {}		
   		AjaxFunc.ajaxAsyncHtml(
			'/common/getJobSrch.ajax'
			,param
			,function(data){
				hideSplash();
				$("#srchJob").html(data);
				openPopup('srchJob');
				return;
			}
			,ajax_error
   		);
    }
};

/**
 * 11.JusoRoadSelFunc 
 * 주소 도로명 공통팝업
 * 
 * param1 callback : 콜백함수
 */
var JusoRoadSrchFunc = {
    resultCallback: null,
    showPop : function (callback) {
    	if (typeof callback === 'function') {
    		JusoRoadSrchFunc.resultCallback = callback;
    	}    	
		showSplash();
		var param = {}
   		AjaxFunc.ajaxAsyncHtml(
			'/common/getJusoRoadSrch.ajax'
			,param
			,function(data){
				hideSplash();
				$("#srchJusoRoad").html(data);
				openPopup('srchJusoRoad');
				return;
			}
			,ajax_error
   		);
    }
};

/**
 * 1-.StaffSrchFunc 
 * 권유직원 찾기
 * 
 * param1 callback : 콜백함수
 */
var StaffSrchFunc = {
    resultCallback: null,
    showPop : function (callback) {
    	if (typeof callback === 'function') {
    		StaffSrchFunc.resultCallback = callback;
    	}    	
		showSplash();
		var param = {}
   		AjaxFunc.ajaxAsyncHtml(
			'/common/getSrchStaffInfo.ajax'
			,param
			,function(data){
				hideSplash();
				$("#srchStaff").html(data);
				openPopup('srchStaff');
				return;
			}
			,ajax_error
   		);
    }
,empshowPop : function (callback,prdcd) {
    	if (typeof callback === 'function') {
    		StaffSrchFunc.resultCallback = callback;
    	}    	
		showSplash();
		var param = {prdcd:prdcd}
   		AjaxFunc.ajaxAsyncHtml(
			'/common/getSrchStaffInfo.ajax'
			,param
			,function(data){
				hideSplash();
				$("#srchStaff").html(data);
				openPopup('srchStaff');
				return;
			}
			,ajax_error
   		);
    }
};

/**
 * 12.BizComSelFunc 
 * 비즈 공통 선택 공통팝업
 * 
 * param1 type :  1.출금가능계좌
 * param2 callback : 콜백함수
 */
var BizComSelFunc = {
    resultCallback: null,
    showPop : function (type, title ,callback) {
    	if (typeof callback === 'function') {
    		BizComSelFunc.resultCallback = callback;
    	}    	
		var param = {type : type, title : title}		
   		AjaxFunc.ajaxAsyncHtml(
			'/common/getBizCom.ajax'
			,param
			,function(data){
				$("#selBizCom").html(data);
				openPopupUp('selBizCom');
				return;
			}
			,ajax_error
   		);
    }
};

/**
 * 12-1.BizLoanComSelFunc 
 * 비즈 공통 선택 공통팝업
 * 
 * param1 type :  대출계좌
 * param2 callback : 콜백함수
 */
var BizLoanComSelFunc = {
    resultCallback: null,
    showPop : function (type, title ,callback) {
    	if (typeof callback === 'function') {
    		BizLoanComSelFunc.resultCallback = callback;
    	}    	
		var param = {type : type, title : title}		
   		AjaxFunc.ajaxAsyncHtml(
			'/common/getBizLoanCom.ajax'
			,param
			,function(data){
				$("#selBizCom").html(data);
				openPopupUp('selBizCom');
				return;
			}
			,ajax_error
   		);
    }
};


/**
 * 13.AppTermsFunc 
 * 앱공통 약관정보 취득
 * 
 * param1 pCode : 약관코드
 * param2 showType : D : 기본 , A : 전체선택박스 표시
 */
var AppTermsFunc = {
    init : function (pCode, pType) {   	
		var param = {
			termCode : pCode
			, showType : pType
		}		
   		AjaxFunc.ajaxAsyncHtml(
			'/common/getAppTermsInfo.ajax'
			,param
			,function(data){
				$("#appTermsDiv").html(data);
				return;
			}
			,ajax_error
   		);
    }
};



/**
 * 9.OcrFunc 
 * Ocr을 통한 신분증 인식 
 */
var OcrFunc = {
	cutImg : null,
	idIssueDate : null,
	compScanIdYn : false,
	resultCallback: null,
    showPop : function (callback) {
    	if (typeof callback === 'function') {
    		OcrFunc.resultCallback = callback;
    	}    	
    	    	
		var param = {};		
   		AjaxFunc.ajaxAsyncHtml(
			'/ocr/ocrMain.ajax'
			,param
			,function(data){
				$("#ocrDiv").html(data);
				openPopupUp('ocrDiv');
				fnInp();
				return;
			}
			,ajax_error
   		);
    },	
	scanIDCard : function () {
		ocr.scanIDCard(OcrFunc.succScanIdFunc, OcrFunc.errorScanIdFunc);	
    },
    succScanIdFunc: function (rt) {
		//var resObj = rt;
    	ocrScanAfterAction(rt);
    },    
    errorScanIdFunc : function (rt) {
		if(rt.errCode == '9401'){ //닫기 버튼 눌렀을시

		} else if(rt.errCode == '9003') { //백버튼 눌렀을시

		} else {
			customAlert({title: "알림", message: "신분증 인식에 실패하였습니다.(" + rt.errCode + ")", btn_txt1:"확인"}, ''
				, function() { return;
			});
		}
		return;
    },
	completScan : function() {
		//신분증 스캔 완료
		//$("#compScanIdMsg").show();
		//$("#getScanId").hide();
		OcrFunc.compScanIdYn = true;
		//document.getElementById("FILE_CONTENTS").value = OcrFunc.cutImg;

	},//OCR 데이터 변환
	mappingNumber : function(numData) {
		
		var num0 = "QT";
		var num1 = "ER";
		var num2 = "NE";
		var num3 = "LH";
		var num4 = "VD";
		var num5 = "DN";
		var num6 = "SP";
		var num7 = "BM";
		var num8 = "ES";
		var num9 = "GT";
		
		if(UtilFunc.isNull(numData)){
			return;
		}
		var str2 = numData.split("-");
		var resData = "";

		for(var i = 0; i< str2.length; i++){ 
			var tmp = "";
			for(var index = 0; index < str2[i].length; index = index+2){
		    	//console.log(str2[i][index]+str2[i][index+1]);
		    	var data = str2[i][index]+str2[i][index+1];
		    	if(num0 == data){
		    		data = "0";
		    	}else if(num1 == data){
		    		data = "1";
		    	}else if(num2 ==data){
		    		data = "2";
		    	}else if(num3 == data){
		    		data = "3";
		    	}else if(num4 == data){
		    		data = "4";
		    	}else if(num5 == data){
		    		data = "5";
		    	}else if(num6 == data){
		    		data = "6";
		    	}else if(num7 == data){
		    		data = "7";
		    	}else if(num8 == data){
		    		data = "8";
		    	}else if(num9 == data){
		    		data = "9";
		    	}
		    	tmp += data;
			}
			resData += resData== "" ? tmp : "-"+tmp;
		}
		return resData;
	}
};	

var popResultSend = false;
/**
 *  FuncPopup
 *  + 공통팝업오픈
 *  + openUrl : 링크
 *  + nextUrl : 성공 시 이동할 url
 *  + target : 링크 오픈 브라우저(_blank, _system, _self)
 *  + type : 기타 구분 코드(직장주소/집주소 구분/팝업 구분)
 *  + execSc : 팝업 오픈 시 실행할 javascript
 */
var FuncPopup = ({

	open : function(openUrl, nextUrl, target, type, execSc){

		var checkPopup = false;
		var exitCodeJS = "self.close = function(){ location.href = \'popup/close\';};";

		// 약관일 경우 스크립트 적용
		if('terms' == type){
			// 약관 스크립트
			var termsList = sessionStorage.getItem("termsInfoList");
			var termsJS = "termsInfoList ="+termsList;
			termsJS += "; sessionStorage.setItem('termsInfoList', JSON.stringify(termsInfoList));";
		}

		var _target;
		if(target=="" || target == null){
			_target =  '_blank';
		}else{
			_target = target;
		}

		var ref;
		var loop_auth;	// 인증 관련 setInterval 변수
		var loop_terms; // 약관 관련 setInterval 변수

		if (systemDevice == 'pc') {
			ref = window.open(openUrl, _target, 'width=600,height=600,location=no,toolbar=no');
		} else {
			popResultSend = true;
			ref = cordova.InAppBrowser.open(openUrl, _target, 'location=no,toolbar=no,enableViewportScale=yes,hidespinner=yes');
		}

		ref.addEventListener('loadstart', function(event) {
			//인증
			if(getOsType() == "and"){
				if(!UtilFunc.isNull(loop_auth)) {
	 				window.clearInterval(loop_auth);
				}
			}			
			
			//약관
			if(!UtilFunc.isNull(loop_terms)) {
				window.clearInterval(loop_terms);
			}

		});
		

		ref.addEventListener('loadstop', function(event) {
			ref.executeScript({ code: exitCodeJS }, function(ee){});
			//hideSplash();

			console.log('loadstop');
			
			//약관 팝업 로드 시
			if(!checkPopup && type.indexOf('terms') > -1){

				ref.executeScript({ code: termsJS }
				, function(ee){
					checkPopup = true;
					}
				);
			}// 약관팝업 로드

			// s: 약관
			if(type.indexOf('terms') > -1){

				loop_terms = window.setInterval(function(){
			           ref.executeScript({
			                   code: "window.shouldClose"
			               },
			               function(values){
			                   if(!UtilFunc.isNull(values)){
			                	   ref.executeScript({
		                               code: "window.shouldCloseData"
		                           },
		                           function(values){
								   	//console(values);
								   		PageFunc.setTermsClose(values[0]);
		                            	ref.close();
		                           });
			                     window.clearInterval(loop_terms);
			                   }
			               }
			           );
			       },500); //loop
			}
			//e:약관
			
			if(type.indexOf('auth_res') > -1){ //인증팝업 
				loop_auth = window.setInterval(function(){
					ref.executeScript(
						{code: "window.shouldClose"}	
						,function(values){
							if(!UtilFunc.isNull(values)){
								window.clearInterval(loop_auth);
								clearInterval(loop_auth);
								clearInterval(AuthFunc.intervalId);								
								ref.executeScript(
									{code: "window.shouldCloseData"}
									,function(values2){	
	
										try {
											if (popResultSend == true) {
												authResultCallBack(values2);
												ref.close();
												popResultSend = false;
												return;
											}
										} catch (e) {
											if (popResultSend == true) {
												AuthFunc.resultCallback(values2);
												ref.close();
												popResultSend = false;
												return;
											}
										}										
								});
	 						}
							//window.clearInterval(loop_auth);
						}//values
					);//executeScript
				},500); //loop
			}			
			// e: 팝업에서 데이터 전송

		});// addEventListener
	}//open
});

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// 스크래핑 관련 함수
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
var FuncScrap =({

		/**
		 * 주소목록 가져오기
		 * 
		 * @param succAddrFunc: SUCCESS FUNCTION
		 * @param failAddrFunc: FAIL FUNCTION
		 */
		searchAddressList : function(){ sasscrapping.searchAddressList(succAddrFunc, failAddrFunc) }
		
		/**
		 * 스크래핑 호출
		 * 
		 * @param docs: 문서번호리스트 String[]
		 * @param cindex: 인증서번지 - int
		 * @param jmin1: 주민번호 앞자리 - string
		 * @param jmin2: 주민번호 뒷자리(클라이언트용 암호화텍스트) - string
		 * @param bnum: 사업자 등록번호 - string
		 * @param jobcode: 증명구분 - String ("1","2","3")
							1. 근로소득자용: 근로자
							2. 연말정산한 사업소득자용: 자영업자, 개인사업자
							3. 종합소득세신고자용: 프리랜서
		 * @param siNm: 시도 - string
		 * @param sggNm: 시군구 - string
		 * @param bankcode: 은행코드 (wooriBank) - string
		 * @param bankaccount: 계좌번호 - string
		 * @param pwd: 인증서비밀번호 - string
		 * @param insuranceStartDate : 보험료납부확인서 조회시작년월 (yyyyMM)
		 * @param insuranceEndDate : 보험료납부확인서 조회종료년월 (yyyyMM)
		 * @param bankStartDate : 입출금 조회시작년월일
		 * @param bankEndDate : 입출금 조회종료년월일
		 * @param completeCallback2: SUCCESS FUNCTION
		 * @param errorCallback2: FAIL FUNCTION
		 */
		,execScrapping2 : function(docs,cindex,jmin1,jmin2,bnum,jobcode,siNm,sggNm,bankcode,bankaccount,pwd, insuranceStartDate, insuranceEndDate, bankStartDate, bankEndDate, completeCallback2, errorCallback2){
			//console.log('PARAM', docs+cindex+jmin1+jmin2+bnum+jobcode+siNm+sggNm+bankcode+bankaccount+pwd);
			//TASK3 : jmin2 암호화 해야함. //ajax 만들기
			//TASK3 : var encJmin2 = Aria.encrypt(jmin2);
			//TASK3 : sasscrapping.execScrapping2(docs,cindex,jmin1,encJmin2,bnum,jobcode,siNm,sggNm,bankcode,bankaccount,pwd, insuranceStartDate, insuranceEndDate, bankStartDate, bankEndDate, completeCallback2, errorCallback2)
			//TASK3 : 아래는 지우기
			/*
			var param = {"jmin2" : jmin2 }
			AjaxFunc.ajaxAsync(
				'/common/ariaEncDec.ajax'
				,param
				,function(result){
					sasscrapping.execScrapping2(docs,cindex,jmin1,jmin2,bnum,jobcode,siNm,sggNm,bankcode,bankaccount,pwd, insuranceStartDate, insuranceEndDate, bankStartDate, bankEndDate, completeCallback2, errorCallback2)
					,function completeCallback2(rt){
						var resObj = rt;
					}
					,function errorCallback2(rt){
					}
					return;
				}
				,ajax_error
			); */
			
			sasscrapping.execScrapping2(docs,cindex,jmin1,jmin2,bnum,jobcode,siNm,sggNm,bankcode,bankaccount,pwd, insuranceStartDate, insuranceEndDate, bankStartDate, bankEndDate, completeCallback2, errorCallback2)
			,function completeCallback2(rt){
				var resObj = rt;
			}
			,function errorCallback2(rt){
			}
		}
		
		/**
		 * 스크래핑 호출 + 지방세납세증명 조회 추가
		 * 
		 * @param cindex: 선유서로
		 * @param building: 59 
		 * @param detailAddr: 동호수 (옵션)
		 */
		, execScrapping3 : function(docs,cindex,jmin1,jmin2,bnum,jobcode,siNm,sggNm,bankcode,bankaccount,pwd, insuranceStartDate, insuranceEndDate, bankStartDate, bankEndDate, addr, phone, building, detailAddr, privateYn, completeCallback3, errorCallback3){
			console.log('PARAM', docs+cindex+jmin1+jmin2+bnum+jobcode+siNm+sggNm+bankcode+bankaccount+pwd);
			sasscrapping.execScrapping3(docs,cindex,jmin1,jmin2,bnum,jobcode,siNm,sggNm,bankcode,bankaccount,pwd, insuranceStartDate, insuranceEndDate, bankStartDate, bankEndDate, addr, phone, building, detailAddr, privateYn, completeCallback3, errorCallback3)

			,function completeCallback3(rt){
				var resObj = rt;
			}

			,function errorCallback3(rt){
			}
			
		}
		
});


var FuncAdbrix = ({
    login : function(){ //로그인시
     try {  AdBrixRm.Common.login();  
          } 
     catch (e) {  };
    },
    signUp : function(){ //회원가입시
     var user_id = '{"user_id" : ""}';
     try { AdBrixRm.Common.signUp(JSON.parse(user_id));
          } 
     catch (e) {  };
     
    },
    event : function(eventName, params){  //커스텀이벤트
      console.log('AdBrixRm.eventName >> ' + eventName);
      console.log('AdBrixRm.event >> ' + params);
      console.log('AdBrixRm.event >> ' + JSON.stringify(params));
     try {  AdBrixRm.event(eventName , params);  
          } 
     catch (e) {  };
    }
});


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// 페이크파인더 관련 함수
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
var FuncFakefinder = ({
	fetchFakeAppResult : function(flag){ // 동의,비동의 여부 조회
		try {
			Fakefinder.getFakeFinderAgreeTermsState(
				function(agreeState){
					if(agreeState == "A") // 동의
					{
							Fakefinder.fetchFakeAppResult(function(res){console.log(res)}, true, function(err){console.log('Execution error : ${err}')});
							Fakefinder.fetchRemoteAppResult();
							if(flag === true) {
								Fakefinder.getInstallId(function(res){FuncFakefinder.niceCustReg(res);}, function(err){console.log('Execution error : ${err}')});
							}
					}
					else
					{
						var noticeParam = {
							title:"알림",
							message:"예가람저축은행은 보이스피싱 피해예방을 목적으로 App 설치정보를 확인합니다.",
							type:"confirm",
							btn_txt1:"미동의",
							btn_txt2:"동의"
						}
						customAlert(
							noticeParam,
							function() {
								Fakefinder.setFakeFinderAgreeTermsState(
									"A",
									function(res){},
									function(res){}
								);
								Fakefinder.fetchFakeAppResult(function(res){console.log(res)}, true, function(err){console.log('Execution error : ${err}')});
								Fakefinder.fetchRemoteAppResult();
								if(flag === true) {
									Fakefinder.getInstallId(function(res){FuncFakefinder.niceCustReg(res);}, function(err){console.log('Execution error : ${err}')});
								}
								
								return;
							},
							function(){
								Fakefinder.setFakeFinderAgreeTermsState(
									"D",
									function(res){},
									function(res){}
								);
								return;
							}
						);
					}
				}
			);
		}
		catch (e) {  };
	},
	versionCheckOfFakeFinder : function(currentVersion){ // 페이크파인더 구동 가능한 버전인지 체크
		var result = true;
		var current = currentVersion.split('.'); // ex) 1.0.2 [1] [0] [2]
		var fakeFinderMinVersion = ["1","0","3"]; //FakeFinder 수행 최소 앱버전 1.0.3
	
		const length = Math.max(current.length, fakeFinderMinVersion.length);

		for (var i = 0; i < length; i++) {
			var a = current[i] ? parseInt(current[i], 10) : 0; //현재버전  ex) 1.0.2
			var b = fakeFinderMinVersion[i] ? parseInt(fakeFinderMinVersion[i], 10) : 0; //FakeFinder 수행 최소 엡버전 1.0.3
	
			if (a < b) { //현재버전이 페이크파인더 구동 가능 버전보다 낮을때
				result = false;
				break;
			}else if(a > b) {
				break;
			}
		}
	
	return result;
	},
	niceCustReg : function(installId){
		var param = {installId:installId}
		AjaxFunc.ajaxAsync(
			'/common/niceCustReg.ajax'
			,param
			, function(result) {
				console.log(result);
			}
			,ajax_error
		);
	}	
});


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// 카카오AD 관련 함수
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
var FuncKakaoAd = ({	
	participation : function(eventName){ //잠재고객 (param >> 'Consulting' : 상담신청 / 'LoanLimitCheck' :대출한도조회)
		console.log('KakaoAD.participation : eventName >> ' + eventName);
		try {  KakaoAD.participation(eventName);
			}
		catch (e) {	};
	},
	signup : function(eventName){ //서비스신청 (param >> 'LoanApplication' : 대출신청)
		console.log('KakaoAD.signup : eventName >> ' + eventName);
		try {  KakaoAD.signUp(eventName);
			}
		catch (e) {	};
	},
	versionCheckOfKakaoAd : function(currentVersion){ // 카카오AD 구동 가능한 버전인지 체크
		var result = true;
		var current = currentVersion.split('.'); // ex) 1.0.2 [1] [0] [2]
		var kakaoAdMinVersion = ["1","0","8"]; //KakaoAD 수행 최소 앱버전 1.0.8
	
		const length = Math.max(current.length, kakaoAdMinVersion.length);

		for (var i = 0; i < length; i++) {
			var a = current[i] ? parseInt(current[i], 10) : 0; //현재버전  ex) 1.0.2
			var b = kakaoAdMinVersion[i] ? parseInt(kakaoAdMinVersion[i], 10) : 0; //KakaoAd 수행 최소 엡버전 1.0.8
	
			if (a < b) { //현재버전이 KakaoAd 구동 가능 버전보다 낮을때
				result = false;
				break;
			}else if(a > b) {
				break;
			}
		}
	
	return result;
	},
});
