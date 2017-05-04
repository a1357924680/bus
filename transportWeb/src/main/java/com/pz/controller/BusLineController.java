package com.pz.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.pz.bean.Bus;
import com.pz.bean.Stations;
import com.pz.biz.BusBiz;
import com.pz.biz.StationsBiz;


@Controller
public class BusLineController {

	private static final Log logger = LogFactory.getLog(BusLineController.class);
	
	private BusBiz busBiz;
	
	private StationsBiz stationsBiz;
	
	
	@Resource(name = "stationsBizImpl")
	public void setStationsBiz(StationsBiz stationsBiz) {
		this.stationsBiz = stationsBiz;
	}


	@Resource(name = "busBizImpl")
	public void setBusBiz(BusBiz busBiz) {
		this.busBiz = busBiz;
	}
	
	
	//后台查询及分页
	@RequestMapping(value="/findAllByPage")
	public @ResponseBody String JdDetailManager(HttpServletResponse response, @RequestParam String page,
			@RequestParam String rows,@RequestParam String bname,@RequestParam String bline) throws Exception {
		response.setCharacterEncoding("utf-8");
		logger.info("findAllByPage called  ");
		int pages=0;
		int rowss=0;
		if(page!=null && !"".equals(page)){
			pages=Integer.parseInt(page);
		}
		
		if(rows!=null && !"".equals(rows)){
			rowss=Integer.parseInt(rows);
		}
		Bus bus=new Bus();
		bus.setPageNum(pages);
		bus.setPageSize(rowss);
		if(bname!=null && !"".equals(bname.trim())){
			bus.setBname(bname+"%");
		}
		if(bline!=null && !"".equals(bline.trim())){
			bus.setBline("%-"+bline+"-%");
		}
		List<Bus> listBusLine=this.busBiz.findBusByPage(bus);
		Gson gson = new Gson();
		return gson.toJson(listBusLine);
	}
	
	
	//后台查询及分页
		@RequestMapping(value="/findByPage")
		public @ResponseBody String findAllByPage(HttpServletResponse response, @RequestParam String page,@RequestParam String rows) throws Exception {
			response.setCharacterEncoding("utf-8");
			logger.info("findByPage called  ");
			int pages=0;
			int rowss=0;
			if(page!=null && !"".equals(page)){
				pages=Integer.parseInt(page);
			}
			
			if(rows!=null && !"".equals(rows)){
				rowss=Integer.parseInt(rows);
			}
			Bus bus=new Bus();
			bus.setPageNum(pages);
			bus.setPageSize(rowss);
			List<Bus> listBusLine=this.busBiz.findBusByPage(bus);
			Gson gson = new Gson();
			return gson.toJson(listBusLine);
		}
	
	//后台查询所有的站点
	@RequestMapping(value="/findAllStations")
	public @ResponseBody String FindAllStation(HttpServletResponse response) throws IOException{
		response.setCharacterEncoding("utf-8");
		logger.info("findAllStation called ");
		Stations s=new Stations();
		List<Stations> listStations=this.stationsBiz.selectStations(s);
		System.out.println("listStations"+listStations);
		Gson gson=new Gson();
		return gson.toJson(listStations);
		
	}
	
	//后台添加busLine
	@RequestMapping(value="/addBusLine")
	public @ResponseBody String addBusLine(HttpServletResponse response,HttpServletRequest request) throws Exception{
		response.setCharacterEncoding("utf-8");
		logger.info("addBusLine called ");
		Gson gson=new Gson();
		Bus bus=new Bus();
		String bname=request.getParameter("bname");
		String bbegin=request.getParameter("bbegin");
		String bstop=request.getParameter("bstop");
		String hiddenLine=request.getParameter("hiddenLine");
		
		List<Bus>list=this.busBiz.findBus(bus);
		for(Bus b:list){
			if(bname.equals(b.getBname())){
				return gson.toJson("have");
			}
		}
		bus.setBname(bname);
		bus.setBbegin(bbegin);
		bus.setBstop(bstop);
		bus.setBline(hiddenLine);
		int a=this.busBiz.insertBus(bus);
		return gson.toJson(a);
		
	}
	
	//后台的修改
	@RequestMapping(value="/updateBusLine")
	public @ResponseBody String updateBusLine(HttpServletResponse response){
		response.setCharacterEncoding("utf-8");
		logger.info("addBusLine called ");
		
		
		Gson gson = new Gson();
		return null;
	}
	//后台的删除
	@RequestMapping(value="/deleteBusLine")
	public @ResponseBody String deleteBusLine(HttpServletResponse response,@RequestParam String ids) throws Exception{
		response.setCharacterEncoding("utf-8");
		logger.info("addBusLine called ");
		Gson gson=new Gson();
		String [] id=ids.split(",");
		for(int i=0;i<id.length;i++){
			if(id[i]!=null && !"".equals(id[i].trim())){
				busBiz.deleteBus(Integer.parseInt(id[i]));
			}
		}
		return gson.toJson(1);
	}
	
	/*//后台的删除
	@RequestMapping(value="/selectblineById")
	public @ResponseBody String selectblineById(HttpServletResponse response,@RequestParam String bid) throws Exception{
		response.setCharacterEncoding("utf-8");
		logger.info("selectblineById called ");
		Bus bus=new Bus();
		int id=0;
		Gson gson=new Gson();
		if(bid!=null && !"".equals(bid)){
			id=Integer.parseInt(bid);
		}
		bus.setBid(id);
		List<Bus>list= busBiz.findBusById(bus);
		return gson.toJson(list);
	}
	*/
	
	@RequestMapping(value="/getBusTotal")
	public @ResponseBody String getBusTotal(HttpServletResponse response,@RequestParam String bname,@RequestParam String bline) throws Exception {
		response.setCharacterEncoding("utf-8");
		logger.info("getBusTotal called  ");
		
		
		Bus bus=new Bus();
		
		if(bname!=null && !"".equals(bname.trim())){
			bus.setBname(bname+"%");
		}
		if(bline!=null && !"".equals(bline.trim())){
			bus.setBline(bline);
		}
		List<Bus> listBusLine=this.busBiz.findBus(bus);
		Gson gson = new Gson();
		return gson.toJson(listBusLine.size());
	}
	
	//换乘
	@RequestMapping(value="/getAllBusFromTo")
	public @ResponseBody String getAllBusFromTo(@RequestParam String start,@RequestParam String stop) throws Exception {
		logger.info("getAllBusFromTo called  ");
		int startStations=0;
		int stopStations=0;
		
		if(start!=null && !"".equals(start.trim())){
			startStations=Integer.parseInt(start);
		}
		if(stop!=null && !"".equals(stop.trim())){
			stopStations=Integer.parseInt(stop);
		}
		Map<String, String>map=busBiz.findByStartAndStop(startStations, stopStations);
		List<Bus> list=new ArrayList<Bus>();
		for(Object obj:map.keySet()){
			System.out.println(obj+"**"+map.get(obj));
			Bus b=new Bus();
			b.setBname(obj.toString());
			b.setBline(map.get(obj));
			list.add(b);
		}
		Gson gson = new Gson();
		return gson.toJson(list);
	}

	
}
