<%@page import="sys.bean.DataBase"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<jsp:useBean id="answerinfo" class="sys.bean.Answerinfo" scope="session"></jsp:useBean>
<jsp:useBean id="admininfo" class="sys.bean.Admininfo" scope="session"></jsp:useBean>
<%
	System.out.println("----------answerList.jsp------------");
	String answerid = answerinfo.getAnswerid();
	String answertitle = answerinfo.getAnswertitle();
	String answerdetail = answerinfo.getAnswerdetail();
	System.out.println("answerid=="+answerid);
	System.out.println("answertitle=="+answertitle);
	System.out.println("answerdetail=="+answerdetail);
	String adminname = admininfo.getAdminname();
	System.out.println("adminname=="+adminname);
	if(adminname == null){
		response.sendRedirect("/AnswerSystem/admin/adminlogin.jsp");
	}
 %>
<!DOCTYPE >
<html>
  <head>
    <title>试卷列表</title>
    
<script type="text/javascript">
	function comein(idcomeinproblem){//进行设计试卷
		document.getElementById(idcomeinproblem).submit();
	}
	function openanswer(idopenproblem){//发布可以考试
		document.getElementById(idopenproblem).submit();
	}
	function closeanswer(idcloseproblem){//关闭考试
		document.getElementById(idcloseproblem).submit();
	}
	function deleteanswer(iddeleteproblem){//删除试卷
		document.getElementById(iddeleteproblem).submit();
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
	 
	 <%
	 	Vector<String[]> answerss = null;
	 	String sql = "select answerid,answertitle,answerdetail from answer";
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
	  <div >
	  <form id="idcomeinproblem<%=i%>" action="/AnswerSystem/adminservlet" method="post">
	  	<input type="hidden" name="action" value="comeinproblem">
	  	<input type="hidden" name="answerid" value="<%=stanswerid%>">
	  	<input type="hidden" name="answertitle" value="<%=stanswertitle%>">
	  	<input type="hidden" name="answerdetail" value="<%=stanswerdetail%>">
	  </form>
	  <form id="idopenproblem<%=i%>" action="/AnswerSystem/adminservlet" method="post">
	  	<input type="hidden" name="action" value="openonproblem">
	  	<input type="hidden" name="answerid" value="<%=stanswerid%>">
	  </form>
	  <form id="iddeleteproblem<%=i%>" action="/AnswerSystem/adminservlet" method="post">
	  	<input type="hidden" name="action" value="deleteproblem">
	  	<input type="hidden" name="answerid" value="<%=stanswerid%>">
	  </form>
	  	<div style="float: left; font-size: 20px;background:#bef; width:600px;cursor: pointer;" onclick="comein('idcomeinproblem<%=i%>')">
	  		<span><%=i%></span>标题：：<%=stanswertitle%>
			<div>内容：：<%=stanswerdetail%></div>
		</div>
		<div style="float: left;width: 150px;">
			<div onclick="openanswer('idopenproblem<%=i%>')">
				（员工将看到试卷）<button>发布</button>
			</div>
		</div>
		<div style="float: left;padding-left: 10px;width: 150px;">
			<div onclick="deleteanswer('iddeleteproblem<%=i%>')">
				（会删除所有有关该试卷的信息）<button>删除</button>
			</div>
		</div>
		<div style="clear: both;">_____</div>
	  </div>
	  <%
	  	}
	   %>
	   
	     
	   
	   	<br><br><br><br><br><br><br><hr><br>已发布试卷：
	   <%
	 	Vector<String[]> onanswerss = null;
	 	String onsql = "select answerid,answertitle,answerdetail from answer where answerstate='on'";
	 	onsql = new String(onsql.getBytes("UTF-8"),"UTF-8");
	 	onanswerss = DataBase.getMessage(onsql);
	 	int onsize = answerss.size();
	 	System.out.println("onsize=="+onsize);
	 	int oni = 0;
	 	for(String[] st : onanswerss){
	 		oni++;
	 		String stanswerid = st[0];
			String stanswertitle = st[1];
			String stanswerdetail = st[2];
			System.out.println("stanswerid=="+stanswerid);
			System.out.println("stanswertitle=="+stanswertitle);
			System.out.println("stanswerdetail=="+stanswerdetail);
	  %>
	  <div >
			<form id="idcloseproblem<%=oni%>" action="/AnswerSystem/adminservlet" method="post">
			  	<input type="hidden" name="action" value="closeproblem">
			  	<input type="hidden" name="answerid" value="<%=stanswerid%>">
		    </form>
	  	<div style="float: left;width: 600px;font-size: 20px;background:#bef;">
	  		<span><%=oni%></span>标题：：<%=stanswertitle%>
			<div>内容：：<%=stanswerdetail%></div>
		</div>
		<div style="float: left;width: 150px;">
			<div style="width:50px;cursor:pointer; height:50px; padding-top: 10px;"  onclick="closeanswer('idcloseproblem<%=oni%>')">
				<button style="width:50px;height:40px;cursor:pointer;">关闭</button>
			</div>
		</div>
	  </div>
	  <%
	  	}
	   %>
	   
	   
	   
	   
	   
	   
	   
	   
	
 	</div>

  </body>

</html>
