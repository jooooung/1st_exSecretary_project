package com.lec.exSec.dto;

import java.sql.Date;
import java.sql.Timestamp;

public class ExDto {
	private int eno;
	private String mid;
	private int epno;
	private double eweight;
	private int eset;
	private int ecount;
	private Timestamp etime;
	private Date edate;
	private String ename;	// join
	public ExDto() {
		super();
	}
	public ExDto(int eno, String mid, int epno, double eweight, int eset, int ecount, Timestamp etime, Date edate,
			String ename) {
		super();
		this.eno = eno;
		this.mid = mid;
		this.epno = epno;
		this.eweight = eweight;
		this.eset = eset;
		this.ecount = ecount;
		this.etime = etime;
		this.edate = edate;
		this.ename = ename;
	}
	public int getEno() {
		return eno;
	}
	public void setEno(int eno) {
		this.eno = eno;
	}
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	public int getEpno() {
		return epno;
	}
	public void setEpno(int epno) {
		this.epno = epno;
	}
	public double getEweight() {
		return eweight;
	}
	public void setEweight(double eweight) {
		this.eweight = eweight;
	}
	public int getEset() {
		return eset;
	}
	public void setEset(int eset) {
		this.eset = eset;
	}
	public int getEcount() {
		return ecount;
	}
	public void setEcount(int ecount) {
		this.ecount = ecount;
	}
	public Timestamp getEtime() {
		return etime;
	}
	public void setEtime(Timestamp etime) {
		this.etime = etime;
	}
	public Date getEdate() {
		return edate;
	}
	public void setEdate(Date edate) {
		this.edate = edate;
	}
	public String getEname() {
		return ename;
	}
	public void setEname(String ename) {
		this.ename = ename;
	}
	@Override
	public String toString() {
		return "ExDto [eno=" + eno + ", mid=" + mid + ", epno=" + epno + ", eweight=" + eweight + ", eset=" + eset
				+ ", ecount=" + ecount + ", etime=" + etime + ", edate=" + edate + ", ename=" + ename + "]";
	}
}
