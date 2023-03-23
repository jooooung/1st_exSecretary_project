package com.lec.exSec.service;

import java.sql.Date;
import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.lec.exSec.dao.ExDao;
import com.lec.exSec.dao.ExPartDao;
import com.lec.exSec.dao.MemberDao;
import com.lec.exSec.dto.ExDto;
import com.lec.exSec.dto.ExPartDto;
import com.lec.exSec.dto.MemberDto;

public class ExService implements Service {
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int eno = Integer.parseInt(request.getParameter("eno"));
		String mid = request.getParameter("mid");
		int epno = Integer.parseInt(request.getParameter("epno"));
		double eweight = Double.valueOf(request.getParameter("eweight"));
		int eset = Integer.parseInt(request.getParameter("eset"));
		int ecount = Integer.parseInt(request.getParameter("ecount"));
		String etimeStr = request.getParameter("etime");
		Date edate = new Date(System.currentTimeMillis());
		ExPartDto epDto = new ExPartDto();
		String ename = epDto.getEname();
		Timestamp etime = Timestamp.valueOf(etimeStr);
		ExDto ex = new ExDto(eno, mid, epno, eweight, eset, ecount, etime, edate, ename);
		request.setAttribute("ex", ex);
	}	
}
