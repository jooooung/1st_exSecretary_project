package com.lec.exSec.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.exSec.dao.ExPartDao;

public class ExPartDeleteService implements Service {
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int epno = Integer.parseInt(request.getParameter("epno"));
		ExPartDao epDao = ExPartDao.getInstance();
		int result = epDao.deleteExPart(epno);
		System.out.println(epno);
		if(result == ExPartDao.SUCCESS) {
			request.setAttribute("deleteExPartResult", "삭제 성공");
		}else {
			request.setAttribute("deleteExPartError", "삭제 실패, 이운동을 사용한 운동기록이 있습니다");
		}
	}
}
