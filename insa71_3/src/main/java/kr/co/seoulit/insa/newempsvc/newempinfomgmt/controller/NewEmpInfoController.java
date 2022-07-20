package kr.co.seoulit.insa.newempsvc.newempinfomgmt.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import kr.co.seoulit.insa.newempsvc.newempinfomgmt.service.NewEmpInfoService;
import kr.co.seoulit.insa.newempsvc.newempinfomgmt.to.NewResumeTO;
import kr.co.seoulit.insa.newempsvc.newempinfomgmt.to.PersonalityInterviewTO;
import net.sf.json.JSONObject;

@RequestMapping("/newempinfomgmt/*")
@RestController
public class NewEmpInfoController {
	
	@Autowired
	private NewEmpInfoService newempInfoService;
	ModelMap map = null;

	@GetMapping("/resumemgmt")
	public ModelMap resumeList(HttpServletRequest request, HttpServletResponse response) {
		map = new ModelMap();
		try {
			String sendData = request.getParameter("sendData");
			JSONObject json = JSONObject.fromObject(sendData);
			int year = Integer.parseInt((String) json.get("year"));
			String half = json.getString("half");
			ArrayList<NewResumeTO> list = newempInfoService.findresumeList(year, half);
			map.put("list", list);

		} catch (Exception e) {
			map.put("errorCode", -1);
			map.put("errorMsg", e.getMessage());
		}
		return map;
	}

	@GetMapping("/piresultnewemp")
	public ModelMap PersonalityInterview(HttpServletRequest request, HttpServletResponse response) {
		map = new ModelMap();
		try {
			
			String sendData = request.getParameter("sendData");
			JSONObject json = JSONObject.fromObject(sendData);
			int year = Integer.parseInt( (String)json.get("year") );
			String half = json.getString("half");
	
			ArrayList<PersonalityInterviewTO> list = newempInfoService.findPInewempList(year, half);
			map.put("list", list);
		} catch (Exception e) {
			map.put("errorCode", -1);
			map.put("errorMsg", e.getMessage());
		}
		return map;
	}
	
	@GetMapping("/sucappli")
	public ModelMap successfulApplicants(HttpServletRequest request, HttpServletResponse response) {
		map = new ModelMap();
		try {
			System.out.println("Asdasdas");
			map.put("asdasd", "asdsad");
		} catch (Exception e) {
			map.put("errorCode", -1);
			map.put("errorMsg", e.getMessage());
		}
		return map;
	}
}
