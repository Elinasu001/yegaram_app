<%@ page language="java" pageEncoding="UTF-8"%><%@
page import="java.util.*"%><%@
page import="java.io.BufferedInputStream"%><%@
page import="java.io.BufferedOutputStream"%><%@
page import="java.io.File"%><%@
page import="java.io.FileInputStream"%><%@
page import="java.net.URLEncoder"%><%!
void download(HttpServletResponse response, String pathname, String filename) {
	
}%><%
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
	String filename = request.getParameter("file");
	filename = filename.replaceAll("/", "_");
	filename = filename.replaceAll("\\\\", "_");
	
	System.out.println("file:" + filename);
	try {
		if(!filename.endsWith(".pdf") && !filename.endsWith(".sig")){
			response.setStatus(404);
			out.print("파일이 존재 하지 않습니다.(" + filename + ")");
			return;
		}
		String dir = "/opt/delfino/tbsFile";	
		String filepath = dir + "/" + filename;
		
		File file = new File(filepath);
		if (file.exists()) {
			response.setContentType("application/pdf");
			filename = URLEncoder.encode(filename, "UTF-8");
			response.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\";");
			byte[] buffer = new byte[4096];
			BufferedInputStream in = new BufferedInputStream(new FileInputStream(file));
			BufferedOutputStream bout = new BufferedOutputStream(response.getOutputStream());
			int n = 0;
			while ((n = in.read(buffer)) != -1) {
				bout.write(buffer, 0, n);
				bout.flush();
			}

			bout.close();
			in.close();
			return;
		} else {
			response.setStatus(404);
			out.print("파일이 존재 하지 않습니다.(" + filename + ")");
			return;
		}
	} catch (Exception e) {
		System.out.println(e);
		response.setStatus(500);
		out.print(e);
		return;
	}
%>