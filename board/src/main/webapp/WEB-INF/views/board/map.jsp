<<<<<<< HEAD
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
	#map {width:500px; height:400px; }

</style>
<body>


		<div id="map"></div>

		
		<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=	6440aa908fe5ec865e69f0edf2486cce"></script>
		<script>
				var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
				var options = { //지도를 생성할 때 필요한 기본 옵션
					center: new kakao.maps.LatLng(33.450701, 126.570667), //지도의 중심좌표.
					level: 3 //지도의 레벨(확대, 축소 정도)
				};
				var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
		</script>
</body>
=======
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>클릭한 위치에 마커 표시하기</title>
    
</head>
<body>
<div id="map" style="width:100%;height:350px;"></div>
<p><em>지도를 클릭해주세요!</em></p> 
<div id="clickLatlng"></div>


<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=	6440aa908fe5ec865e69f0edf2486cce"></script>
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };

var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

// 지도를 클릭한 위치에 표출할 마커입니다
var marker = new kakao.maps.Marker({ 
    // 지도 중심좌표에 마커를 생성합니다 
    position: map.getCenter() 
}); 
// 지도에 마커를 표시합니다
marker.setMap(map);

// 지도에 클릭 이벤트를 등록합니다
// 지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
kakao.maps.event.addListener(map, 'click', function(mouseEvent) {        
    
    // 클릭한 위도, 경도 정보를 가져옵니다 
    var latlng = mouseEvent.latLng; 
    
    // 마커 위치를 클릭한 위치로 옮깁니다
    marker.setPosition(latlng);
    
    var message = '클릭한 위치의 위도는 ' + latlng.getLat() + ' 이고, ';
    message += '경도는 ' + latlng.getLng() + ' 입니다';
    
    var resultDiv = document.getElementById('clickLatlng'); 
    resultDiv.innerHTML = message;
    
});
$.ajax({
	url : "test.action",
	type : 'post',
	data : {
		name : "이름",
		age : "20",
		gender : "man"
	},
	success : function(data) {
				
     },
	error : function() {
		alert("error");
	}
});


</script>


</body>
>>>>>>> branch 'master' of https://github.com/qwe82466/springLee.git
</html>