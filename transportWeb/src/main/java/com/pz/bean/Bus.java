package com.pz.bean;

public class Bus {

	private int bid;//编号
	private String bname;//100路
	private String  bline;//路线
	private String bbegin;//早班车时间
	private String bstop;//晚班车时间
	
	private int start;//查询起始站
	private int stop;//查询终到站
	
	private int pageNum;  //第几页
	private int pageSize;  //每页多少条
	
	public int getPageNum() {
		return pageNum;
	}
	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	
	public int getStart() {
		return start;
	}
	public void setStart(int start) {
		this.start = start;
	}
	public int getStop() {
		return stop;
	}
	public void setStop(int stop) {
		this.stop = stop;
	}
	public int getBid() {
		return bid;
	}
	public void setBid(int bid) {
		this.bid = bid;
	}
	public String getBname() {
		return bname;
	}
	public void setBname(String bname) {
		this.bname = bname;
	}
	public String getBline() {
		return bline;
	}
	public void setBline(String bline) {
		this.bline = bline;
	}
	public String getBbegin() {
		return bbegin;
	}
	public void setBbegin(String bbegin) {
		this.bbegin = bbegin;
	}
	public String getBstop() {
		return bstop;
	}
	public void setBstop(String bstop) {
		this.bstop = bstop;
	}
	
	@Override
	public String toString() {
		return "Bus [bid=" + bid + ", bname=" + bname + ", bline=" + bline + ", bbegin=" + bbegin + ", bstop=" + bstop+"]";
	}
	
}
