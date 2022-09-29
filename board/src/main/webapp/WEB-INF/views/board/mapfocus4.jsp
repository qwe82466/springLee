<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>여러개 마커에 이벤트 등록하기1</title>
    

</head>
<body>
	<h1> 왜 안보이지?</h1>
    <c:forEach var="list" items="${list}" >
                            <tr>          
                                <td>${list.latitude}</td>
                                <td>${list.longitude}</td>
                                <br/>
                            </tr>
     </c:forEach>
    
<div id="map" style="width:100%;height:350px;"></div>




<script>
/*
var data = '${list}';


//브라우저 콘솔창
console.log(data);
console.log(data.latitude);
//html 부분에 띄워줌
for (var value of data) {
    document.write(value);
  }
  
  
  
$.ajax({
	url : "board/mapfocus5",
	type : 'post',
	data : {
    
	},
	success : function(data) { // controllor에서 list를 return 받았음
                $.each(data,function(index, value) { // 값이 여러개 일 때는 반복문 사용
                	alert(index);
                    alert(value.longtiude); 
                	alert(value.latitude); 
                    	
                }
     },
	error : function() {
		alert("error");
	}
});

 */

</script>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=6440aa908fe5ec865e69f0edf2486cce""></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js" integrity="sha512-aVKKRRi/Q/YV+4mjoKBsE4x3H+BkegoM/em46NNlCqNTmUYADjBbeNefNxYV7giUp0VxICtqdrbqU7iVaeZNXA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

<script>

function mapshow(positions) {
	console.log("3333333333333333333");
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
	    mapOption = { 
	        center: new kakao.maps.LatLng(37.039231202424496, 127.99092756358594), // 지도의 중심좌표
	        level: 15 // 지도의 확대 레벨
	    };

	var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
	
	
	for (var i = 0; i < positions.length; i ++) {
	    // 마커를 생성합니다
	    var marker = new kakao.maps.Marker({
	        map: map, // 마커를 표시할 지도
	        position: positions[i].latlng // 마커의 위치
	    });

	    // 마커에 표시할 인포윈도우를 생성합니다 
	    var infowindow = new kakao.maps.InfoWindow({
	        content: positions[i].content // 인포윈도우에 표시할 내용
	    });

	    // 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
	    // 이벤트 리스너로는 클로저를 만들어 등록합니다 
	    // for문에서 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
	    kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
	    kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));
	}

	// 인포윈도우를 표시하는 클로저를 만드는 함수입니다 
	function makeOverListener(map, marker, infowindow) {
	    return function() {
	        infowindow.open(map, marker);
	    };
	}

	// 인포윈도우를 닫는 클로저를 만드는 함수입니다 
	function makeOutListener(infowindow) {
	    return function() {
	        infowindow.close();
	    };
	}
}

// 문서가 준비되면 ajax 요청해서 데이터 가져오기 
$(document).ready(function(){
	console.log("11111111111111111");
	var positions = new Array();
	$.ajax({
		url: "/board/mapfocus5.json",
		type: "get",
		success: function(result){
			// 데이터 요청해서 리턴받은 리스트 result에 담기고 
			console.log("2222222222222");
			console.log(result.length);
			// 카카오 지도에 던져줄 postions 구조 만들기 
			for(let i = 0; i < result.length; i++){
				let pos = {"content":'<div>제주국제공항</div>', latlng: new kakao.maps.LatLng( result[i].latitude, result[i].longitude)};
				positions.push(pos); 
			}
			console.log("******************************");
			console.log(positions);
			
			// 만든 positions 던져주며 지도 띄우는 기능 함수 호출 
			mapshow(positions); 
			
		},
		error: function(e) {
			console.log(e);
		}
	}); 
	
	
});

</script>

<script>
/*
console.log("3333333333333333333");
var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
    mapOption = { 
        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 15 // 지도의 확대 레벨
    };

var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
 
// 마커를 표시할 위치와 내용을 가지고 있는 객체 배열입니다 
 var positions = [
	
	
	
	{
        content: '<div>제주국제공항</div>', 
        latlng: new kakao.maps.LatLng( 33.507853181471695, 126.49204986023099)
    },
    {
        content: '<div>카카오</div>', 
        latlng: new kakao.maps.LatLng(33.450705, 126.570677)
    },
    {
        content: '<div>생태연못</div>', 
        latlng: new kakao.maps.LatLng(33.450936, 126.569477)
    },
    {
        content: '<div>텃밭</div>', 
        latlng: new kakao.maps.LatLng(33.450879, 126.569940)
    },
    {
        content: '<div>근린공원</div>',
        latlng: new kakao.maps.LatLng(33.451393, 126.570738)
    }
];

for (var i = 0; i < positions.length; i ++) {
    // 마커를 생성합니다
    var marker = new kakao.maps.Marker({
        map: map, // 마커를 표시할 지도
        position: positions[i].latlng // 마커의 위치
    });

    // 마커에 표시할 인포윈도우를 생성합니다 
    var infowindow = new kakao.maps.InfoWindow({
        content: positions[i].content // 인포윈도우에 표시할 내용
    });

    // 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
    // 이벤트 리스너로는 클로저를 만들어 등록합니다 
    // for문에서 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
    kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
    kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));
}

// 인포윈도우를 표시하는 클로저를 만드는 함수입니다 
function makeOverListener(map, marker, infowindow) {
    return function() {
        infowindow.open(map, marker);
    };
}

// 인포윈도우를 닫는 클로저를 만드는 함수입니다 
function makeOutListener(infowindow) {
    return function() {
        infowindow.close();
    };
}

*/

/* 아래와 같이도 할 수 있습니다 */
/*
for (var i = 0; i < positions.length; i ++) {
    // 마커를 생성합니다
    var marker = new kakao.maps.Marker({
        map: map, // 마커를 표시할 지도
        position: positions[i].latlng // 마커의 위치
    });

    // 마커에 표시할 인포윈도우를 생성합니다 
    var infowindow = new kakao.maps.InfoWindow({
        content: positions[i].content // 인포윈도우에 표시할 내용
    });

    // 마커에 이벤트를 등록하는 함수 만들고 즉시 호출하여 클로저를 만듭니다
    // 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
    (function(marker, infowindow) {
        // 마커에 mouseover 이벤트를 등록하고 마우스 오버 시 인포윈도우를 표시합니다 
        kakao.maps.event.addListener(marker, 'mouseover', function() {
            infowindow.open(map, marker);
        });

        // 마커에 mouseout 이벤트를 등록하고 마우스 아웃 시 인포윈도우를 닫습니다
        kakao.maps.event.addListener(marker, 'mouseout', function() {
            infowindow.close();
        });
    })(marker, infowindow);
}
*/
</script>
</body>
</html>