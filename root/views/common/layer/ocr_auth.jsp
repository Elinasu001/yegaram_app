<%@page import="co.gnbsoftec.common.util.StringUtils"%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
var resultImage = "";
var lastCamera;
var cameraApp;
var cameraInitParam = {
   successCallback : fnOcrSuccFunc,
   failedCallback : fnOcrFailFunc
};

//모바일웹카메라
var mobWebCamera = (function ($) {
	const cameraApp = document.querySelector("#camera-area");
	const body = document.querySelector(".camera-area-body");
	const video = document.querySelector(".camera-area-body-video");
	let canvas = document.querySelector(".camera-area-body-canvas");
	const capture_button = document.querySelector(".camera-area-footer-capture-button");
	const close_button = document.querySelector(".camera-area-footer-close-button");
	let ctx = canvas.getContext("2d");
	var video_devices = [];
	var current_device_id;
	var realVideoRect = {};
	var guide_rect = {};
	var capture_callback;
	var failed_callback;
	var isReady = false;
	var debug_log = false;
	const constraints = {
		audio: false,
		video: {
			width: {
				ideal: 860
			},
			height: {
				ideal: 1248
			},
			frameRate: {
				min: 10,
				ideal: 30,
				max: 60
			},
			facingMode: {
				exact: "environment"
			},
		},
	};
	var video_target_rect = {
		left: 0,
		top: 0,
		width: video.videoWidth,
		height: video.videoHeight,
	};
	
	var repeat_draw = {
		time: 300, 
	};
	
	function handleSuccess(stream) {
		window.stream = stream; // make stream available to browser console
		video.srcObject = stream;
	}

	function handleError(error) {
		console.log("navigator.MediaDevices.getUserMedia error: ", error.message, error.name);
		alert(error.message + " | " + error.name);
	}
	
	var onLoadedmetadata = function (event) {
		drawGuide();
	};
	
	var onResizeWindow = function () {
		setTimeout(function () {
			drawGuide();
		}, repeat_draw.time);
		drawGuide();
		if(debug_log){
			console.log("rect = left:" + guide_rect.left + " top:" + guide_rect.top + " height:" + guide_rect.height + " width:" + guide_rect.width);
		}
	};

	var drawGuide = function () {
		document.body.classList.add("scroll-lock");
		
		var videoWidth = video.videoWidth;
		var videoHeight = video.videoHeight;

		var video_ratio = videoWidth / videoHeight;

		var canvasWidth = 0;
		var canvasHeight = 0;
		
		var w_ratio = body.clientWidth / videoWidth;
		var h_ratio = body.clientHeight / videoHeight;

		if (w_ratio <   h_ratio) {
			canvasWidth = body.clientWidth;
			canvasHeight = body.clientWidth / video_ratio;
		} 
		else {
			canvasHeight = body.clientHeight;
			canvasWidth = body.clientHeight * video_ratio;
		}
		canvas.style.left = (body.clientWidth - canvasWidth) / 2 + 'px';
		canvas.style.top = (body.clientHeight - canvasHeight) / 2 + 'px';
		canvas.width = canvasWidth;
		canvas.height = canvasHeight;
		if (!ctx) {
			ctx = canvas.getContext("2d");
		}
		ctx.clearRect(0, 0, canvas.offsetWidth, canvas.offsetHeight);

		if(debug_log){
			console.log('body size : ' + body.clientWidth + ' * ' + body.clientHeight + ', canvas size : ' + canvasWidth + ' * ' + canvasHeight);
		}
		video.style.top = canvas.style.top;
		video.style.left = canvas.style.left;
		video.width = canvas.width;
		video.height = canvas.height;
		
		canvasWidth = canvas.offsetWidth;
		canvasHeight = canvas.offsetHeight;
	};

	var videoStreamToBlob = function (callback_function) {
		video_target_rect = {
			left: 0,
			top: 0,
			width: video.videoWidth,
			height: video.videoHeight,
		};

		var data_canvas = document.querySelector(".extract-image");
		data_canvas.width = video.videoWidth;
		data_canvas.height = video.videoHeight;
		var data_ctx = data_canvas.getContext("2d");

		data_ctx.clearRect(0, 0, video_target_rect.width,
			video_target_rect.height);

		data_ctx.drawImage(video, 0, 0, video_target_rect.width,
			video_target_rect.height);
		var dataUrl = data_canvas.toDataURL("image/jpeg");
		var callback_data = {};
		callback_data.blob = dataUrl.toString();
		callback_data.width = video_target_rect.width;
		callback_data.height = video_target_rect.height;

		data_ctx.clearRect(0, 0, video_target_rect.width,
			video_target_rect.height);
		data_canvas.toDataURL("image/jpeg");
		
		if (callback_function) {
			callback_function(callback_data);
		}
		dataUrl = null;
		data_ctx = null;
		callback_data.blob = null;
		data_canvas = null;

	};

	var initRTC = function (cameraInitParam) {
		capture_callback = cameraInitParam.successCallback;
		failed_callback = cameraInitParam.failedCallback;
		video_devices = [];
		enumerateDevices().then(function () {
			setCameraSelect();
			isReady = true;
		})
		//.catch(function(error){
		['catch'](function(error){
			end();
			failed_callback(error);
		});
	};

	var getUserMedia = function () {
		canvas = document.querySelector(".camera-area-body-canvas");
		ctx = canvas.getContext("2d");
		var newContraionts = Object.assign({}, constraints);
		if (current_device_id) {
			newContraionts.video.deviceId = {
				exact: current_device_id
			};
		}
		return navigator.mediaDevices.getUserMedia(newContraionts);
	};

	var enumerateDevices = function () {
		return new Promise(
			function (resolve, reject) {
				if (navigator.mediaDevices.enumerateDevices) {
					navigator.mediaDevices
						.enumerateDevices()
						.then(
							function getDevice(media_devices) {
								media_devices
									.forEach(function (media_device) {
										if (media_device.kind === "videoinput" && media_device.label.indexOf("front") === -1) {
											video_devices.push(media_device);
										}
									});
								if(debug_log){
									console.log(video_devices);
								}
								resolve();
						})
						['catch'](function(error) {
							end();
							failed_callback(error);
						});
				}
			});
	};

	var startRTC = function (callback) {
		var interval = setInterval(function () {
			if (isReady) {
				cameraApp.style.display = "block";
				getUserMedia().then(handleSuccess)
				['catch'](function(error){
					end();
					failed_callback(error);
				});
				clearInterval(interval);
			}else {
				cameraApp.style.display = "none";
				end();
			}
		}, 100);

		window.addEventListener("resize", onResizeWindow);
		window.addEventListener("orientationchange", onResizeWindow);
	};

	var setCameraSelect = function () {
		if (video_devices && video_devices.length > 0) {
			current_device_id = video_devices[video_devices.length - 1].deviceId;
		}else{
			current_device_id = "";
		}
	};

	var end = function () {
		cameraApp.style.display = "none";
		document.body.classList.remove("scroll-lock");
		video.pause();
		if (video.srcObject) {
			video.srcObject.getTracks().forEach(function (track) {
				if (track.readyState == "live") {
					track.stop();
				}
			});
			URL.revokeObjectURL(video.srcObject);
			video.srcObject = null;
		} else {
			if (video.src) {
				URL.revokeObjectURL(video.src);
			}
			video.src = null;
		}
		video.width = video.height = video.ratio = 0;
		if (ctx){
			ctx.clearRect(0, 0, canvas.offsetWidth, canvas.offsetWidth);
			ctx.fillStyle="black";
			ctx.fillRect(0,0,canvas.offsetWidth,canvas.offsetWidth);
			ctx.clearRect(0, 0, canvas.offsetWidth, canvas.offsetWidth);
		}
		isReady = false;
		ctx = null;
		canvas = null;
		window.removeEventListener("resize", onResizeWindow);
		window.removeEventListener("orientationchange", onResizeWindow);
	};
	
	var stopVideo = function() {
		video.pause();
		if (video.srcObject) {
			video.srcObject.getTracks().forEach(function (track) {
				if (track.readyState == "live") {
					track.stop();
				}
			});
			URL.revokeObjectURL(video.srcObject);
			video.srcObject = null;
		} else {
			if (video.src) {
				URL.revokeObjectURL(video.src);
			}
			video.src = null;
		}
		video.width = video.height = video.ratio = 0;
	};

	var cancel = function () {
		cameraApp.style.display = "none";
		end();
	};

	var capture = function () {
		videoStreamToBlob(capture_callback);
		end();
	};

	capture_button.addEventListener("click", capture);
	close_button.addEventListener("click", cancel);
	video.addEventListener("loadedmetadata", onLoadedmetadata);
	
	return {
		initRTC: initRTC,
		startRTC: startRTC,
		capture: capture,
		cancel: cancel,
		end: end,
		getUserMedia: getUserMedia,
	};
})();
		
var ${reqDs.id }_Func = ({
	// 닫기  
	close : function(){},
	// 취소 (그만하기)
	cancel : function(){},
	// 확인 (처리 완료 버튼, 또는 처리완료 선택)
	confirm : function(result){
		${reqDs.id }_Func.callback(result, resultImage);
	},
	// 호출 화면 콜백 처리	
	callback : function(){}
});

// 이미지 촬영 성공
function fnOcrSuccFunc(image_data) {
	if (image_data != "") {
		var img_data = image_data.blob.substring(23); // base64 img
		resultImage = image_data.blob;
		var ocrReqForm = makeForm("ocrReqForm");
		addFormData(ocrReqForm, "txGbnCd", "O");
		addFormData(ocrReqForm, "IDCD_IMG", img_data);
		doAction("OCR_AUTH", ocrReqForm, ocrResult);	
	}
}
// 이미지 촬영 오류
function fnOcrFailFunc(error) {
	biz.alert("신분증 촬영 중 오류가 발생하였습니다. "+error, function(){
		fnShowArea("camera");
	});
}
// 화면보이기 영역처리
function fnShowArea(divId) {
	fnAreaDisable();
	$("#"+divId+"Div").show();
	$("#"+divId+"Btn").show();
}
// 전체가리기
function fnAreaDisable() {
	$("#ocrRESP_CD_err").hide();
	$("#initDiv").hide();
	$("#cameraDiv").hide();
	$("#resultDiv").hide();
	$("#initBtn").hide();
	$("#cameraBtn").hide();
	$("#resultBtn").hide();
}
// OCR 결과코드
function ocrResult(resDs) {
	
	if("Y" == resDs.APP_HEADER.errYn){	
		
		biz.alert("신분증 정보를 인식할 수 없습니다.","확인", function(){
			takePhoto();
		});
		
	} else {

		var respCd = resDs.RESP_CD; 						// 00:정상 01:진위확인실패(수정 또는 재촬영) 09:이미지 인식실패(재촬영) 99:본인신분증아님 
		var respMsg = resDs.RESP_MSG;						// 응답메시지
		var maskedImg = resDs.MASKED_IMG; 					// 마스킹 이미지
		var maskedSsn = resDs.MASKED_SSN;					// 마스킹 실명번호
		var idbirth = resDs.ID_BIRTH;						// 생년월일
		var idTycd = resDs.ID_TYCD;							// 신분증 종류 ic:주민등록증 dl:운전면허증
		var ocrName = resDs.ID_NAME; 						// 성명
		var isuDt = resDs.ISU_DT;							// 발급일자
		var licenseNo = resDs.LICENSE_NO;					// 운전면허번호
		var licenseCd = resDs.LICENSE_CD;					// 운전면허일련코드
		var licenseAreaDstcd = resDs.LICENSE_AREA_DSTCD;	// 운전면허지역코드
		var reqId = resDs.REQ_ID;							// 진위확인요청ID
		
		if (maskedImg != "") {
			let dataStr = "data:image/jpeg;base64," + maskedImg;
			$("#resultImg").attr("src", dataStr);
			
			$("#ocrREQ_ID").val(reqId)
			
			$("#ocrMASKED_SSN").val(idbirth);
			$("#ocrCUST_NM").val(ocrName);
			$("#ocrID_TYCD").val(idTycd);
			
			if (idTycd == "ic") {
				$("#ocrID_TYCD_ic").show();
				$("#ocrID_TYCD_dl").hide();
				$("#ocrISU_DT").val(isuDt);
			} else {
				$("#ocrID_TYCD_dl").show();
				$("#ocrID_TYCD_ic").hide();
				$("#ocrLICENSE_NO").val(licenseNo);
				$("#ocrLICENSE_CD").val(licenseCd);
			}
				
			fnShowArea("result");
			
			var ocrResultMessage = "";
			if ("00" == respCd) {
				ocrResultMessage = "<b>신분증 본인확인</b>이<br/>완료되었습니다";
				//ocrResultMessage = "<b>신분증 본인확인</b>";
				$("#ocrRESP_CD_err").hide();
				$("#ocrCUST_NM").attr('readonly', true);
				$("#ocrISU_DT").attr('readonly', true);
				$("#ocrLICENSE_NO").attr('readonly', true);
				$("#ocrLICENSE_CD").attr('readonly', true);
				$("#editBtn").hide();
				$("#retryCameraBtn").hide();
				$("#resultBtn").show();
			} else {
				ocrResultMessage = "<b>인식된 신분증 정보를</b><br/> <b>확인</b>해주세요";
				$("#ocrRESP_CD_err").show();
				$("#ocrCUST_NM").attr('readonly', false);
				$("#ocrISU_DT").attr('readonly', false);
				$("#ocrLICENSE_NO").attr('readonly', false);
				$("#ocrLICENSE_CD").attr('readonly', false);
				$("#resultBtn").hide();
				$("#editBtn").show();
				$("#retryCameraBtn").show();
			}
			$("#ocrResultMessage").html(ocrResultMessage);
			
		} else {
			biz.alert("신분증 인식에 실패하였습니다. 재 촬영을 진행해주세요.","재촬영", function(){
				takePhoto();
			});
		}
	}
}
// 사진촬영
function takePhoto() {
	
	try {
		cameraApp.initRTC(cameraInitParam);
		cameraApp.startRTC(function() {
			setTimeout(function() {
				lastCamera = cameraApp.current_device_id;
			}, 500);
		});
		fnShowArea("camera");
		
	} catch (e) {
		biz.alert("신분증 촬영 중 오류가 발생하였습니다.["+e+"]", function(){
			failedCallback(e);
		});
	}
}

$(document).ready(function(){

	cameraApp = mobWebCamera;
	
	// 신분증촬영 버튼
	$("#initBtn").click(function(){
		takePhoto();
	});
	// 완료 버튼
	$("#resultBtn").click(function(){
		${reqDs.id }_Func.confirm("Y");
	});
	// 재촬영 버튼
	$("#retryCameraBtn > a").click(function(){
		$("#editBtn").hide();
		takePhoto();
	});
	// 수정제출 버튼
	$("#editBtn").click(function(){
		
		var ocrEditForm = makeForm("ocrEditForm");
		addFormData(ocrEditForm, "txGbnCd", "U");
		addFormData(ocrEditForm, "REQ_ID", $("#ocrREQ_ID").val());
		addFormData(ocrEditForm, "CUST_NM", $("#ocrCUST_NM").val());
		addFormData(ocrEditForm, "ISU_DT", $("#ocrISU_DT").val());
		addFormData(ocrEditForm, "LICENSE_CD", $("#ocrLICENSE_CD").val());
		addFormData(ocrEditForm, "LICENSE_NO", $("#ocrLICENSE_NO").val());
		addFormData(ocrEditForm, "ID_TYCD", $("#ocrID_TYCD").val());
		
		doAction("OCR_AUTH", ocrEditForm, function(resJson){
			if ("00" == resJson.RESP_CD) {
				biz.alert("완료 되었습니다.","확인", function(){
					${reqDs.id }_Func.confirm("Y");							
				});	
			} else if("01" == resJson.RESP_CD){
				biz.alert("신분증 정보를 확인해주세요. " + resJson.RESP_MSG);		
				
			} else {
				biz.alert("처리 중 오류가 발생했습니다.");	
			}
		});
	});
	fnShowArea("init");
});

</script>
<style>
/* OCR촬영 */
.idcard-div {position:relative; min-height:100%; color:#fff; font-family:'Spoqa Han Sans'; font-weight:400; line-height:1.5; 
box-sizing:border-box;
/*background-color:rgba(0,0,0,0.7);*/
}
.idcard-cam-cont {}
.idcard-cam-cont .img-line-wrap {border-radius:18px; background-color:rgba(255,255,255,0.2);}
.idcard-cam-cont .cam-desc01 {margin-top:20px; color:#fff; font-size:20px; font-weight:700; text-align:center;}

#inpDiv, #camera-area {
	display: none;
	width: 100%;
	height: 100%;
}
.camera-area-body {
	position: relative;
	border-radius: 30px;
}
#capture-guide {
	position: relative;
	z-index: 2;
}
.camera-area-body-canvas, .camera-area-body-video {
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	border-radius: 30px;
}
.license-cont, .idcard-input-cont {
	display: none;
}
#resultDiv {
	display: none;
}
.extract-image { display:none; }
</style>
<!-- <div class="content-wrap"> -->
	<!-- 상단타이틀 -->    
    <div class="pop-header">
        <h2 class="pop-title">${reqDs.title }</h2>
        <button type="button" name="button" class="btn-layer-close" data-focus="btn-layer-close" onclick="javascript:${reqDs.id}_Func.close();">닫기</button>
    </div>
    
    <div class="pop-con-wrap">
		<!-- OCR 촬영안내 -->
        <div class="default-wrap" id="initDiv" style="display: none"><!-- [퍼블] 클래스 변경 -->
           <div class="tit-wrap">
				<p class="txt"><b>주민등록증</b> 또는 <b>운전면허증</b>을<br/>준비해 주세요</p>
			</div>
			<div class="imgbox-wrap mb40">
				<img src="/resources/images/common/img_registrationcard.png" alt="주민등록증 예시이미지">
			</div>
			<dl class="list-bull ico"><!-- [퍼블] 클래스 변경 -->
				<dt><b>촬영 전 확인해 주세요</b></dt>
				<!-- [퍼블] 텍스트 변경 -->
				<dd>타인의 신분증으로 촬영하시면 관계 법령에 따라 처벌될 수 있어요</dd>
				<dd>흔들림 없고,  빛 반사가 없도록 촬영해 주세요</dd>
				<dd>신분증 정보가 식별이 어려울 경우, 진위확인이 불가능하여 비대면계좌개설 이용이 제한될 수 있어요</dd>
				<!-- // [퍼블] 텍스트 변경 -->
			</dl>
        </div>
    
    	<!-- OCR 촬영 -->
		<div class="default-wrap" id="cameraDiv" style="display:none;"><!-- [퍼블] 클래스 변경 -->
			<div class="tit-wrap">
				<p class="txt"><b>신분증</b>을<br><b>기준선</b> 안에 맞춰주세요</p><!-- [퍼블] 텍스트 변경 -->
			</div>
			<div class="imgbox-wrap ocr-wrap mb40">
				<div id="camera-area">
					<div class="idcard-div">
						<div class="idcard-cam-cont mt10">
							<div class="img-line-wrap camera-area-body">
								<img src="/resources/images/common/cam_line.png" alt="" id="capture-guide" />
								<canvas class="camera-area-body-canvas"></canvas>
								<video class="camera-area-body-video" playsinline autoplay></video>
							</div>
						</div>
					</div>
					<div>
						<canvas class="extract-image"></canvas>
					</div>
				</div>
			</div>
			<dl class="list-bull"><!-- [퍼블] 클래스 변경 -->
				<dt><b>촬영 TIP</b></dt>
				<!-- [퍼블] 텍스트 변경 -->
				<dd>글자에 초점을 맞추고, 빛 반사에 유의하세요</dd>
				<dd>계속해서 촬영이 안 될 때는 카메라를 닫고 정보를 직접 입력해 주세요</dd>
				<!-- // [퍼블] 텍스트 변경 -->
			</dl>
        </div>
    
   		<!-- OCR 촬영결과 -->
        <div class="default-wrap" id="resultDiv" style="display:none;"><!-- [퍼블] 클래스 변경 -->
	        <!-- <div class="tit-wrap">
				<p class="txt" id="ocrResultMessage"><b>신분증 본인확인</b> 및 제출이<br/>완료되었습니다</p>
			</div> [퍼블] 삭제 -->
			<!-- D: 2023-06-14, 신분증이미지 구조변경 -->
			<div class="ocr-img"><!-- [퍼블] 클래스 변경 -->
				<img id="resultImg" src=""/>
			</div>
			
			<div class="btn-cont-wrap btn-sm" id="retryCameraBtn" style="display: none;">
				<a href="#none" class="btn btn-camera" >다시촬영</a><!-- [퍼블] 클래스 변경 -->
			</div>
			<input type="hidden" id="ocrREQ_ID" />
			<input type="hidden" id="ocrID_TYCD" />
			
			<div class="form-wrap">
				<label for="ocrCUST_NM" class="formlabel">이름</label><!-- [퍼블] 텍스트 변경 -->
				<div class="input">
					<input type="text" title="성명" id="ocrCUST_NM" class="inp" name="" value="" required readonly="readonly"/>
				</div>
			</div>

			<div class="form-wrap w50"><!-- [퍼블] 텍스트 변경 -->
				<label for="ocrMASKED_SSN" class="formlabel">주민등록번호</label>
				<div class="input">
					<span>
						<input type="tel" title="주민등록번호" id="ocrMASKED_SSN" class="inp" name="" value="" maxlength="14" required readonly="readonly"/>
					</span>
					<span class="inputTextHyphen">-</span>
					<span>
						<input type="password" title="주민등록번호 뒷자리" id="jumin2" class="inp" name="jumin2"  value="1111111" placeholder="" maxlength="7" required disabled>
						<!-- <span class="jumintext">●●●●●●●</span> -->
					</span>
				</div>
			</div>

			<div class="form-wrap" style="display:none;" id="ocrID_TYCD_ic"><!-- [퍼블] 클래스 변경 -->
				<label for="ocrISU_DT" class="formlabel">발급일자</label>
				<div class="input">
					<input type="date" title="발급일자" id="ocrISU_DT" class="inp" name="" value="" placeholder="발급일자를 입력해주세요." required readonly="readonly"/>
				</div>
				<p class="error-txt">발급일자를 입력해주세요</p>
			</div>
			<div class="form-wrap" style="display:none;" id="ocrID_TYCD_dl"><!-- [퍼블] 클래스 변경 -->
				<label for="ocrLICENSE_NO" class="formlabel">면허번호</label>
				<div class="input">
					<input type="text" title="면허번호" id="ocrLICENSE_NO" class="inp" name="" value="" placeholder="면허번호를 입력해주세요." required readonly="readonly"/>
				</div>
				<label for="ocrLICENSE_CD" class="formlabel">식별번호</label>
				<div class="input">
					<input type="text" title="식별번호" id="ocrLICENSE_CD" class="inp" name="" value="" placeholder="면허번호를 입력해주세요." required readonly="readonly"/>
				</div>
			</div>

			<ul class="info-txt-list"  style="display: none;" id="ocrRESP_CD_err"><!-- [퍼블] 클래스 변경 -->
				<li>인식된 신분증 정보를 확인해 주세요</li>
				<li>신분증정보가 실제와 다른 경우 이용이 제한될 수 있어요</li>
			</ul>

        </div>
                                            
        <!-- 수정구역 -->
 	</div>
 	
    <!-- 하단버튼 -->
    <div class="fixed-btn-wrap">
		<div class="btn-wrap">
			<a href="#none" class="btn btn-camera" id="initBtn">신분증 촬영</a><!-- [퍼블] 클래스 변경 -->
			<a href="#none" class="btn camera-area-footer-capture-button" id="cameraBtn" style="display:none;">촬영하기</a><!-- [퍼블] 텍스트 변경 -->
			<a href="#none" class="btn" id="resultBtn" style="display:none;">완료</a>
			<a href="#none" class="btn" id="editBtn" style="display:none;">수정 제출</a>
		</div>
		<a href="#none" class="btn-txt camera-area-footer-close-button" style="display:none;">그만하기</a><!-- [퍼블] 텍스트 변경 -->
	</div>
	<!-- D: 2023-06-14, 버튼구조 변경 //-->
<!-- </div> -->


