package kr.co.seoulit.insa.newempsvc.documentmgmt.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.seoulit.insa.newempsvc.documentmgmt.mapper.ConditionMapper;
import kr.co.seoulit.insa.newempsvc.documentmgmt.to.ConditionTO;

@Service
public class NDocumentMgmtServiceImpl implements NDocumentMgmtService {

	@Autowired
	private ConditionMapper conditionMapper;
	
	@Override
	public void registCondition(ConditionTO nemp) {
		conditionMapper.registCondition(nemp);
	}

}
