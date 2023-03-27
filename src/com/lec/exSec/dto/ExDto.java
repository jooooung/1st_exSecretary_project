package com.lec.exSec.dto;

import java.sql.Date;

public class ExDto {
	private int eno;
	private String mid;
	private int epno;
	private double eweight;
	private int eset;
	private int ecount;
	private int ehour;
	private int emin;
	private int esec;
	private Date edate;
	private String ename;	// join
	public ExDto() {
		super();
	}
	
	public ExDto(int eno, String mid, int epno, double eweight, int eset, int ecount, int ehour, int emin, int esec,
			Date edate, String ename) {
		super();
		this.eno = eno;
		this.mid = mid;
		this.epno = epno;
		this.eweight = eweight;
		this.eset = eset;
		this.ecount = ecount;
		this.ehour = ehour;
		this.emin = emin;
		this.esec = esec;
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
	public int getEhour() {
		return ehour;
	}

	public void setEhour(int ehour) {
		this.ehour = ehour;
	}

	public int getEmin() {
		return emin;
	}

	public void setEmin(int emin) {
		this.emin = emin;
	}
	public int getEsec() {
		return esec;
	}
	public void setEsec(int esec) {
		this.esec = esec;
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
				+ ", ecount=" + ecount + ", ehour=" + ehour + ", emin=" + emin + ", esec=" + esec + ", edate=" + edate
				+ ", ename=" + ename + "]";
	}
}
