package com.lec.exSec.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.lec.exSec.dao.InbodyDao;
import com.lec.exSec.dto.MemberDto;

public class InbodyListService implements Service {
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		InbodyDao iDao = InbodyDao.getInstance();
		HttpSession session = request.getSession();
		MemberDto member = (MemberDto) session.getAttribute("member");
		String mid = "";
		if(member != null) {
			mid = member.getMid();
		}
		request.setAttribute("inbody", iDao.listInbody(mid));
	}
}
