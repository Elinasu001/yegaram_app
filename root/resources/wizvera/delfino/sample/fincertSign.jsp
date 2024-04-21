<%@page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta http-equiv="Expires" content="-1" />
    <meta http-equiv="Progma" content="no-cache" />
    <meta http-equiv="cache-control" content="no-cache" />
    <title>WizIN-Delfino Sample - fincertSign</title>
    <style type="text/css">
        label { width: 80px; display: inline-block; text-align: right;}
    </style>

    <%@ include file="../svc/delfino.jsp"%>
</head>

<body>
    <h1>Delfino.fincertSign</h1>

    <script type="text/javascript">
    //<![CDATA[

    //전자서명시 호출되는  CallBack 함수
    function TEST_complete2(result) {
    	console.log("call back 호출~~~~~~~~~~~~~~~~~~~~~~~");
    	console.log(JSON.stringify(result));
    	
    	if(result.status==1){
            console.log("전자서명데이터 : " + result.signData);
            console.log("VID : " + result.vidRandom);
            console.log("인증서일련번호 : " + result.certSeqNum);
            console.log("인증서 : " + result.certificate);
            document.resultForm.signData.value = result.signData;
            document.resultForm.vidRandom.value = result.vidRandom;
            document.resultForm.certSeqNum.value = result.certSeqNum;
            document.resultForm.certificate.value = result.certificate;
        }
        else{
            if(result.status==0) return; //사용자취소
            if(result.status==-10301) return; //구동프로그램 설치를 위해 창을 닫을 경우
            //if (Delfino.isPasswordError(result.status)) alert("비밀번호 오류 횟수 초과됨"); //v1.1.6,0 over & DelfinoConfig.passwordError = true
            alert("error:" + result.message + "[" + result.status + "]");
        }
    }
    
    function fincertSign(gubun) {
        if(Delfino.getModule() != "G10") Delfino.setModule("G10");
        
        //PKCS1 서명
        var test = {
            "signFormat":
            {
                "type": "PKCS1",
                   "PKCS1Info":
                   {
                    "includeR": true
                }
            },
            "content":
            {
                "binary":
                {
                    "binaries": ["MTIzNDU2Nzg5MA"]
                }
            },
            "algorithm": "RSASSA-PKCS1-v1_5_SHA256",
            "certSeqNum": true,
            "view":
            {
                "enableTextView": false,
                "enableTextViewAddInfo": {}
            },
            "info":
            {
                "signType": "01"
            }
        };
        
        //PKCS7 서명
        var test1 = {
            "signFormat":
            {
                "type": "CMS",
                "CMSInfo":
                {
                    "ssn": "dummy",
                    "time": "CLIENT",
                    "includeR": true
                }
            },
            "content":
            {
                "plainText":
                {
                    "plainTexts": ["login=certLogin&delfinoNonce=KhyUB%2FsJK8QiqM0SrsSnF3IDD%2Bc%3D&__CERT_STORE_MEDIA_TYPE=FINCERT"],
                    "encoding": "UTF-8"
                }
            },
            "algorithm": "RSASSA-PKCS1-v1_5_SHA256",
            "view":
            {
                "enableTextView": false,
                "enableTextViewAddInfo":
                {}
            },
            "info":
            {
                "signType": "01"
            }
        };
        
        var test3 = [
        	   {
        		      "signFormat":{
        		         "type":"CMS",
        		         "CMSInfo":{
        		            "ssn":"dummy",
        		            "includeR":true
        		         }
        		      },
        		      "content":{
        		         "plainText":{
        		            "plainTexts":[
        		               {
        		                  "키":"값"
        		               }
        		            ]
        		         }
        		      },
        		      "algorithm":"RSASSA-PKCS1-v1_5_SHA256",
        		      "info":{
        		         "signType":"01"
        		      }
        		   },
        		   {
        		      "signFormat":{
        		         "type":"CMS",
        		         "CMSInfo":{
        		            "ssn":"dummy",
        		            "includeR":true
        		         }
        		      },
        		      "content":{
        		         "plainText":{
        		            "plainTexts":[
        		               {
        		                  "키":"값"
        		               }
        		            ]
        		         }
        		      },
        		      "algorithm":"RSASSA-PKCS1-v1_5_SHA256",
        		      "info":{
        		         "signType":"01"
        		      }
        		   }
        		];

        if(gubun == "1") {
            Delfino.fincertSign(test3, {provider:"fincert", finCertMode :"fincert"}, TEST_complete2);
        } else if(gubun == "2") {
            Delfino.fincertSign(test, {provider:"fincert", finCertMode :"fincertcorp"}, TEST_complete2);
        }
    }

    //]]>
    </script>

    <input type="button" value="금융개인" onclick="javascript:fincertSign('1');" /> 
    <input type="button" value="금결원전자서명(법인)" onclick="javascript:fincertSign('2');" />
    <br/>
    <br/>
    
    <h3>서명결과</h3>
    <form id="resultForm" method="post" name="resultForm">
	    result.certSeqNum: <input type="text" name="certSeqNum" /><br/>
	    result.vidRandom:  <input type="text" name="vidRandom" /><br/>
	    result.signData:
	      <br/><textarea style="width: 700px; height: 80px;" name="signData"></textarea><br/>
	    result.certificate:
	      <br/><textarea style="width: 700px; height: 80px;" name="certificate"></textarea><br/>
   </form>

  <hr />

</body>
</html>
