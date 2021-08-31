<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="kr.bit.model.*"%>
<%@ page import="java.util.*"%>
<%
	// ArrayList<MemberVO> list=(ArrayList<MemberVO>)request.getAttribute("list");
%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name='viewport' content='width=device-width, initial-scale=1'>
<link rel='stylesheet'
	href='https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css'>
<script
	src='https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js'></script>
<script
	src='https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js'></script>
<script type="text/javascript">
	$(document).ready(function(){
		<c:if test="${!empty msg}">
		alert("${msg}");
		<c:remove var="msg" scope="session"/>
		</c:if>
	});

  function deleteFn(num){
	  location.href="${ctx}/memberDelete.do?num="+num; // ?num=12
  }
  
  function check(){
	  if($('#user_id').val()==''){
		  alert('아이디를 입력하세요');
		  return false;
	  }
	  if($('#password').val()==''){
		  alert('비밀번호를 입력하세요');
		  return false;
	  }
	  return true;
  }
  function logout(){
	  location.href="<c:url value='/memberLogout.do'/>";
  }
  function memberList(){
// 	 var html = $("#collapse1 .panel-body").html();
// 	 alert(html);
	$.ajax({
		url : "<c:url value='/memberAjaxList.do'/>",
		type : "GET",
		datatype : "json",
		success : resultHtml, //<== 회원 리스트로 받기
		error : function (){alert('error');}
	});
  }
  function resultHtml(data){
	  var html="<table class='table table-hover'>";
	  	html+="<tr>";
		html+="<th>번호</th>";
		html+="<th>아이디</th>";
		html+="<th>비밀번호</th>";
		html+="<th>이름</th>";
		html+="<th>나이</th>";
		html+="<th>이메일</th>";
		html+="<th>전화번호</th>";
		html+="<th>삭제</th>";
		html+="</tr>";
		$.each(data, function(index,obj){
			html+="<tr>";
			html+="<td>"+obj.num+"</td>";
			html+="<td>"+obj.id+"</td>";
			html+="<td>"+obj.pass+"</td>";
			html+="<td>"+obj.name+"</td>";
			html+="<td>"+obj.age+"</td>";
			html+="<td>"+obj.email+"</td>";
			html+="<td>"+obj.phone+"</td>";
			html+="<td>"+obj.num+"</td>";
			html+="</tr>";
		});
		html+="</table>";
		$("#collapse1 .panel-body").html(html);
  }
</script>
</head>
<body>
	[MVC06 예제 - FrontController+POJO]

	<div class="container">
		<h2>회원관리 시스템</h2>
		<div class="panel panel-default">
			<div class="panel-heading">
				<c:if test="${sessionScope.userId==null || sessionScope.userId==''}">
					<form class="form-inline" action="${ctx}/memberLogin.do" method="POST">
						<div class="form-group">
							<label for="user_id">ID:</label> 
							<input type="text" class="form-control" id="user_id" name="user_id">
						</div>
						<div class="form-group">
							<label for="pwd">Password:</label> 
							<input type="password" class="form-control" id="password" name="password">
						</div>
						<button type="submit" class="btn btn-default" onclick="return check()">로그인</button>
					</form>
				</c:if>
				<c:if test="${sessionScope.userId!=null && sessionScope.userId!=''}">
					${sessionScope.userName}님 환영합니다.
<%-- 					<button type="button" class="btn btn-worning" onclick="location.href='${ctx}/memberLogout.do'">로그아웃</button> --%>
					<button type="button" class="btn btn-worning" onclick="logout()">로그아웃</button>
				</c:if>
			</div>
			<div class="panel-body">
				<div class="table-responsive">
					<table class="table">
						<thead>
							<tr>
								<th>번호</th>
								<th>아이디</th>
								<th>비밀번호</th>
								<th>이름</th>
								<th>나이</th>
								<th>이메일</th>
								<th>전화번호</th>
								<th>삭제</th>
							</tr>
						</thead>
						<tbody>
								<c:forEach var="vo" items="${list}">
									<tr>
										<td>${vo.num}</td>
										<td><a href="${ctx}/memberContent.do?num=${vo.num}">${vo.id}</a></td>
										<td>${vo.pass}</td>
										<td>${vo.name}</td>
										<td>${vo.age}</td>
										<td>${vo.email}</td>
										<td>${vo.phone}</td>
										<c:if test = "${sessionScope.userId==vo.id}">
										<td>
										${sessionScope.userID}
											<input type="button" value="삭제" class="btn btn-warning"
											onclick="deleteFn(${vo.num})">
										</td>
										</c:if>
										<c:if test = "${sessionScope.userId!=vo.id}">
										<td>
										${sessionScope.userID}
											<input type="button" value="삭제" class="btn btn-warning"
											onclick="deleteFn(${vo.num})" disabled="disabled">
										</td>
										</c:if>
									</tr>
								</c:forEach>
								<tr>
									<td colspan="8" align="right">
									<input type="button" value="회원가입"	class="btn btn-primary"	onclick="location.href='${ctx}/memberRegister.do'" /></td>
								</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="panel-footer">
			회원관리 ERP 시스템(admin@alsongdalsong.com)
			</div>
		</div>
		<div class="panel-group">
		  <div class="panel panel-default">
		    <div class="panel-heading">
		      <h4 class="panel-title">
		        <a data-toggle="collapse" href="#collapse1" onclick="memberList()">회원 리스트 보기</a>
		      </h4>
		    </div>
		    <div id="collapse1" class="panel-collapse collapse">
		      <div class="panel-body">Panel Body</div>
		      <div class="panel-footer">Panel Footer</div>
		    </div>
		  </div>
		</div>
	</div>
</body>
</html>