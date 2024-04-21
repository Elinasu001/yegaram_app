/**
 * ocr_camera.js
 */
var lastCamera;
var cameraApp;
var cameraInitParam = {
   successCallback : fnOcrSuccFunc,
   failedCallback : fnOcrFailFunc
};

// 결과 셋팅
function fnSettingResult(resDs) {
	
	var respCd = resDs.RESP_CD; 						// 00:정상, 01:진위확인실패(수정 또는 재촬영), 09: 이미지 인식실패(재촬영)
	var respMsg = resDs.RESP_MSG;						// 응답메시지
	var maskedImg = resDs.MASKED_IDCD_IMG; 				// 마스킹이미지
	var idTycd = resDs.ID_TYCD;							// 신분증종류코드 1.주민등록증 2.운전면허증
	var isuDt = resDs.ISU_DT;							// 발급일자
	var licenseNo = resDs.LICENSE_NO;					// 운전면허번호
	var licenseAreaDstcd = resDs.LICENSE_AREA_DSTCD;	// 운전면허지역코드
	
	$("#ID_TYCD").val(idTycd);		
	$("#P_IDT_CNFR_ISS_DT").val(isuDt);
	$("#disLICENSE_AREA_DSTCD").html(licenseAreaDstcd);
	$("#LICENSE_AREA_DSTCD").val(licenseAreaDstcd);
	$("#LICENSE_NO").val(licenseNo);
	$("#ISU_DT").val(isuDt);
	
	if (maskedImg != "") {
		let dataStr = "data:image/jpeg;base64," + maskedImg;
		$("#resultImg").attr("src", dataStr);
	}
	
	if ("00" == respCd) {
		$(".idcdErr").hide();
		$(".idcdOk").show();
		messageView("신분증 본인인증이 완료되었습니다.", function(){
			
			if ("1" == idTycd) {
				$("#idcdLicenseArea").hide();
				$("#idcdJuminArea").show();
			} else {
				$("#idcdLicenseArea").show();
				$("#idcdJuminArea").hide();
			}
			fnShowArea("result");
		});
		
	} else if ("01" == respCd) {
		$(".idcdErr").show();
		$(".idcdOk").hide();
		messageView("신분증 본인인증 처리 중 오류가 발생하였습니다. 입력정보 수정 또는 재촬영을 진행해주세요.", function(){
			
			if ("1" == idTycd) {
				$("#idcdLicenseArea").hide();
				$("#idcdJuminArea").show();
			} else {
				$("#idcdLicenseArea").show();
				$("#idcdJuminArea").hide();
			}
			fnShowArea("result");
		});
		
	} else {
		messageView("신분증 인식에 실패하였습니다. 재 촬영을 진행해주세요.", function(){
			fnShowArea("init");
		});
	}
}

// 신분증 수정 제출
function fnUpdateIdCard() {
	var ocrUpdateForm = makeForm("ocrUpdateForm");
	addFormData(ocrUpdateForm, "txGbnCd", "U");
	addFormData(ocrUpdateForm, "IDCD_IMG", $("#IDCD_IMG").val());
	addFormData(ocrUpdateForm, "ID_TYCD", $("#ID_TYCD").val());
	addFormData(ocrUpdateForm, "ISU_DT", $("#ISU_DT").val());
	addFormData(ocrUpdateForm, "LICENSE_AREA_DSTCD", $("#LICENSE_AREA_DSTCD").val());
	addFormData(ocrUpdateForm, "LICENSE_NO", $("#LICENSE_NO").val());
	doAction("AUTH01", ocrUpdateForm, fnSettingResult);
}

// 이미지 촬영 성공
function fnOcrSuccFunc(image_data) {
	
	var img_data = image_data.blob.substring(23); // base64 img
	$("#IDCD_IMG").val(img_data);
	
	var ocrReqForm = makeForm("ocrReqForm");
	addFormData(ocrReqForm, "txGbnCd", "I");
	addFormData(ocrReqForm, "IDCD_IMG", img_data);
	doAction("AUTH01", ocrReqForm, fnSettingResult);
}
// 이미지 촬영 오류
function fnOcrFailFunc(error) {
	messageView("신분증 촬영 중 오류가 발생하였습니다. "+error, function(){
		fnShowArea("init");
	});
}

// 촬영 이미지 출력 (정상처리 건)
function setScannedData(maskedImg, idType, issuDate, licenseNo, drvlicsAreaDstcd){
	
	if (maskedImg != "") {
		let dataStr = "data:image/jpeg;base64," + maskedImg;
		$("#resultImg").attr("src", dataStr);
	}
	   
   $(".idcard-input-cont, .license-cont").hide();
   if (idType == '1') { // 주민등록증
      $(".idcard-input-cont").show();
      $("#C_ISU_DT").val(issuDate);
   } else if(idType == '2') { // 운전면허증
      $(".license-cont").show();
      $("#C_DRVLICS_AREA_DSTCD").val(drvlicsAreaDstcd);
      $("#C_DRVLICS_NO").val(licenseNo);
   }
}

// 화면보이기 영역처리
function fnShowArea(divId) {
	fnAreaDisable();
	$("#"+divId+"Div").show();
}

// 전체가리기
function fnAreaDisable() {
	$("#initDiv").hide();
	$("#resultDiv").hide();
}

// 사진촬영
function takePhoto() {
	
	try {
		
		if (isLocalServer()) {
			messageView("로컬기동 카메라SKIP..", function(){
				var localTest = {"blob":LOCAL_IDCD_IMG};
				fnOcrSuccFunc(localTest);	
			});
			
		} else {
			fnAreaDisable();
			cameraApp.initRTC(cameraInitParam);
			cameraApp.startRTC(function() {
				setTimeout(function() {
					lastCamera = cameraApp.current_device_id;
				}, 500);
			});
		}
		
	} catch (e) {
		messageView("신분증 촬영 중 오류가 발생하였습니다.["+e+"]", function(){
			failedCallback(e);
		});
	}
}

$(document).ready(function(){

	cameraApp = mobWebCamera;
	
	// 신분증 촬영
	$("#takePhotoBtn").click(function(){
		takePhoto();
	});
	
	// 신분증 재촬영
	$("#reTakePhotoBtn").click(function(){
		takePhoto();
	});
	
	// 신분증 수정제출
	$("#updateIdcdBtn").click(function(){
		updatePhoto();
	});
	
	// 신분증 제출완료
	$("#confirmIdcdBtn").click(function(){
		fnIdcdAuthConfirm();
	});
	
	fnShowArea("init");
});

// 카메라 닫기
function closeCamera(){
	fnShowArea("init");
}

function validateForm() {
	
	if ($("#ISU_DSTCD").val() == "") {
		if ($.trim($("#ISU_DT").val()) != "") {
			$("#ISU_DSTCD").val("1");
		} else if ($.trim($("#DRVLICS_NO").val()) != "") {
			$("#ISU_DSTCD").val("2");
		}
	}
	
	if ($("#ISU_DSTCD").val() == "1") {
		if ($.trim($("#ISU_DT").val()) == "") {
			alert("주민등록증 발급일자를 입력해 주세요.");
			return false;
		}
	} else if ($("#ISU_DSTCD").val() == "2") {
		if ($.trim($("#DRVLICS_AREA_DSTCD").val()) == "") {
			alert("면허 발급지역을 선택해 주세요.");
			return false;
		}
		if ($.trim($("#DRVLICS_NO").val()) == "") {
			alert("면허번호를 입력해 주세요.");
			return false;
		} else if ($.trim($("#DRVLICS_NO").val()).length != 10) {
			alert("면허번호를 확인해 주세요.");
			return false;
		}
	} else {
		alert("신분증 종류가 지정되지 않았습니다. 재촬영을 진행해주세요.");
		return false;
	}
	return true;
}

// 모바일웹카메라
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