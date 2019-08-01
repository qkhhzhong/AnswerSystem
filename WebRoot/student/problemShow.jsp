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
<!DOCTYPE >
<html>
  <head>
    <title>试卷展示</title>
 <script type="text/javascript">
 	function checksubmit(){
 	
 		var single = document.getElementsByName("smsingle");
 		for(var sin=0 ; sin < single.length ; sin++){
 			var thesingle = null;
			thesingle = single[sin].value;
 			if(thesingle == null || thesingle == ""){
 				alert("请完成单选题");
 				return false;
 			}
 		}
 		
 		var multime = document.getElementsByName("smmultime");//多选题次数
 		for(var mtime = 0 ; mtime < multime.length ; mtime++){
 			var idtime = mtime+1;// 获取某一个name 
 			var multiple = document.getElementsByName("smmulti"+idtime);
 			var themultiple = "";//这里是一个name,多选的多个选择
 			for(var mul=0 ; mul < multiple.length ; mul++){
 				if(multiple[mul].checked){
 					themultiple += multiple[mul].value;
 				}
 			}
 			if(themultiple == null || themultiple == ""){
 				alert("请完成多选题");
 				return false;
 			}
 		}
 	
 	
 		var panduan = document.getElementsByName("smpanduan");
 		for(var pan=0 ; pan < panduan.length ; pan++){
 			var thepanduan = null;
			thepanduan = panduan[pan].value;
 			if(thepanduan == null || thepanduan == ""){
 				alert("请完成判断题");
 				return false;
 			}
 		} 
 	
 		var tiankong = document.getElementsByName("smtiankong");
 		for(var tia=0 ; tia < tiankong.length ; tia++){
 			var thetiankong = null;
 			thetiankong = tiankong[tia].value;
 			if(thetiankong == null || thetiankong.trim() ==""){
 				alert("请完成填空题");
 				return false;
 			}
 		}
 		
 		var jianda = document.getElementsByName("smjianda");
 		for(var jia=0 ; jia < jianda.length ; jia++){
 			var thejianda = null;
 			thejianda = jianda[jia].value;
 			if(thejianda == null || thejianda.trim() ==""){
 				alert("请完成简答题");
 				return false;
 			}
 		}
 		
 		var wenda = document.getElementsByName("smwenda");
 		for(var wen=0 ; wen < wenda.length ; wen++){
 			var thewenda = null;
 			thewenda = wenda[wen].value;
 			if(thewenda == null || thewenda.trim() ==""){
 				alert("请完成问答题");
 				return false;
 			}
 		}
 		
 		var fujia = document.getElementsByName("smfujia");
 		for(var fu=0 ; fu < fujia.length ; fu++){
 			var thefujia = null;
 			thefujia = fujia[fu].value;
 			if(thefujia == null || thefujia.trim() ==""){
 				alert("请完成附加题");
 				return false;
 			}
 		}
 		
 		return true;
 	}
 </script>
  </head>
  <body style="background:url(/AnswerSystem/images/main.jpg);background-size: cover;">
	<div style="margin:0 auto;width: 1000px;height: 150px;">
		<div style="padding-top: 60px;padding-left: 50px; font-size: 25px;">欢迎您：<%=username%></div>
	</div>
    <jsp:include page="problemheader.jsp" ></jsp:include>
 	<br>
 	<div style="margin:0 auto;width: 1000px;">
<%//试卷标题，说明
	Vector<String[]> ansvv = null;
	String anssql = "select answertitle,answerdetail from "+
	" answer where answerid='"+answerid+"'";
	anssql = new String(anssql.getBytes("UTF-8"),"UTF-8");
	ansvv = DataBase.getMessage(anssql);
	for(String[] anst : ansvv){
		String stanswertitle = anst[0];
		String stanswerdetail = anst[1];
		System.out.println("stanswertitle=="+anst[0]);
		System.out.println("stanswerdetail=="+anst[1]);
%>
 	
 		<div style="text-align: center;"><%=stanswertitle%></div>
 		<div style="padding-left: 50px;">说明：<%=stanswerdetail%></div>
<%
	}
 %>

	<form action="/AnswerSystem/stuservlet" method="post" onsubmit="return checksubmit()">
		<input type="hidden" name="action" value="submitproblem">
		<input type="hidden" name="answerid" value="<%=answerid%>">
		<input type="hidden" name="userid" value="<%=userid%>">
		<br><hr><br><div>一、单选题</div> 		
<%//单选题
	Vector<String[]> singless = null;
	String singsql = "select problemid,ptitle,pa,pb,pc,pd,pkey,pscore,ptype,pcreatetime,answerid from"+
	" probleminfo where answerid='"+answerid+"' and ptype='single' order by pcreatetime asc";
	singsql = new String(singsql.getBytes("UTF-8"),"UTF-8");
	singless = DataBase.getMessage(singsql);
	int singsize = singless.size();
	int singi = 0;
	System.out.println("singsize=="+singsize);
	for(String[] st : singless){
		singi++;
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
	  <div><%=singi%>、<%=stptitle%>--------分值：<%=stpscore%></div>
	  <div style="padding-left: 40px;">
		  A、<%=stpa%><br>B、<%=stpb%><br>
		  C、<%=stpc%><br>D、<%=stpd%>
	  </div><br>
	  <div><select name="smsingle" id="smsingle<%=singi%>">
	  			<option value="">请选择</option>
			  	<option value="A">A</option>
			  	<option value="B">B</option>
			  	<option value="C">C</option>
			  	<option value="D">D</option>
			</select>
	  </div>
	  <input type="hidden" name="singleproblemid" value="<%=stproblemid%>">
	  <br>
<%
	}
%>	
 	<br><hr><br><div>二、多选题</div> 
<%//多选题
	Vector<String[]> multivv = null;
	String multisql = "select problemid,ptitle,pa,pb,pc,pd,pkey,pscore,ptype,pcreatetime,answerid from"+
	" probleminfo where answerid='"+answerid+"' and ptype='multiple' order by pcreatetime asc";
	multisql = new String(multisql.getBytes("UTF-8"),"UTF-8");
	multivv = DataBase.getMessage(multisql);
	int mulsize = multivv.size();
	int muli = 0;
	System.out.println("mulsize=="+mulsize);
	for(String[] st : multivv){
		muli++;
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
	  <div><%=muli%>、<%=stptitle%>--------分值：<%=stpscore%></div>
	  <div style="padding-left: 40px;">
		  A、<%=stpa%><br>B、<%=stpb%><br>
		  C、<%=stpc%><br>D、<%=stpd%>
	  </div><br>
	  <div>
	  	<input type="hidden" name="smmultime"><!-- js验证是否为空，判断个数 -->
	  	<input type="checkbox" name="smmulti<%=muli%>" value="A">A
	  	<input type="checkbox" name="smmulti<%=muli%>" value="B">B
	 	<input type="checkbox" name="smmulti<%=muli%>" value="C">C
	 	<input type="checkbox" name="smmulti<%=muli%>" value="D">D
	 </div>
	 <input type="hidden" name="multiproblemid" value="<%=stproblemid%>">
	 <br>
<%
	}
%>	
		<input type="hidden" name="smmultilength" value="<%=muli%>">
 	<br><hr><br><div>三、判断题</div> 
<%//判断题
	 	Vector<String[]> panduanvv = null;
	 	String panduansql = "select problempanduanid,ppcontent,ppkey,ppscore,pcreatetime,answerid from"+
	 	" problempanduan where answerid='"+answerid+"' order by pcreatetime asc";
	 	panduansql = new String(panduansql.getBytes("UTF-8"),"UTF-8");
	 	panduanvv = DataBase.getMessage(panduansql);
	 	int pdsize = panduanvv.size();
	 	int pdi = 0;
	 	System.out.println("pdsize=="+pdsize);
	 	for(String[] st : panduanvv){
	 		pdi++;
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
	  <div>
	  	<%=pdi%>、<%=stppcontent%>（   ）--------分值：<%=stppscore%>
	  </div><br>
	  <div><select name="smpanduan" id="smpanduan<%=pdi%>">
	  			<option value="">请选择</option>
			  	<option value="yes">正确</option>
			  	<option value="no">错误</option>
			</select>
	  </div>
	  <input type="hidden" name="pdproblemid" value="<%=stproblempanduanid%>">
	  <br>
<%
	}
%> 	
 	
 	<br><hr><br><div>四、填空题</div> 
<%
	Vector<String[]> tiankongvv = null;
	String tksql = "select problemquestid,pqcontent,pqkey,pqscore,pqtype,pcreatetime,answerid from "+
	" problemquestinfo where answerid='"+answerid+"' and pqtype='tiankong' order by pcreatetime asc";
	tksql = new String(tksql.getBytes("UTF-8"),"UTF-8");
	tiankongvv = DataBase.getMessage(tksql);
	int tksize = tiankongvv.size();
	int tki = 0;
	System.out.println("tksize=="+tksize);
	for(String[] st : tiankongvv){
		tki++;
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
	  <div>
	  	<%=tki%>、<%=stpqcontent%>--------分值：<%=stpqscore%>
	  </div><br>
	  <div>
	 		请按顺序写答案：<br><textarea rows="8" cols="80" name="smtiankong"></textarea>
	 </div>
	 <input type="hidden" name="tkproblemid" value="<%=stproblemquestid%>">
	 <br>
<%
	}
%>
 	
	<br><hr><br><div>五、简答题</div> 
<%
	Vector<String[]> jiandavv = null;
	String jdsql = "select problemquestid,pqcontent,pqkey,pqscore,pqtype,pcreatetime,answerid from "+
	" problemquestinfo where answerid='"+answerid+"' and pqtype='jianda' order by pcreatetime asc";
	jdsql = new String(jdsql.getBytes("UTF-8"),"UTF-8");
	jiandavv = DataBase.getMessage(jdsql);
	int jdsize = jiandavv.size();
	int jdi = 0;
	System.out.println("jdsize=="+jdsize);
	for(String[] st : jiandavv){
		jdi++;
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
	  <div>
	  	<%=jdi%>、<%=stpqcontent%>--------分值：<%=stpqscore%>
	  </div><br>
	  <div>
	 		请填写：<br><textarea rows="8" cols="80" name="smjianda"></textarea>
	 </div>
	 <input type="hidden" name="jdproblemid" value="<%=stproblemquestid%>">
	 <br>
<%
	}
%> 	

	<br><hr><br><div>六、问答题（客户常问问题）</div> 
<%//问答题
	Vector<String[]> wendavv = null;
	String wdsql = "select problemquestid,pqcontent,pqkey,pqscore,pqtype,pcreatetime,answerid from "+
	" problemquestinfo where answerid='"+answerid+"' and pqtype='wenda' order by pcreatetime asc";
	wdsql = new String(wdsql.getBytes("UTF-8"),"UTF-8");
	wendavv = DataBase.getMessage(wdsql);
	int wdsize = wendavv.size();
	int wdi = 0;
	System.out.println("wdsize=="+wdsize);
	for(String[] st : wendavv){
		wdi++;
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
	  <div>
	  	<%=wdi%>、<%=stpqcontent%>--------分值：<%=stpqscore%>
	  </div><br>
	  <div>
	 	请填写：<br><textarea rows="8" cols="80" name="smwenda"></textarea>
	  </div>
	  <input type="hidden" name="wdproblemid" value="<%=stproblemquestid%>">
	  <br>
<%
	}
%>

	<br><hr><br><div>七、附加题</div>
<%//附加题
	 	Vector<String[]> fujiavv = null;
	 	String sql = "select problemquestid,pqcontent,pqkey,pqscore,pqtype,pcreatetime,answerid from "+
	 	" problemquestinfo where answerid='"+answerid+"' and pqtype='fujia' order by pcreatetime asc";
	 	sql = new String(sql.getBytes("UTF-8"),"UTF-8");
	 	fujiavv = DataBase.getMessage(sql);
	 	int fjsize = fujiavv.size();
	 	int fji = 0;
	 	System.out.println("fjsize=="+fjsize);
	 	for(String[] st : fujiavv){
	 		fji++;
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
	  <div>
	  	<%=fji%>、<%=stpqcontent%>--------分值：<%=stpqscore%>
	  </div><br>
	  <div>
	 	请填写：<br><textarea rows="8" cols="80" name="smfujia"></textarea>
	 </div>
	 <input type="hidden" name="fjproblemid" value="<%=stproblemquestid%>">
	 <br>
<%
	}
%>
	<input type="submit" value="提交"><input type="reset" value="重置">
</form>
		<br><br><hr><br>
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