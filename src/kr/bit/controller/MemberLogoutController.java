package kr.bit.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.bit.model.MemberDAO;
import kr.bit.model.MemberVO;

public class MemberLogoutController implements Controller {

	@Override
	public String requestHandler(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String ctx = request.getContextPath();
		request.getSession().invalidate();
		return "redirect:"+ctx+"/memberList.do";
	}

}
