package com.pz.biz.impl;

import java.util.List;

import javax.annotation.Resource;
import org.springframework.stereotype.Service;

import com.pz.bean.Admins;
import com.pz.biz.AdminsBiz;
import com.pz.dao.BaseDao;


@Service
public class AdminsBizImpl implements AdminsBiz {

	private BaseDao baseDao;
	
	@Resource(name="baseDaoMybatisImpl")
	public void setBaseDao(BaseDao baseDao) {
		this.baseDao = baseDao;
	}
	
	@Override
	public int insertAdmin(String pwd) throws Exception {
		Admins admin=new Admins();
		admin.setApwd(pwd);
		return baseDao.add(admin, "insertAdmin");
	}
	
	@Override
	public int updatePwd(int aid, String apwd) throws Exception {
		Admins admin=new Admins();
		admin.setAid(aid);
		admin.setApwd(apwd);
		return baseDao.update(admin, "updatePwd");
	}
	
	@Override
	public void deleteAdmin(int aid) throws Exception {
		Admins admin=new Admins();
		admin.setAid(aid);
		baseDao.delete(admin, "deleteAdmin");
	}

	@Override
	public Admins adminLogin(int aid, String apwd) throws Exception {
		Admins admin=new Admins();
		admin.setAid(aid);
		admin.setApwd(apwd);
		List<Admins> list=baseDao.findAll(admin, "adminLogin");
		if(list!=null && list.size()>0){
			return list.get(0);
		}
		return null;
	}

}
