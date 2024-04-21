<%@page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	long time = System.currentTimeMillis() / 1000L;
	session.setAttribute("delfinoServerTime", Long.toString(time));
%>
<%=time%>