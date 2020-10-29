<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<html>
<head>
<meta charset="UTF-8">
	<title>환율 계산 페이지</title>
	
	<script>
	document.addEventListener("DOMContentLoaded", function(){
		getExchangeData();
	});

	//환율 정보 받아오기
	function getExchangeData() {
		
		const host = "http://www.apilayer.net/api/live?access_key=";
		const api_key = "422b0f6c24a835394dd309224879684c";
		fetch(host+api_key, {
			method:'GET'
		})
		.then(res=>res.json())
		.then(data=>{printTarget(data)});
	}

	//조회한 환율 정보를 바탕으로 화면에 그릴 데이터를 구성 
	function printTarget(val){
		let target = document.getElementById('target').value;
		let targetExc;
		
		if(target==='krw'){
			targetExc = val.quotes.USDKRW;
		} else if(target==='jpy'){
			targetExc = val.quotes.USDJPY;
		} else if(target==='php'){
			targetExc = val.quotes.USDPHP;
		} else {
			alert("환율 정보를 조회할 수 없습니다.");
			return;
		}

		document.getElementById('excNum').value = targetExc; 
		document.getElementById('exchangeRate').innerText = printFix(targetExc)+' '+target.toUpperCase()+'/USD';
	}

	// 주어진 숫자를 아래 조건에 맞게 변경한다.
	// 1.소수점 아래 2자리
	// 2.숫자 3자리 이상일 경우 콤마 
	function printFix(val){
		val = val.toFixed(2);
		val = val.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		return val;
	}

	//환율 계산 수행 
	function formSubmit(){
		if(document.getElementById('target').value === ""){
			alert('수취 국가를 확인해주세요.');
			return false;
		}
		if(document.getElementById('exchangeRate').value === ""
			|| document.getElementById('excNum').value === "" ){
			alert('환율 정보를 확인해주세요.');
			return false;
		}
		const remAmount = parseInt(document.getElementById('remAmount').value);
		if(!dataCheck(remAmount)){
			alert('송금액이 바르지 않습니다.');
			return false;
		}
		
	}

	// 조건에 부합 여부를 체크한다.
	// 아래 조건에 하나라도 포함되는 경우 false를 리턴한다.
	// 아무것도 포함되지 않으면 true를 리턴한다.
	// 1. 숫자가 아닌가?
	// 2. 0 이하 10,000 이상의 수인가?
	function dataCheck(val){
		if(isNaN(val)){
			return false;
		}
		else if(val<=0 || val>10000){
			return false;
		}
		return true;
	}
	
	</script>
</head>
<body>
	<h1>환율 계산</h1>
	<form action="/Calc/ExchageRate.do" onSubmit="return formSubmit(this)">
	<div>
		<span>송금국가: 미국(USD)</span>
	</div>
	<div>
		<span>수취국가: </span>
		<select onchange="getExchangeData()" id="target" name="target">
			<option value="krw" selected >한국(KRW)</option>
			<option value="jpy">일본(JPY)</option>
			<option value="php">필리핀(PHP)</option>
		</select>
	</div>
	<div>
		<span>환율: </span> <span id="exchangeRate"></span>
		<input type="hidden" id="excNum" name="excNum">
	</div>
	<div>
		<span>송금액: </span> 
		<input type="text" id="remAmount" name="remAmount" value="${remAmount}"> <span>USD</span>
	</div>
	<input type="submit">
	</form>
	<div id="result">
		<span>${ calcResult }</span>
	</div>
</body>
</html>