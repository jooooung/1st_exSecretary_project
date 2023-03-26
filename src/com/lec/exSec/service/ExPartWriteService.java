package com.lec.exSec.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.exSec.dao.ExPartDao;
import com.lec.exSec.dto.ExPartDto;

public class ExPartWriteService implements Service {
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int epno = 0;
		String eppart = request.getParameter("eppart");
		String ename = request.getParameter("ename");
		ExPartDao epDao = ExPartDao.getInstance();
		ExPartDto dto = new ExPartDto(epno, eppart, ename);
		int result = epDao.writeExPart(dto);
		if(result == ExPartDao.SUCCESS) {
			request.setAttribute("exPartWriteResult", "운동 등록 완료");
		}else {
			request.setAttribute("exPartWriteError", "운동 등록 실패");
		}
	}
}
