package com.lec.exSec.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.lec.exSec.dao.InbodyDao;
import com.lec.exSec.dto.MemberDto;

public class InbodyModifyViewService implements Service {
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int inum = Integer.parseInt(request.getParameter("inum"));
		HttpSession session = request.getSession();
		MemberDto member = (MemberDto)session.getAttribute("member");
		String mid = "";
		if(member != null) {
			mid = member.getMid();
		}
		InbodyDao iDao = InbodyDao.getInstance();
		request.setAttribute("modifyInbody", iDao.modifyViewInbody(inum, mid));
	}
}
