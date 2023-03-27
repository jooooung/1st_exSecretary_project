package com.lec.exSec.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.lec.exSec.dao.ExDao;
import com.lec.exSec.dto.MemberDto;

public class exRecordDeleteService implements Service {
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int eno = Integer.parseInt(request.getParameter("eno"));
		HttpSession session = request.getSession();
		MemberDto member = (MemberDto) session.getAttribute("member");
		String mid = "";
		if(member != null) {
			mid = member.getMid();
		}
		ExDao eDao = ExDao.getInstance();
		int result = eDao.deleteExRecord(eno, mid);
		if(result == ExDao.SUCCESS) {
			request.setAttribute("exRecordDeleteResult", "운동기록 삭제 성공");
		}else {
			request.setAttribute("exRecordDeleteError", "운동기록 삭제 실패");
		}
	}
}
