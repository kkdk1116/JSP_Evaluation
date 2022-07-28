<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<%@ page import="evaluation.EvaluationDTO" %>
<%@ page import="evaluation.EvaluationDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.net.URLEncoder" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<title>평가 웹 사이트</title>
	<!--  부트스트랩 CSS 추가하기 -->
	<link rel="stylesheet" href="./css/bootstrap.min.css">
	<!--  커스텀 CSS 추가하기 -->
	<link rel="stylesheet" href="./css/custom.css">
</head>
<body>
<% 
	request.setCharacterEncoding("UTF-8");
	String travelDivide = "전체";
	String searchType = "최신순";
	String search = "";
	int pageNumber = 0;
	if(request.getParameter("travelDivide") != null) {
		travelDivide = request.getParameter("travelDivide");
	}
	if(request.getParameter("searchType") != null) {
		searchType = request.getParameter("searchType");
	}
	if(request.getParameter("search") != null) {
		search = request.getParameter("search");
	}
	if(request.getParameter("pageNumber") != null) {
		try {
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		} catch (Exception e) {
			System.out.println("검색 페이지 번호 오류");
		}
	}
	
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
	/*
	boolean emailChecked = new UserDAO().getUserEmailChecked(userID);
	if(emailChecked == false) {
		PrintWriter script = response.getWriter();	
		script.println("<script>");
		script.println("location.href = 'emailSendConfirm.jsp';");
		script.println("</script>");
		script.close();
		return;
	}
	*/
%>
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<a class = "navbar-brand" href="index.jsp">평가 웹 사이트</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div id="navbar" class="collapse navbar-collapse">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item active">
					<a class="nav-link" href="index.jsp">메인</a>
				</li>
				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle" id="dropdown" data-toggle="dropdown">
						회원 관리
					</a>
					<div class="dropdown-menu" aria-labelledby="dropdown">
<%
	if (userID == null) {
%>					
						<a class="dropdown-item" href="userLogin.jsp">로그인</a>
						<a class="dropdown-item" href="userJoin.jsp">회원가입</a>
<%
	} else {
%>						
						<a class="dropdown-item" href="userLogout.jsp">로그아웃</a>
<%
	}
%>
					</div>					
				</li>
			</ul>
			<form action = "./index.jsp" method="get" class="form-inline my-2 my-lg-0">
				<input type="text" name="search" class="form-control mr-sm-2" type="search" placeholder="내용을 입력하세요" aria-label="Search">
				<button class="btn btn-outline-success my-2 my-sm-0" type="submit">검색</button>
			</form>
		</div>
	</nav>
	<section class="container">
		<form method="get" action="./index.jsp" class="form-inline mt-3">
			<select name="travelDivide" class="form-control mx-1 mt-2">
				<option value="전체">전체</option>
				<option value="단기"> <%if (travelDivide.equals("단기")) out.println("selected"); %>단기</option>
				<option value="장기"> <%if (travelDivide.equals("장기")) out.println("selected"); %>장기</option>
				<option value="기타"> <%if (travelDivide.equals("기타")) out.println("selected"); %>기타</option>
			</select>
			<select name="travelDivide" class="form-control mx-1 mt-2">
				<option value="최신순">최신순</option>
				<option value="추천순"> <%if (searchType.equals("추천순")) out.println("selected"); %>추천순</option>
			</select>
			<input type="text" name="search" class="form-control mx-1 mt-2" placeholder="내용을 입력하세요.">
			<button type="submit" class="btn btn-primary mx-1 mt-2">검색</button>
			<a class="btn btn-primary mx-1 mt-2" data-toggle="modal" href="#registerModal">등록하기</a>	
			<a class="btn btn-danger mx-1 mt-2" data-toggle="modal" href="#reportModal">신고</a>				
		</form>
<%
	ArrayList<EvaluationDTO> evaluationList = new ArrayList<EvaluationDTO>();
	evaluationList = new EvaluationDAO().getList(travelDivide, searchType, search, pageNumber);
	if(evaluationList != null) 
		for(int i = 0; i < evaluationList.size(); i++) {
			if(i == 5) break;
			EvaluationDTO evaluation = evaluationList.get(i);

%>
		
		<div class="card bg-light mt-3">
			<div class="card-header bt-light">
				<div class="row">
					<div class="col-8 text-left"><%= evaluation.getRegionName() %>&nbsp;<small><%= evaluation.getCountryName()%></small></div>
					<div class="col-4 text-right">
						종합성 <span style="color: red;"><%= evaluation.getTotalScore() %></span>
					</div>
				</div>
			</div>
			<div class="card-body">
				<h5 class="card-title">
					<%= evaluation.getEvaluationTitle() %>&nbsp;<small>(<%= evaluation.getTravelYear() %>년 <%= evaluation.getQuarterDivide() %>)</small>
				</h5>
				<p class="card-text"> <%= evaluation.getEvaluationContent() %>  </p>
				<div class="row">
					<div class="col-9 text-left">
						문화력 <span style="color: red;"><%= evaluation.getCultureScore() %></span>
						가성비 <span style="color: red;"><%= evaluation.getCreditScore() %></span>
						안전성 <span style="color: red;"><%= evaluation.getComfortableScore() %></span>
						<span style="color: green;">(추천: <%= evaluation.getLikeCount() %>)</span>
					</div>
					<div class="col-3 text-right">
						<a onclick="return confirm('추천하시겠습니까?')" href="./likeAction.jsp?evaluationID=<%= evaluation.getEvaluationID() %>">추천</a>
						<a onclick="return confirm('삭제하시겠습니까?')" href="./deleteAction.jsp?evaluationID=<%= evaluation.getEvaluationID() %>">삭제</a>
					</div>
				</div>
			</div>
		</div>
<%
	}
%>		
	</section>

	<ul class="pagination justify-content-centet mt-3">
		<li class="page-item">
<%
	if(pageNumber <= 0) {		
%>	
	<a class="page-link disabled">이전</a>
<%
	} else {
%>
	<a class="page-link" href="./index.jsp?travelDivide=<%= URLEncoder.encode(travelDivide, "UTF-8")%>&searchType=
	<%= URLEncoder.encode(searchType, "UTF-8") %>&search=<%= URLEncoder.encode(search, "UTF-8") %>&pageNumber=
	<%= pageNumber-1 %>">이전</a>
<%
	}
%>

		</li>
		<li>
<%
	if(pageNumber >  6) {
%>
	<a class = "page-link disabled">다음</a>
<% 
	} else {		
%>
	<a class="page-link" href="./index.jsp?travelDivide=<%= URLEncoder.encode(travelDivide, "UTF-8")%>&searchType=
	<%= URLEncoder.encode(searchType, "UTF-8") %>&search=<%= URLEncoder.encode(search, "UTF-8") %>&pageNumber=
	<%= pageNumber+1 %>">다음</a>
<%
	}
%>
		
		</li>
	</ul>
	<!-- 등록하기 시작 -->
	<div class="modal fade" id="registerModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modal">평가 등록</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"> <!-- 닫기 버튼 -->
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form action="./evaluationRegisterAction.jsp" method="post">
						<div class="form-row">
							<div class="form-group col-sm-6">
								<label>도시명</label>
								<input type="text" name="regionName" class="form-control" maxlength="20">
							</div>
							<div class="form-group col-sm-6">
								<label>나라명</label>
								<input type="text" name="countryName" class="form-control" maxlength="20">
							</div>
						</div>
						<div class="form-row">
							<div class="form-group col-sm-4">
								<label>여행 연도</label>
								<select name="TravelYear" class="form-control">
									<option value="2011">2011</option>
									<option value="2012">2012</option>
									<option value="2013">2013</option>
									<option value="2014">2014</option>
									<option value="2015">2015</option>
									<option value="2016">2016</option>
									<option value="2017">2017</option>
									<option value="2018">2018</option>
									<option value="2019">2019</option>
									<option value="2020">2020</option>
									<option value="2021">2021</option>
									<option value="2022" selected>2022</option>
									<option value="2023">2023</option>
									<option value="2024">2024</option>
									<option value="2025">2025</option>
								</select>
							</div>
							<div class="form-group col-sm-4">
								<label>여행 분기</label>
								<select name="quarterDivide" class="form-control">
									<option value="1분기">1학기</option>
									<option value="2분기">2분기</option>
									<option value="3분기" selected>3분기</option>
									<option value="4분기">4분기</option>
								</select>
							</div>
							<div class="form-group col-sm-4">
								<label>여행 기간</label>
								<select name="TravelDivide" class="form-control">
									<option value="단기" selected>단기</option>
									<option value="장기">장기</option>
									<option value="기타">기타</option>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label>제목</label>
							<input type="text" name="evaluationTitle" class="form-control" maxlength="30">	
						</div>
						<div class="form-group">
							<label>내용</label>
							<textarea name="evaluationContent" class="form-control" maxlength="2048" style="height: 180px;"></textarea>
						</div>
						<div class="form-row">
							<div class="form-group col-sm-3">
								<label>종합성</label>
								<select name="totalScore" class="form-control">
									<option value="A" selected>A</option>
									<option value="B">B</option>
									<option value="C">C</option>
									<option value="D">D</option>
									<option value="F">F</option>		
								</select>
							</div>
						</div>
						<div class="form-row">
							<div class="form-group col-sm-3">
								<label>문화력</label>
								<select name="cultureScore" class="form-control">
									<option value="A" selected>A</option>
									<option value="B">B</option>
									<option value="C">C</option>
									<option value="D">D</option>
									<option value="F">F</option>		
								</select>
							</div>
						</div>
						<div class="form-row">
							<div class="form-group col-sm-3">
								<label>가성비</label>
								<select name="creditScore" class="form-control">
									<option value="A" selected>A</option>
									<option value="B">B</option>
									<option value="C">C</option>
									<option value="D">D</option>
									<option value="F">F</option>		
								</select>
							</div>
						</div>
						<div class="form-row">
							<div class="form-group col-sm-3">
								<label>안전성</label>
								<select name="comfortableScore" class="form-control">
									<option value="A" selected>A</option>
									<option value="B">B</option>
									<option value="C">C</option>
									<option value="D">D</option>
									<option value="F">F</option>		
								</select>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
							<button type="submit" class="btn btn-primary">등록하기</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<!-- 등록하기 끝 -->
	<!-- 신고하기 시작-->
	<div class="modal fade" id="reportModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modal">신고하기</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"> <!-- 닫기 버튼 -->
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form action="./reportAction.jsp" method="post">
						<div class="form-group">
							<label>신고 제목</label>
							<input type="text" name="reportTitle" class="form-control" maxlength="30">	
						</div>
						<div class="form-group">
							<label>신고 내용</label>
							<textarea name="reportContent" class="form-control" maxlength="2048" style="height: 180px;"></textarea>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
							<button type="submit" class="btn btn-danger">신고하기</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<footer class="bg-dark mt-4 p-5 text-center" style="color: #FFFFFF;">
		Copyright &copy; 2022 김대길 All Rights Reserved.
	</footer>
	
	<!--  제이쿼리 자바스크립트 추가하기 -->
	<script src="./js/jquery-3.6.0.min.js"></script>
	<!--  파퍼 자바스크립트 추가하기 -->
	<script src="./js/popper.js"></script>
	<!--  부트스트랩 자바스크립트 추가하기 -->
	<script src="./js/bootstrap.min.js"></script>
</body>
</html>