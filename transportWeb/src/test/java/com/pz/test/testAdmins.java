package com.pz.test;

import java.sql.SQLException;
import java.text.ParseException;

import javax.sql.DataSource;

import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.pz.bean.Admins;
import com.pz.biz.AdminsBiz;

public class testAdmins {

	ApplicationContext ac = new ClassPathXmlApplicationContext("beans.xml");
	AdminsBiz biz = (AdminsBiz) ac.getBean("adminsBizImpl");
	
	//@Test   //
	public void testAccount() throws SQLException, ParseException{
		ApplicationContext ac=new ClassPathXmlApplicationContext("beans.xml");
		DataSource ds=(DataSource) ac.getBean("dataSource");
		System.out.println(ds);
	}
	
	//@Test   //
	public void testAccount1() throws SQLException, ParseException{
		ApplicationContext ac = new ClassPathXmlApplicationContext("beans.xml");
		AdminsBiz biz = (AdminsBiz) ac.getBean("adminsBizImpl");
		System.out.println(biz);
	}
	
	
	//@Test
	public void test() throws Exception {
		String pwd="aaaaaa";
		System.out.println(biz.insertAdmin(pwd));
	}
	
	//@Test
	public void test1() throws Exception {
		String pwd="aaaaaa";
		int aid=1;
		System.out.println(biz.updatePwd(aid, pwd));
	}
	
	//@Test
	public void test2() throws Exception {
		int aid=3;
		biz.deleteAdmin(aid);
	}
	
	//@Test
	public void test3() throws Exception {
		String pwd="aaaaaa";
		int aid=4;
		System.out.println(biz.adminLogin(aid, pwd));
	}
	
	@Test
	public void test4() throws Exception {
		Admins admin=new Admins();
		admin.setAid(1);
		admin.setPageNum(1);
		admin.setPageSize(2);
		System.out.println(biz.findAdminsByPage(admin));
	}

}
