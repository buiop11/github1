<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- 시큐리티 -->
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>   

<!-- 일자 셋팅  -->    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- project 경로설정 -->
<c:set var="project" value="/myproject/resources/common/" />

<!-- 이미지 경로 설정  -->
<c:set var="root" value="/myproject/resources/images/" />

<script type="text/javascript" src="${project}script.js"></script>
<link type="text/css" rel="stylesheet" href="${project}main.css" />
 