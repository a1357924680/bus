package com.pz.test;


import java.io.IOException;
import java.util.List;

import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.pz.bean.Stations;
import com.pz.biz.StationsBiz;

public class testStations {

	ApplicationContext ac = new ClassPathXmlApplicationContext("beans.xml");
	StationsBiz biz = (StationsBiz) ac.getBean("stationsBizImpl");
	
	//@Test
	public void test() throws IOException {
		String sname="高铁学院";
		System.out.println(biz.insertStations(sname));
	}
	
	//@Test
	public void test1() throws IOException {
		String sname="什么站";
		int sid=1;
		Stations s=new Stations();
		s.setSname(sname);
		s.setSid(sid);
		System.out.println();
	}
	
	//@Test
	public void test2() throws IOException {
		int sid=2;
		biz.deleteStation(sid);
	}
	
	@Test
	public void test3() throws IOException {
		Stations s=new Stations();
		//s.setSid(4);
		//s.setSname("%市%");
		s.setPageNum(1);
		s.setPageSize(3);
		List<Stations> list=biz.selectStations(s);
		for(Stations s1:list){
			System.out.println(s1);
		}
	}

}
