package ssm.crud;

import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.at.crud.bean.Employee;
import com.github.pagehelper.PageInfo;

/*
 * 使用Spring测试模块测试请求
 * 
 */
@RunWith(SpringJUnit4ClassRunner.class)
//使用@webAppConfiguration注解吧整个ioc容器注入
@WebAppConfiguration
@ContextConfiguration(locations= {"classpath:applicationContext.xml","file:src/main/webapp/WEB-INF/dispatcherServlet-servlet.xml"})
public class MvcTest {
	
	//传入SpringMvc的ioc
	@Autowired
	WebApplicationContext context;
	//虚拟mvc请求,获取处理结果
	MockMvc mockMvc;
	
	//使用@Before注解进行初始化
	//创建mvc请求 
	@Before
	public void initMockMvc() {
		mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
	}
	@Test
	public void testPage() throws Exception {
		//模拟请求获取数据
		MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn", "1")).andReturn();
		//从请求域中取出pageInfo
		MockHttpServletRequest request = result.getRequest();
		PageInfo pi = (PageInfo) request.getAttribute("pageInfo");
		System.out.println("当前页码:"+pi.getPageNum());
		System.out.println("总页码:"+pi.getPages());
		System.out.println("总记录数:"+pi.getTotal());
		System.out.println("在页面需要连续显示的页码");
		int[] nums = pi.getNavigatepageNums();
		for(int i : nums) {
			System.out.println(" "+i);
		}
		//获取员工数据
		List<Employee> list = pi.getList();
		for(Employee employee : list) {
			System.out.println("ID:"+employee.getEmpId()+"==>Name:"+employee.getEmpName());
		}
	}
}
