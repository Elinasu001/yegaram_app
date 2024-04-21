/* step progress bar */
function getStepProgress() {
  const stepTotalNum = Math.floor($(".step-wrap .tot").text());
  const stepCurrentNum = Math.floor($(".step-wrap .current").text());
  const pregressValue = 100 / stepTotalNum * stepCurrentNum;
  $(".step-bar").css("width", `${pregressValue}%`)
}

/* 레이어 콤보에서 선택된 값 셋팅 소스 - 각 jsp 내부에 있음 확인
// 레이어 콤보에서 선택된값 셋팅하기
function setLayerCdVal(layerId, code, text) {
  closePopup(layerId);
  $("#"+layerId+"_caller > span.placeholder").css("display", "none");
  $("#"+layerId+"_caller > span.label").css("display", "block");
  $("#"+layerId+"_caller > span.label").text(text);
  $("#"+layerId+"_caller > input").val(code);
  //개인거래목적 기타 선택시 기타사유 영역 보이기
  if ("selTrnsPrps" == layerId) {
    if ("3999" == code) {
      $("#div_etcStr1").show();
    } else {
      $("#INDV_TRN_PRPS_ETC_CNTN").val("");
      $("#div_etcStr1").hide();
    }
  }

  //거래자금원전 기타 선택시 기타사유 영역 보이기
  if ("selTrnsCpt" == layerId) {
    if ("7090" == code) {
      $("#div_etcStr2").show();
    } else {
      $("#INDV_TRN_CPT_ETC_CNTN").val("");
      $("#div_etcStr2").hide();
    }
  }

  //직업 기타 선택시 기타사유 영역 보이기
  if ("selJob" == layerId) {
    if ("3770" == code) {
      $("#div_etcStr3").show();
    } else {
      $("#CDD_OCPT_ETC").val("");
      $("#div_etcStr3").hide();
    }
  }
}
*/