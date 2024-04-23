<%@page import="co.gnbsoftec.common.util.StringUtils"%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
var lastCamera;
var cameraApp;
var cameraInitParam = {
   successCallback : fnOcrSuccFunc,
   failedCallback : fnOcrFailFunc
};
var cameraResultImg = "";

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
	confirm : function(){
		${reqDs.id }_Func.callback(cameraResultImg);
	},
	// 호출 화면 콜백 처리	
	callback : function(){}
});

// 이미지 촬영 성공
function fnOcrSuccFunc(image_data) {
	if (image_data != "") {
		
		var img_data = image_data.blob.substring(23); // base64 img
		cameraResultImg = image_data.blob;
		
		let dataStr = "data:image/jpeg;base64," + img_data;
		$("#resultImg").attr("src", dataStr);
		fnShowArea("result");
	}
}
// 이미지 촬영 오류
function fnOcrFailFunc(error) {
	cameraResultImg = "";
	biz.alert("사진 촬영 중 오류가 발생하였습니다. "+error, function(){
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
		biz.alert("사진 촬영 중 오류가 발생하였습니다.["+e+"]", function(){
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
	width: 100%;
	height: 100%;
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
<div class="content-wrap">
	<!-- 상단타이틀 -->    
    <div class="pop-header">
        <h2 class="pop-title">${reqDs.title }</h2>
        <button type="button" name="button" class="btn-layer-close" data-focus="btn-layer-close" onclick="javascript:${reqDs.id}_Func.close();">닫기</button>
    </div>
    
    <!-- OCR 촬영안내 -->
    <div class="pop-con-wrap" id="initDiv" style="display: none">
        <div class="default-wrap"><!-- [퍼블] 클래스 변경 -->
           <div class="tit-wrap">
				<p class="txt"><b>사진으로 제출하실</b> <b>문서</b>를<br/>준비해 주세요</p>
			</div>
			
			<dl class="list-bull ico">
				<dt><b>촬영 전 확인해 주세요</b></dt>
				<dd>타인의 문서 촬영은 법적 처벌을 받을 수 있어요</dd>
			</dl>
        </div>
    </div>
    
    <!-- OCR 촬영 -->
    <div class="pop-con-wrap" id="cameraDiv" style="display:none;">
        <div class="default-wrap mt40">
			<div class="imgbox-wrap ocr-wrap type-high"><!-- 2023-07-19 클래스 type-high 추가시 카메라 영역 길쭉한 case 노출, mb40 삭제 -->
				<div id="camera-area">
					<div class="idcard-div">
						<div class="idcard-cam-cont mt10">
							<div class="img-line-wrap camera-area-body">
								<img src="/resources/images/common/chk_all_off.png" alt="" id="capture-guide" />
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
        </div>
    </div>
    
    <!-- OCR 촬영결과 -->
    <div class="pop-con-wrap" id="resultDiv" style="display:none;">
        <div class="default-wrap mt20">
	        <div class="tit-wrap">
				<p class="txt" id="ocrResultMessage"><b>촬영된 사진을 </b>확인해주세요 </p>
			</div>
			<!-- D: 2023-06-14, 신분증이미지 구조변경 -->
			<div class="imgbox-wrap ocr-wrap type-high">
				<img id="resultImg" src=""/>
			</div>
			
			<div class="btn-cont-wrap btn-add mt20" id="retryCameraBtn" style="display: none;">
				<a href="#none" class="btn" >다시촬영 </a>
			</div>
        </div>
 	</div>
 	
    <!-- 하단버튼 -->
    <div class="fixed-btn-wrap">
		<div class="btn-wrap">
			<a href="#none" class="btn" id="initBtn">사진촬영</a>
			<a href="#none" class="btn camera-area-footer-capture-button" id="cameraBtn" style="display:none;">촬영</a>
			<a href="#none" class="btn" id="resultBtn" style="display:none;">완료</a>
		</div>
		<a href="#none" class="btn-txt camera-area-footer-close-button" style="display:none;">취소</a><!-- [D] 텍스트버튼 추가 시 div.btn-wrap의 형제로 .btn-txt 추가 -->
	</div>
	<!-- D: 2023-06-14, 버튼구조 변경 //-->
</div>
