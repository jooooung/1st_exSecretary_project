package com.lec.exSec.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.exSec.dao.ExBoardDao;
import com.lec.exSec.dto.ExBoardDto;

public class exBoardModifyViewService implements Service {
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int bnum = Integer.parseInt(request.getParameter("bnum"));
		ExBoardDao ebDao = ExBoardDao.getInstance();
		ExBoardDto ebDto = ebDao.modifyViewExBoard_replyViewExBoard(bnum);
		request.setAttribute("exboard", ebDto);
	}
}
