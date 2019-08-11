<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport"
    content="width=device-width,initial-scale=1,shrink-to-fit=no">
<title>회사 위치보기 </title>
</head>

<style>
	#map{
		height: 500px;
		width: 500px;
	}
</style>

<body>

<!-------목록보여주기 header------->
<%@ include file="header.jsp" %>



<!-- 위치 안내 시작  -->
<div style="margin: 0 auto; width: 1200px;">

<div align="center" style="margin-top:50px; margin-bottom:30px;">
<h3>아트박스 위치 안내 </h3>
서울특별시 금천구 가산디지털2로 123 월드메르디앙2차 4층</div>

<div id="map" style="margin: 0 auto; margin-bottom: 100px;"></div>
<script>
	function initMap(){
		var uluru = {lat: 37.478792, lng: 126.878710};
		var map = new google.maps.Map(document.getElementById('map'),{
			zoom: 14,
			center: uluru
		});
		
		var marker = new google.maps.Marker({
			position: uluru,
			map: map
		});
	}

</script>
<script async defer
	src="http://maps.googleapis.com/maps/api/js?key=AIzaSyBAbKkp6N_ZSCat8-P4UnXfobNqkk_--c0&callback=initMap">
	</script>

</div>

<!------화면 맨 하단 footer------>
<%@ include file="footer.jsp" %>

</body>
</html>