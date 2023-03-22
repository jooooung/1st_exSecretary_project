package com.lec.exSec.service;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.exSec.dao.ExPartDao;
import com.lec.exSec.dto.ExPartDto;

public class exService implements Service {
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		String eppart = request.getParameter("eppart");
		ExPartDao epDao = ExPartDao.getInstance();
		ArrayList<ExPartDto> exPart = epDao.forSelectEx(eppart);
		request.setAttribute("exPart", exPart);
	}
}
