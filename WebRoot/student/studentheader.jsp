<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<script type="text/javascript">
	function exitlogin(){
		window.location.href="/AnswerSystem/student/stulogin.jsp"; 
	}
		
</script>
<style>
.all{
	width: 1050px;
	height: 50.8px;
	background: #e4fafa;
	margin:0 auto;
}
</style>

<div class="all">
<div style="float: left;margin: 10px;padding-left: 100px;">
 	<a href="/AnswerSystem/student/stuanswerList.jsp">试卷列表</a>
 </div>
 <div style="float: left;margin: 10px;padding-left: 100px;">
 	<a href="/AnswerSystem/student/problemResultList.jsp">我的考试</a>
 </div>
 <div style="margin:10px; float:right;padding-right: 150px;">
 	<a style="cursor:pointer;" onclick="exitlogin()">退出</a>
 </div>
 <div style="clear: both;"></div>
 
 </div>
