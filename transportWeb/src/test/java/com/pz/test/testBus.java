package com.pz.test;

import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.pz.bean.Bus;
import com.pz.biz.BusBiz;

public class testBus {

	ApplicationContext ac = new ClassPathXmlApplicationContext("beans.xml");
	BusBiz biz = (BusBiz) ac.getBean("busBizImpl");
	
	//@Test
	public void test() throws Exception {
		Bus bus=new Bus();
		bus.setBbegin("6:00");
		bus.setBstop("19:00");
		bus.setBline("-4-6-8-3-5-6-");
		bus.setBname("390路");
		System.out.println(biz.insertBus(bus));
	}
	
	//@Test
	public void test1() throws Exception {
		Bus bus=new Bus();
		bus.setBbegin("6:00");
		bus.setBstop("19:00");
		bus.setBline("-4-6-8-3-5-6-");
		bus.setBname("140路");
		bus.setBid(1);
		System.out.println(biz.updateBus(bus));
	}
	
	//@Test
	public void test2() throws Exception {
		System.out.println();
	}
	
	//@Test
	public void test3() throws Exception {
		Bus bus=new Bus();
		//bus.setBline("3");
		bus.setBname("140");
		List<Bus> list=biz.findBus(bus);
		for(Bus b:list){
			System.out.println(b);
		}
	}
	
	//@Test
	public void test4() throws Exception {
		Bus bus=new Bus();
		bus.setBline(9+"");
		List<Bus> list=biz.findBus(bus);
		for(Bus b:list){
			System.out.println(b);
		}
	}
	//@Test
	public void test5() throws Exception {
		
		Map<String, String>map=biz.findByStartAndStop(4, 5);
		for(Object obj:map.keySet()){
			System.out.println(obj+"**"+map.get(obj));
		}
	}
	
	@Test
	public void test6() throws Exception {
		
		Bus bus=new Bus();
		bus.setPageNum(1);
		bus.setPageSize(3);
		System.out.println(biz.findBusByPage(bus));
	}

}
