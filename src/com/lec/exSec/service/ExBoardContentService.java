package com.lec.exSec.service;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.exSec.dao.BcommentDao;
import com.lec.exSec.dao.ExBoardDao;
import com.lec.exSec.dto.BcommentDto;
import com.lec.exSec.dto.ExBoardDto;

public class ExBoardContentService implements Service {
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int bnum = Integer.parseInt(request.getParameter("bnum"));
		ExBoardDao ebDao = ExBoardDao.getInstance();
		ExBoardDto ebDto = ebDao.contentExBoard(bnum);
		BcommentDao bDao = BcommentDao.getInstance();
		ArrayList<BcommentDto> bDto = bDao.getBcomment(bnum);
		request.setAttribute("exBoard", ebDto);
		request.setAttribute("comment", bDto);
	}
}
