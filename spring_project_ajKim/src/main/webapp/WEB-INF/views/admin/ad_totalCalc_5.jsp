<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="ad_setting.jsp" %>    
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport"
    content="width=device-width,initial-scale=1,shrink-to-fit=no">
<title>관리자 - 결산!!!! </title>
<style>
.menu ul li {
	float:left;
	list-style: none;
	margin-right: 20px;
}

a {text-decoration: none; color: white; font-weight: bold;}
.content table tr td {border: 1px solid black;}
.tabel_th{border: 1px solid black; background-color:lightgrey;}
.product_list tr td img {width:80px; height:80px;}


/* 페이지 넘기기  */
.paging{float:left; margin-top:50px; margin-left: 500px;}
.btn_pageprev {float: left;}
.txt_pagenum {float: left;}
.txt_pagenum a {
    line-height: 35px;
    padding: 0 15px;
    color:black;
}

#totalCalc{border-bottom:2px dotted white;} /* 밑줄 표시하기 header file에 있는 id값 css적용 */

// 결산 그래프 
*{margin:0;padding:0;}
/* div{padding:0px; overflow: hidden; height: auto;} */
.hgroup{padding:20px;background-color:#e9e9e9;}
.hgroup h1{font-family:Tahoma;}
.hgroup p{margin:10px 0;font-size:10px}
h2{margin:0;padding:20px;border:1px solid #000;background-color:#f9f9f9;border-width:1px 0;font-family:Tahoma;}
</style>

<link rel='stylesheet' href='${root2}Nwagon.css' type='text/css'>
<script src='${root2}Nwagon.js'></script>

</head>
<body>

<!-- 관리자 메인 로고  -->
<%@ include file="ad_header.jsp" %>


<section style="width:1200px; height: 1000px; margin:0 auto; margin-bottom:50px;">
	<br>
	<div class="content" style="width:1200px;">
		

	<h2> '주문확정'누적 합계 : <fmt:formatNumber value="${totalSale}" pattern="#,###" />원</h2>
	
	<h2>1907월 카테고리 별 도넛 그래프 ('주문확정' 기준)</h2>
	<div id="chart_d"></div>
	
	<c:forEach var="type" items="${chart2}">
	   Key is ${type["CODE2"]} 
		value is ${type.SUM_P}
	</c:forEach>	
	
<%-- 	<c:set var="cate_D" value="${chart2['D']}"/>
	<c:set var="cate_T" value="${chart2['T']}" />
	<c:set var="cate_M" value="${chart2['M']}" />
	<c:set var="cate_L" value="${chart2['L']}" />
	 --%>
	<script>
		
	var chart2Array = new Array();
	var colorArray = new Array();
	var categoryArray = new Array();
	
	var color = ['#2BC8C9', '#FF8C00', '#DC143C','#2EB400'];
	var i = 0;
	
	<c:forEach var="map" items="${chart2}">
		chart2Array[i] = ${map.SUM_P};
		colorArray[i] = color[i];
		
		var code = '${map.CODE2}';
		
		if(code === 'T') categoryArray[i] = '토이/인형';
		if(code === 'M') categoryArray[i] = '문구';
		if(code === 'L') categoryArray[i] = '리빙/데코';
		if(code === 'D') categoryArray[i] = '디지털/가전';
		
		i++;
	</c:forEach>

	console.log(colorArray);
	console.log(categoryArray);
	console.log(chart2Array);
	console.log("~~~~~~~~~~");
	
		var options = {
			'dataset': { 
				title: '월 카테고리 별 도넛 그래프',
				values: chart2Array,
				colorset: colorArray,
				fields: categoryArray 
			},
			'donut_width' : 40, 
			'core_circle_radius':60,
			'chartDiv': 'chart_d',
			'chartType': 'donut',
			'chartSize': {width:600, height:300}
		};

		Nwagon.chart(options);
	</script>
 
	
	
  <h2> ArtBox 월별 총 판매 그래프 ('주문확정' 기준) </h2>
  <div id="chart8"></div>


	<c:forEach var="type1" items="${chart1}">
		
	</c:forEach>	

	<!-- *****스크립트시작  -->
	<script>
	
	var chart1Array = new Array();
	var monthName =  new Array();
	
	var i = 0;
	
	<c:forEach var="map" items="${chart1}">
		
		chart1Array[i] = ${map.SUM};
		monthName[i]  = ${map.DATE2};
		
		i++;
	</c:forEach>
	
	
		var options = {
			'legend': {
	            names: monthName,
	            hrefs: []
	        },
	        'dataset': {
	            title: 'ArtBox 월별 총 판매 그래프',
	            values: chart1Array,
	            colorset: ['#56b4e9'],
	            fields:['월별 총판매']
	        },
	        'chartDiv': 'chart8',
	        'chartType': 'column',
	        'chartSize': { width: 700, height: 300 },
	        'maxValue': 500000,
	        'increment': 50000
		};

		Nwagon.chart(options);

	</script>
 
	
	
	</div>
	
</section>

 <!-----화면 맨 하단 footer----->
 <%@ include file="ad_footer.jsp" %>
 

</body>
</html>