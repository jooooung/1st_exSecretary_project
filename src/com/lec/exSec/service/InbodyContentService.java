package com.lec.exSec.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.lec.exSec.dao.InbodyDao;
import com.lec.exSec.dto.InbodyDto;
import com.lec.exSec.dto.MemberDto;

public class InbodyContentService implements Service {
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		MemberDto member = (MemberDto)session.getAttribute("member");
		String mid = "";
		if(member != null) {
			mid = member.getMid();
		}
		int inum = Integer.parseInt(request.getParameter("inum"));
		InbodyDao iDao = InbodyDao.getInstance();
		InbodyDto iDto = iDao.contentInbody(inum, mid);
		request.setAttribute("inbody", iDto);
	}
}
