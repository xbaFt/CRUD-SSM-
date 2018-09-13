package com.at.crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.at.crud.bean.Departement;
import com.at.crud.dao.DepartementMapper;

@Service
public class DeptementService {
	
	@Autowired
	private DepartementMapper departemenetMapper;
	
	public List<Departement> getAllDept(){
		List<Departement> dept = departemenetMapper.selectByExample(null);
		return dept;
	}
	
}
