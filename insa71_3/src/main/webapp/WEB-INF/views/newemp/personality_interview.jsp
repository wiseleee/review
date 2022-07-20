<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>personality_interview</title>
	<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>
<style>
	.dv-body{background-color:white;border:1px solid red;}
	.chart{display:flex;}
	.chart-child{display:inline-block;}
	table{text-align: center;}
	th:first-child, td:nth-child(2){border-right:1px solid black;}
	th{border-bottom:1px solid black;}
</style>
<script>
//personality :	p_challenger, p_creativity, p_passion, p_cooperation, p_globalmind; 
//interview :	i_attitude, i_scrupulosity, i_reliability, i_creativity, i_positiveness
let bean = {};
$(document).ready(function(){
	$("#showcodebtn").click(function(){
		findNew_emp();
	})
});
function findNew_emp(){ //실행하자마자 데이터를 가져옴
	$("canvas").val("");
	saveInfo();
	const sendData = JSON.stringify(bean);
	let ResumeListGridOptions={};
	$.ajax({
		type : "GET" ,
		url:'${pageContext.request.contextPath}/newempinfomgmt/piresultnewemp',
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
			let Infolist = data.list;
			console.log(Infolist);
			showListGrid(Infolist);
		}
	});
}
function showListGrid(Infolist) {
	document.querySelector('#empSelect_grid').innerHTML="";
	const columnDef =
	[
		{ headerName : "임시코드", field : "p_code"},
		{ headerName : "이름", field : "p_name" },
		{ headerName : "나이", field : "p_age" }
	];
	ResumeListGridOptions = {
		columnDefs : columnDef, //  정의된 칼럼 정보를 넣어준다. 
		rowData : Infolist, // 그리드 데이터, json data를 넣어준다. 
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
		},
		onCellClicked : function(node)
		{
			document.querySelector(".chart").innerHTML="<canvas id='radar-chart' width='500' height = '500' class='chart-child' ></canvas><canvas id='radar-chart2' width='500' height = '500' class='chart-child' ></canvas>";
			console.log(node.data);
			nodeData = node.data;
			new Chart(document.getElementById("radar-chart"),
			{
				type: 'radar',
				data:
				{
					labels: ["도전", "창의", "열정", "협력", "글로벌마인드"],
					datasets:
					[{
						label: "인성",
						fill: true,
						backgroundColor: "rgba(255,99,132,0.2)",
						borderColor: "rgba(255,99,132,1)",
						pointBorderColor: "#fff",
						pointBackgroundColor: "rgba(255,99,132,1)",
						pointBorderColor: "#fff",
						data: [nodeData.p_challenge, nodeData.p_creativity, nodeData.p_passion, nodeData.p_cooperation, nodeData.p_globalmind]
					}]
				},
				options:
				{
					responsive: false,
					title:
					{
						display: true,
						text: 'CODE : '+nodeData.p_code
					},
					scale:
					{
						ticks:
						{
								beginAtZero:true,
								max:5,
								min:0
						}
					} 
				}
			});
			new Chart(document.getElementById("radar-chart2"),
			{
				type: 'radar',
				data:
				{
					labels: ["태도", "주도성", "신뢰성", "창의성", "적극성"],
					datasets:
					[{
						label: "면접",
						fill: true,
						backgroundColor: "rgba(179,181,198,0.2)",
						borderColor: "rgba(179,181,198,1)",
						pointBorderColor: "#fff",
						pointBackgroundColor: "rgba(179,181,198,1)",
						data: [nodeData.i_attitude, nodeData.i_scrupulosity, nodeData.i_reliability, nodeData.i_creativity, nodeData.i_positiveness]
					}]
				},
				options:
				{
					responsive: false,
					title:
					{
						display: true
					},
					scale:
					{
						ticks:
						{
							beginAtZero:true,
							max:5,
							min:0
						}
					}
				}
			});
			table_Data(nodeData);
		}
	};
	let eGridDiv = document.querySelector('#empSelect_grid');
	console.log(columnDef);
	console.log(Infolist);
	const agger = new agGrid.Grid(eGridDiv, ResumeListGridOptions); // 그리드 생성, 가져온 자료 그리드에 뿌리기
}

function table_Data(nodeData)
{
	$("#p_challenge").val(nodeData.p_challenge);
	$("#i_attitude").val(nodeData.i_attitude);
	$("#p_globalmind").val(nodeData.p_globalmind);
	$("#i_positiveness").val(nodeData.i_positiveness);
	$("#p_creativity").val(nodeData.p_creativity);
	$("#i_scrupulosity").val(nodeData.i_scrupulosity);
	$("#p_cooperation").val(nodeData.p_cooperation);
	$("#i_creativity").val(nodeData.i_creativity);
	$("#p_passion").val(nodeData.p_passion);
	$("#i_reliability").val(nodeData.i_reliability);
	const p_avg = (nodeData.p_challenge + nodeData.p_globalmind + nodeData.p_creativity + nodeData.p_cooperation + nodeData.p_passion ) / 5;
	const i_avg = (nodeData.i_attitude + nodeData.i_scrupulosity + nodeData.i_reliability + nodeData.i_creativity + nodeData.i_positiveness) / 5;
	$("#p_avg").val(p_avg);
	$("#i_avg").val(i_avg);
}
function saveInfo()
{
	
	bean.year = $("#year").val();
	bean.half = $("#half").val();
}
</script>
</head>
<body>
	<h1>인성/면접 결과표</h1>
	<input type ="number" id="year" value=2022 />년도
	<label for="half" ></label>
	  <select id = "half">
	    <option value="상반기" >상반기(1~6월)</option>
	    <option value="하반기" >하반기(7~12월)</option>
	  </select>
	  <input type="button" id = "showcodebtn" value="전송" /><br/><br/>
	<div id="empSelect_grid" class="ag-theme-balham" style="width:40%; height:200px;">년도와 반기 입력해주세요...</div>
	<hr>
	<div class="dv-body">
		<div class="chart" ></div>
	</div>
	<hr>
	<div class="dv-body">
		<table>
			<tr>
				<th colspan=2>인성</th><th colspan=2>면접</th>
			</tr>
			<tr>
				<td>도전 :</td><td><input type="text" id="p_challenge" readonly /></td>
				<td>태도 :</td><td><input type="text" id="i_attitude" readonly /></td>
			</tr>
			<tr>
				<td>창의 :</td><td><input type="text" id="p_creativity" readonly /></td>
				<td>주도성 :</td><td><input type="text" id="i_scrupulosity" readonly /></td>
			</tr>
			<tr>
				<td>열정 :</td><td><input type="text" id="p_passion" readonly /></td>
				<td>신뢰성 :</td><td><input type="text" id="i_reliability" readonly /></td>
			</tr>
			<tr>
				<td>협력 :</td><td><input type="text" id="p_cooperation" readonly /></td>
				<td>창의성 :</td><td><input type="text" id="i_creativity"  readonly /></td>
			</tr>
			<tr>
				<td>글로벌마인드 :</td><td><input type="text" id="p_globalmind"  readonly /></td>
				<td>적극성 :</td><td><input type="text" id="i_positiveness"  readonly /></td>
			</tr>
			<tr>
				<td>인성 평균 :</td><td><input type="text" id="p_avg" readonly /></td>
				<td>면접 평균 :</td><td><input type="text" id="i_avg"  readonly /></td>
			</tr>
		</table>
	</div>
</body>
</html>