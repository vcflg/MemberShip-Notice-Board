<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.*" %>
<%@ page import="bbs.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="user" class="user.User"/> 
<jsp:useBean id="userDAO" class="user.UserDAO"/> 
<jsp:useBean id="bbs" class="bbs.Bbs"/> 
<jsp:useBean id="bbsDAO" class="bbs.BbsDAO"/> 
<jsp:setProperty name="user" property="userID"/>
<jsp:setProperty name="user" property="userPassword"/>
<jsp:setProperty name="user" property="userName"/>
<jsp:setProperty name="user" property="userGender"/>
<jsp:setProperty name="user" property="userEmail"/>
<jsp:setProperty name="bbs" property="bbsID"/>
<jsp:setProperty name="bbs" property="bbsTitle"/>
<jsp:setProperty name="bbs" property="bbsContent"/>

<% 
	String action = request.getParameter("action");
	
	if(action.equals("view")){//게시판 요청
		ArrayList<Bbs> list = bbsDAO.getList();
		request.setAttribute("list", list);
		pageContext.forward("bbs.jsp");
	}
	else if(action.equals("join")){ // 회원가입 요청
			if(userDAO.join(user)!=-1){
				response.sendRedirect("control.jsp?action=view");
			}else
				throw new Exception("DB오류");
			
		}
	
	else if(action.equals("login")){ //로그인
		int result = userDAO.login(user.getUserID(), user.getUserPassword());
			
		if (result == 1) {
			session.setAttribute("userID", user.getUserID());
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href='bbs.jsp'");
			script.println("</script>");
		} 
		else if (result == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");					
			script.println("alert('비밀번호가 틀립니다.');");
			script.println("history.back()");
			script.println("</script>");
		} 
		else if (result == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('존재하지 않는 아이디입니다..');");
			script.println("history.back()");
			script.println("</script>");
		} 
		else if (result == -2) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('DB오류가 발생.');");
			script.println("history.back()");
			script.println("</script>");
		}
	}
	
	else if(action.equals("update")){ //게시글 수정
		int result = bbsDAO.update(bbs.getBbsID(), bbs.getBbsTitle(),bbs.getBbsContent());
		if (result == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('글 수정에 실패했습니다.');");
			script.println("history.back()");
			script.println("</script>");
		} else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'bbs.jsp'");
			script.println("</script>");
		}
	}
	else if(action.equals("delete")){ //삭제
		int result = bbsDAO.delete(bbs.getBbsID());
		if (result == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('글 삭제에 실패했습니다.');");
			script.println("history.back()");
			script.println("</script>");
		} else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'bbs.jsp'");
			script.println("</script>");
		}
	}
	else if(action.equals("write")){ // 글쓰기
		int result = bbsDAO.write(bbs.getBbsTitle(),user.getUserID(),bbs.getBbsContent());
		if(result == -1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('글쓰기에 실패했습니다.');");
			script.println("history.back()");
			script.println("</script>");
			}
		else{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'bbs.jsp'");
			script.println("</script>");		
		}	
	}
	
	
	
%>


