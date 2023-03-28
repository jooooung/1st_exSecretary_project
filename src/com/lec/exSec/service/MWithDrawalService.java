package com.lec.exSec.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.lec.exSec.dao.BcommentDao;
import com.lec.exSec.dao.ExBoardDao;
import com.lec.exSec.dao.ExDao;
import com.lec.exSec.dao.InbodyDao;
import com.lec.exSec.dao.MemberDao;
import com.lec.exSec.dto.MemberDto;

public class MWithDrawalService implements Service {
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		MemberDto member = (MemberDto) session.getAttribute("member");
		String mid = "";
		if(member != null) {
			mid = member.getMid();
		}
		ExBoardDao ebDao = ExBoardDao.getInstance();
		ebDao.deleteWithDExBoard(mid);
		BcommentDao bDao = BcommentDao.getInstance();
		bDao.deleteWithDBcomment(mid);
		InbodyDao iDao = InbodyDao.getInstance();
		iDao.deleteWithDInbody(mid);
		ExDao eDao = ExDao.getInstance();
		eDao.deleteWithDExBoard(mid);
		MemberDao mDao = MemberDao.getInstance();
		int result = mDao.withdrawalMember(mid);
		session.invalidate();
		if(result == MemberDao.SUCCESS) {
			request.setAttribute("withdrawalResult", "회원 탈퇴가 완료되었습니다.");
		}else {
			request.setAttribute("withdrawalResult", "로그인 상태가 아닙니다.");
		}
	}
}
