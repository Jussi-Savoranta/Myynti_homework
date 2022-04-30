<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script
	src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.15.0/jquery.validate.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/main.css">
<title>Insert title here</title>
</head>
<body>
	<form id="tiedot">
		<table>
			<thead>
				<tr>
					<th colspan="5" class="oikealle"><span id="takaisin">Takaisin asiakkaisiin</span></th>
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
				<tr>
					<td><input type="text" name="etunimi" id="etunimi"></td>
					<td><input type="text" name="sukunimi" id="sukunimi"></td>
					<td><input type="text" name="puhelin" id="puhelin"></td>
					<td><input type="text" name="sposti" id="sposti"></td>
					<td><input type="submit" id="tallenna" value="Lis��"></td>
				</tr>
			</tbody>

		</table>
	</form>
	<span id="ilmo"></span>
</body>
<script>
	$(document).ready(function() {
		$("#takaisin").click(function() {
			document.location="listaaasiakkaat.jsp";
		});
		
		$("#tiedot").validate({
			rules : {
				enimi : {
					required : true
				},
				snimi : {
					required : true

				},
				puhelin : {
					required : true,
					number : true,
					minlength : 10,
					maxlength : 15
				},
				sposti : {
					required : true
				}
			},
			messages : {
				enimi : {
					required : "Puuttuu"

				},
				snimi : {
					required : "Puuttuu"
				},
				puhelin : {
					required : "Puuttuu",
					number : "Ei kelpaa",
					minlength : "Liian lyhyt",
					maxlength : "Liian pitk��"
				},
				sposti : {
					required : "Puuttuu"
				}
			},
			submitHandler : function(form) {
				lisaaTiedot();
			}
		});
	});
	// tietojen lis��minen
	function lisaaTiedot() {
		console.log("toimii")
		//$("#ilmo").html("Asiakkaan lis��minen ep�onnistui.");
		var formJsonStr = formDataJsonStr($("#tiedot").serializeArray()); //muutetaan lomakkeen tiedot json-stringiksi
		$.ajax({
			url : "asiakkaat",
			data : formJsonStr,
			type : "POST",
			dataType : "json",
			success : function(result) { //result on joko {"response:1"} tai {"response:0"}       
				if (result.response == 0) {
					$("#ilmo").html("Asiakkaan lis��minen ep�onnistui.");
				} else if (result.response == 1) {
					$("#ilmo").html("Asiakkaan lis��minen onnistui.");
					$("#etunimi", "#sukunimi", "#puhelin", "#sposti").val("");
				}
			  }});	
			}
</script>
</html>