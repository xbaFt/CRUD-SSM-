package com.at.crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.at.crud.bean.Employee;
import com.at.crud.bean.EmployeeExample;
import com.at.crud.bean.EmployeeExample.Criteria;
import com.at.crud.dao.EmployeeMapper;

@Service
public class EmployeeService {

	@Autowired
	EmployeeMapper employeeMapper;
	
	//查询员工所有信息
	public List<Employee> getAll() {
		return employeeMapper.selectByExampleWithDept(null);
	}
	
	//保存员工信息
	public void saveEmp(Employee employee) {
		employeeMapper.insertSelective(employee);
	}
	
	//验证员工姓名是否重复 返回true代表姓名不重复
	public boolean checkUser(String name) {
		EmployeeExample example = new EmployeeExample();
		Criteria create = example.createCriteria();
		create.andEmpNameEqualTo(name);
		long countByExample = employeeMapper.countByExample(example);
		return countByExample==0;
	}

	public Employee getEmp(Integer id) {
		Employee selectByPrimaryKey = employeeMapper.selectByPrimaryKey(id);
		return selectByPrimaryKey ;
	}

	public void updataEmp(Employee employee) {
		employeeMapper.updateByPrimaryKeySelective(employee);
	}

	public void deleteEmp(Integer id) {
		employeeMapper.deleteByPrimaryKey(id);
	}
	
	public void deleteBatch(List<Integer> ids) {
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		criteria.andEmpIdIn(ids);
		employeeMapper.deleteByExample(example);
	}
}
