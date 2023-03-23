package com.lec.exSec.service;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.exSec.dao.ExPartDao;
import com.lec.exSec.dto.ExPartDto;

public class PreExService implements Service {
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		ExPartDao eDao = ExPartDao.getInstance();
		ExPartDto epDto = new ExPartDto();
		ArrayList<ExPartDto> expart = eDao.forSelectEx(epDto);
		request.setAttribute("expart", expart);
	}
}
