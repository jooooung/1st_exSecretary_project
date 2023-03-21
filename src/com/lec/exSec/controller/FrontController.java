package com.lec.exSec.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.exSec.service.JoinService;
import com.lec.exSec.service.LoginService;
import com.lec.exSec.service.MidConfirmService;
import com.lec.exSec.service.Service;

@WebServlet("*.do")
public class FrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		actionDo(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		actionDo(request, response);
	}
	private void actionDo(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
		String uri = request.getRequestURI();
		String conPath = request.getContextPath();
		String command = uri.substring(conPath.length());
		String viewPage = null;
		Service service = null;
		if(command.equals("/main.do")) {	// 메인페이지
			viewPage = "main/main.jsp";
		}else if(command.equals("/loginView.do")) {	// member 로그인 페이지
			viewPage = "member/login.jsp";
		}else if(command.equals("/login.do")) {		// 로그인 처리
			service = new LoginService();
			service.execute(request, response);
			viewPage = "main.do";
		}else if(command.equals("/joinView.do")) {	// 회원가입 페이지
			viewPage = "member/join.jsp";
		}else if(command.equals("/midConfirm.do")) {  // 아이디 중복체크
			service = new MidConfirmService();
			service.execute(request, response);
			viewPage = "member/midConfirm.jsp";
		}else if(command.equals("/join.do")) {  // 회원가입 저장
			service = new JoinService();
			service.execute(request, response);
			viewPage = "loginView.do";
		}
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}