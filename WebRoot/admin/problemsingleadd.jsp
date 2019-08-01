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
  		var ptitle = document.getElementsByName("ptitle")[0].value;
  		var pa = document.getElementsByName("pa")[0].value;
  		var pb = document.getElementsByName("pb")[0].value;
  		var pc = document.getElementsByName("pc")[0].value;
  		var pd = document.getElementsByName("pd")[0].value;
  		var pscore = document.getElementsByName("pscore")[0].value;
  		if(ptitle == null || ptitle.trim() == ""){
  			alert("请填写题目");
  			return false;
  		}
  		if(pa == null || pa.trim() == ""){
  			alert("请填写A");
  			return false;
  		}
  		if(pb == null || pb.trim() == ""){
  			alert("请填写B");
  			return false;
  		}
  		if(pc == null || pc.trim() == ""){
  			alert("请填写C");
  			return false;
  		}
  		if(pd == null || pd.trim() == ""){
  			alert("请填写D");
  			return false;
  		}
  		if(pscore == null || pscore.trim() == ""){
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
	 <div>
	 	题目名称：<input type="text" name="ptitle" style="width: 800px;height:30px; font-size: 18px;"><br>
	 	A的内容：<input type="text" name="pa" style="width: 600px;height:30px; font-size: 18px;"><br>
	 	B的内容：<input type="text" name="pb" style="width: 600px;height:30px; font-size: 18px;"><br>
	 	C的内容：<input type="text" name="pc" style="width: 600px;height:30px; font-size: 18px;"><br>
	 	D的内容：<input type="text" name="pd" style="width: 600px;height:30px; font-size: 18px;"><br>
	 	设置答案：<select name="pkey" id="pkey" style="width: 50px;height:30px; font-size: 18px;">
			  	<option selected value="A">A</option>
			  	<option value="B" >B</option>
			  	<option value="C">C</option>
			  	<option value="D">D</option>
			  </select><br>
		设置分数：<input type="number" name="pscore" style="width:60px;height: 30px;font-size: 18px;">
	 </div><br>
	 <input type="hidden" name="answerid" value="<%=answerid%>">
	 <input type="hidden" name="action" value="addsingle">
	 <input type="hidden" name="ptype" value="single">
	 <input type="submit" value="提交	" style="width: 50px;height: 30px;">
	 <input type="reset" value="重置" style="width: 50px;height: 30px;">
	</form>
 	<br><hr><br>
 	
 	<%
	 	Vector<String[]> singless = null;
	 	String sql = "select problemid,ptitle,pa,pb,pc,pd,pkey,pscore,ptype,pcreatetime,answerid from"+
	 	" probleminfo where answerid='"+answerid+"' and ptype='single' order by pcreatetime asc";
	 	sql = new String(sql.getBytes("UTF-8"),"UTF-8");
	 	singless = DataBase.getMessage(sql);
	 	int size = singless.size();
	 	int i = 0;
	 	System.out.println("size=="+size);
	 	for(String[] st : singless){
	 		i++;
	 		String stproblemid = st[0];
			String stptitle = st[1];
			String stpa = st[2];
			String stpb = st[3];
			String stpc = st[4];
			String stpd = st[5];
			String stpkey = st[6];
			String stpscore = st[7];
			String stptype = st[8];
			String stpcreatetime = st[9];
			String stanswerid = st[10];
			System.out.println("stproblemid=="+stproblemid);
			System.out.println("stptitle=="+stptitle);
			System.out.println("stanswerid=="+stanswerid);
	  %>
	  <div style="float: left;padding: 10px;width: 700px;">
	  	<%=i%>-问题：<%=stptitle%>--答案：<%=stpkey%>--分值：<%=stpscore%>
	  </div>
	  <div style="float: left;padding: 10px;" onclick="prodele('iddelform<%=i%>')">
	  	<button>删除</button>
	  </div>
	  <form id="iddelform<%=i%>" action="/AnswerSystem/mainservlet" method="post">
	  	<input type="hidden" name="action" value="sindelform">
	  	<input type="hidden" name="deleid" value="<%=stproblemid%>">
	  </form>
	  <%
	  	}
	   %>
		
	</div>		
</body>

</html>
