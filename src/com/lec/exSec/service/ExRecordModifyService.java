package com.lec.exSec.service;

import java.sql.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.lec.exSec.dao.ExDao;
import com.lec.exSec.dto.ExDto;
import com.lec.exSec.dto.MemberDto;

public class ExRecordModifyService implements Service {
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		MemberDto member = (MemberDto) session.getAttribute("member");
		String mid = "";
		if(member != null) {
			mid = member.getMid();
		}
		int eno = Integer.parseInt(request.getParameter("eno"));
		int epno = Integer.parseInt(request.getParameter("epno"));
		String ename = request.getParameter("ename");
		double eweight = Double.valueOf(request.getParameter("eweight"));
		int eset = Integer.parseInt(request.getParameter("eset"));
		int ecount = Integer.parseInt(request.getParameter("ecount"));
		String ehourStr = request.getParameter("ehour");
		if(ehourStr == "00") ehourStr = null;
		int ehour = Integer.parseInt(ehourStr);
		String eminStr = request.getParameter("emin");
		if(eminStr == "00" && ehourStr == "00") ehourStr = null;
		int emin = Integer.parseInt(eminStr);
		String esecStr = request.getParameter("esec");
		if(esecStr == "00") ehourStr = null;
		int esec = Integer.parseInt(ehourStr);
		Date edate = Date.valueOf(request.getParameter("edate"));
		ExDao eDao = ExDao.getInstance();
		ExDto eDto = new ExDto(eno, mid, epno, eweight, eset, ecount, ehour, emin, esec, edate, ename);
		int result = eDao.modifyEx(eDto);
		if(result == ExDao.SUCCESS) {
			request.setAttribute("exRecordModifyResult", "운동기록 수정 성공");
		}else {
			request.setAttribute("exRecordModifyError", "운동기록 수정 실패");
		}
	}
}
