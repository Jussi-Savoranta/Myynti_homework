<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/main.css">
<title>Insert title here</title>
<style>

</style>
</head>
<body>
<table id="listaus">
	<thead>	
	<tr>
	<th colspan="5" class="oikealle"><span id="uusiAsiakas">Lisää uusi asiakas</span></th>
	</tr>	
		<tr>
			<th class="oikealle">Hakusana:</th>
			<th colspan="3"><input type="text" id="hakusana"></th>
			<th><input type="button" value="hae" id="hakunappi"></th>
		</tr>	
	<tr>
		<th>Etunimi</th>
		<th>Sukunimi</th>
		<th>Puhelin</th>
		<th>Sposti</th>	
		<th></th>						
	</tr>
	</thead>
	<tbody>
	</tbody>
</table>

<script>
$(document).ready(function(){
	$("#uusiAsiakas").click(function(){
		document.location="lisaaasiakas.jsp";
	});
	
	haeAsiakkaat();
	$("#hakunappi").click(function(){		
		console.log($("#hakusana").val());
		haeAsiakkaat();
	});
	//enterin kuuntelu
	$(document.body).on("keydown", function(event){
		  if(event.which==13){
			  haeAsiakkaat();
		  }
	});
	//kursori hakulaatikkoon sivun latauksessa
	$("#hakusana").focus();
});

function haeAsiakkaat() {
	$("#listaus tbody").empty();
	//Funktio palauttaa tiedot json-objektina
	$.ajax({url:"asiakkaat/" + $("#hakusana").val(), type:"GET", dataType:"json", success:function(result){
		console.log(result);
		
		$.each(result.asiakkaat, function(i, field){  
        	var htmlStr;
        	htmlStr+="<tr id='rivi_"+field.asiakas_id+"'>";
        	htmlStr+="<td>"+field.etunimi+"</td>";
        	htmlStr+="<td>"+field.sukunimi+"</td>";
        	htmlStr+="<td>"+field.puhelin+"</td>";
        	htmlStr+="<td>"+field.sposti+"</td>";
        	htmlStr+="<td><a href='muutaasiakas.jsp?asiakas_id="+field.asiakas_id+"'>Muuta</a>&nbsp;";
        	htmlStr+="<span class='poista' onclick=poista('" + field.asiakas_id + "')>Poista</span></td>";
        	htmlStr+="</tr>";
        	$("#listaus tbody").append(htmlStr);
        	console.log("rivi_"+field.asiakas_id);
        });
	}});
}

function poista(asiakas_id){
	if(confirm("Poista asiakas " + asiakas_id +"?")){
		$.ajax({url:"asiakkaat/"+asiakas_id, type:"DELETE", dataType:"json", success:function(result) { //result on joko {"response:1"} tai {"response:0"}
	        if(result.response==0){
	        	console.log("ei onnistu")
	        	$("#ilmo").html("Asiakkaan poisto epäonnistui.");
	        }else if(result.response==1){
	        	console.log("rivi_"+field.asiakas_id);
	        	$("#rivi_"+asiakas_id).css("background-color", "red"); //Värjätään poistetun asiakkaan rivi
	        	alert("Asiakkaan " + asiakas_id +" poisto onnistui.");
	        	haeAsiakkaat();        	
			}
	    }});
	}
}
</script>

</body>
</html>