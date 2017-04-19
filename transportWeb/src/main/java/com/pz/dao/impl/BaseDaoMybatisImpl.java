package com.pz.dao.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.stereotype.Repository;

import com.pz.dao.BaseDao;


//操作sqlsession.find  selectOne  insert update
@Repository  //ioc   
public class BaseDaoMybatisImpl<T> extends SqlSessionDaoSupport implements BaseDao<T> {
	private String mapperLocation="com.pz.mapper.";
	
//将获取mapper.xml 文件封装成一个方法     t.getClass()获取到类     .getSimpleName()去掉    类名的后缀    +Mapper  + id
//所以在写bizImpl的时候  都需要最终传进的泛型 (T,t)是一个类
	private String getMapperId(T t,String sqlId){
		return mapperLocation+ t.getClass().getSimpleName()+"Mapper."+sqlId;
	}
	
	@Override
	@Resource(name="sqlSessionFactory")   //di
	public void setSqlSessionFactory(SqlSessionFactory sqlSessionFactory) {
		super.setSqlSessionFactory(sqlSessionFactory);
	}


	@Override
	public List<T> findAll(T t, String sqlId) {
		return super.getSqlSession().selectList(getMapperId(t,sqlId),t);
		
	}


	@Override
	public List<T> findAll(T t, Map map, String sqlId) {
		return super.getSqlSession().selectList(getMapperId(t, sqlId), map);
	}


	@Override
	public int add(T t, String sqlId) {
		return super.getSqlSession().insert(getMapperId(t, sqlId), t);
	}


	@Override
	public void add(T t, Map map, String sqlId) {
		super.getSqlSession().insert(getMapperId(t, sqlId),map);
	}


	@Override
	public void addMany(T t, List list, String sqlId) {
		super.getSqlSession().insert(getMapperId(t, sqlId), list);
	}


	@Override
	public void delete(T t, String sqlId) {
		super.getSqlSession().delete(getMapperId(t, sqlId), t);
		
	}


	@Override
	public void delete(T t, Map map, String sqlId) {
		super.getSqlSession().delete(getMapperId(t, sqlId),map);
		
	}


	@Override
	public void deleteMany(T t, List list, String sqlId) {
		super.getSqlSession().delete(getMapperId(t, sqlId), list);
		
	}


	@Override
	public int update(T t, String sqlId) {
		return super.getSqlSession().update(getMapperId(t, sqlId), t);
		
	}


	@Override
	public void update(T t, Map map, String sqlId) {
		super.getSqlSession().update(getMapperId(t, sqlId),map);
		
	}


	@Override
	public void update(T t, List list, String sqlId) {
		super.getSqlSession().update(getMapperId(t, sqlId), list);
		
	}


	@Override
	public double findFunc(T t, String sqlId) {
		return super.getSqlSession().selectOne(this.getMapperId(t, sqlId),t);
	}


	@Override
	public double findFunc(T t, Map map, String sqlId) {
		return super.getSqlSession().selectOne(this.getMapperId(t, sqlId), map);
	}

}
