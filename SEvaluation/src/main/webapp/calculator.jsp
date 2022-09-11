<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    // 변수 선언
    int result = 0;
    
    // GET POST는 대문자로만 작성해야함.
    // form 태그 method가 post이므로 post 요청이 들어왔을 경우!
    if(request.getMethod().equals("POST")){
        String op = request.getParameter("op");
        
        // 파라미터 값은 문자열로 주고받기 때문에 형변환 필요
        int num1 = Integer.parseInt(request.getParameter("num1"));
        int num2 = Integer.parseInt(request.getParameter("num2"));
        
        switch(op){
        case "+":
            result = num1 + num2;
            break;
        case "-":
            result = num1 - num2;
            break;
        case "*":
            result = num1 * num2;
            break;
        case "/":
            result = num1 / num2;
            break;
        }
    }
%>
<html>
<head>
<meta charset="UTF-8">
<title>계산기</title>
</head>
<body>
 
<h2>계산기</h2>
<hr>
<form method="post" name="form1">
    <input type="text" name="num1" id="num1"> <!-- name속성은 id와같다. 유지보수를 위해 id도 적어줌 -->
    <select name="op">
        <option selected>+</option>
        <option>-</option>
        <option>*</option>
        <option>/</option>
    </select>
    <input type="text" name="num2" id="num2">
    <input type="submit" value="계산하기" name="btn1">
    <input type="reset" value="다시입력" name="btn2">
</form>
<hr>
<h3>계산결과: <%= result %></h3>
 
</body>
</html>
