package com.lec.exSec.service;

import java.sql.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.lec.exSec.dao.ExDao;
import com.lec.exSec.dto.ExDto;
import com.lec.exSec.dto.MemberDto;

public class ExService implements Service {
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		MemberDto member = (MemberDto) session.getAttribute("member");
		String mid = "";
		if(member != null) {
			mid = member.getMid();
		}
		String[] epnoStr = request.getParameterValues("expart");
		int[] epnoArr = new int[epnoStr.length];
		int epno = 0;
		for (int i = 0; i < epnoStr.length; i++) {
			epnoArr[i] = Integer.parseInt(epnoStr[i]);
			epno += epnoArr[i];
		}
		String eweightStr = request.getParameter("eweight");
		if(eweightStr == null) eweightStr = "0";
		double eweight = Double.valueOf(eweightStr);
		int eset = Integer.parseInt(request.getParameter("eset"));
		int ecount = Integer.parseInt(request.getParameter("ecount"));
		int ehour = Integer.parseInt(request.getParameter("ehour"));
		int emin = Integer.parseInt(request.getParameter("emin"));
		int esec = Integer.parseInt(request.getParameter("esec"));
		Date edate = new Date(System.currentTimeMillis());
		String ename = request.getParameter("ename");
		ExDao eDao = ExDao.getInstance();
		ExDto ex = new ExDto(0, mid, epno, eweight, eset, ecount, ehour, emin, esec, edate, ename);
		int result = eDao.writeEx(ex);
		if(result == ExDao.SUCCESS) {
			request.setAttribute("exResult", "오늘의 운동 완료!");
		}else {
			request.setAttribute("exFailResult", "운동을 완료하지 못했습니다");
		}
	}
}
