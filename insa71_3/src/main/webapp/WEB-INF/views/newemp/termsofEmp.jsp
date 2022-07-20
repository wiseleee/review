<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<head>
	<title>terms_emp</title>
	<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
	<script type="text/javascript" src="http://maps.google.com/maps/api/js?key=AIzaSyC8UHAVjK073bToMSOZg0eTE9HRRB4SuB8" ></script>
	<script>
		let nempBean={};
		let pdf = {};
		$(document).ready(function() {
			Map();
		    $("#condition_form").click(condition_Form);
		});
		
		function Map()
		{
		    var Y_point = 35.159755;        // Y 좌표
		    var X_point = 128.1062387;        // X 좌표
		    var zoomLevel = 18;                // 지도의 확대 레벨 : 숫자가 클수록 확대정도가 큼
		    var markerTitle = "서울IT교육센터";        // 현재 위치 마커에 마우스를 오버을때 나타나는 정보
		    var markerMaxWidth = 300;                // 마커를 클릭했을때 나타나는 말풍선의 최대 크기
		    var contentString    = '<div>' +		// 말풍선 내용
		    '<h2>오시는 길</h2>'+
		    '<p>주소 : 경상남도 진주시 가좌동 가좌길74번길 8 KR 혜람빌딩 5층</p>' +
			'<p>영업 시간 : 평일 오전 9:00 ~ 오후 10:00, 토요일 오전 9:00 ~ 오후 1:00</p>'+
			'<p>보건 및 안전 : 예약 필수 · 마스크 필수 · 체온 확인 필수 · 직원 마스크 착용함 · 직원 체온 확인함 </p>' +
			'<p>연락처 : 055-753-3677</p>'
		    '</div>';
		    var myLatlng = new google.maps.LatLng(Y_point, X_point);
		    var mapOptions =
		    {
				zoom: zoomLevel,
				center: myLatlng,
				mapTypeId: google.maps.MapTypeId.ROADMAP
			}
		    var map = new google.maps.Map(document.getElementById('map_ma'), mapOptions);
		    var marker = new google.maps.Marker
		    ({
				position: myLatlng,
				map: map,
				title: markerTitle
		    });
		    var infowindow = new google.maps.InfoWindow
		    ({
		           content: contentString,
		           maxWizzzdth: markerMaxWidth
		    });
		    google.maps.event.addListener(marker, 'click', function()
		    {
		        infowindow.open(map, marker);
		    });
		}
		function saveInfo()
		{//각 데이터들을 컨트롤러에게 보내기 위해 nempBean에 저장
			console.log(nempBean);
			nempBean.min_age=$("#min_age").val(); 
			nempBean.max_age=$("#max_age").val();
			nempBean.dept=$("#dept").val();
			nempBean.last_school=$("#last_school").val();
			nempBean.career=$("#career").val();
			nempBean.year=$("#year").val();
			nempBean.half=$("#half").val();
		}
		function condition_Form()
		{//JSON형태로 데이터를 전송
			saveInfo();
			const sendData = JSON.stringify(nempBean);
			$.ajax
			({
				type : "POST" ,
				url : "${pageContext.request.contextPath}/documentmgmt/condition",
				data:
				{"sendData" : sendData},
				dataType : "json",
				success : function(data)
				{
					if(data.errorCode<0){
		                 var error=/unique constraint/;
		                 if(error.test(data.errorMsg)){
		                    alert("에러 : "+data.errorMsg);
		                    return false;
		                 }              
		              }
					else
		              alert(nempBean.year + "년도 의 "+nempBean.half + "의 신입사원 채용 정보를 저장하였습니다.");
					location.reload(); 
				}
			});
		}
	</script>
	<style type="text/css">
		.dv{background-color:white;margin-top:10px;}
		#map_ma {width:100%; height:400px; clear:both; border:solid 1px red;}
		.th{background-color : rgba(0, 0, 0, 0.22); color:black; border:solid 1px white; text-align: center}
		#th_top{border-top:solid 1px rgba(0, 0, 0, 0.22);}
 		#th_bottom{border-bottom:solid 1px rgba(0, 0, 0, 0.22);}
		.tb{border: 1px solid rgba(0, 0, 0, 0.22); height:auto; height : 50px;}
		input[type="text"],input[type="number"],select{border:none; border-bottom:solid 1px rgba(0, 0, 0, 0.22);}
		input[type="text"]:focus,input[type="number"]:focus,select:focus{outline:2px solid #d50000;}
	</style>
</head>
<body>
	<div id = "dv_body">
		<div>
			<div id = "map_ma" ></div>
		</div>
		<div class="dv" >
			<h2>기초 조건 양식</h2>
			<table class = "tb">
				<tr>
					<td class ="th" id="th_top">
						최소 나이
					</td>
					<td>
						<input type ="number" placeholder="min_age" name = "min_age" id="min_age" maxlength='3' value=20 />
					</td>
					<td class ="th" id="th_top">
						최대 나이
					</td>
					<td>
						<input type ="number" placeholder="max_age" name = "max_age" id="max_age" maxlength='3' value=30 />
					</td>
				</tr>
				<tr>
					<td class ="th">
						채용 년도
					</td>
					<td>
						<input type ="number" placeholder="year" name = "year" id="year" value=2022 />
					</td>
					<td class ="th">
				 		반기
					</td>
					<td>
						<label for="half" ></label>
						  <select id = "half">
						    <option value="상반기" >상반기(1~6월)</option>
						    <option value="하반기" >하반기(7~12월)</option>
						  </select>
						 
					</td>
				</tr>
				<tr>
					<td class ="th">
						경력
					</td>
					<td>
						<input type ="text" placeholder="career" name = "career" id="career" />
					</td>
					<td class ="th">
						모집 부문
					</td>
					<td>
						<label for='dept' ></label>
						  <select id = "dept">
						    <option value="인사팀" >인사팀</option>
						    <option value="회계팀" >회계팀</option>
						    <option value="전산팀" >전산팀</option>
						    <option value="보안팀" >보안팀</option>
						    <option value="개발팀" >개발팀</option>
						    <option value="무관" selected >무관</option>
						  </select>
					</td>
				</tr>
				<tr>
					<td class ="th" id="th_bottom">
						학력
					</td>
					<td>
						<label for='last_school' ></label>
						  <select id = "last_school">
						    <option value="초졸" >초졸</option>
						    <option value="중졸" >중졸</option>
						    <option value="고졸" selected >고졸</option>
						    <option value="2년제대학" >2년제대학</option>
						    <option value="4년제대학" >4년제대학</option>
						  </select>
					</td>
					<td class ="th" id="th_bottom">
						채용 양식
					</td>
					<td>
						<input type="file" name="pdf_file" accept=".hwp" id="pdf_file" />
					</td>
				</tr>
			</table>
			<input type = "button" value="전송" id = "condition_form" />
			<input type = "reset" value="취소" />
		</div>
	</div>
</body>
</html>