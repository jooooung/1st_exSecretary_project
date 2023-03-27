package com.lec.exSec.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.lec.exSec.dao.InbodyDao;
import com.lec.exSec.dto.MemberDto;

public class InbodyDeleteService implements Service {
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int inum = Integer.parseInt(request.getParameter("inum"));
		HttpSession session = request.getSession();
		MemberDto member = (MemberDto) session.getAttribute("member");
		String mid = "";
		if(member != null) {
			mid = member.getMid();
		}
		InbodyDao iDao = InbodyDao.getInstance();
		int result = iDao.deleteInbody(inum, mid);
		if(result == InbodyDao.SUCCESS) {
			request.setAttribute("inbodyDeleteResult", "기록 삭제 성공");
		}else {
			request.setAttribute("inbodyDeleteError", "기록 삭제 실패");
		}
	}	
}
