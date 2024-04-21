<%-- --------------------------------------------------------------------------
 - File Name   : vpcg-lakaoCallback-sample.jsp
 - Description : 카카오 S6x0의  이용기관 등록시 사용되는 Callback 입니다.
                           수신된 정보(CI)를 이용하고자 할 경우 커스트마이징(DB에 저장)하여 사용해야합니다.
 - Last Update : 2021/01/08
-------------------------------------------------------------------------- --%><%@
page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%><%@
page import="java.util.*"%><%@
page import="java.io.*"%><%@
page import="org.json.*"%><%
    /*
    //이용기관 연결생성 요청 예
    {
        "service_user_status":"REGISTERED",
        "service_user_id":577,
        "ci":"Jwe+n6n6eBjg1xh/rf59c8lEF4A==",
        "terms":[
            {
            "term_id":35,
            "title":"개인정보수집동의",
            "agree_yn":"Y"
            }
        ]
    }

    //이용기관 연결끊기 요청 예
    {
    "service_user_status":"DEREGISTERED",
    "service_user_id":577
    }
    */
    try{
        StringBuffer jsonBuffer = new StringBuffer();
        BufferedReader reader = request.getReader();
        String line;
        while((line = reader.readLine()) != null) {
            jsonBuffer.append(line);
        }
        String jsonString = jsonBuffer.toString();
        System.out.println("[kakao-callback] json:" + jsonString);
        if ("".equals(jsonString)) {
            responseError(response, out, "E400", String.format("이용기관 연결 처리시 에러가 발생했습니다.(empty data)"));
            return;
        }
        
        JSONObject jsonObject = new JSONObject(jsonString);
        String serviceUserStatus = jsonObject.getString("service_user_status");
        int serviceUserId = jsonObject.getInt("service_user_id");
        if("REGISTERED".equals(serviceUserStatus)){
            String ci = jsonObject.getString("ci");
            System.out.println(String.format("[kakao-callback] REGISTERED service_user_id:%d, ci:%s", serviceUserId, ci));
            //TODO: 필요시 serviceUserId, ci를 DB에 저장한다.

            //responseError(response, out, "E400", String.format("등록된 사용자가 아닙니다. 회원가입후 이용하시기 바랍니다.")); //TODO: 미등록 회원일경우
            //responseError(response, out, "E401", String.format("이용기관 연결생성 처리시 에러가 발생했습니다")); //TODO: 에러발생시
            
        }
        else if("DEREGISTERED".equals(serviceUserStatus)){
            System.out.println(String.format("[kakao-callback] DEREGISTERED service_user_id:%d", serviceUserId));
            //TODO: 저장된 serviceUserId를 DB에서 삭제한다.

            //responseError(response, out, "E402", String.format("이용기관 연결끊기 처리시 에러가 발생했습니다")); //TODO: 에러발생시
        }
    } catch(Exception e){
        e.printStackTrace();
        responseError(response, out, "E400", String.format("이용기관 연결 처리시 에러가 발생했습니다.(%s)", e.getClass().getSimpleName()));
    }

%><%!
    private void responseError(HttpServletResponse response, JspWriter out, String errcode, String errmsg) {
        System.out.println(String.format("[kakao-callback] ERROR: errcode:%s, errmsg:%s", errcode, errmsg));
        try{
            response.setStatus(400);
            response.setCharacterEncoding("UTF-8");
            response.setContentType("application/json;charset=UTF-8");
            JSONObject error = new JSONObject();
            error.put("errcode", errcode);
            error.put("errmsg", errmsg);
            out.print(error.toString());
        } catch(Exception e){
            e.printStackTrace();
        }
    }
%>