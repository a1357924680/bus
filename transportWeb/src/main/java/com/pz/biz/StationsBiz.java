package com.pz.biz;

import java.io.IOException;
import java.util.List;

import com.pz.bean.Stations;

public interface StationsBiz {

	public int insertStations(String sname) throws IOException;
	
	public int updateStation(Stations s) throws IOException;
	
	public void deleteStation(int sid) throws IOException;
	
	public List<Stations> selectStations(Stations s)throws IOException;
	
	public List<Stations> selectStationsByPage(Stations s) throws Exception;
}
