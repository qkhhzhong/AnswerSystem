<%@page import="sys.bean.DataBase"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<jsp:useBean id="answerinfo" class="sys.bean.Answerinfo" scope="session"></jsp:useBean>
<jsp:useBean id="userinfo" class="sys.bean.Userinfo" scope="session"></jsp:useBean>
<%
	System.out.println("----------problemShow.jsp------------");
	String answerid = answerinfo.getAnswerid();
	String answertitle = answerinfo.getAnswertitle();
	String answerdetail = answerinfo.getAnswerdetail();
	System.out.println("answerid=="+answerid);
	System.out.println("answertitle=="+answertitle);
	System.out.println("answerdetail=="+answerdetail);
	
	String userid = userinfo.getUserid();
	String username = userinfo.getUsername();
	System.out.println("userid=="+userid);
	System.out.println("username=="+username);
	if(userid == null){
		response.sendRedirect("/AnswerSystem/student/stulogin.jsp");
	}
 %>
<!DOCTYPE>
<html>
  <head>
    <title>试卷展示</title>

<script type="text/javascript">
	function look(idlookproblem){
		document.getElementById(idlookproblem).submit();
	}
</script>
   </head>
  <body style="background:url(/AnswerSystem/images/main.jpg);background-size: cover;">
	<div style="margin:0 auto;width: 1000px;height: 150px;">
		<div style="padding-top: 60px;padding-left: 50px; font-size: 30px;">欢迎您：<%=username%></div>
	</div>
    <jsp:include page="studentheader.jsp" ></jsp:include>
 	<br>
 	<div style="margin:0 auto;width: 1000px;">
 	
 	<%
 		Vector<String[]> haveansvv = null;
 		String ansql = "select distinct answerid from smprobleminfo where userid='"+userid+"'";
 	 	ansql = new String(ansql.getBytes("UTF-8"),"UTF-8");
 	 	haveansvv = DataBase.getMessage(ansql);
 	 	int anssize = haveansvv.size();
 	 	int hi = 0;
 	 	if(anssize < 1){
 	 		%>
 	 		<div>无考试信息</div>
 	 		<%
 	 		System.out.println("--无考试信息--");
 	 	}else{
 	 	
 	 	for(String[] hast : haveansvv){
 	 		hi++;
 	 		String haanswerid = hast[0];
 	 	
 	 %>			
 				<%
	 	Vector<String[]> answerss = null;
	 	String sql = "select answerid,answertitle,answerdetail from answer where answerid='"+haanswerid+"' ";
	 	sql = new String(sql.getBytes("UTF-8"),"UTF-8");
	 	answerss = DataBase.getMessage(sql);
	 	int size = answerss.size();
	 	System.out.println("size=="+size);
	 	for(String[] st : answerss){
	 		String stanswerid = st[0];
			String stanswertitle = st[1];
			String stanswerdetail = st[2];
			System.out.println("stanswerid=="+stanswerid);
			System.out.println("stanswertitle=="+stanswertitle);
			System.out.println("stanswerdetail=="+stanswerdetail);
	  %>
	  <div>
	  <form id="idlookproblem<%=hi%>" action="/AnswerSystem/stuservlet" method="post">
	  	<input type="hidden" name="action" value="lookproblem">
	  	<input type="hidden" name="answerid" value="<%=stanswerid%>">
	  	<input type="hidden" name="answertitle" value="<%=stanswertitle%>">
	  	<input type="hidden" name="answerdetail" value="<%=stanswerdetail%>">
	  	<input type="hidden" name="userid" value="<%=userid%>">
	  </form>
	  	<div onclick="look('idlookproblem<%=hi%>')" style="width:700px; padding: 20px;margin: 20px; background: #bbe;">
	  		<div><span>--<%=hi%></span>—>>点击查看成绩--</div>
	  		<div>------<%=stanswertitle%>------</div>
	  	</div>
	  </div>
	  <%
	  	}
	   %>
 				
 				
 				
 				
 				
 				
 				
 				
 				
 				
	
	<%
			}//循环输出hvanswerid
		}//这里是有考试信息结尾
	%>
	</div>		
</body>
</html>
<script type="text/javascript">

<%
	String message = (String)request.getAttribute("message");
	if(message != null ){
%>
 		alert('<%= message %>');
<%	
	}
%>

</script>