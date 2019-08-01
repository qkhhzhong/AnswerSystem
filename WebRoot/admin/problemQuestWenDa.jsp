<%@page import="sys.bean.DataBase"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<jsp:useBean id="answerinfo" class="sys.bean.Answerinfo" scope="session"></jsp:useBean>
<jsp:useBean id="admininfo" class="sys.bean.Admininfo" scope="session"></jsp:useBean>
<%
	System.out.println("----------problemQuestWenDa.jsp.jsp------------");
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
    <title>问答题</title>
   <script type="text/javascript">
  	function prodele(iddelform){
  		document.getElementById(iddelform).submit();
  	}
  	
  	function checksubmit(){
  		var pqcontent = document.getElementsByName("pqcontent")[0].value;
  		var pqkey = document.getElementsByName("pqkey")[0].value;
  		var pqscore = document.getElementsByName("pqscore")[0].value;
  		if(pqcontent == null || pqcontent.trim() == ""){
  			alert("请填写内容");
  			return false;
  		}
  		if(pqkey == null || pqkey.trim() == ""){
  			alert("请填写答案");
  			return false;
  		}
  		if(pqscore == null || pqscore.trim() == ""){
  			alert("请设置分数");
  			return false;
  		}
  		return true;
  	}
  </script>
   </head>
  <body style="background:url(/AnswerSystem/images/main.jpg);background-size: cover;">
    <jsp:include page="problemheader.jsp" ></jsp:include>
 	<br>
 	<div style="margin:0 auto;width: 1000px;">
	  <form action="/AnswerSystem/adminservlet" method="post" onsubmit="return checksubmit()">
	 	<input type="hidden" name="action" value="addquest">	
	 	<input type="hidden" name="pqtype" value="wenda">
	 	<input type="hidden" name="answerid" value="<%=answerid%>">
	 	<div>
	 		问答题内容：（问答题为客户常问问题）<br><textarea rows="8" cols="80" name="pqcontent" style="font-size: 18px;"></textarea>
	  	</div>
	 	<div>
	 		问答题答案：<br><textarea rows="8" cols="80" name="pqkey" style="font-size: 18px;"></textarea>
	 	</div>
	 	<div><br>设置分值：
	 		<input type="number" name="pqscore" style="width:60px;height: 30px;font-size: 18px;">
	 	</div>
	 	
	 	<br><input type="submit" value="提交" style="width: 50px;height: 30px;">
	 	<input type="reset" value="重置" style="width: 50px;height: 30px;">
	  </form>
 	<br><hr><br>
 	
 	<%
	 	Vector<String[]> writess = null;
	 	String sql = "select problemquestid,pqcontent,pqkey,pqscore,pqtype,pcreatetime,answerid from "+
	 	" problemquestinfo where answerid='"+answerid+"' and pqtype='wenda' order by pcreatetime asc";
	 	sql = new String(sql.getBytes("UTF-8"),"UTF-8");
	 	writess = DataBase.getMessage(sql);
	 	int size = writess.size();
	 	int i = 0;
	 	System.out.println("size=="+size);
	 	for(String[] st : writess){
	 		i++;
	 		String stproblemquestid = st[0];
			String stpqcontent = st[1];
			String stpqkey = st[2];
			String stpqscore = st[3];
			String stpqtype = st[4];
			String stpcreatetime = st[5];
			String stanswerid = st[6];
			System.out.println("stpqcontent=="+stpqcontent);
			System.out.println("stpqtype=="+stpqtype);
			System.out.println("stanswerid=="+stanswerid);
	  %>
	  <div style="float: left;padding: 10px;width: 700px;">
		  <div><%=i%>问题：<%=stpqcontent%> </div>
		  <div>&nbsp;答案：<%=stpqkey%></div>
		  <div>&nbsp;分值：<%=stpqscore%></div>
	  </div>
	  <div style="float: left;padding: 10px;" onclick="prodele('iddelform<%=i%>')">
	  	<button>删除</button>
	  </div>
	  <form id="iddelform<%=i%>" action="/AnswerSystem/mainservlet" method="post">
	  	<input type="hidden" name="action" value="wendadelform">
	  	<input type="hidden" name="deleid" value="<%=stproblemquestid%>">
	  </form>
	  <%
	  	}
	   %>
		
	</div>		
</body>

</html>
