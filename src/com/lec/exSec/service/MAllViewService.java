package com.lec.exSec.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.exSec.dao.MemberDao;

public class MAllViewService implements Service {
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		String pageNum = request.getParameter("pageNum");
		if(pageNum== null) pageNum = "1";
		int currentPage = Integer.parseInt(pageNum);
		final int PAGESIZE = 3 , BLOCKSIZE = 5;
		int startRow = (currentPage - 1) * PAGESIZE + 1;
		int endRow = startRow + PAGESIZE - 1;
		MemberDao mDao = new MemberDao();
		request.setAttribute("members", mDao.getMemberlist(startRow, endRow)); 
		int totCnt = mDao.getMemberTotCnt();
		int pageCnt = (int)Math.ceil((double)totCnt / PAGESIZE);
		int startPage = ((currentPage - 1) / BLOCKSIZE) * BLOCKSIZE + 1;
		int endPage = startPage + BLOCKSIZE - 1;
		if(endPage > pageCnt) {
			endPage = pageCnt;
		}
		request.setAttribute("BLOCKSIZE", BLOCKSIZE);	
		request.setAttribute("startPage", startPage);	
		request.setAttribute("endPage", endPage);	
		request.setAttribute("pageCnt", pageCnt);	
		request.setAttribute("pageNum", currentPage);	

	}
}
