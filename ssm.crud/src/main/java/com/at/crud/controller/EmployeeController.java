package com.at.crud.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.annotation.RequestScope;

import com.at.crud.bean.Employee;
import com.at.crud.bean.Msg;
import com.at.crud.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

//处理员工crud请求
@Controller
public class EmployeeController {

	@Autowired
	EmployeeService employeeService;
	

	//查询单个员工信息
	@RequestMapping(value = "/emp/{id}", method = RequestMethod.GET)
	@ResponseBody
	public Msg getEmp(@PathVariable(value = "id")Integer id) {
		System.out.println("getEmp");
		Employee employee = employeeService.getEmp(id);
		return Msg.success().add("emp", employee);
	}
	
	
	//处理放回json格式数据,加入jackson包
	@RequestMapping(value = "/emp",method = RequestMethod.GET)
	@ResponseBody
	public Msg getEmps(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
		// 1 调用PageHelper.startPage(页码,每页要显示的数据的条数)
				PageHelper.startPage(pn, 10);
				
				// 2 获取员工所有信息
				List<Employee> emp = employeeService.getAll();

				// 3 把查询到的数据封装到pageInfo里,页码连续显示五页
				PageInfo page = new PageInfo(emp, 5);
				
				return Msg.success().add("pageInfo", page);
	}

	// 查询员工数据
	//@RequestMapping("/emps")
	// 获取页面传输过来的页数进行分页查询
	public String getEmps(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {
		/*
		 * 使用pagehepler进行分页 1.下载jar包 2.在mybatis-config文件里添加 <plugins> <plugin
		 * interceptor="com.github.pagehelper.PageInterceptor"></plugin> </plugins>
		 * 
		 */
		// 1 调用PageHelper.startPage(页码,每页要显示的数据的条数)
		PageHelper.startPage(pn, 10);
		
		// 2 获取员工所有信息
		List<Employee> emp = employeeService.getAll();
 
		// 3 把查询到的数据封装到pageInfo里,页码连续显示五页
		PageInfo page = new PageInfo(emp, 5);

		// 4 把pageInfo封装到Model里面
		model.addAttribute("pageInfo",page);
		return "list";
	}
	
	//保存员工信息 添加@valid注解 验证信息
	@RequestMapping(value = "/emp",method = RequestMethod.POST)
	@ResponseBody
	public Msg saveEmp(@Valid Employee employee ,BindingResult result) {
		//定义一个Map存储错误信息
		Map<String,Object> map = new HashMap<String, Object>();
		//判断信息是否正确
		if(!result.hasErrors()) {
			System.out.println("...............");
			employeeService.saveEmp(employee);
			return Msg.success();
		}else {
			//如果校验失败,则把失败信息传回前台
			List<FieldError> fieldErrors = result.getFieldErrors();
			for(FieldError fildel_Error:fieldErrors) {
				System.out.println("错误字段:"+fildel_Error.getField());
				System.out.println("错误信息:"+fildel_Error.getDefaultMessage());
				map.put(fildel_Error.getField(), fildel_Error.getDefaultMessage());
			}
			return Msg.fail().add("fildel_Error", map);
		}
		
	}
//	@RequestMapping(value = "/savemps",method = RequestMethod.POST)
//	@ResponseBody
//	public String saveEmp(String p) {
//		System.out.println(p);
//		return p;
//	}
	
	//验证员工姓名
	@RequestMapping(value = "/checkuser",method = RequestMethod.POST)
	@ResponseBody
	public Msg checkuser(@RequestParam(value = "empName")String empName) {
		boolean b = employeeService.checkUser(empName);
		String regx = "(^[a-zA-Z0-9_-]{2,8}$)|(^[\\u2E80-\\u9FFF]{2,6}$)";
		if(!empName.matches(regx)) {
			return Msg.fail().add("va_msg", "用户名不可用");
				}
		if(b) {
			//用户名可用
			return Msg.success();
		}else {
			return Msg.fail().add("va_masg","用户名已存在");
		}
	}
	
	//保存员工 传入的id的变量名要和bean中的变量名一致
	@ResponseBody
	@RequestMapping(value = "/emp/{empId}",method = RequestMethod.PUT)
	public Msg saveEmp(Employee employee) {
		System.out.println("..........");
		employeeService.updataEmp(employee);
		return Msg.success();
	}
	
	//删除员工
	@ResponseBody
	@RequestMapping(value = "/emp/{ids}",method = RequestMethod.DELETE)
	public Msg deleteEmp(@PathVariable(value = "ids")String ids) {
		if(ids.contains("-")) {
			List<Integer> del_id = new ArrayList<Integer>();
			String[] str_id = ids.split("-");
			for(String string:str_id) {
				del_id.add(Integer.parseInt(string));
			}
			employeeService.deleteBatch(del_id);
		}else {		
			Integer id = Integer.parseInt(ids);
			employeeService.deleteEmp(id);
		}
		return Msg.success();
	}
}
