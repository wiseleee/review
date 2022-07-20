<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<title>personality_interview</title>

<script type="text/javascript">
let bean = {};
$(document).ready(function(){
	$("#btn").click(function(){
		findResumeInfo();
	})
});
function saveInfo()
{
	bean.year=$("#year").val();
	bean.half=$("#half").val();
	console.log(bean);
}
function findResumeInfo(){ //실행하자마자 데이터를 가져옴
	$("#empSelect_grid").html("");
	saveInfo();
	const sendData = JSON.stringify(bean);
	let ResumeListGridOptions={};
	$.ajax({
		type : "GET" ,
		url:'${pageContext.request.contextPath}/newempinfomgmt/resumemgmt',
		dataType:"json",
		data:
		{"sendData" : sendData},
		success : function(data){
			if(data.errorCode < 0){
				let str = "내부 서버 오류가 발생했습니다\n";
				str += "관리자에게 문의하세요\n";
				str += "에러 위치 : " + $(this).attr("id");
				str += "에러 메시지 : " + data.errorMsg;
				alert(str);
				return;
			}
			let resumeInfolist = data.list;
			showResumeListGrid(resumeInfolist);
		}
	});
}
function showResumeListGrid(resumeInfolist) {
	const columnDef =
	[
		{ headerName : "임시코드", field : "p_code"},
		{ headerName : "이름", field : "p_name" },
		{ headerName : "나이", field : "p_age" },
		{ headerName : "성별", field : "p_gender" },
		{ headerName : "주소", field : "p_address" },
		{ headerName : "전화번호", field : "p_tel" },
		{ headerName : "이메일", field : "p_email" },
		{ headerName : "부서", field : "p_dept" },
		{ headerName : "학력", field : "p_last_school" },
		{ headerName : "경력", field : "p_career" }
	];
	console.log(resumeInfolist);
	ResumeListGridOptions = {
		columnDefs : columnDef, //  정의된 칼럼 정보를 넣어준다. 
		rowData : resumeInfolist, // 그리드 데이터, json data를 넣어준다. 
		enableColResize : true, // 칼럼 리사이즈 허용 여부
		enableSorting : true, // 정렬 옵션 허용 여부
		enableFilter : true, // 필터 옵션 허용 여부
		enableRangeSelection : true, // 정렬 기능 강제여부, true인 경우 정렬이 고정이 된다.  
		localeText : { noRowsToShow : '조회 결과가 없습니다.' }, // 데이터가 없는 경우 보여 주는 사용자 메시지
		
		getRowStyle : function(param) { // row 스타일 지정 e.g. {"textAlign":"center", "backgroundColor":"#f4f4f4"}
			if (param.node.rowPinned) {
				return {
					'font-weight' : 'bold',
					background : '#dddddd'
				};
			}
			return {
				'text-align' : 'center'
			};
		},
		getRowHeight : function(param) { // // 높이 지정
			if (param.node.rowPinned) {
				return 30;
			}
			return 24;
		},
		onGridReady : function(event) { // GRID READY 이벤트, 사이즈 자동조정 
			event.api.sizeColumnsToFit();
		},
		
		onGridSizeChanged : function(event) { // 창 크기 변경 되었을 때 이벤트 
			event.api.sizeColumnsToFit();
		}
		
	};
	let eGridDiv = document.querySelector('#empSelect_grid');
	console.log(columnDef);
	console.log(resumeInfolist);
	new agGrid.Grid(eGridDiv, ResumeListGridOptions); // 그리드 생성, 가져온 자료 그리드에 뿌리기
}
</script>
</head>
<body>
	<h1>채용 이력서</h1>
	<div>
	<form action="${pageContext.request.contextPath}/newempinfomgmt/resumeResult.do" method="get" >
		<input type="number" value=2022 id="year" size=4 />년도
		<label for="half" ></label>
		  <select id = "half">
		    <option value="상반기" >상반기(1~6월)</option>
		    <option value="하반기" >하반기(7~12월)</option>
		  </select>
		  <input type = "button" id = "btn" value="전송" />
	</form>
	</div>
	<div id="empSelect_grid" class="ag-theme-balham" style="width:100%; height:500px;"></div>
</body>
</html>