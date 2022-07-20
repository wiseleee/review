package kr.co.seoulit.insa.newempsvc.newempinfomgmt.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.seoulit.insa.newempsvc.newempinfomgmt.mapper.NewEmpMapper;
import kr.co.seoulit.insa.newempsvc.newempinfomgmt.to.NewResumeTO;
import kr.co.seoulit.insa.newempsvc.newempinfomgmt.to.PersonalityInterviewTO;


@Service
public class NewEmpInfoServiceImpl implements NewEmpInfoService
{

	@Autowired
	private NewEmpMapper newempMapper;

	@Override
	public ArrayList<NewResumeTO> findresumeList(int year, String half) {
		// TODO Auto-generated method stub
		System.out.println(year+half);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("year", year);
		map.put("half", half);
		return newempMapper.findresumeList(map);
	}

	@Override
	public ArrayList<PersonalityInterviewTO> findPInewempList(int year, String half) {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("year", year);
		map.put("half", half);
		return newempMapper.findPInewempList(map);
	}

}
