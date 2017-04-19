package com.pz.biz.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.pz.bean.Bus;
import com.pz.bean.Stations;
import com.pz.biz.BusBiz;
import com.pz.biz.StationsBiz;
import com.pz.dao.BaseDao;

@Service
public class BusBizImpl implements BusBiz {

	private BaseDao baseDao;
	
	@Resource(name="baseDaoMybatisImpl")
	public void setBaseDao(BaseDao baseDao) {
		this.baseDao = baseDao;
	}
	
	private StationsBiz biz=new StationsBizImpl();
	
	
	@Override
	public int insertBus(Bus bus) throws Exception {
		return baseDao.add(bus, "insertBus");
	}
	
	@Override
	public int updateBus(Bus bus) throws Exception {
		return baseDao.update(bus, "updateBus");
	}
	
	@Override
	public void deleteBus(int bid) throws Exception {
		Bus bus=new Bus();
		bus.setBid(bid);
		baseDao.delete(bus, "deleteBus");;
	}

	@Override
	public List<Bus> findBus(Bus bus) throws Exception {
		if(bus.getBline()!=null){
			bus.setBline("%-"+bus.getBline()+"-%");
		}
		if(bus.getBname()!=null){
			bus.setBname(bus.getBname()+"%");
		}
		List<Bus> list=baseDao.findAll(bus, "findBus");
		return addToList(list);
	}
	
	//将已转换好的公交车路线重新写进对象
	private List<Bus> addToList(List<Bus> list) throws Exception{
		
		List<Bus> newList=new ArrayList<Bus>();
		for(Bus b:list){
			b.setBline(changetoName(b.getBline()));
			newList.add(b);
		}
		return newList;
	}

	//将站点编号转换为站点名
	private String changetoName(String bline) throws Exception {
		String [] blines=bline.substring(1).split("-");
		StringBuffer sb=new StringBuffer();
		for(int i=0;i<blines.length;i++){
			Stations s=new Stations();
			s.setSid(Integer.parseInt(blines[i].trim()));
			List<Stations> slist=baseDao.findAll(s, "selectStations");
			if(slist!=null && slist.size()>0){
				s=slist.get(0);
			}
			if(i!=(blines.length-1)){
				sb.append(s.getSname()+"-->");
			}else{
				sb.append(s.getSname());
			}
		}
		return sb.toString();
	}
	
	@Override
	public List<Bus> FromStartToStop(int start, int stop) throws Exception {
		//'%-4-%-3-%'
		String bline ="%-"+start+"-%-"+stop+"-%";
		Bus bus=new Bus();
		bus.setBline(bline);
		return baseDao.findAll(bus, "findBus");
	}

	@Override
	public Map<String, String> findByStartAndStop(int start, int stop) throws Exception {
		
		//将换乘信息都存到map中,键为公交名字,值为站点
		Map<String, String> busMap=new HashMap<String,String>();
		
		Bus startBus=new Bus();
		startBus.setBline("%-"+Integer.toString(start)+"-%");
		List<Bus> startList=baseDao.findAll(startBus, "findBus");
		
		Bus stopBus=new Bus();
		stopBus.setBline("%-"+Integer.toString(stop)+"-%");
		List<Bus> stopList=baseDao.findAll(stopBus, "findBus");
		
		for(int i=0;i<startList.size();i++){
			for(int j=0;j<stopList.size();j++){
				//如果是同一辆公交车
				if(startList.get(i).getBid()==stopList.get(j).getBid()){
					
					//正序
					List<Bus> on=FromStartToStop(start, stop);
					if(on!=null && on.size()>0){
						String online=subLine(startList.get(i).getBline(), start, stop);
						for(Bus b:on){
							if(online!=null){
								busMap.put(startList.get(i).getBname(), online);
							}
						}
					}
					
					//反序
					List<Bus> down=FromStartToStop(stop,start);
					if(down!=null && down.size()>0){
						StringBuffer sb1=new StringBuffer();
						sb1.append(startList.get(i).getBline());
						String downline=subLine(sb1.reverse().toString(), start, stop);
						for(Bus b:down){
							if(downline!=null){
								busMap.put(startList.get(i).getBname(), downline);
							}
						}
					}
					
				//如果不是同一辆公交车
				}else{
					//取出各自bline,分割"-",放到数组中
					String [] startbline=startList.get(i).getBline().substring(1).split("-");
					String [] stopbline=stopList.get(j).getBline().substring(1).split("-");
					//循环,将相同的站点放入StringBuffer中
					StringBuffer stationsb=new StringBuffer();
					for(int x=0;x<startbline.length;x++){
						for(int y=0;y<stopbline.length;y++){
							if(startbline[x].equals(stopbline[y])){
								stationsb.append(startbline[x]+",");
							}
						}
					}
					//StringBuffer分割存储在数组中,循环数组,查找路线-->  起点=>中间点=>终点
					if(stationsb.toString().length()>0){//两条公交有共同的站点
						String [] stations=stationsb.toString().split(",");
						for(int n=0;n<stations.length;n++){
							String startLine=subLine(startList.get(i).getBline(), start,Integer.parseInt(stations[n]));
							String endLine=subLine(stopList.get(j).getBline(), Integer.parseInt(stations[n]), stop);
							//写进map中  -->  <起点公交名=>终点公交名,起点公交路线=>转乘=>终点公交路线>
							if(startLine!=null && endLine!=null){
								busMap.put(startList.get(i).getBname()+"==>转乘==>"+stopList.get(j).getBname(), startLine+"==>转乘==>"+endLine);
							}
							
						}
					}
				}
			}
		}
		return busMap;
	}

	private String subLine(String bline,int start,int stop) throws Exception{
		int sindex = bline.indexOf(Integer.toString(start));
		int eindex = bline.indexOf(Integer.toString(stop));
		if(sindex>0 && eindex>0){
			if(sindex<eindex){
				return changetoName("-"+bline.substring(sindex, eindex+Integer.toString(stop).length())+"-");
			}else if(sindex>eindex){//表示与数据库存储方向相反
				StringBuffer sb2=new StringBuffer();
				sb2.append("-"+bline.substring(eindex, sindex+Integer.toString(start).length())+"-");
				return changetoName(sb2.reverse().toString());
			}
			
		}
		return null;
	}
	

}
