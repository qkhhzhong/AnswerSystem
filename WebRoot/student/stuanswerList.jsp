<%@page import="sys.bean.DataBase"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<jsp:useBean id="answerinfo" class="sys.bean.Answerinfo" scope="session"></jsp:useBean>
<jsp:useBean id="userinfo" class="sys.bean.Userinfo" scope="session"></jsp:useBean>
<%
	System.out.println("----------stuanswerList.jsp------------");
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
<!DOCTYPE >
<html>
  <head>
    <title>试卷列表</title>
    
<script type="text/javascript">
	function comein(idcomeinproblem){
		document.getElementById(idcomeinproblem).submit();
	}
</script>
   </head>
  <body style="background:url(/AnswerSystem/images/main.jpg);background-size: cover;">
	<div style="margin:0 auto;width: 1000px;height: 150px;">
		<div style="padding-top: 60px;padding-left: 50px; font-size: 25px;">欢迎您：<%=username%></div>
	</div>
    <jsp:include page="studentheader.jsp" ></jsp:include>
 	<br>
 	<div style="margin:0 auto;width: 1000px;">
	 
	 <%
	 	Vector<String[]> answerss = null;
	 	String sql = "select answerid,answertitle,answerdetail from answer where answerstate='on'";
	 	sql = new String(sql.getBytes("UTF-8"),"UTF-8");
	 	answerss = DataBase.getMessage(sql);
	 	int size = answerss.size();
	 	System.out.println("size=="+size);
	 	int i = 0;
	 	for(String[] st : answerss){
	 		i++;
	 		String stanswerid = st[0];
			String stanswertitle = st[1];
			String stanswerdetail = st[2];
			System.out.println("stanswerid=="+stanswerid);
			System.out.println("stanswertitle=="+stanswertitle);
			System.out.println("stanswerdetail=="+stanswerdetail);
	  %>
	  <div style="background:#cdf; padding: 10px;margin: 10px;">
	  <form id="idcomeinproblem<%=i%>" action="/AnswerSystem/stuservlet" method="post">
	  	<input type="hidden" name="action" value="showproblem">
	  	<input type="hidden" name="answerid" value="<%=stanswerid%>">
	  	<input type="hidden" name="answertitle" value="<%=stanswertitle%>">
	  	<input type="hidden" name="answerdetail" value="<%=stanswerdetail%>">
	  </form>
		    <div style="width:700px;cursor:pointer; background: #bdf;" onclick="comein('idcomeinproblem<%=i%>')">
		  	<ul>
		  		<li><span><%=i%>———>>>点击进入考试</span></li>
		  		<li>标题：：<%=stanswertitle%></li>
		  		<li>内容：：<%=stanswerdetail%></li>
		  	</ul>
		  	</div>
	  </div>
	  <%
	  	}
	   %>
	
 	</div>

  </body>

</html>
