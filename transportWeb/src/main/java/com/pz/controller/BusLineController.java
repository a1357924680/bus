package com.pz.controller;

import java.io.PrintWriter;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.pz.bean.Bus;
import com.pz.biz.BusBiz;


@Controller
public class BusLineController {

	private static final Log logger = LogFactory.getLog(BusLineController.class);
	
	private BusBiz busBiz;

	@Resource(name = "busBizImpl")
	public void setBusBiz(BusBiz busBiz) {
		this.busBiz = busBiz;
	}
	
	
	//后台查询及分页
	@RequestMapping(value="/findAllByPage")
	public @ResponseBody void JdDetailManager(HttpServletResponse response, @RequestParam String page,@RequestParam String rows) throws Exception {
		response.setCharacterEncoding("utf-8");
		logger.info("findAllByPage called  ");
		int pages=0;
		int rowss=0;
		if(page!=null && "".equals(page)){
			pages=Integer.parseInt(page);
		}
		
		if(rows!=null && "".equals(rows)){
			rowss=Integer.parseInt(rows);
		}
		Bus bus=new Bus();
		bus.setPageNum(pages);
		bus.setPageSize(rowss);
		
		List<Bus> ListBusLine=this.busBiz.findBusByPage(bus);
		PrintWriter out = response.getWriter();
		Gson gson = new Gson();
		out.print(gson.toJson(ListBusLine));
	}
	
}
