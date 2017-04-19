package com.pz.bean;

public class Admins {
	
	private int aid;
	private String apwd;
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
