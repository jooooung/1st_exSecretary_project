package com.lec.exSec.dto;

import java.sql.Timestamp;

public class BcommentDto {
	private int cnum;
	private int bnum;
	private String mid;
	private String aid;
	private String ccontent;
	private Timestamp cdate;
	private String cip;
	public BcommentDto() {
		super();
	}
	public BcommentDto(int cnum, int bnum, String mid, String aid, String ccontent, Timestamp cdate, String cip) {
		super();
		this.cnum = cnum;
		this.bnum = bnum;
		this.mid = mid;
		this.ccontent = ccontent;
		this.cdate = cdate;
		this.cip = cip;
	}
	public int getCnum() {
		return cnum;
	}
	public void setCnum(int cnum) {
		this.cnum = cnum;
	}
	public int getBnum() {
		return bnum;
	}
	public void setBnum(int bnum) {
		this.bnum = bnum;
	}
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	public String getCcontent() {
		return ccontent;
	}
	public String getAid() {
		return aid;
	}
	public void setAid(String aid) {
		this.aid = aid;
	}
	public void setCcontent(String ccontent) {
		this.ccontent = ccontent;
	}
	public Timestamp getCdate() {
		return cdate;
	}
	public void setCdate(Timestamp cdate) {
		this.cdate = cdate;
	}
	public String getCip() {
		return cip;
	}
	public void setCip(String cip) {
		this.cip = cip;
	}
	@Override
	public String toString() {
		return "BcommentDto [cnum=" + cnum + ", bnum=" + bnum + ", mid=" + mid + ", aid=" + aid + ", ccontent="
				+ ccontent + ", cdate=" + cdate + ", cip=" + cip + "]";
	}
	
}
