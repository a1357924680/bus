package com.pz.biz;

import com.pz.bean.Admins;

public interface AdminsBiz {

	//添加管理员
	public int insertAdmin(String pwd) throws Exception;
	
	//修改密码
	public int updatePwd(int aid,String apwd) throws Exception;
	
	//删除管理员
	public void deleteAdmin(int aid) throws Exception;
	
	//管理员登录
	public Admins adminLogin(int aid,String apwd) throws Exception;
}
