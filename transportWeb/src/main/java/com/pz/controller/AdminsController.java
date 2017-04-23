package com.pz.controller;


import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.pz.bean.Admins;
import com.pz.biz.AdminsBiz;

@Controller
public class AdminsController {

	private AdminsBiz adminsBiz;
	
	@Resource(name = "adminsBizImpl")
	public void setCollectBiz(AdminsBiz adminsBiz) {
		this.adminsBiz = adminsBiz;
	}
	
	//管理员登录
	@RequestMapping(value = "/adminLogin")
	public String adminLogin(Admins admin,HttpSession session){
		try {
			admin=adminsBiz.adminLogin(admin.getAid(), admin.getApwd());
			if(admin==null){
				session.setAttribute("loginErrorInfo", "用户名或密码错误，请重新输入");
				return "admin/login";
			}
			session.setAttribute("loginErrorInfo", "");
			session.setAttribute("currentUser", admin);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "admin/main";
	}
	
	//修改密码
	@RequestMapping(value = "/updatePwd")
	public @ResponseBody String updatePwd(String newPassword2,HttpSession session){
		Admins admin=(Admins) session.getAttribute("currentUser");
		int result=0;
		try {
			result=adminsBiz.updatePwd(admin.getAid(), newPassword2);
		} catch (Exception e) {
			e.printStackTrace();
		}
		Gson gson=new Gson();
		return gson.toJson(result);
	}
	
	//分页显示管理员
	@RequestMapping(value = "/showAdminsByPage")
	public @ResponseBody String showAdminsByPage(String page,String rows){
		int pageNum=0;
		int pageSize=0;
		if(page!=null && !page.equals("")){
			pageNum=Integer.parseInt(page);
		}
		if(rows!=null && !rows.equals("")){
			pageSize=Integer.parseInt(rows);
		}
		Admins admin=new Admins();
		admin.setPageNum(pageNum);
		admin.setPageSize(pageSize);
		List<Admins> list=null;
		try {
			list=adminsBiz.findAdminsByPage(admin);
		} catch (Exception e) {
			e.printStackTrace();
		}
		Gson gson=new Gson();
		return gson.toJson(list);
	}
	
	//添加新管理员
	@RequestMapping(value = "/saveNewAdmin")
	public @ResponseBody String saveNewAdmin(String newPassword){
		int result=0;
		try {
			result=adminsBiz.insertAdmin(newPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
		Gson gson=new Gson();
		return gson.toJson(result);
	}
	
	@RequestMapping(value = "/deleteAdmins")
	public @ResponseBody String deleteAdmins(String ids){
		String [] idss=ids.split(",");
		for(int i=0;i<idss.length;i++){
			if(idss[i]!=null && !"".equals(idss[i])){
				try {
					adminsBiz.deleteAdmin(Integer.parseInt(idss[i]));
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		Gson gson=new Gson();
		return gson.toJson(1);
	}
	
	
}
