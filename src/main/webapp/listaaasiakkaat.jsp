<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/main.css">
<title>Insert title here</title>
</head>
<body>

<table id="listaus">
	<thead>	
	<tr>	
	<th id="hSana">Hakusana:</th>	
	<th><input type="text" name="enimi"></th>	
	<th><input type="submit" value="Hae"></th>	
	</tr>	
		<tr id= haku>
			<th>Etunimi</th>
			<th>Sukunimi</th>
			<th>Puhelin</th>
			<th>Sposti</th>							
		</tr>
	</thead>
	<tbody>
	</tbody>
</table>

<script>
$(document).ready(function(){
	//Funktio palauttaa tiedot json-objektina
	$.ajax({url:"asiakkaat", type:"GET", dataType:"json", success:function(result){
		console.log(result);
		
		$.each(result.asiakkaat, function(i, field){  
        	var htmlStr;
        	htmlStr+="<tr>";
        	htmlStr+="<td>"+field.etunimi+"</td>";
        	htmlStr+="<td>"+field.sukunimi+"</td>";
        	htmlStr+="<td>"+field.puhelin+"</td>";
        	htmlStr+="<td>"+field.sposti+"</td>";  
        	htmlStr+="</tr>";
        	$("#listaus tbody").append(htmlStr);
        });
	}});
});
</script>

</body>
</html>