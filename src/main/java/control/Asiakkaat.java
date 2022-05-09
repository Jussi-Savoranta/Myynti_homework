package control;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import model.Asiakas;
import model.dao.Dao;


@WebServlet("/asiakkaat/*")
public class Asiakkaat extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
  
    public Asiakkaat() {
        super();
        System.out.println("Asiakkaat.Asiakkaat()");
    }

	//GET /asiakkaat/[hakusana]
    //GET /asiakkaat/haeyksi/asiakas_id
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Asiakkaat.doGet()");
		String pathInfo = request.getPathInfo();
		System.out.println(pathInfo);
		
		Dao dao = new Dao();
		ArrayList<Asiakas> asiakkaat;
		
		String strJSON = "";
		if(pathInfo==null) { //hae kaikki asiakkaat
			asiakkaat = dao.listaaKaikki();
			strJSON = new JSONObject().put("asiakkaat", asiakkaat).toString();
		} else if(pathInfo.contains("haeyksi")) { // hae yksi asiakas
			String asiakas_id = pathInfo.replace("/haeyksi/", "");
			System.out.println("as_id:");
			System.out.println(asiakas_id);
			Asiakas asiakas = dao.etsiAsiakas(asiakas_id);
			if(asiakas == null) {
				strJSON = "{}";
			} else {

			JSONObject JSON = new JSONObject();
			//System.out.println(asiakas.getAsiakas_id() + " " + asiakas.getEtunimi());
			JSON.put("etunimi", asiakas.getEtunimi());
			JSON.put("sukunimi", asiakas.getSukunimi());
			JSON.put("puhelin", asiakas.getPuhelin());
			JSON.put("sposti", asiakas.getSposti());
			strJSON = JSON.toString();
			}
		} else {//hae hakusanan mukaiset asiakkaat
			String hakusana = pathInfo.replace("/", "");
			asiakkaat = dao.listaaKaikki(hakusana);
			strJSON = new JSONObject().put("asiakkaat", asiakkaat).toString();
			System.out.println(asiakkaat);
		}
		
		
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		out.println(strJSON);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Asiakkaat.doPost()");
		JSONObject jsonObj = new JsonStrToObj().convert(request);
		Asiakas asiakas = new Asiakas();
		asiakas.setEtunimi(jsonObj.getString("etunimi"));
		asiakas.setSukunimi(jsonObj.getString("sukunimi"));
		asiakas.setPuhelin(jsonObj.getString("puhelin"));
		asiakas.setSposti(jsonObj.getString("sposti"));
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		Dao dao = new Dao();
		System.out.println("Asiakkaat.java:" + asiakas.toString());
		if(dao.lisaaAsiakas(asiakas)) {
			out.println("{\"response\":1}");
		} else {
			out.println("{\"response\":0}");
		}

	}

	// muutetaan asiakkaan tiedot
	protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Asiakkaat.doPut()");
		JSONObject jsonObj = new JsonStrToObj().convert(request);
		Asiakas asiakas = new Asiakas();
		asiakas.setEtunimi(jsonObj.getString("etunimi"));
		asiakas.setSukunimi(jsonObj.getString("sukunimi"));
		asiakas.setPuhelin(jsonObj.getString("puhelin"));
		asiakas.setSposti(jsonObj.getString("sposti"));
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		Dao dao = new Dao();
		System.out.println("Asiakkaat.java: " + asiakas.toString());
		if(dao.muutaAsiakas(asiakas)) {
			System.out.println("Asiakkaan muuttaminen onnistui");
			out.println("{\"response\":1}");
		} else {
			System.out.println("Asiakkaan muuttaminen ep‰onnistui");
			out.println("{\"response\":0}");
		}
	}


	protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Asiakkaat.doDelete()");
		//haetaan requestin path
		String pathInfo = request.getPathInfo(); 
		System.out.println(pathInfo);
		//poistetaan path'sta /-viiva, jolloin j‰ljelle j‰‰ vain asiakas_id
		String poistettavaAsiakas_id = pathInfo.replace("/", "");
		
		Dao dao = new Dao();
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		
		//poistaAsiakas palauttaa booleanin
		if(dao.poistaAsiakas(poistettavaAsiakas_id)) {
			//poistaminen onnistui
			out.println("{\"response\":1}");
		} else {
			//poistaminen ep‰onnistui
			out.println("{\"response\":0}");
		}
	}

}
