package com.lec.exSec.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.lec.exSec.dao.BcommentDao;
import com.lec.exSec.dto.AdminDto;
import com.lec.exSec.dto.MemberDto;

public class BCommentDeleteService implements Service {
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		HttpSession httpSession = request.getSession();
		MemberDto member = (MemberDto)httpSession.getAttribute("member");	// id가져오기 위한 member
		AdminDto admin = (AdminDto)httpSession.getAttribute("admin");	// id가져오기 위한 admin
		if(member != null || admin != null) {
			String mid = "";
			if(member != null) {
				mid = member.getMid();
			}
			String aid = "";
			if(admin != null) {
				aid = admin.getAid();
			}
			int cnum = Integer.parseInt(request.getParameter("cnum"));
			BcommentDao bcDao = BcommentDao.getInstance();
			request.setAttribute("deleteComment", bcDao.deleteBcomment(cnum, mid, aid));
		}
	}
}
