package com.lec.exSec.service;

import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.lec.exSec.dao.BcommentDao;
import com.lec.exSec.dto.AdminDto;
import com.lec.exSec.dto.BcommentDto;
import com.lec.exSec.dto.MemberDto;

public class BCommentModifyService implements Service {
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		String ccontent = request.getParameter("ccontent");
		String cip = request.getRemoteAddr();
		int bnum = Integer.parseInt(request.getParameter("bnum"));
		int cnum = Integer.parseInt(request.getParameter("cnum"));
		Timestamp cdate = Timestamp.valueOf(request.getParameter("cdate"));
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
			BcommentDao bcDao = BcommentDao.getInstance();
			BcommentDto bcDto = new BcommentDto(cnum, bnum, mid, aid, ccontent, cdate, cip);
			int result = bcDao.modifyBcomment(bcDto);
			if(result == BcommentDao.SUCCESS) {
				request.setAttribute("BcommentModify", "댓글 수정 성공");
			}else {
				request.setAttribute("BcommentModify", "댓글 수정 실패");
			}
		}else {
			request.setAttribute("exBoardResult", "로그인 해주세요");
			
		}
	}
}
