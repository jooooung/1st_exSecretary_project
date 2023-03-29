package com.lec.exSec.service;

import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.lec.exSec.dao.BcommentDao;
import com.lec.exSec.dto.AdminDto;
import com.lec.exSec.dto.BcommentDto;
import com.lec.exSec.dto.MemberDto;

public class BCommentService implements Service {
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
			int bnum = Integer.parseInt(request.getParameter("bnum"));
			String ccontent = request.getParameter("ccontent");
			Timestamp cdate = new Timestamp(System.currentTimeMillis());
			String cip = request.getRemoteAddr();
			BcommentDao bcDao = BcommentDao.getInstance();
			BcommentDto dto = new BcommentDto(0, bnum, mid, aid, ccontent, cdate, cip); 
			request.setAttribute("BcommentResult", bcDao.writeBcomment(dto));
		}else {
			request.setAttribute("exBoardResult", "로그인 해주세요");
			return;
		}
	}
}
