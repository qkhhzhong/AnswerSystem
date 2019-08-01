<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<jsp:useBean id="admininfo" class="sys.bean.Admininfo" scope="session"></jsp:useBean>
<%
	System.out.println("----------createAnswer.jsp------------");
	String adminname = admininfo.getAdminname();
	System.out.println("adminname=="+adminname);
	if(adminname == null){
		response.sendRedirect("/AnswerSystem/admin/adminlogin.jsp");
	}
 %>
<!DOCTYPE >
<html>
  <head>
    <title>createCourse</title>
 <script type="text/javascript">
 	function checksubmit(){
 		var antitle = document.getElementsByName("answertitle")[0].value;
 		var andetail = document.getElementsByName("answerdetail")[0].value;
 		if(antitle == null || antitle.trim() == ""){
 			alert("要填写试卷标题");
 			return false;
 		}
 		if(andetail == null || andetail.trim() == ""){
 			alert("填写试卷描述信息");
 			return false;
 		}
 		 		
 		return true;
 	}
 </script>
   </head>
  <body style="background:url(/AnswerSystem/images/main.jpg);background-size: cover;font-size: 25px;">
	<div style="margin:0 auto;width: 1000px;height: 150px;">
		<div style="padding-top: 60px;padding-left: 50px; font-size: 30px;">欢迎您：<%=adminname%></div>
	</div>
    <jsp:include page="createheader.jsp" ></jsp:include>
 	<br>
 	<div style="margin:0 auto;width: 1000px;">
	  <form action="/AnswerSystem/adminservlet" id="courseform" method="post" onsubmit="return checksubmit()">
	 	<input type="hidden" name="action" value="createanswer">
	 	<div style="float: left;">
		 	<div>
		 		试卷标题：<br><input type="text" name="answertitle" style="width:700px;height: 35px;font-size: 20px;"> 
		  	</div>
		 	<div>
		 		试卷描述：<br><textarea name="answerdetail" style="width:700px;height:300px;font-size: 18px;"></textarea>
		 	</div>
	 	</div>	
	 	<div style="float: left;padding-left: 10px;padding-top:100px; width: 200px;">
	 		试卷标题<br>如：七月员工考核考试<br><br>
	 		试卷描述<br>可写考核目的，说明，考试分值等。
	 	</div>
	 	<div style="clear: both;"></div>
	 	<input type="submit" value="提交" style="font-size: 28px;width: 80px;height: 50px;">
	 	<input type="reset" value="重置" style="font-size: 28px;width: 80px;height: 50px;">
	  </form>
	
 	</div>
  </body>
</html>
<script type="text/javascript">
<%
	String message = (String)request.getAttribute("message");
	if(message != null ){
%>
 		alert('<%=message%>');
<%	
	}
%>
</script>