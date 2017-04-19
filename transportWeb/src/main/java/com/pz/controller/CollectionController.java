package com.pz.controller;


import javax.annotation.Resource;

import org.springframework.stereotype.Controller;

import com.pz.biz.AdminsBiz;

@Controller
public class CollectionController {

	private AdminsBiz adminsBiz;
	
	@Resource(name = "adminsBizImpl")
	public void setCollectBiz(AdminsBiz adminsBiz) {
		this.adminsBiz = adminsBiz;
	}
	
	
	
	
}
