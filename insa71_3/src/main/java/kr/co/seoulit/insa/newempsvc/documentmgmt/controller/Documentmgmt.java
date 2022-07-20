package kr.co.seoulit.insa.newempsvc.documentmgmt.controller;



import java.io.File;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.filechooser.FileSystemView;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;

import kr.co.seoulit.insa.newempsvc.documentmgmt.service.NDocumentMgmtService;
import kr.co.seoulit.insa.newempsvc.documentmgmt.to.ConditionTO;

@RequestMapping("/documentmgmt/*")
@RestController
public class Documentmgmt {

	@Autowired
	private NDocumentMgmtService documentMgmtService;
	
	ModelMap map = null;
	ConditionTO nemp = null;
	
	@PostMapping("/condition")
	public ModelMap registTerm(HttpServletRequest request, HttpServletResponse response) {		
		map = new ModelMap();
		String sendData = request.getParameter("sendData");
		try {
			Gson gson = new Gson();
			nemp = gson.fromJson(sendData, ConditionTO.class);
			System.out.println("last_school : "+nemp.getLast_school());
			documentMgmtService.registCondition(nemp);
			map.put("errorMsg","success");
			map.put("errorCode", 0);
			nemp=null;
		} catch (Exception e) {
			map.put("errorMsg", e.getMessage());
			map.put("errorCode", -1);
		}
		return map;
	}
}
