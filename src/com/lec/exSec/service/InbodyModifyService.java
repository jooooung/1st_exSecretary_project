package com.lec.exSec.service;

import java.sql.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.lec.exSec.dao.InbodyDao;
import com.lec.exSec.dto.InbodyDto;
import com.lec.exSec.dto.MemberDto;

public class InbodyModifyService implements Service {
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int inum = Integer.parseInt(request.getParameter("inum"));
		HttpSession session = request.getSession();
		MemberDto member = (MemberDto) session.getAttribute("member");
		String mid = "";
		if(member != null) {
			mid = member.getMid();
		}
		double iweight = Double.valueOf(request.getParameter("iweight"));
		double ifat = Double.valueOf(request.getParameter("ifat"));
		double imuscle = Double.valueOf(request.getParameter("imuscle"));
		Date idate = Date.valueOf(request.getParameter("idate"));
		InbodyDao iDao = InbodyDao.getInstance();
		InbodyDto dto = new InbodyDto(inum, mid, iweight, ifat, imuscle, idate);
		int result = iDao.modifyInbody(dto);
		if(result == InbodyDao.SUCCESS) {
			request.setAttribute("inbodyModifyResult", "수정 성공");
		}else {
			request.setAttribute("inbodyModifyError", "수정 실패");
		}
	}
}
