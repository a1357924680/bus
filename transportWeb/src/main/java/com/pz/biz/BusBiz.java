package com.pz.biz;

import java.util.List;
import java.util.Map;

import com.pz.bean.Bus;

public interface BusBiz {

	//增加公交信息
	public int insertBus(Bus bus)throws Exception;
	
	//修改公交信息
	public int updateBus(Bus bus)throws Exception;
	
	//删除公交信息
	public void deleteBus(int bid)throws Exception;
	
	//查询公交信息
	public List<Bus> findBus(Bus bus)throws Exception;
	
	public List<Bus> FromStartToStop(int start,int stop)throws Exception;
	
	//起点终点查询
	public Map<String, String> findByStartAndStop(int start,int stop)throws Exception;
	
	
}
