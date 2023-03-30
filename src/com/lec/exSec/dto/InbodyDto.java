package com.lec.exSec.dto;

import java.sql.Date;

public class InbodyDto {
	private int inum;
	private String mid;
	private double iweight;
	private double ifat;
	private double imuscle;
	private Date idate;
	public InbodyDto() {
		super();
	}
	
	public InbodyDto(String mid, double iweight, double ifat, double imuscle, Date idate) {
		super();
		this.mid = mid;
		this.iweight = iweight;
		this.ifat = ifat;
		this.imuscle = imuscle;
		this.idate = idate;
	}

	public InbodyDto(int inum, String mid, double iweight, double ifat, double imuscle, Date idate) {
		super();
		this.inum = inum;
		this.mid = mid;
		this.iweight = iweight;
		this.ifat = ifat;
		this.imuscle = imuscle;
		this.idate = idate;
	}
	public int getInum() {
		return inum;
	}
	public void setInum(int inum) {
		this.inum = inum;
	}
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	public double getIweight() {
		return iweight;
	}
	public void setIweight(double iweight) {
		this.iweight = iweight;
	}
	public double getIfat() {
		return ifat;
	}
	public void setIfat(double ifat) {
		this.ifat = ifat;
	}
	public double getImuscle() {
		return imuscle;
	}
	public void setImuscle(double imuscle) {
		this.imuscle = imuscle;
	}
	public Date getIdate() {
		return idate;
	}
	public void setIdate(Date idate) {
		this.idate = idate;
	}
	@Override
	public String toString() {
		return "{\"idate\": \"" + idate + "\", \"iweight\": " + iweight + ",  "
			 + "\"ifat\": " + ifat + ", \"imuscle\" : " + imuscle + "}";
	}
}
