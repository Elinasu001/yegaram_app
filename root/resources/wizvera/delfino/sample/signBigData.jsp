<%@page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%

    // 서명 데이타 포맷 검증하기

    HashMap<String, String> format = new HashMap<String, String>();
    format.put("account", "계좌번호");
    format.put("recvUser", "받는사람;bold");
    format.put("amount", "금액;currency");
    format.put("비고", "비고");

    request.setAttribute("format", format);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width" />
    <title>전자서명</title>
    <%@ include file="../svc/delfino.jsp" %>
</head>
<body>
<h2>전자서명</h2>
<form method="post" name="sign" action="signAction.jsp" onsubmit="Delfino.signForm(this);return false;">
    계좌번호 : <input id="account" type="text" name="account" format="${format['account']}" value="123-123-123"><br/>
    받는사람 : <input type="text" name="recvUser" format="${format['recvUser']}" value="아무개"><br/>
    금액 : <input type="text" name="amount" format="${format['amount']}" value="100000"><br/>
    비고 : <input type="text" name="비고" format="${format['비고']}" value=""><br/>
    <input type="hidden" name="포맷비어있음" format="${format['포맷비어있음']}" value="포맷비어있음value"><br/>
    <input type="hidden" name="포맷없음" value="포맷없음 value"><br/>
    <label>많은 데이터 </label>
    <br/>
    <textarea id="bigData" rows="5" cols="80"  name="etc" ></textarea>
    <br/>
    <input type="submit">
</form>
<p>
    임의의 데이터 추가.
</p>
<ul>
    <li><input type="text" id="bigDataSize" value="1000">Byte <button onclick="setBigDataInput();">임의의 데이터 양 설정</button></li>
    <li><button onclick="setBigData(1000000);">1M데이터 설정</button></li>
    <li><button onclick="setBigData(2000000);">2M데이터 설정</button></li>
    <li><button onclick="setBigData(3000000);">3M데이터 설정</button></li>
</ul>
<br/>
</p>
<script type="text/javascript">
    function setBigDataInput() {
        var dataSize = Number($("#bigDataSize").val());
        setBigData(dataSize);
    }
    function setBigData(dataSize) {
        var data = "";
        for(var i=0;i<dataSize/10;i++) {
            data += "0123456789";
        }
        $("#bigData").text(data);

    }
</script>
</body>
</html>