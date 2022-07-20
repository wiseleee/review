<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<title>success_applicant</title>
<script type="text/javascript">
let bean = {};
$(document).ready(function(){
		asd();
});
function asd(){
	$.ajax({
		type : "GET" ,
		url:'${pageContext.request.contextPath}/newempinfomgmt/sucappli',
		dataType:"json",
		success : function(data){
			if(data.errorCode < 0){
				let str = "내부 서버 오류가 발생했습니다\n";
				str += "관리자에게 문의하세요\n";
				str += "에러 위치 : " + $(this).attr("id");
				str += "에러 메시지 : " + data.errorMsg;
				alert(str);
				return;
			}
		}
	});
}
</script>
</head>
<body>
	<h1>합격자 조회</h1>
	<div id="empSelect_grid" class="ag-theme-balham" style="width:100%; height:500px;"></div>
</body>
</html>