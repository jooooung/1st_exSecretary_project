package com.lec.exSec.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.exSec.dao.ExBoardDao;

public class ExBoardReplyViewService implements Service {
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int bnum = Integer.parseInt(request.getParameter("bnum"));
		ExBoardDao ebDao = ExBoardDao.getInstance();
		request.setAttribute("modifyExboard", ebDao.modifyViewExBoard_replyViewExBoard(bnum));
	}
}
