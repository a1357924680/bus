package com.pz.biz.impl;

import java.io.IOException;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.pz.bean.Stations;
import com.pz.biz.StationsBiz;
import com.pz.dao.BaseDao;

@Service
public class StationsBizImpl implements StationsBiz {

	private BaseDao baseDao;
	
	@Resource(name="baseDaoMybatisImpl")
	public void setBaseDao(BaseDao baseDao) {
		this.baseDao = baseDao;
	}
	
	@Override
	public int insertStations(String sname) throws IOException {
		Stations s=new Stations();
		s.setSname(sname);
		return baseDao.add(s,"insertStations");
	}
	@Override
	public int updateStation(Stations s) throws IOException {
		return baseDao.update(s, "updateStation");
	}
	@Override
	public void deleteStation(int sid) throws IOException {
		Stations s=new Stations();
		s.setSid(sid);
		baseDao.delete(s, "deleteStation");
	}
	
	@Override
	public List<Stations> selectStations(Stations s) throws IOException {
		return baseDao.findAll(s, "selectStations");
	}

}
