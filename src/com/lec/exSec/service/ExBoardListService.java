package com.lec.exSec.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.exSec.dao.BcommentDao;
import com.lec.exSec.dao.ExBoardDao;
import com.lec.exSec.dto.ExBoardDto;

public class ExBoardListService implements Service {
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		String pageNum = request.getParameter("pageNum");
		if(pageNum == null) {
			if(request.getAttribute("pageNum") != null) {
				pageNum = (String)request.getAttribute("pageNum");
			}else {
				pageNum = "1";
			}
		}
		int currentPage = Integer.parseInt(pageNum);
		final int PAGESIZE = 10, BLOCKSIZE = 10;
		int startRow = (currentPage - 1) * PAGESIZE + 1;
		int endRow = startRow + PAGESIZE - 1;  
		ExBoardDao ebDao = ExBoardDao.getInstance();
		request.setAttribute("exBoardList", ebDao.listExBoard(startRow, endRow));
		int totCnt = ebDao.getExBoardTotCnt();
		int pageCnt = (int)Math.ceil((double)totCnt / PAGESIZE);
		int startPage = ((currentPage - 1) / BLOCKSIZE) * BLOCKSIZE + 1;
		int endPage = startPage + BLOCKSIZE - 1;
		if(endPage > pageCnt) endPage = pageCnt;
		request.setAttribute("pageNum", currentPage);
		request.setAttribute("pageCnt", pageCnt);
		request.setAttribute("BLOCKSIZE", BLOCKSIZE);
		request.setAttribute("startPage", startPage);
		request.setAttribute("endPage", endPage);
		request.setAttribute("totCnt", totCnt);		
	}
}
