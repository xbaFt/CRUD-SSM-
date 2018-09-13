package com.at.crud.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.at.crud.bean.Departement;
import com.at.crud.bean.Msg;
import com.at.crud.service.DeptementService;

//处理dept请求
@Controller
public class DeptementController {
	
	@Autowired
	private DeptementService deptementService;
	
	@RequestMapping("/dept")
	@ResponseBody
	public Msg getDept() {
		List<Departement> list = deptementService.getAllDept();
		System.out.println(list);
		return Msg.success().add("dept", list);
	}
}
