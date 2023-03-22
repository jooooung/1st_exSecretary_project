package com.lec.exSec.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Date;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.lec.exSec.dao.MemberDao;
import com.lec.exSec.dto.MemberDto;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class MemberModifyService implements Service {
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		String path = request.getRealPath("memberPhotoUp");
		int maxSize = 1024 * 1024 * 3; // 업로드 용량 3mb 제한
		String mphoto = "";
		int result = MemberDao.FAIL;
		try {
			MultipartRequest mRequest = new MultipartRequest(request, path, maxSize, "utf-8", 
					new DefaultFileRenamePolicy());
			Enumeration<String> params = mRequest.getFileNames();
			String param = params.nextElement();
			mphoto = mRequest.getFilesystemName(param);
			String dbMpw = mRequest.getParameter("dbMpw");
			String dbMphoto = mRequest.getParameter("dbMphoto");
			String mid = mRequest.getParameter("mid");
			String oldMpw = mRequest.getParameter("oldMpw");
			if (!oldMpw.equals(dbMpw)) {
				request.setAttribute("modifyErrorMsg", "비밀번호를 확인하세요");
				return;
			}
			String mpw = mRequest.getParameter("mpw");
			if (mpw.equals("")) { // 새비밀번호 미입력 시 현 비밀번호로
				mpw = dbMpw;
			}
			String mname	 = mRequest.getParameter("mname");
			String mtel 	 = mRequest.getParameter("mtel");
			String memail 	 = mRequest.getParameter("memail");
			String mgender   = mRequest.getParameter("mgender");
			mphoto = mphoto == null ? dbMphoto : mphoto;
			String mbirthStr = mRequest.getParameter("mbirth");
			Date mbirth = null;
			if(!mbirthStr.equals("")) {
				mbirth = Date.valueOf(mbirthStr);
			}
			String mrdateStr = mRequest.getParameter("mrdate");
			System.out.println(mrdateStr);
			Date mrdate = null;
			if(!mrdateStr.equals("")) {
				mrdate = Date.valueOf(mrdateStr);
			}
			MemberDao mDao = MemberDao.getInstance();
			MemberDto member = new MemberDto(mid, mpw, mname, mphoto, mtel, memail, mgender, mbirth, mrdate);	
			result = mDao.joinMember(member);
			if(result == MemberDao.SUCCESS) {
				HttpSession session = request.getSession(); 
				session.setAttribute("member", member);
				request.setAttribute("modifyResult", "정보수정 성공");
			} else { // 수정 실패시
				request.setAttribute("modifyErrorMsg", "정보수정 실패");
			}
		} catch (IOException e) {
			System.out.println(e.getMessage());
		}
		File serverFile = new File(path + "/" + mphoto);
		if(serverFile.exists() && result==MemberDao.SUCCESS) {
			InputStream is = null;
			OutputStream os = null;
			try {
				is = new FileInputStream(serverFile);
				os = new FileOutputStream("C:/exSecretary_Project/exSecretary/WebContent/memberPhotoUp/"+mphoto);
				byte[] bs = new byte[(int) serverFile.length()];
				while(true) {
					int readByteCnt = is.read(bs);
					if(readByteCnt==-1) break;
					os.write(bs, 0, readByteCnt);
				}
			} catch (IOException e) {
				System.out.println(e.getMessage());
			}finally {
				try {
					if(os!=null) os.close();
					if(is!=null) is.close();
				} catch (IOException e) {
					System.out.println(e.getMessage());
				}
			} // try-catch-finally
		} // if - serverFile
	}
}
