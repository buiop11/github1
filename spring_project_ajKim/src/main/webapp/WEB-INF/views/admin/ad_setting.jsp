<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 시큐리티 -->
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>  

<!-- 일자 셋팅  -->    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- project 경로설정 -->
<c:set var="project" value="/myproject/resources/admin/" />

<!-- 결산 그래프파일 -->
<c:set var="root2" value="/myproject/resources/common/" /> 

<!-- 이미지 경로 설정 / 일단 root로 변경 -->
<c:set var="root" value="/myproject/resources/images/" />

<script type="text/javascript" src="${project}ad_script.js"></script>    
<link type="text/css" rel="stylesheet" href="${project}style.css" />
 