#UCPID 설치/업데이트

0. deflino.properties 설정

# 개발: KICA(한국정보인증) yessign(금융결제원) SignKorea(코스콤) CrossCert(한국전자인증)
ucpid.responder.host.KICA=121.254.188.161
ucpid.responder.port.KICA=9090
ucpid.responder.host.yessign=203.233.91.231
ucpid.responder.port.yessign=4719
ucpid.responder.host.SignKorea=211.175.81.101
ucpid.responder.port.SignKorea=8098
ucpid.responder.host.CrossCert=203.248.34.63
ucpid.responder.port.CrossCert=17586

# 운영: KICA(한국정보인증) yessign(금융결제원) SignKorea(코스콤) CrossCert(한국전자인증)
#ucpid.responder.host.KICA=211.35.96.16
#ucpid.responder.port.KICA=9190
#ucpid.responder.host.yessign=203.233.91.21
#ucpid.responder.port.yessign=4831
#ucpid.responder.host.SignKorea=210.207.195.13
#ucpid.responder.port.SignKorea=8078
#ucpid.responder.host.CrossCert=211.192.169.191
#ucpid.responder.port.CrossCert=17586

ucpid.isp.cp.code=E001C863083O
ucpid.isp.sign.certificate.path={delfino.home}/ucpid_key/crosscert/signCert.der
ucpid.isp.sign.privatekey.path={delfino.home}/ucpid_key/crosscert/signPri.key
ucpid.isp.sign.privatekey.password=egV3qYHEazJ6EHWWNIQTmA==
ucpid.isp.km.certificate.path={delfino.home}/ucpid_key/crosscert/kmCert.der
ucpid.isp.km.privatekey.path={delfino.home}/ucpid_key/crosscert//kmPri.key
ucpid.isp.km.privatekey.password=egV3qYHEazJ6EHWWNIQTmA==


1. 업데이트
(1) delfino-cli: 20210527 이상
  - delfino_config.js에 DeflinoConfig.policyOidCertFilterForMyData 설정 추가됨
    >> 웹일경우 OID 필터링을 아래와 같이 사용하도록 가이드
        var myDataSignOptions = {};
    	myDataSignOptions.policyOidCertFilter = DelfinoConfig.policyOidCertFilterForMyData; //마이데이타용 OID필터적용
    	Delfino.multiSignForMyData(signData, myDataSignOptions, TEST_complete);
  
  - {delfino_client_home}/sample-mydata/ 샘플 추가
  
(2) delfino-g10_html5: v10.1.33 이상

(3) delfino-v3_full.jar: v3.2.3 이상
  >> jsp를 이용한 ucpid-gateway 지원
  >> 마이데이타 전용 ood-mydata.conf 추가

2. UCPID관련 설정 확인 추가
(1) UCPID용으로 발급받은 서버인증서 {delfino.home}/ucpid_key 에 추가
  >> 정보인증에서 테스트용으로 받은 ucpid용 서버 인증서(파일4개_를 {delfino.home}/ucpid_key/* 에 복사
 
(2) delfino.properties
  >> 마이데이타용으로 신규 추가된 oid-mydata.conf를 oidfile.path에 설정(15라인)
  >> UCPID 설정 확인 및 추가: 148 ~170라인 참고
    ucpid.responder.gateway 설정사용시 별도로 제공되는 ucpid-gateway.jsp파일은 외부접속에 되는 was에 설치
   
3. UCPID 샘플 추가 및 동작 확인
  https://{install_doamin}:{port}/wizvera/delfino/sample-mydata/myDataSign.jsp
