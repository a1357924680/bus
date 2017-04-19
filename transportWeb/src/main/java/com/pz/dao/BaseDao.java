package com.pz.dao;

import java.util.List;
import java.util.Map;

public  interface BaseDao<T> {
	public List<T> findAll(T t,String sqlId);
	
	// select * from xx limit 5,10
	// Map start=5
	//  end =10     分页
	//这个方法既能查多个又能查一个  就是在BizImpl的时候写返回值不一样
	public List<T> findAll(T t,Map map,String sqlId);
	
	public int add(T t,String sqlId);
	
	public void add(T t,Map map,String sqlId);
	//批量增加
	public void addMany(T t,List list,String sqlId);
	
	public void delete(T t,String sqlId);
	
	public void delete(T t,Map map,String sqlId);
	
	//delete from xxx where id in(1,2,3)  批量删除
	public void deleteMany(T t,List list , String sqlId);
	
	public int update(T t,String sqlId);
	
	
	public void update(T t,Map map,String sqlId);
	//update xxx set sex=x where id in(1,2,3)  批量修改
	public void update(T t,List list , String sqlId);
	
	//聚合函数
	public double findFunc(T t,String sqlId);
	
	public double findFunc(T t,Map map,String sqlId);
	
}
