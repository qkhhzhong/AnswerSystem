<%@ page language="java" contentType="text/html;charset=utf-8" errorPage="exception.jsp"%>
<%
	System.out.println("-----------stulogin.jsp-------------");
	session.invalidate();//清空session
 %>
<!DOCTYPE>
<html>
<head>
	<title>Answersystem</title>
<script type="text/javascript">
	function cherksubmit(){
		var userid = document.getElementById("userid").value;
		var userpassword = document.getElementById("userpassword").value;
		if(userid.trim() == ""){
			alert("账号不能为空");
			return false;
		}
		if(userpassword.trim() == ""){
			alert("密码不能为空");
			return false;
		}
		return true;
	}
</script>
<style type="text/css">
.form{
	margin:200px 100px 100px 517px;
	height:500px;
	width:600px;
	background-color:rgba(255,255,255,0.5);
}
.inputoo{
	width:500px;
	height:50px;
	text-align:center;
	padding-top:15px;
	margin:5px auto;
	font-size: 28px;
}
</style>	 
</head>
	<body style="background:url(/AnswerSystem/images/main.jpg);background-size: cover;">
	<div class="form" >
       <br><h1 style="text-align: center;font-size: 40px;">AnswerSystem</h1> 
       <h2 style="text-align: center;font-size: 30px;padding: 5px;">员工登录</h2>
       <form action="/AnswerSystem/mainservlet" method="post" onsubmit="return cherksubmit(this)" >
       <input type="hidden" name="action" value="stulogin">
       <div style="background-color:rgba(98,211,222,0.7);">
	       <div class="inputoo">
	       		工号 ：<input type="text" id="userid" name="userid" style="font-size: 24px;" >
	   		</div>
	       <div class="inputoo">
	     		  密码 ：<input type="password" id="userpassword" name="userpassword" style="font-size: 24px;">
	       </div><br>
	       <div class="inputoo">
	     		<input type="submit" value="提交">&nbsp;&nbsp;&nbsp;
	       		<input type="reset" value="重置">
	       </div> 
       </div>  
    </form>
  </div>
  </body>
</html>
<%
	String message=(String)request.getAttribute("message");
	System.out.println("message=="+message);
	if(message != null || message == "" )
	{
%>
	<script type="text/javascript">
	  alert('<%= message %>');
	</script>
<%
	}
%>