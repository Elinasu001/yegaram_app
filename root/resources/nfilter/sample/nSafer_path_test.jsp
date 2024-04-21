<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<%--
  ~ Copyright NSHC
  ~ All rights reserved.
  ~
  ~ This software is the confidential and proprietary information
  ~ of NSHC ("Confidential Information").
  --%>

<%
// aix
out.println("LIBPATH : " + System.getenv("LIBPATH") + "<br>");

// linux, hp-ux ia64, solaris
out.println("LD_LIBRARY_PATH : " + System.getenv("LD_LIBRARY_PATH") + "<br>");

// hp-ux
out.println("SHLIB_PATH : " + System.getenv("SHLIB_PATH") + "<br>");

// java lib path
out.println("java.library.path: " + System.getProperty("java.library.path"));

%>
