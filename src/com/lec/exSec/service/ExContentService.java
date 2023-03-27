package com.lec.exSec.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.lec.exSec.dao.ExDao;
import com.lec.exSec.dao.InbodyDao;
import com.lec.exSec.dto.ExDto;
import com.lec.exSec.dto.InbodyDto;
import com.lec.exSec.dto.MemberDto;

public class ExContentService implements Service {
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		MemberDto member = (MemberDto)session.getAttribute("member");
		String mid = "";
		if(member != null) {
			mid = member.getMid();
		}
		int eno = Integer.parseInt(request.getParameter("eno"));
		ExDao eDao = ExDao.getInstance();
		ExDto eDto = eDao.contentEx(eno, mid);
		request.setAttribute("exContent", eDto);
	}
}
