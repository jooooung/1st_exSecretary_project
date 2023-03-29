package com.lec.exSec.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.exSec.service.ALoginService;
import com.lec.exSec.service.BCommentDeleteService;
import com.lec.exSec.service.BCommentModifyService;
import com.lec.exSec.service.BCommentModifyViewService;
import com.lec.exSec.service.BCommentService;
import com.lec.exSec.service.ExBoardContentService;
import com.lec.exSec.service.ExBoardListService;
import com.lec.exSec.service.ExBoardReplyService;
import com.lec.exSec.service.ExBoardReplyViewService;
import com.lec.exSec.service.ExBoardWriteService;
import com.lec.exSec.service.ExContentService;
import com.lec.exSec.service.ExPartDeleteService;
import com.lec.exSec.service.ExPartListService;
import com.lec.exSec.service.ExPartModifyService;
import com.lec.exSec.service.ExPartModifyViewService;
import com.lec.exSec.service.ExPartWriteService;
import com.lec.exSec.service.ExRecordListService;
import com.lec.exSec.service.ExRecordModifyService;
import com.lec.exSec.service.ExRecordModifyViewService;
import com.lec.exSec.service.ExRecordWriteService;
import com.lec.exSec.service.ExService;
import com.lec.exSec.service.InbodyContentService;
import com.lec.exSec.service.InbodyDeleteService;
import com.lec.exSec.service.InbodyListService;
import com.lec.exSec.service.InbodyModifyService;
import com.lec.exSec.service.InbodyModifyViewService;
import com.lec.exSec.service.JoinService;
import com.lec.exSec.service.LoginService;
import com.lec.exSec.service.MAllViewService;
import com.lec.exSec.service.MLogoutService;
import com.lec.exSec.service.MWithDrawalService;
import com.lec.exSec.service.MemberModifyService;
import com.lec.exSec.service.MidConfirmService;
import com.lec.exSec.service.PreExRecordWriteService;
import com.lec.exSec.service.Service;
import com.lec.exSec.service.ExBoardDeleteService;
import com.lec.exSec.service.ExBoardModifyService;
import com.lec.exSec.service.ExBoardModifyViewService;
import com.lec.exSec.service.ExRecordDeleteService;
import com.lec.exSec.service.inbodyWriteService;
import com.lec.exSec.service.PreExService;

@WebServlet("*.do")
public class FrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private int result = 0;
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
		/* * * * * * * * * * * * * * * * * * * * * * * * * * * */
		
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
			result = 1;
		}else if(command.equals("/midConfirm.do")) {  // 아이디 중복체크
			service = new MidConfirmService();
			service.execute(request, response);
			viewPage = "member/midConfirm.jsp";
		}else if(command.equals("/join.do")) {  // 회원가입 저장
			if(result== 1) {
				service = new JoinService();
				service.execute(request, response);
				result= 0;
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
		}else if(command.equals("/memberWithDrawal.do")) {
			service = new MWithDrawalService();
			service.execute(request, response);
			viewPage = "main.do";
		/* * * * * * * * * * * * member-운동하기 * * * * * * * * * * * */	
		}else if(command.equals("/exView.do")) {	// 운동하기 페이지
			service = new PreExService();
			service.execute(request, response);
			result = 1;
			viewPage = "ex/ex.jsp";
		}else if(command.equals("/ex.do")) {	// 운동하기에서 한 운동 저장
			if(result == 1) {
				service = new ExService();
				service.execute(request, response);
				result = 0;
			}
			viewPage = "exRecordList.do";
		/* * * * * * * * * * * * member-운동기록 * * * * * * * * * * * */
		}else if(command.equals("/exRecordList.do")) {	// 운동기록 목록
			service = new ExRecordListService();
			service.execute(request, response);
			viewPage = "ex/exRecordList.jsp"; 
		}else if(command.equals("/exContent.do")) {	// 운동기록 상세보기
			service = new ExContentService();
			service.execute(request, response);
			viewPage = "ex/exContent.jsp"; 
		}else if(command.equals("/exRecordModifyView.do")) {		// 특정 운동기록 수정 페이지 
			service = new ExRecordModifyViewService();
			service.execute(request, response);
			viewPage = "ex/exRecordMoidfy.jsp";
			result = 1;
		}else if(command.equals("/exRecordModify.do")) {		// 특정 운동기록 수정 저장 
			if(result == 1) {
				service = new ExRecordModifyService();
				service.execute(request, response);
				result = 0;
			}
			viewPage = "exContent.do";
		}else if(command.equals("/exRecordWriteView.do")) {		// 운동기록 등록페이지
			service = new PreExRecordWriteService();
			service.execute(request, response);
			viewPage = "ex/exRecordWrite.jsp";
			result = 1;
		}else if(command.equals("/exRecordWrite.do")) {	// 운동기록 등록 저장
			if(result == 1) {
				service = new ExRecordWriteService();
				service.execute(request, response);
				result = 0;
			}
			viewPage = "exRecordList.do";
		}else if(command.equals("/exRecordDelete.do")){	// 특정 운동기록 삭제
			service = new ExRecordDeleteService();
			service.execute(request, response);
			viewPage = "exRecordList.do";
			/* * * * * * * * * * * * member-나의 변화 * * * * * * * * * * * */
		}else if(command.equals("/inbodyList.do")) {	// 나의 변화 페이지
			service = new InbodyListService();
			service.execute(request, response);
			viewPage = "inbody/inbodyList.jsp";
		}else if(command.equals("/inbodyWriteView.do")){	// 나의 변화 추가 페이지
			viewPage = "inbody/inbodyWrite.jsp";
			result = 1;
		}else if(command.equals("/inbodyWrite.do")) {	// 추가한 나의 변화 저장
			if(result == 1) {
				service = new inbodyWriteService();
				service.execute(request, response);
				result = 0;
			}
			viewPage = "inbodyList.do";
		}else if(command.equals("/inbodyContent.do")) {	// 특정 나의 변화 상세보기
			service = new InbodyContentService();
			service.execute(request, response);
			viewPage = "inbody/inbodyContent.jsp";
		}else if(command.equals("/inbodyModifyView.do")){	// 나의변화 수정하기 페이지
			service = new InbodyModifyViewService();
			service.execute(request, response);
			viewPage = "inbody/inbodyModify.jsp";
		}else if(command.equals("/inbodyModify.do")){	// 나의변화 수정 저장
			service = new InbodyModifyService();
			service.execute(request, response);
			viewPage = "inbodyList.do";
		}else if(command.equals("/inbodyDelete.do")){	// 나의변화 삭제
			service = new InbodyDeleteService();
			service.execute(request, response);
			viewPage = "inbodyList.do";
		}
		/* * * * * * * * * * * * admin * * * * * * * * * * * */
		/* * * * * * * * * * * * * * * * * * * * * * * * * * * */
		
		 else if(command.equals("/aLoginView.do")) {	// admin 로그인 페이지
			viewPage = "admin/adminLogin.jsp";
		}else if(command.equals("/aLogin.do")) {	// admin 로그인 처리
			service = new ALoginService();
			service.execute(request, response);
			viewPage = "main.do";
		}else if(command.equals("/exPartList.do")) {	// 운동 목록
			service = new ExPartListService();
			service.execute(request, response);
			viewPage = "exPart/listExPart.jsp";
		}else if(command.equals("/exPartWriteView.do")) {	// 새 운동 등록 페이지
			viewPage = "exPart/exPartwrite.jsp";
			result = 1;
		}else if(command.equals("/exPartWrite.do")) {	// 새 운동 저장
			if(result == 1) {
				service = new ExPartWriteService();
				service.execute(request, response);
				result = 0;
			}
			viewPage = "exPartList.do";
		}else if(command.equals("/exPartModifyView.do")) {	// 운동 수정 페이지
			service = new ExPartModifyViewService();
			service.execute(request, response);
			viewPage = "exPart/exPartModify.jsp";
			result = 1;
		}else if(command.equals("/exPartModify.do")) {	// 운동 수정 저장
			if(result == 1) {
				service = new ExPartModifyService();
				service.execute(request, response);
				result = 0;
			}
			viewPage = "exPartList.do";
		}else if(command.equals("/exPartDelete.do")) {	// 운동 삭제
			service = new ExPartDeleteService();
			service.execute(request, response);
			viewPage = "exPartList.do";
		}else if(command.equals("/mAllView.do")) {	// 회원 목록
			service = new MAllViewService();
			service.execute(request, response);
			viewPage = "admin/mAllView.jsp";
			
		/* * * * * * * * * * * * exBoard * * * * * * * * * * * */
		/* * * * * * * * * * * * * * * * * * * * * * * * * * * */
			
		}else if(command.equals("/exBoardList.do")) {	// 자유게시판 목록 
			service = new ExBoardListService();
			service.execute(request, response);
			viewPage = "exBoard/exBoardList.jsp";
		}else if(command.equals("/exBoardContentView.do")) {	// 글 상세보기
			service = new ExBoardContentService();
			service.execute(request, response);
			viewPage = "exBoard/exBoardContent.jsp";
		}else if(command.equals("/exBoardWriteView.do")) {	// 글 쓰기
			viewPage = "exBoard/exBoardWrite.jsp";
			result = 1;
		}else if(command.equals("/exBoardWrite.do")) {	// 글 쓰기 저장
			if(result == 1) {
				service = new ExBoardWriteService();
				service.execute(request, response);
				result = 0;
			}
			viewPage = "exBoardList.do";
		}else if(command.equals("/exBoardReplyView.do")) {	// 답글 쓰기
			service = new ExBoardReplyViewService();
			service.execute(request, response);
			viewPage = "exBoard/exBoardReply.jsp";
			result = 1;
		}else if(command.equals("/exBoardReply.do")) {	// 답글 저장
			if(result == 1) {
				service = new ExBoardReplyService();
				service.execute(request, response);
				result = 0;
			}
			viewPage = "exBoardList.do"; 
		}else if(command.equals("/exBoardModifyView.do")) {	// 글 수정 페이지
			service = new ExBoardModifyViewService();
			service.execute(request, response);
			viewPage = "exBoard/exBoardModify.jsp";
			result = 1;
		}else if(command.equals("/exBoardModify.do")) {	// 수정글 저장
			if(result == 1) {
				service = new ExBoardModifyService();
				service.execute(request, response);
				result = 0;
			}
			viewPage = "exBoardList.do";
		}else if(command.equals("/exBoardDelete.do")) {	// 선택 글 삭제
			service = new ExBoardDeleteService();
			service.execute(request, response);
			viewPage = "exBoardList.do";
		}else if(command.equals("/bComment.do")) { // 댓글 달기
			service = new BCommentService();
			service.execute(request, response);
			viewPage = "exBoardContentView.do";
		}else if(command.equals("/bCommentModifyView.do")) { // 댓글 수정
			service = new BCommentModifyViewService();
			service.execute(request, response);
			viewPage = "Bcomment/bCommentModify.jsp";
		}else if(command.equals("/bCommentModify.do")) { // 수정 댓글 저장
			service = new BCommentModifyService();
			service.execute(request, response);
			viewPage = "exBoardContentView.do";
		}else if(command.equals("/bCommentDelete.do")) { // 댓글 삭제
			service = new BCommentDeleteService();
			service.execute(request, response);
			viewPage = "exBoardContentView.do";
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
