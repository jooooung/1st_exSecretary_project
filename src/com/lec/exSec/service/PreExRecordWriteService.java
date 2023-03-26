package com.lec.exSec.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.lec.exSec.dao.ExPartDao;
import com.lec.exSec.dto.ExPartDto;

public class PreExRecordWriteService implements Service {
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		ExPartDao epDao = ExPartDao.getInstance();
		ExPartDto expart = new ExPartDto();
		request.setAttribute("expart", epDao.forSelectEx(expart));
	}
}
