<%@ page language="java" contentType="text/html;charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %> 
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.util.*" %>
<% 
	String uploadPath = "/opt/delfino/upload";
	//int size = 10*1024*1024;
	int size = 2100000000;
	String message = "";
	try{
		MultipartRequest multi = new MultipartRequest(request, uploadPath, size, "UTF-8", new DefaultFileRenamePolicy());
  		Enumeration<String> files = multi.getFileNames();
  		
		while(files.hasMoreElements()){
			String file = (String)files.nextElement();
			String filename = multi.getFilesystemName(file);
	  		if(filename != null){
	  			if(message != ""){
	  				message += "|";
	  			}
		  		message += filename;
	  		} else{
		  		message="fail to upload file1";
	  		}
		}
		System.out.println(message);
 	}catch(Exception e){
		message="fail to upload file2";
		e.printStackTrace();
 	}
%>
<%=message%>