<%@page import="sys.bean.DataBase"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<jsp:useBean id="answerinfo" class="sys.bean.Answerinfo" scope="session"></jsp:useBean>
<jsp:useBean id="userinfo" class="sys.bean.Userinfo" scope="session"></jsp:useBean>
<%
	System.out.println("----------lookResult.jsp------------");
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
	if(userid == null || answerid == null){
		response.sendRedirect("/AnswerSystem/admin/adminlogin.jsp");
	}
 %>
<!DOCTYPE >
<html>
  <head>
    <title>查看答案-分数</title>
 <style type="text/css">
 .header{
 	width: 1050px;
	height: 100px;
	margin:0 auto;
	font-size: 28px;
 }
 </style>
   </head>
  <body style="background:url(/AnswerSystem/images/main.jpg);background-size: cover;">
	<div class="header">
		<div style="background: #e4fafa;margin-top: 100px;">
			<div style="float: left;margin: 10px;">
				<%=username%>的试卷
			</div>
			<div style="float: right;margin: 10px;padding-right: 150px;">
				<a href="/AnswerSystem/admin/lookResultList.jsp">返回</a>
			</div>
			<div style="clear: both;"></div>
		</div>
	</div>
 
 	<br>
 	<div style="margin:0 auto;width: 1000px;font-size: 25px;">
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
 %><br><hr>
 
 	<div style="text-align: center;"><!-- 显示分数 -->
 		<%
 			String sinmulsumsql = "select SUM(pscore) from probleminfo where answerid='"+answerid+"' ";
 		 	sinmulsumsql = new String(sinmulsumsql.getBytes("UTF-8"),"UTF-8");
 		 	String sinmulsum = DataBase.selectOneString(sinmulsumsql);//单选、多选总分
 		 	System.out.println("~~~~~~~~单选多选总分~~~~~~~="+sinmulsum);
 		 	
 		 	String panduansumsql = "select SUM(ppscore) from problempanduan where answerid='"+answerid+"' ";
 		 	panduansumsql = new String(panduansumsql.getBytes("UTF-8"),"UTF-8");
 		 	String panduansum = DataBase.selectOneString(panduansumsql);//判断总分
 		 	System.out.println("~~~~~~~~判断题总分~~~~~~~="+panduansum);
 		 	
 		 	String datisumsql = "select SUM(pqscore) from problemquestinfo where answerid='"+answerid+"' ";
 		 	datisumsql = new String(datisumsql.getBytes("UTF-8"),"UTF-8");
 		 	String datisum = DataBase.selectOneString(datisumsql);//大题总分
 		 	System.out.println("~~~~~~~~大题总分~~~~~~~="+datisum);
 		 	int intsing = 0;
 		 	int intpanduan = 0;
 		 	int intdati = 0;
 		 	if(sinmulsum != null){		 	
 		 		intsing = Integer.parseInt(sinmulsum);
 		 	}
 		 	if(panduansum != null){		 	
 		 		intpanduan = Integer.parseInt(panduansum);
 		 	}
 		 	if(datisum != null){		 	
 		 		intdati = Integer.parseInt(datisum);
 		 	}
 		 	int scoresum = intsing + intpanduan + intdati;
 		 	System.out.println("~~~试卷总分~~~=="+scoresum);
 		 %>
 		试卷总分：<%=scoresum%> -------(单选多选题：<%=sinmulsum%>-------判断题：<%=panduansum%>------大题：<%=datisum%>)
 	</div>
 	<div style="text-align: center;"><!-- 显示分数 -->
 		<%
 			String smsinmulsumsql = "select SUM(smscore) from smprobleminfo where "+
 			" userid='"+userid+"' and answerid='"+answerid+"' ";
 		 	smsinmulsumsql = new String(smsinmulsumsql.getBytes("UTF-8"),"UTF-8");
 		 	String smsinmulsum = DataBase.selectOneString(smsinmulsumsql);//单选、多选总分
 		 	System.out.println("~~~~~~~~获得单选多选总分~~~~~~~="+smsinmulsum);
 		 	
 		 	String smpanduansumsql = "select SUM(smscore) from smproblempanduan where "+
 			" userid='"+userid+"' and answerid='"+answerid+"' ";
 			smpanduansumsql = new String(smpanduansumsql.getBytes("UTF-8"),"UTF-8");
 		 	String smpanduansum = DataBase.selectOneString(smpanduansumsql);//判断总分
 		 	System.out.println("~~~~~~~~获得判断题总分~~~~~~~="+smpanduansum);
 		 	
 		 	String smdatisumsql = "select SUM(smscore) from smproblemquestinfo where "+
 			" userid='"+userid+"' and answerid='"+answerid+"' ";
 		 	smdatisumsql = new String(smdatisumsql.getBytes("UTF-8"),"UTF-8");
 		 	String smdatisum = DataBase.selectOneString(smdatisumsql);//大题总分
 		 	System.out.println("~~~~~~~~获得大题总分~~~~~~~="+smdatisum);
 		 	int smintsing = 0;
 		 	int smintpanduan = 0;
 		 	int smintdati = 0;
 		 	if(smsinmulsum != null){		 	
 		 		intsing = Integer.parseInt(smsinmulsum);
 		 	}
 		 	if(smpanduansum != null){		 	
 		 		intpanduan = Integer.parseInt(smpanduansum);
 		 	}
 		 	if(smdatisum != null){		 	
 		 		intdati = Integer.parseInt(smdatisum);
 		 	}
 		 	int smscoresum = intsing + intpanduan + intdati;
 		 	System.out.println("~~~我的考试得分~~~=="+smscoresum);
 		 %>
		<br>获得总分：<%=smscoresum%> -------(单选多选题：<%=smsinmulsum%>-------判断题：<%=smpanduansum%>------大题：<%=smdatisum%>)
 	</div><br><hr>

		<br><div>一、单选题</div> 		
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
	  <div><span style="background: #fae;">答案：<%=stpkey%></span></div>
	  <%
	  		Vector<String[]> myresulvv = null;
	  		String resulsql = "select smkey,smscore from smprobleminfo where "+
	  		" answerid='"+answerid+"' and userid='"+userid+"' and problemid='"+stproblemid+"'";
	  		resulsql = new String(resulsql.getBytes("UTF-8"),"UTF-8");
	  		myresulvv = DataBase.getMessage(resulsql);
	  		String mysmkey = null;
	  		String mysmscore = null;
	  		for(String[] sinst : myresulvv){
	  			mysmkey = sinst[0];
	  			mysmscore = sinst[1];
	  		}
	   %>  
	  <div><span style="background: #fdd;"><%=username%>的选择：<%=mysmkey%>---得分：<%=mysmscore%></span></div>
	  
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
	 <div><span style="background: #fae;">答案：<%=stpkey%></span></div>
	  <%
	  		Vector<String[]> myresulvv = null;
	  		String resulsql = "select smkey,smscore from smprobleminfo where "+
	  		" answerid='"+answerid+"' and userid='"+userid+"' and problemid='"+stproblemid+"'";
	  		resulsql = new String(resulsql.getBytes("UTF-8"),"UTF-8");
	  		myresulvv = DataBase.getMessage(resulsql);
	  		String mysmkey = null;
	  		String mysmscore = null;
	  		for(String[] sinst : myresulvv){
	  			mysmkey = sinst[0];
	  			mysmscore = sinst[1];
	  		}
	   %>  
	  <div><span style="background: #fdd;"><%=username%>的选择：<%=mysmkey%>---得分：<%=mysmscore%></span></div>
	 <br>
<%
	}
%>	

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
	  <div><span style="background: #fae;">答案：<%=stppkey%></span></div>
	  <%
	  		Vector<String[]> mypdresulvv = null;
	  		String resulsql = "select smkey,smscore from smproblempanduan where "+
	  		" answerid='"+answerid+"' and userid='"+userid+"' and problempanduanid='"+stproblempanduanid+"'";
	  		resulsql = new String(resulsql.getBytes("UTF-8"),"UTF-8");
	  		mypdresulvv = DataBase.getMessage(resulsql);
	  		String mysmkey = null;
	  		String mysmscore = null;
	  		for(String[] sinst : mypdresulvv){
	  			mysmkey = sinst[0];
	  			mysmscore = sinst[1];
	  		}
	   %>  
	  <div><span style="background: #fdd;"><%=username%>的选择：<%=mysmkey%>---得分：<%=mysmscore%></span></div>
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
	  <div style="width: 700px;background:#fae;">
	 		答案：<div style="padding-left: 50px;"><%=stpqkey%></div>
	 </div><br>
	 	<%
	 		Vector<String[]> tkresultvv = null;
	  		String resulsql = "select smkey,smscore,smevaluate from smproblemquestinfo where answerid='"+answerid+"' "+
	  		" and userid='"+userid+"' and problemquestid='"+stproblemquestid+"'";
	  		resulsql = new String(resulsql.getBytes("UTF-8"),"UTF-8");
	  		tkresultvv = DataBase.getMessage(resulsql);
	  		String myskmey = null;
	  		String mysmscore = "";
	  		String myevaluate = "";
	  		for(String[] tkst : tkresultvv){
	  			myskmey = tkst[0];
	  			mysmscore = tkst[1];
	  			myevaluate = tkst[2];
	  			System.out.println("myskmey=="+myskmey);
	  			System.out.println("mysmscore=="+mysmscore);
	  			System.out.println("myevaluate=="+myevaluate);
	  		}
	 	 %> 
	 <div style="width:700px;background: #fdd;"><%=username%>的回答：<div style="padding-left: 50px;"><%=myskmey%></div></div><br>
	 <div style="width:700px;"><span style="background: #fee;"><%=myevaluate.equals("0")?"":"评价："+myevaluate%></span></div><br>
	 <div><span style="background: #ffe;"><%=mysmscore.equals("0")?"---未批改---":"---得分："+mysmscore%></span></div>
	 
	  		
	  		<form action="/AnswerSystem/adminservlet" method="post">
	  			<input type="hidden" name="action" value="givescore">
	  			<input type="hidden" name="answerid" value="<%=answerid%>">
	  			<input type="hidden" name="userid" value="<%=userid%>">
	  			<input type="hidden" name="problemquestid" value="<%=stproblemquestid%>">
	  			<div><br>评价：<br><textarea name="giveevaluate" style="width:700px;height:150px;font-size: 25px;"></textarea></div>
		  		<div>打分：<input type="number" name="givescore" style="width: 70px;height: 40px;font-size: 25px;"></div>
	  			<div style="padding-top: 5px;padding-left: 220px;">
	  				<input type="submit" value="确定" style="width: 80px;height: 40px;font-size: 22px;">
	  			</div>
	  		</form>

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
	  <div style="width: 700px;background:#fae;">
	 		答案：<div style="padding-left: 50px;"><%=stpqkey%></div>
	 </div><br>
	 	<%
	 		Vector<String[]> tkresultvv = null;
	  		String resulsql = "select smkey,smscore,smevaluate from smproblemquestinfo where answerid='"+answerid+"' "+
	  		" and userid='"+userid+"' and problemquestid='"+stproblemquestid+"'";
	  		resulsql = new String(resulsql.getBytes("UTF-8"),"UTF-8");
	  		tkresultvv = DataBase.getMessage(resulsql);
	  		String myskmey = null;
	  		String mysmscore = "";
	  		String myevaluate = "";
	  		for(String[] tkst : tkresultvv){
	  			myskmey = tkst[0];
	  			mysmscore = tkst[1];
	  			myevaluate = tkst[2];
	  			System.out.println("myskmey=="+myskmey);
	  			System.out.println("mysmscore=="+mysmscore);
	  			System.out.println("myevaluate=="+myevaluate);
	  		}
	 	 %> 
	 <div style="width:700px;background: #fdd;"><%=username%>的回答：<div style="padding-left: 50px;"><%=myskmey%></div></div><br>
	 <div style="width:700px;"><span style="background: #ffe;"><%=myevaluate.equals("0")?"":"评价："+myevaluate%></span></div><br>
	 <div><span style="background: #ffe;"><%=mysmscore.equals("0")?"---未批改---":"---得分："+mysmscore%></span></div>

	  		<form action="/AnswerSystem/adminservlet" method="post">
	  			<input type="hidden" name="action" value="givescore">
	  			<input type="hidden" name="answerid" value="<%=answerid%>">
	  			<input type="hidden" name="userid" value="<%=userid%>">
	  			<input type="hidden" name="problemquestid" value="<%=stproblemquestid%>">
		  		<div><br>评价：<br><textarea name="giveevaluate" style="width:700px;height:150px;font-size: 25px;"></textarea></div>
		  		<div>打分：<input type="number" name="givescore" style="width: 70px;height: 40px;font-size: 25px;"></div>
	  			<div style="padding-top: 5px;padding-left: 220px;">
	  				<input type="submit" value="确定" style="width: 80px;height: 40px;font-size: 22px;">
	  			</div>
	  		</form>

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
	  <div style="width: 700px;background:#fae;">
	 		答案：<div style="padding-left: 50px;"><%=stpqkey%></div>
	 </div><br>
	 	<%
	 		Vector<String[]> tkresultvv = null;
	  		String resulsql = "select smkey,smscore,smevaluate from smproblemquestinfo where answerid='"+answerid+"' "+
	  		" and userid='"+userid+"' and problemquestid='"+stproblemquestid+"'";
	  		resulsql = new String(resulsql.getBytes("UTF-8"),"UTF-8");
	  		tkresultvv = DataBase.getMessage(resulsql);
	  		String myskmey = null;
	  		String mysmscore = "";
	  		String myevaluate = "";
	  		for(String[] tkst : tkresultvv){
	  			myskmey = tkst[0];
	  			mysmscore = tkst[1];
	  			myevaluate = tkst[2];
	  			System.out.println("myskmey=="+myskmey);
	  			System.out.println("mysmscore=="+mysmscore);
	  			System.out.println("myevaluate=="+myevaluate);
	  		}
	 	 %> 
	 <div style="width:700px;background: #fdd;"><%=username%>的回答：<div style="padding-left: 50px;"><%=myskmey%></div></div><br>
	 <div style="width:700px;"><span style="background: #ffe;"><%=myevaluate.equals("0")?"":"评价："+myevaluate%></span></div><br>
	 <div><span style="background: #ffe;"><%=mysmscore.equals("0")?"---未批改---":"---得分："+mysmscore%></span></div>

	  		<form action="/AnswerSystem/adminservlet" method="post">
	  			<input type="hidden" name="action" value="givescore">
	  			<input type="hidden" name="answerid" value="<%=answerid%>">
	  			<input type="hidden" name="userid" value="<%=userid%>">
	  			<input type="hidden" name="problemquestid" value="<%=stproblemquestid%>">
		  		<div><br>评价：<br><textarea name="giveevaluate" style="width:700px;height:150px;font-size: 25px;"></textarea></div>
		  		<div>打分：<input type="number" name="givescore" style="width: 70px;height: 40px;font-size: 25px;"></div>
	  			<div style="padding-top: 5px;padding-left: 220px;">
	  				<input type="submit" value="确定" style="width: 80px;height: 40px;font-size: 22px;">
	  			</div>
	  		</form>

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
	   <div style="width: 700px;background:#fae;">
	 		答案：<div style="padding-left: 50px;"><%=stpqkey%></div>
	 </div><br>
	 	<%
	 		Vector<String[]> tkresultvv = null;
	  		String resulsql = "select smkey,smscore,smevaluate from smproblemquestinfo where answerid='"+answerid+"' "+
	  		" and userid='"+userid+"' and problemquestid='"+stproblemquestid+"'";
	  		resulsql = new String(resulsql.getBytes("UTF-8"),"UTF-8");
	  		tkresultvv = DataBase.getMessage(resulsql);
	  		String myskmey = null;
	  		String mysmscore = "";
	  		String myevaluate = "";
	  		for(String[] tkst : tkresultvv){
	  			myskmey = tkst[0];
	  			mysmscore = tkst[1];
	  			myevaluate = tkst[2];
	  			System.out.println("myskmey=="+myskmey);
	  			System.out.println("mysmscore=="+mysmscore);
	  			System.out.println("myevaluate=="+myevaluate);
	  		}
	 	 %> 
	 <div style="width:700px;background: #fdd;"><%=username%>的回答：<div style="padding-left: 50px;"><%=myskmey%></div></div><br>
	 <div style="width:700px;"><span style="background: #ffe;"><%=myevaluate.equals("0")?"":"评价："+myevaluate%></span></div><br>
	 <div><span style="background: #ffe;"><%=mysmscore.equals("0")?"---未批改---":"---得分："+mysmscore%></span></div>

	  		<form action="/AnswerSystem/adminservlet" method="post">
	  			<input type="hidden" name="action" value="givescore">
	  			<input type="hidden" name="answerid" value="<%=answerid%>">
	  			<input type="hidden" name="userid" value="<%=userid%>">
	  			<input type="hidden" name="problemquestid" value="<%=stproblemquestid%>">
		  		<div><br>评价：<br><textarea name="giveevaluate" style="width:700px;height:150px;font-size: 25px;"></textarea></div>
		  		<div>打分：<input type="number" name="givescore" style="width: 70px;height: 40px;font-size: 25px;"></div>
	  			<div style="padding-top: 5px;padding-left: 220px;">
	  				<input type="submit" value="确定" style="width: 80px;height: 40px;font-size: 22px;">
	  			</div>
	  		</form>

	 <br>
<%
	}
%>
		<br><br><hr><br>
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