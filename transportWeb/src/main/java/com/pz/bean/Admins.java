package com.pz.bean;

import java.io.Serializable;

public class Admins implements Serializable{
	
	private static final long serialVersionUID = 1L;
	private int aid;
	private String apwd;
	
	private int pageNum;
	private int pageSize;
	
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
	public int getAid() {
		return aid;
	}
	public void setAid(int aid) {
		this.aid = aid;
	}
	public String getApwd() {
		return apwd;
	}
	public void setApwd(String apwd) {
		this.apwd = apwd;
	}
	@Override
	public String toString() {
		return "Admins [aid=" + aid + ", apwd=" + apwd + "]";
	}
	

}
