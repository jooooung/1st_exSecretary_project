package com.lec.exSec.service;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.lec.exSec.dao.BcommentDao;
import com.lec.exSec.dao.ExBoardDao;
import com.lec.exSec.dto.AdminDto;
import com.lec.exSec.dto.BcommentDto;
import com.lec.exSec.dto.ExBoardDto;
import com.lec.exSec.dto.MemberDto;

public class BCommentModifyViewService implements Service {
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int bnum = Integer.parseInt(request.getParameter("bnum"));
		ExBoardDao ebDao = ExBoardDao.getInstance();
		ExBoardDto ebDto = ebDao.contentExBoard(bnum);
		BcommentDao bDao = BcommentDao.getInstance();
		ArrayList<BcommentDto> bDto = bDao.getBcomment(bnum);
		request.setAttribute("exBoard", ebDto);
		request.setAttribute("comment", bDto);
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
			bnum = Integer.parseInt(request.getParameter("bnum"));
			int cnum = Integer.parseInt(request.getParameter("cnum"));
			BcommentDao bcDao = BcommentDao.getInstance();
			BcommentDto dto = bcDao.getBcommentOne(bnum, cnum); 
			request.setAttribute("BcommentModify", dto);
		}else {
			request.setAttribute("exBoardResult", "로그인 해주세요");
			return;
		}
	}
}
