<%@page import="co.gnbsoftec.common.util.StringUtils"%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String headerTitle = request.getParameter("title");
	String headerType = request.getParameter("type");
	String backBtn = (null != request.getParameter("backBtn")) ? request.getParameter("backBtn") : "true";
	headerTitle = StringUtils.isEmpty(headerTitle) ? "예가람저축은행" : headerTitle;
%>
<header class="headerWrap">
	<div class="header">
		<%if ("true".equals(backBtn)) {%>
	    <a class="btn-back" onclick="PageFunc.back();"><span class="blind">이전페이지 이동하기</span></a>
	    <%} %>
	    <h2><span><%=headerTitle %></span></h2>
	</div>
	<div class="menu-wrap">
		<%if (!"none".equals(headerType)) {%>
	    	<a class="btn-menu">메뉴</a>
	    <%} %>
	</div>
</header>