<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<jsp:useBean id="answerinfo" class="sys.bean.Answerinfo" scope="session"></jsp:useBean>
<%
	String answertitle = answerinfo.getAnswertitle();
 %>
<style>
.all{
	width: 1050px;
	height: 50.8px;
	background: #e4fafa;
	margin:0 auto;
}
</style>
<div style="margin:0 auto;width: 1000px;height: 150px;">
		<div style="padding-top: 60px;text-align:center; font-size: 25px;">设计试卷:<%=answertitle%></div>
	</div>
<div class="all">

 <div style="float: left;margin: 10px;">
 	<a href="/AnswerSystem/admin/problemsingleadd.jsp">单选题</a>
 </div>
<div style="float: left;margin: 10px;">
 	<a href="/AnswerSystem/admin/problemmultipleadd.jsp">多选题</a>
 </div>
 <div style="float: left;margin: 10px;">
 	<a href="/AnswerSystem/admin/problemPanDuan.jsp">判断题</a>
 </div>
 <div style="float: left;margin: 10px;">
 	<a href="/AnswerSystem/admin/problemQuestTianKong.jsp">填空题</a>
 </div>
 <div style="float: left;margin: 10px;">
 	<a href="/AnswerSystem/admin/problemQuestJianDa.jsp">简答题</a>
 </div>
 <div style="float: left;margin: 10px;">
 	<a href="/AnswerSystem/admin/problemQuestWenDa.jsp">问答题</a>
 </div>
  <div style="float: left;margin: 10px;">
 	<a href="/AnswerSystem/admin/problemQuestFuJia.jsp">附加题</a>
 </div>
 <div style="float: left;margin: 10px;">
 	<a href="/AnswerSystem/admin/problemShow.jsp">试卷展示</a>
 </div>
 <div style="float: left;margin: 10px;padding-left: 20px;">
 	<a href="/AnswerSystem/admin/createAnswer.jsp">返回</a>
 </div>
 <div style="clear: both;"></div>
 
 </div>

