<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="evaluation.EvaluationDTO"%>
<%@ page import="evaluation.EvaluationDAO"%>
<%@ page import="util.SHA256"%>
<%@ page import="java.io.PrintWriter"%>

<%
	request.setCharacterEncoding("UTF-8");
	String userID = null;
	if(session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	if(userID == null) {
		PrintWriter script = response.getWriter();	
		script.println("<script>");
		script.println("alert('로그인을 해주세요.');");
		script.println("location.href = 'userLogin.jsp';");
		script.println("</script>");
		script.close();
		return;
	}
	
	String countryName = null;
	String regionName = null;
	int TravelYear = 0;
	String quarterDivide = null;
	String TravelDivide = null;
	String evaluationTitle = null;
	String evaluationContent = null;
	String totalScore = null;
	String cultureScore = null;
	String creditScore = null;
	String comfortableScore = null;

	if(request.getParameter("countryName") != null) {
		countryName = request.getParameter("countryName");
	}
	if(request.getParameter("regionName") != null) {
		regionName = request.getParameter("regionName");
	}
	if(request.getParameter("TravelYear") != null) {
		try{
			TravelYear = Integer.parseInt(request.getParameter("TravelYear"));
		} catch (Exception e) {
			System.out.println("연도 데이터 오류");
		}
	}
	if(request.getParameter("quarterDivide") != null) {
		quarterDivide = request.getParameter("quarterDivide");
	}
	if(request.getParameter("TravelDivide") != null) {
		TravelDivide = request.getParameter("TravelDivide");
	}
	if(request.getParameter("evaluationTitle") != null) {
		evaluationTitle = request.getParameter("evaluationTitle");
	}
	if(request.getParameter("evaluationContent") != null) {
		evaluationContent = request.getParameter("evaluationContent");
	}
	if(request.getParameter("totalScore") != null) {
		totalScore = request.getParameter("totalScore");
	}
	if(request.getParameter("cultureScore") != null) {
		cultureScore = request.getParameter("cultureScore");
	}
	if(request.getParameter("creditScore") != null) {
		creditScore = request.getParameter("creditScore");
	}
	if(request.getParameter("comfortableScore") != null) {
		comfortableScore = request.getParameter("comfortableScore");
	}
	
	if(countryName == null || regionName == null || TravelYear == 0 || quarterDivide == null || TravelDivide == null || 
			TravelDivide == null || evaluationTitle == null || evaluationContent == null || totalScore == null || 
			cultureScore == null || creditScore == null || comfortableScore == null ||
			evaluationTitle.equals("") || evaluationContent.equals("")) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안 된 사항이 있습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
	EvaluationDAO evaluationDAO = new EvaluationDAO();
	int result = evaluationDAO.write(new EvaluationDTO(0, userID, countryName, regionName,
			TravelYear, quarterDivide, TravelDivide, evaluationTitle, evaluationContent, 
			totalScore, cultureScore, creditScore, comfortableScore, 0));
	if (result == -1) {
		PrintWriter script = response.getWriter();	
		script.println("<script>");
		script.println("alert('평가 등록에 실패했습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	} else {
		PrintWriter script = response.getWriter();	
		script.println("<script>");
		script.println("location.href = 'index.jsp'");
		script.println("</script>");
		script.close();
		return;
	
	}
%>