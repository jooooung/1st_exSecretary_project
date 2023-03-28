package com.lec.exSec.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.lec.exSec.dao.AdminDao;
import com.lec.exSec.dao.ExPartDao;
import com.lec.exSec.dto.AdminDto;

public class ExPartModifyViewService implements Service {
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		AdminDto admin = (AdminDto)session.getAttribute("admin");
		String aid = "";
		if(admin != null) aid = admin.getAid();
		int epno = Integer.parseInt(request.getParameter("epno"));
		ExPartDao epDao = ExPartDao.getInstance();
		request.setAttribute("modifyExPart", epDao.contentExPart(epno));

	}
}
