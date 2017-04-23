package com.pz.controller;


import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.pz.bean.Stations;
import com.pz.biz.StationsBiz;

@Controller
public class StationsController {

	private StationsBiz stationsBiz;
	
	@Resource(name = "stationsBizImpl")
	public void setCollectBiz(StationsBiz stationsBiz) {
		this.stationsBiz = stationsBiz;
	}
	
	//分页显示表格内容
	@RequestMapping(value = "/findStationsByPage")
	public @ResponseBody String findStationsByPage(String page,String rows){
		int pageNum=0;
		int pageSize=0;
		Stations s=new Stations();
		if(page!=null && !page.equals("")){
			pageNum=Integer.parseInt(page);
			s.setPageNum(pageNum);
		}
		if(rows!=null && !rows.equals("")){
			pageSize=Integer.parseInt(rows);
			s.setPageSize(pageSize);
		}
		List<Stations> list=new ArrayList<Stations>();
		try {
			list=stationsBiz.selectStationsByPage(s);
		} catch (Exception e) {
			e.printStackTrace();
		}
		Gson gson=new Gson();
		return gson.toJson(list);
	}
	
	//添加新站点
	@RequestMapping(value = "/saveStations")
	public @ResponseBody String saveStations(String sname){
		Gson gson=new Gson();
		int result=0;
			try {
				List<Stations> list=stationsBiz.selectStations(new Stations());
				for(Stations s:list){
					if(sname.equals(s.getSname())){
						return gson.toJson("have");
					}
				}
				result=stationsBiz.insertStations(sname);
			} catch (IOException e) {
				e.printStackTrace();
			}
		return gson.toJson(result);
	}
	
	//根据id查找站点名
	@RequestMapping(value = "/selectStationsById")
	public @ResponseBody String selectStationsById(String id){
		Gson gson=new Gson();
		Stations s=new Stations();
		int sid=0;
		if(id!=null && !"".equals(id.trim())){
			sid=Integer.parseInt(id);
			s.setSid(sid);
		}
		try {
			List<Stations> list=stationsBiz.selectStations(s);
			if(list.size()>0 && list!=null){
				return gson.toJson(list.get(0).getSname());
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		return gson.toJson(1);
	}
	
	//修改站点信息
	@RequestMapping(value = "/updateStations")
	public @ResponseBody String updateStations(String sname,String id){
		Gson gson=new Gson();
		Stations s=new Stations();
		int sid=0;
		if(id!=null && !"".equals(id.trim())){
			sid=Integer.parseInt(id);
			s.setSid(sid);
		}
		if(sname!=null && !"".equals(sname.trim())){
			s.setSname(sname);
		}
		int result=0;
			try {
				List<Stations> list=stationsBiz.selectStations(new Stations());
				for(int i=0;i<list.size();i++){
					if(sname.equals(list.get(i).getSname()) && sid!=list.get(i).getSid()){//站点名字相同，但修改的id不同
						return gson.toJson("have");
					}
				}
				result=stationsBiz.updateStation(s);
			} catch (IOException e) {
				e.printStackTrace();
			}
		return gson.toJson(result);
	}
	
	@RequestMapping(value = "/deleteStations")
	public @ResponseBody String deleteStations(String ids){
		System.out.println("ids"+ids);
		Gson gson=new Gson();
		String [] id=ids.split(",");
		for(int i=0;i<id.length;i++){
			if(id[i]!=null && !"".equals(id[i].trim())){
				try {
					stationsBiz.deleteStation(Integer.parseInt(id[i]));
				} catch (NumberFormatException | IOException e) {
					e.printStackTrace();
				}
			}
		}
		return gson.toJson(1);
	}
	
}
