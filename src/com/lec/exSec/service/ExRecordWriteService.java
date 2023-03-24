package com.lec.exSec.service;

import java.sql.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.lec.exSec.dao.ExDao;
import com.lec.exSec.dto.ExDto;
import com.lec.exSec.dto.MemberDto;

public class ExRecordWriteService implements Service {
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		
		HttpSession session = request.getSession();
		MemberDto member = (MemberDto) session.getAttribute("member");
		
		String mid = member.getMid();
		int epno = Integer.parseInt(request.getParameter("epno"));
		String expart = request.getParameter("expart");
		double eweight = Double.valueOf(request.getParameter("eweight"));
		int eset = Integer.parseInt(request.getParameter("eset"));
		int ecount = Integer.parseInt(request.getParameter("ecount"));
		Date edate = new Date(System.currentTimeMillis());
		String ename = request.getParameter("ename");
		ExDto eDto = new ExDto(0, mid, epno, eweight, eset, ecount, null, edate, ename);
	}
}
