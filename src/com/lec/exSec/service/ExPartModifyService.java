package com.lec.exSec.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.exSec.dao.ExPartDao;
import com.lec.exSec.dto.ExPartDto;

public class ExPartModifyService implements Service {
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int epno = Integer.parseInt(request.getParameter("epno"));
		String eppart = request.getParameter("eppart");
		String ename = request.getParameter("ename");
		ExPartDao epDao = ExPartDao.getInstance();
		ExPartDto dto = new ExPartDto(epno, eppart, ename);
		int result = epDao.modifyExPart(dto);
		if(result == ExPartDao.SUCCESS) {
			request.setAttribute("expartModifyResult", "운동 수정 성공");
		}else {
			request.setAttribute("expartModifyError", "운동 수정 실패");
		}
	}
}
