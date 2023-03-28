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
		String mid = "";
		if(member != null) {
			mid = member.getMid();
		}
		int epno = Integer.parseInt(request.getParameter("expart"));
		double eweight = Double.valueOf(request.getParameter("eweight"));
		int eset = Integer.parseInt(request.getParameter("eset"));
		int ecount = Integer.parseInt(request.getParameter("ecount"));
		String ehourStr = request.getParameter("ehour");
		if(ehourStr == "") ehourStr = "00";
		int ehour = Integer.parseInt(ehourStr);
		String eminStr = request.getParameter("emin");
		if(eminStr == "") eminStr = "00";
		int emin = Integer.parseInt(eminStr);
		String esecStr = request.getParameter("esec");
		if(esecStr == "") esecStr = "00";
		int esec = Integer.parseInt(esecStr);
		Date edate = new Date(System.currentTimeMillis());
		String ename = request.getParameter("ename");
		ExDao eDao = ExDao.getInstance();
		ExDto eDto = new ExDto(0, mid, epno, eweight, eset, ecount, ehour, emin, esec, edate, ename);
		int result = eDao.writeEx(eDto);
		if(result == ExDao.SUCCESS) {
			request.setAttribute("exRecordWriteResult", "운동기록 등록 성공");
		}else {
			request.setAttribute("exRecordWriteError", "운동기록 등록 실패");
		}
	}
}
