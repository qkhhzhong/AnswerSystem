<%@page import="sys.bean.DataBase"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<jsp:useBean id="answerinfo" class="sys.bean.Answerinfo" scope="session"></jsp:useBean>
<jsp:useBean id="admininfo" class="sys.bean.Admininfo" scope="session"></jsp:useBean>
<%
	System.out.println("----------problemsingleadd.jsp------------");
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
    <title>添加单选题目</title>
   <script type="text/javascript">
  	function prodele(iddelform){
  		document.getElementById(iddelform).submit();
  	}
  	
  	function checksubmit(){
  		var ppcontent = document.getElementsByName("ppcontent")[0].value;
  		var ppkey = document.getElementsByName("ppkey")[0].value;
  		var ppscore = document.getElementsByName("ppscore")[0].value;
  		if(ppcontent == null || ppcontent.trim() == ""){
  			alert("请填写判断题内容");
  			return false;
  		}
  		if(ppkey == null || ppkey.trim() == ""){
  			alert("请填写答案");
  			return false;
  		}
  		if(ppscore == null || ppscore.trim() == ""){
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
 	 <input type="hidden" name="answerid" value="<%=answerid%>">
	 <input type="hidden" name="action" value="addpanduan">
 	 <div>判断题内容<br><textarea name="ppcontent" style="width: 600px;height:120px; font-size: 18px;"></textarea></div>
	 <div><br>设置答案<select name="ppkey" style="width:60px;height: 30px;font-size: 18px;">
			  	<option selected value="yes">正确</option>
			  	<option value="no">错误</option>
			  </select>	
	 </div>
	 <div>设置分数<input type="number" name="ppscore" style="width:60px;height: 30px;font-size: 18px;"></div>
	 
	 <br><input type="submit" value="提交	" style="width: 50px;height: 30px;">
	 <input type="reset" value="重置" style="width: 50px;height: 30px;">
	</form>
 	<br><hr><br>
 	
 	<%
	 	Vector<String[]> panduanvv = null;
	 	String sql = "select problempanduanid,ppcontent,ppkey,ppscore,pcreatetime,answerid from"+
	 	" problempanduan where answerid='"+answerid+"' order by pcreatetime asc";
	 	sql = new String(sql.getBytes("UTF-8"),"UTF-8");
	 	panduanvv = DataBase.getMessage(sql);
	 	int size = panduanvv.size();
	 	int i = 0;
	 	System.out.println("size=="+size);
	 	for(String[] st : panduanvv){
	 		i++;
	 		String stproblempanduanid = st[0];
			String stppcontent = st[1];
			String stppkey = st[2];
			String stppscore = st[3];
			String stpcreatetime = st[4];
			String stanswerid = st[5];
			System.out.println("stppcontent=="+stppcontent);
			System.out.println("stppkey=="+stppkey);
			System.out.println("stanswerid=="+stanswerid);
	  %>
	  <div style="float: left;padding: 10px;width: 700px;">
	  	<%=i%>-问题：<%=stppcontent%>--答案：<%=stppkey%>--分值：<%=stppscore%>
	  </div>
	  <div style="float: left;padding: 10px;" onclick="prodele('iddelform<%=i%>')">
	  	<button>删除</button>
	  </div>
	  <form id="iddelform<%=i%>" action="/AnswerSystem/mainservlet" method="post">
	  	<input type="hidden" name="action" value="panduandelform">
	  	<input type="hidden" name="deleid" value="<%=stproblempanduanid%>">
	  </form>
	  <%
	  	}
	   %>
		
	</div>		
</body>

</html>
