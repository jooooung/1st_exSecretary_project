package com.lec.exSec.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.lec.exSec.dao.ExDao;
import com.lec.exSec.dto.MemberDto;

public class ExRecordDeleteService implements Service {
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		String enoStr = request.getParameter("eno");
		if(enoStr == null) {
			enoStr = "0";
		}
		int eno = Integer.parseInt(enoStr);
		HttpSession session = request.getSession();
		MemberDto member = (MemberDto) session.getAttribute("member");
		String mid = "";
		if(member != null) {
			mid = member.getMid();
		}
		ExDao eDao = ExDao.getInstance();
		int result = eDao.deleteExRecord(eno, mid);
		if(result == ExDao.SUCCESS) {
			request.setAttribute("exRecordDeleteResult", "삭제 성공");
		}
	}
}
