<%@ page language="java" pageEncoding="UTF-8"%><%@
page import="java.util.*"%><%@
page import="java.io.BufferedInputStream"%><%@
page import="java.io.BufferedOutputStream"%><%@
page import="java.io.File"%><%@
page import="java.io.FileInputStream"%><%@
page import="org.apache.commons.lang.StringUtils"%><%!
  public class Download{      
    public void set(HttpServletResponse response,  String pathname, String filename){
    	String fname = pathname + filename;
//      try{
//        fname = java.net.URLEncoder.encode(fname, "UTF-8");
//        fname = fname.replace('+', ' '); // for space
//      }catch(Exception e){
//        System.out.println(e);
//      }
//      response.reset();
//      response.setContentType("application/unknown;charset=utf-8"); 
//      response.setHeader("Accept-Ranges", "bytes");
//      response.setHeader("Content-Disposition", "attachment; filename="+fname); 
//      response.setHeader("Content-Description", "JSP Generated Data");  
      try{
        File fileEx = new File(fname);
        if(fileEx.exists()) {
          
          //response.setContentType("application/force-download;charset=utf-8"); 
          //response.setContentType("application/pdf;charset=utf-8"); 
          //response.setContentType("application/unknown;charset=utf-8"); 
          //response.setContentType("imgage/jpeg"); 
          response.setContentType("application/vnd.ms-excel"); 
          response.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\";");  

          byte[] buffer = new byte[4096];
          BufferedInputStream in    = new BufferedInputStream(new FileInputStream(fname));
          BufferedOutputStream bout = new BufferedOutputStream(response.getOutputStream());
          int n = 0;
          while((n=in.read(buffer, 0, 4096)) != -1) {
            bout.write(buffer, 0, n);
            bout.flush();
          }

          bout.close();
          in.close();
          
        }else{
          throw new Exception("파일이 존재 하지 않습니다.(" + fname + ")");
        }
        System.out.println("#####################################################################");
        System.out.println("#####################################################################");
        System.out.println("#####################################################################");
        System.out.println("#####################################################################");
        System.out.println("#####################################################################");
        System.out.println("#####################################################################");
        System.out.println("#####################################################################");
        System.out.println("#####################################################################");
        System.out.println("#####################################################################");
        System.out.println("#####################################################################");
      }catch(Exception e){
        System.out.println(e);
      }
    }
  }
%><%
  request.setCharacterEncoding("UTF-8");
  try{
    Download ExcelDown = new Download();
    //String dnFile = "D://wizvera/acsServer/webapps";
    //String dnFile = "/home/wizvera/apache-tomcat-6.0.32/webapps";
    //dnFile += "/ROOT/tomcat.gif";
//    String dnFile += "/tmp/dn.xls";
    ExcelDown.set(response, "/tmp/", "dn.xls");
  }catch(Exception e){
    System.out.println("Grid JSON Error: " + e);
  }
%>