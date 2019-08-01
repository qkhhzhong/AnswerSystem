<%@page import="sys.bean.DataBase"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<jsp:useBean id="admininfo" class="sys.bean.Admininfo" scope="session"></jsp:useBean>
<%
	System.out.println("----------studentList.jsp------------");
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
 		var username = document.getElementsByName("username")[0].value;
 		var userid = document.getElementsByName("userid")[0].value;
 		var userpassword = document.getElementsByName("userpassword")[0].value;
 		if(username == null || username.trim() == ""){
 			alert("请输入员工姓名");
 			return false;
 		}
 		if(userid == null || userid.trim() == ""){
 			alert("请输入员工号");
 			return false;
 		}
 		if(userpassword == null || userpassword.trim() == ""){
 			alert("请设置员工密码");
 			return false;
 		}
 		
 		return true;
 	}
 	function deleuser(iddeleform){
 		document.getElementById(iddeleform).submit();
 	}
 </script>
   </head>
  <body style="background:url(/AnswerSystem/images/main.jpg);background-size: cover;">
	<div style="margin:0 auto;width: 1000px;height: 150px;">
		<div style="padding-top: 60px;padding-left: 50px; font-size: 30px;">欢迎您：<%=adminname%></div>
	</div>
    <jsp:include page="createheader.jsp" ></jsp:include>
 	<br>
 	<div style="margin:0 auto;width: 1000px;">
	  
		<div style="float: left;width: 650px;background: #a6a;">
		<%
			Vector<String[]> stuvv = null;
			String stusql = "select username,userid,userpassword from userinfo";
			stusql = new String(stusql.getBytes("UTF-8"),"UTF-8");
			stuvv = DataBase.getMessage(stusql);
			int stusize = stuvv.size();
			System.out.println("stusize=="+stusize);
			int di = 0;
			for(String[] stust : stuvv){
				di++;
				String stusername = stust[0];
				String stuserid = stust[1];
				String stuserpassword = stust[2];
				System.out.println("stusername=="+stusername);
		 %>
		 <div style="background: #f5f; margin: 20px;">
			<div style="float:left;width:500px; padding-left: 20px;padding-top: 10px;">
				姓名：<%=stusername%>----工号：<%=stuserid%>----密码：<%=stuserpassword%>
			</div>
			<div style="float: left;padding-right: 10px;padding-top: 10px;">
				<button onclick="deleuser('iddeleform<%=di%>')">删除</button>
			</div>
			<form id="iddeleform<%=di%>" action="/AnswerSystem/mainservlet" method="post" >
				<input type="hidden" name="action" value="delestu">
				<input type="hidden" name="userid" value="<%=stuserid%>">
			</form>
		</div>
			<br>
		<%
			}
		 %>
		<div style="height: 60px;"></div>
		</div>
		
		
		<div style="float:left;width:300px;background: #dff">
			<form action="/AnswerSystem/mainservlet" method="post" onsubmit="return checksubmit()">
			<input type="hidden" name="action" value="createstu">
			<div style="text-align: center;">
				<div>添加员工</div>
				<div>
					员工姓名<br><input name="username" type="text" >
				</div>
				<div>
					员工号<br><input name="userid" type="text" >
				</div>
				<div>
					员工密码<br><input name=userpassword type="text" >
				</div>
				<div>
					<input type="submit" value="添加">
					<input type="reset" value="重置">
				</div>	
			</div>
			</form>
		</div>	
	
	
 	</div>

  </body>

</html>
