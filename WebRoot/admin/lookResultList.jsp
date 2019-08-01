<%@page import="sys.bean.DataBase"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<jsp:useBean id="answerinfo" class="sys.bean.Answerinfo" scope="session"></jsp:useBean>
<jsp:useBean id="admininfo" class="sys.bean.Admininfo" scope="session"></jsp:useBean>
<%
	System.out.println("----------lookResultList.jsp------------");
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
<!DOCTYPE>
<html>
  <head>
    <title>员工试卷列表</title>

<script type="text/javascript">
	function look(idlookresult){
		document.getElementById(idlookresult).submit();
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
 		Vector<String[]> havedovv = null;
 		String dosql = "select answerid,userid from smprobleminfo group by answerid,userid order by answerid,userid asc";
 	 	dosql = new String(dosql.getBytes("UTF-8"),"UTF-8");
 	 	havedovv = DataBase.getMessage(dosql);
 	 	int dosize = havedovv.size();
 	 	int hi = 0;
 	 	if(dosize < 1){
 	 		%>
 	 		<div>无考试信息</div>
 	 		<%
 	 		System.out.println("--无考试信息--");
 	 	}else{
 	 	
 	 	for(String[] hast : havedovv){
 	 		hi++;
 	 		String hanswerid = hast[0];
 	 		String huserid = hast[1];
 	 	
 	 %>			
 				<%
	 	Vector<String[]> morevv = null;
	 	String mosql = "select answertitle,username from answer,userinfo where answerid='"+hanswerid+"' and userid='"+huserid+"'";
	 	mosql = new String(mosql.getBytes("UTF-8"),"UTF-8");
	 	morevv = DataBase.getMessage(mosql);
	 	int size = morevv.size();
	 	System.out.println("size=="+size);
	 	for(String[] st : morevv){
	 		String stanswertitle = st[0];
			String stusername = st[1];
			System.out.println("stanswertitle=="+stanswertitle);
			System.out.println("stusername=="+stusername);
	  %>
	  <div>
	  <form id="idlookresult<%=hi%>" action="/AnswerSystem/adminservlet" method="post">
	  	<input type="hidden" name="action" value="lookresult">
	  	<input type="hidden" name="answerid" value="<%=hanswerid%>">
	  	<input type="hidden" name="userid" value="<%=huserid%>">
	  </form>
	  	<div onclick="look('idlookresult<%=hi%>')" style="width:700px; padding: 20px;margin: 20px; background: #bbe;">
	  		<div><span>--<%=hi%></span>--点击查看批改--</div>
	  		<div>试卷：<%=stanswertitle%>------</div>
	  		<div>姓名：<%=stusername%>------</div>
	  	</div>
	  </div>
	  <%
	  	}
	   %>
	   		
	
	<%
			}//循环输出
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