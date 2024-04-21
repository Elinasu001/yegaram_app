<%@page import="co.gnbsoftec.common.util.StringUtils"%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String stepBarTotal = request.getParameter("total"); 		// 전체단계
	String stepBarCurrent = request.getParameter("current"); 	// 현재단계
	double stepPercent = (Double.parseDouble(stepBarCurrent) / Double.parseDouble(stepBarTotal)) * 100;
	String stepBarWidth = String.valueOf(Math.floor(stepPercent*100)/100);
%>
<!-- s: contents -->
<div class="step-wrap">
	<div class="step-line"
		aria-label="총 <%=stepBarTotal%>단계 중 <%=stepBarCurrent%>단계 진행중">
		<div class="step-bar" style="width:<%=stepBarWidth%>%;"></div>
	</div>
	<div class="num">
		<strong class="current"><%=stepBarTotal%></strong>/<span class="tot"><%=stepBarCurrent%></span>
	</div>
</div>
<!-- //e: contents -->