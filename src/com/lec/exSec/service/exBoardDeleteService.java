package com.lec.exSec.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.exSec.dao.ExBoardDao;

public class ExBoardDeleteService implements Service {
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int bnum = Integer.parseInt(request.getParameter("bnum"));
		ExBoardDao ebDao = ExBoardDao.getInstance();
		int result = ebDao.deleteExBoard(bnum);
		if(result == ExBoardDao.SUCCESS) {
			request.setAttribute("exBoardResult", "글 삭제 성공");
		}else {
			request.setAttribute("exBoardError", "글 삭제 실패");
		}
	}
}
