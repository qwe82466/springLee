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
<button onclick="troll()" type="button">난버튼..</button>



<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=6440aa908fe5ec865e69f0edf2486cce"></script>
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng(37.46480350301109, 126.59449343928672 ), // 지도의 중심좌표
        level: 10 // 지도의 확대 레벨
    }; 

var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

// 지도를 클릭한 위치에 표출할 마커입니다
var marker = new kakao.maps.Marker({ 
    // 지도 중심좌표에 마커를 생성합니다 
    position: map.getCenter() 
}); 
// 지도에 마커를 표시합니다
marker.setMap(map);
var lat1 = 0;
var lat2 = 0;
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
   	//여기서부터 새로 이벤트 파야함
       
   	lat1 = latlng.getLat();
   	lat2 = latlng.getLng();
   

    
  
    
});

function troll(){
    console.log("계정킴");
    //링크에 정보담아서 생성
    var link = 'mapfocusPro?latitude='+lat1+'&longitude='+lat2;
    
    //location.replace(link);
    window.location.href=link;
   	}
	



</script>

		
	
	




</body>
</html>