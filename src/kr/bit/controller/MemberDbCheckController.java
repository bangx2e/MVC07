package kr.bit.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.bit.model.MemberDAO;

public class MemberDbCheckController implements Controller {

	@Override
	public String requestHandler(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String id = request.getParameter("id");
		MemberDAO dao = new MemberDAO();
		String dbDouble = dao.memberDbCheck(id);
		System.out.println(dbDouble);
		response.getWriter().print(dbDouble);
		return null;
	}

}
