package com.lec.exSec.dto;

import java.sql.Timestamp;

public class ExBoardDto {
	private int bnum;
	private String mid;
	private String aid;
	private String btitle;
	private String bcontent;
	private String bphoto;
	private Timestamp bdate;
	private int bhit;
	private int bgroup;
	private int bstep;
	private int bindent;
	private String bip;
	private String writer;	// join
	public ExBoardDto() {
		super();
	}
	public ExBoardDto(int bnum, String mid, String aid, String btitle, String bcontent, String bphoto, Timestamp bdate,
			int bhit, int bgroup, int bstep, int bindent, String bip, String writer) {
		super();
		this.bnum = bnum;
		this.mid = mid;
		this.aid = aid;
		this.btitle = btitle;
		this.bcontent = bcontent;
		this.bphoto = bphoto;
		this.bdate = bdate;
		this.bhit = bhit;
		this.bgroup = bgroup;
		this.bstep = bstep;
		this.bindent = bindent;
		this.bip = bip;
		this.writer = writer;
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
	public String getAid() {
		return aid;
	}
	public void setAid(String aid) {
		this.aid = aid;
	}
	public String getBtitle() {
		return btitle;
	}
	public void setBtitle(String btitle) {
		this.btitle = btitle;
	}
	public String getBcontent() {
		return bcontent;
	}
	public void setBcontent(String bcontent) {
		this.bcontent = bcontent;
	}
	public String getBphoto() {
		return bphoto;
	}
	public void setBphoto(String bphoto) {
		this.bphoto = bphoto;
	}
	public Timestamp getBdate() {
		return bdate;
	}
	public void setBdate(Timestamp bdate) {
		this.bdate = bdate;
	}
	public int getBhit() {
		return bhit;
	}
	public void setBhit(int bhit) {
		this.bhit = bhit;
	}
	public int getBgroup() {
		return bgroup;
	}
	public void setBgroup(int bgroup) {
		this.bgroup = bgroup;
	}
	public int getBstep() {
		return bstep;
	}
	public void setBstep(int bstep) {
		this.bstep = bstep;
	}
	public int getBindent() {
		return bindent;
	}
	public void setBindent(int bindent) {
		this.bindent = bindent;
	}
	public String getBip() {
		return bip;
	}
	public void setBip(String bip) {
		this.bip = bip;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	@Override
	public String toString() {
		return "ExBoardDto [bnum=" + bnum + ", mid=" + mid + ", aid=" + aid + ", btitle=" + btitle + ", bcontent="
				+ bcontent + ", bphoto=" + bphoto + ", bdate=" + bdate + ", bhit=" + bhit + ", bgroup=" + bgroup
				+ ", bstep=" + bstep + ", bindent=" + bindent + ", bip=" + bip + ", writer=" + writer + "]";
	}
}
