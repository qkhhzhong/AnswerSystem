<%@page import="sys.bean.DataBase"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<jsp:useBean id="answerinfo" class="sys.bean.Answerinfo" scope="session"></jsp:useBean>
<jsp:useBean id="admininfo" class="sys.bean.Admininfo" scope="session"></jsp:useBean>
<%
	System.out.println("----------problemShow.jsp------------");
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
    <title>试卷展示</title>
   </head>
  <body style="background:url(/AnswerSystem/images/main.jpg);background-size: cover;">
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
	  </div>
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
	  </div>
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
	  </div>
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
	  </div>
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
	  </div>
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
	  </div>
<%
	}
%>


		<br><br><hr><br>
	</div>		
</body>

</html>
