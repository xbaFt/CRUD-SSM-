package ssm.crud;

import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.at.crud.bean.Departement;
import com.at.crud.bean.Employee;
import com.at.crud.dao.DepartementMapper;
import com.at.crud.dao.EmployeeMapper;

//利用Spring的单元测试模块测试dao层工作
//1 导入模块
//2 添加ContextConfiguration注解
//3 直接Autowired
//添加spring單元測試模塊
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {
	
	@Autowired
	DepartementMapper departementMapper;
	@Autowired
	EmployeeMapper employeeMapper;
	@Autowired
	SqlSession sqlSession;
	@Test
	public void testCRUD() {
		//创建ioc容器
		ApplicationContext ioc = new ClassPathXmlApplicationContext("applicationContext.xml");
		DepartementMapper departement = ioc.getBean(DepartementMapper.class);
		System.out.println(departement);
		
		//1 插入信息
		//departement.insertSelective(new Departement(null,"开发部"));
		//departement.insertSelective(new Departement(null,"调试部"));
		 
		//2 生成员工信息
		//employeeMapper.insertSelective(new Employee(null, "小白","M" ,"小白@qq.com", 1));
		
		//3 批量生成员工信息
		EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
		for(int i = 0;i<1000;i++) {
			String uid = UUID.randomUUID().toString().substring(0, 5)+i;
			mapper.insertSelective(new Employee(null,uid,"M",uid+"@qq.com",1));
		}
		System.out.println("批量执行完成");
	}

}
