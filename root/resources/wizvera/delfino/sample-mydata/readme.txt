#UCPID ��ġ/������Ʈ

0. deflino.properties ����

# ����: KICA(�ѱ���������) yessign(����������) SignKorea(�ڽ���) CrossCert(�ѱ���������)
ucpid.responder.host.KICA=121.254.188.161
ucpid.responder.port.KICA=9090
ucpid.responder.host.yessign=203.233.91.231
ucpid.responder.port.yessign=4719
ucpid.responder.host.SignKorea=211.175.81.101
ucpid.responder.port.SignKorea=8098
ucpid.responder.host.CrossCert=203.248.34.63
ucpid.responder.port.CrossCert=17586

# �: KICA(�ѱ���������) yessign(����������) SignKorea(�ڽ���) CrossCert(�ѱ���������)
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


1. ������Ʈ
(1) delfino-cli: 20210527 �̻�
  - delfino_config.js�� DeflinoConfig.policyOidCertFilterForMyData ���� �߰���
    >> ���ϰ�� OID ���͸��� �Ʒ��� ���� ����ϵ��� ���̵�
        var myDataSignOptions = {};
    	myDataSignOptions.policyOidCertFilter = DelfinoConfig.policyOidCertFilterForMyData; //���̵���Ÿ�� OID��������
    	Delfino.multiSignForMyData(signData, myDataSignOptions, TEST_complete);
  
  - {delfino_client_home}/sample-mydata/ ���� �߰�
  
(2) delfino-g10_html5: v10.1.33 �̻�

(3) delfino-v3_full.jar: v3.2.3 �̻�
  >> jsp�� �̿��� ucpid-gateway ����
  >> ���̵���Ÿ ���� ood-mydata.conf �߰�

2. UCPID���� ���� Ȯ�� �߰�
(1) UCPID������ �߱޹��� ���������� {delfino.home}/ucpid_key �� �߰�
  >> ������������ �׽�Ʈ������ ���� ucpid�� ���� ������(����4��_�� {delfino.home}/ucpid_key/* �� ����
 
(2) delfino.properties
  >> ���̵���Ÿ������ �ű� �߰��� oid-mydata.conf�� oidfile.path�� ����(15����)
  >> UCPID ���� Ȯ�� �� �߰�: 148 ~170���� ����
    ucpid.responder.gateway �������� ������ �����Ǵ� ucpid-gateway.jsp������ �ܺ����ӿ� �Ǵ� was�� ��ġ
   
3. UCPID ���� �߰� �� ���� Ȯ��
  https://{install_doamin}:{port}/wizvera/delfino/sample-mydata/myDataSign.jsp
