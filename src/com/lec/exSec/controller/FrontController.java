package com.lec.exSec.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.exSec.service.ALoginService;
import com.lec.exSec.service.ExRecordListService;
import com.lec.exSec.service.ExRecordWriteService;
import com.lec.exSec.service.ExService;
import com.lec.exSec.service.JoinService;
import com.lec.exSec.service.LoginService;
import com.lec.exSec.service.MLogoutService;
import com.lec.exSec.service.MemberModifyService;
import com.lec.exSec.service.MidConfirmService;
import com.lec.exSec.service.Service;
import com.lec.exSec.service.PreExService;

@WebServlet("*.do")
public class FrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private int join = 0;
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
		/* * * * * * * * * * * * member * * * * * * * * * * * */
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
			join = 1;
		}else if(command.equals("/midConfirm.do")) {  // 아이디 중복체크
			service = new MidConfirmService();
			service.execute(request, response);
			viewPage = "member/midConfirm.jsp";
		}else if(command.equals("/join.do")) {  // 회원가입 저장
			if(join == 1) {
				service = new JoinService();
				service.execute(request, response);
				join = 0;
			}
			viewPage = "loginView.do";
		}else if(command.equals("/memberView.do")){		// 마이페이지(정보수정)
			viewPage = "member/memberView.jsp";
		}else if(command.equals("/modify.do")){		// 정보 수정 처리
			service = new MemberModifyService();
			service.execute(request, response);
			viewPage = "memberView.do"; 
		}else if(command.equals("/logout.do")) {	// 로그아웃
			service = new MLogoutService();
			service.execute(request, response);
			viewPage = "main.do";
		}else if(command.equals("/aLoginView.do")) {	// admin 로그인 페이지
			viewPage = "admin/adminLogin.jsp";
		}else if(command.equals("/aLogin.do")) {	// admin 로그인 처리
			service = new ALoginService();
			service.execute(request, response);
			viewPage = "main.do";
		}else if(command.equals("/exView.do")) {	// 운동하기 페이지
			service = new PreExService();
			service.execute(request, response);
			viewPage = "ex/ex.jsp";
		}else if(command.equals("/ex.do")) {	// 운동하기에서 한 운동 저장
			service = new ExService();
			service.execute(request, response);
			viewPage = "exRecordList.do";
		}else if(command.equals("/exRecordList.do")) {	// 운동기록 목록
			service = new ExRecordListService();
			service.execute(request, response);
			viewPage = "ex/exRecordList.jsp"; 
		}else if(command.equals("/exRecordWriteView.do")) {		// 운동기록 등록페이지
			viewPage = "ex/exRecordWrite.jsp";
		}else if(command.equals("/exRecordWrite.do")) {	// 운동기록 등록 저장
			service = new ExRecordWriteService();
			service.execute(request, response);
			viewPage = "exRecordList.do";
		}
			
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
