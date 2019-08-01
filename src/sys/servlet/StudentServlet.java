package sys.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Vector;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import sys.bean.Admininfo;
import sys.bean.Answerinfo;
import sys.bean.DataBase;
import sys.bean.Userinfo;

public class StudentServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		this.doPost(request, response);
	}


	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		System.out.println("~~~~~~~~~~StudentServlet.java~~~~~~~~~~~~~~~~");
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		String message = null;
		HttpSession session = request.getSession(true);
		PrintWriter out = response.getWriter();
		String action = request.getParameter("action");
		
		Admininfo admininfo = (Admininfo)session.getAttribute("admininfo");
		if(admininfo==null){
			admininfo = new Admininfo();
			session.setAttribute("admininfo",admininfo);
		}
		
		Answerinfo answerinfo = (Answerinfo)session.getAttribute("answerinfo");
		if(answerinfo==null){
			answerinfo = new Answerinfo();
			session.setAttribute("answerinfo",answerinfo);
		}
		
		Userinfo userinfo = (Userinfo)session.getAttribute("userinfo");
		if(userinfo==null){
			userinfo = new Userinfo();
			session.setAttribute("userinfo",userinfo);
		}
		
		System.out.printf("--action==="+action+"--\n");
		if(action == null){return;}
		if(action.equals("showproblem")){//用户进入某试卷进行答题
			String answerid = request.getParameter("answerid");
			String answertitle = request.getParameter("answertitle");
			String answerdetail = request.getParameter("answerdetail");
			System.out.println("answerid=="+answerid);
			System.out.println("answertitle=="+answertitle);
			System.out.println("answerdetail=="+answerdetail);
			answerinfo.setAnswerid(answerid);
			answerinfo.setAnswertitle(answertitle);
			answerinfo.setAnswerdetail(answerdetail);
			request.setAttribute("answerinfo", answerinfo);
			this.getServletContext().getRequestDispatcher("/student/problemShow.jsp").forward(request, response);
		}
		else if(action.equals("lookproblem")){//用户进入已答试卷进入查看成绩。
			String answerid = request.getParameter("answerid");
			String answertitle = request.getParameter("answertitle");
			String answerdetail = request.getParameter("answerdetail");
			String userid = request.getParameter("userid");
			System.out.println("answerid=="+answerid);
			System.out.println("answertitle=="+answertitle);
			System.out.println("answerdetail=="+answerdetail);
			System.out.println("userid=="+userid);
			answerinfo.setAnswerid(answerid);
			answerinfo.setAnswertitle(answertitle);
			answerinfo.setAnswerdetail(answerdetail);
			request.setAttribute("answerinfo", answerinfo);
			String usersql = "select username,userpassword from userinfo where userid='"+userid+"'";
			usersql = new String(usersql.getBytes("UTF-8"),"UTF-8");
			Vector<String[]> vv = null;
			vv = DataBase.getMessage(usersql);
			String username = null;
			String userpassword = null;
			for(String[] st:vv){
				username  = st[0];
				userpassword = st[1];
			}
			userinfo.setUserid(userid);
			userinfo.setUsername(username);
			userinfo.setUserpassword(userpassword);
			
			this.getServletContext().getRequestDispatcher("/student/problemResult.jsp").forward(request, response);
		}
		else if(action.equals("submitproblem")){//员工交试卷
			String answerid = request.getParameter("answerid");//试卷id
			String userid = request.getParameter("userid");//员工id
			System.out.println("---answerid---"+answerid);
			System.out.println("---userid---"+userid);
			if(userid.equals("null") || userid == null){
				System.out.println("--跳到登录--");
				this.getServletContext().getRequestDispatcher("/student/stulogin.jsp").forward(request, response);
				return;
			}
			
			String checkhavedosql = "select smproblemid from smprobleminfo " +
					" where answerid='"+answerid+"' and userid='"+userid+"'";
			checkhavedosql = new String(checkhavedosql.getBytes("UTF-8"),"UTF-8");
			Vector<String[]> havedovv = DataBase.getMessage(checkhavedosql);
			int havedo = havedovv.size();
			System.out.println("havedo=="+havedo);
			if(havedo >= 1){
				message = "只能提交一次";
				System.out.println("message=="+message);
				request.setAttribute("message", message);
				this.getServletContext().getRequestDispatcher("/student/problemShow.jsp").forward(request, response);
				return;
			}
			
			message = "--false--";
			int haveallnum = 0;
			int singnum = 0;
			int mulnum = 0;
			int pdnum = 0;
			int tknum = 0;
			int jdnum = 0;
			int wdnum = 0;
			int fjnum = 0;
			
			//在这里开启数据库事务，把stat传给数据库
			Connection conn = null;
			Statement stat = null;
			try {
			Context initial = new InitialContext();
			DataSource ds = (DataSource)initial.lookup("java:comp/env/jdbc/AnswerSource");
			conn = ds.getConnection();		
			conn.setAutoCommit(false);//关闭自动提交
			System.out.println("----关闭自动提交--conn.setAutoCommit(false)---");
			System.out.println("----开户事务回滚----");	
			stat = conn.createStatement();
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			//单选
			String[] singleproblemid = request.getParameterValues("singleproblemid");//单选id
			String[] smsingle = request.getParameterValues("smsingle");//所有单选key
			String singlesql = "";
			try{

				for(int pid=0 ; pid < singleproblemid.length ; pid++){
					String sprid = singleproblemid[pid];//传进来的单选id
					System.out.println("sprid=="+sprid);
					
					String keysql = "select pkey,pscore from probleminfo where problemid='"+sprid+"'";
					keysql = new String(keysql.getBytes("UTF-8"),"UTF-8");
					Vector<String[]> keyscorevv = DataBase.getMessage(keysql);	
					String singlekey = null;
					String singscore = null;
					for(String[] st : keyscorevv){
						singlekey = st[0];//这里是单选题的答案
						singscore = st[1];//这里是单选题的分值
					}
					
					String smsinglekey = smsingle[pid];//员工的答的
					System.out.println("smsinglekey=="+smsinglekey);
					
					int smscore = 0;//相等给分不等0分
					if(smsinglekey.equals(singlekey)){
						smscore = Integer.parseInt(singscore);
					}
					System.out.println("答对有分答错没分=="+smscore);
					singlesql = "insert into smprobleminfo(problemid,answerid,userid,smkey,smscore) " +
							"values('"+sprid+"','"+answerid+"','"+userid+"','"+smsinglekey+"','"+smscore+"')";
					singlesql = new String(singlesql.getBytes("UTF-8"),"UTF-8");//答的单选插入数据库
					System.out.println("singlesql=="+singlesql);
					singnum += DataBase.UpdateInsertSubmitSql(singlesql, stat, conn);
				}
			}catch (Exception e) {
				System.out.println("singleEEEEEEEEE");
			}
			System.out.println("--singnum--"+singnum);
			
			//多选 先获取多选题的个数
			String[] multiproblemid = request.getParameterValues("multiproblemid");
			String mulnumber = request.getParameter("smmultilength");
			int multilsize = Integer.parseInt(mulnumber);//得出有几个多选题
			for(int smmul = 0 ; smmul < multilsize ; smmul++){//全列出
				int num = smmul+1;
				String[] smmulti = request.getParameterValues("smmulti"+num);
				String smmultvalue = "";//员工答的多选题
				
				try{
					for(int smmulii=0 ; smmulii < smmulti.length ; smmulii++){
						smmultvalue += smmulti[smmulii];//选的每一个空
					}
				}catch (Exception e) {
					System.out.println("multiple111EEEEEEEEE");
				}
				System.out.println("smmultvalue=="+smmultvalue);//得出员工答的这一个多选
			}
			String multiplesql = "";
			try{

				for(int pid=0 ; pid <multiproblemid.length ; pid++){
					String mprid = multiproblemid[pid];//传进来的单选id
					System.out.println("mprid=="+mprid);
					
					String mkeysql = "select pkey,pscore from probleminfo where problemid='"+mprid+"'";
					mkeysql = new String(mkeysql.getBytes("UTF-8"),"UTF-8");
					Vector<String[]> mkeyscorevv = DataBase.getMessage(mkeysql);	
					String mulkey = null;
					String mulscore = null;
					for(String[] st : mkeyscorevv){
						mulkey = st[0];//这里是多选题的答案
						mulscore = st[1];//这里是多选题的分值
					}
					
					int num = pid+1;
					String[] smmulti = null;
					String smmultvalue = "";//员工答的多选题	
					smmulti = request.getParameterValues("smmulti"+num);
					
					try{
						for(int x=0 ; x < smmulti.length ; x++){
							smmultvalue += smmulti[x];//选的每一个空
						}
					}catch (Exception e) {
						System.out.println("multiple222EEEEEEEEE");
					}
					
					System.out.println("smmultvalue=="+smmultvalue);//得出员工答的这一个多选
					
					int smscore = 0;//相等给分不等0分
					if(smmultvalue.equals(mulkey)){
						smscore = Integer.parseInt(mulscore);
					}
					System.out.println("答对有分答错没分=="+smscore);
					multiplesql = "insert into smprobleminfo(problemid,answerid,userid,smkey,smscore) " +
							"values('"+mprid+"','"+answerid+"','"+userid+"','"+smmultvalue+"','"+smscore+"')";
					multiplesql = new String(multiplesql.getBytes("UTF-8"),"UTF-8");//答的单选插入数据库
					System.out.println("multiplesql=="+multiplesql);
					mulnum += DataBase.UpdateInsertSubmitSql(multiplesql, stat, conn);
				}
			}catch (Exception e) {
				System.out.println("multiple333EEEEEEEEE");
			}
			System.out.println("--mulnum--"+mulnum);
			
			
			
			//判断题
			String[] pdproblemid = request.getParameterValues("pdproblemid");//判断id
			String[] smpanduan = request.getParameterValues("smpanduan");//所有判断key
			String pdsql = "";
			try{
				for(int pid=0 ; pid <pdproblemid.length ; pid++){
					String pdpid = pdproblemid[pid];//传进来的判断id
					System.out.println("pdpid=="+pdpid);
					
					String keysql = "select ppkey,ppscore from problempanduan where problempanduanid='"+pdpid+"'";
					keysql = new String(keysql.getBytes("UTF-8"),"UTF-8");
					Vector<String[]> keyscorevv = DataBase.getMessage(keysql);	
					String ppkey = null;
					String ppscore = null;
					for(String[] st : keyscorevv){
						ppkey = st[0];//这里是判断题的答案
						ppscore = st[1];//这里是判断题的分值
					}
					
					String smpdvalue = smpanduan[pid];//员工的答的
					System.out.println("smpdvalue=="+smpdvalue);
					
					int smscore = 0;//相等给分不等0分
					if(smpdvalue.equals(ppkey)){
						smscore = Integer.parseInt(ppscore);
					}
					System.out.println("答对有分答错没分=="+smscore);
					pdsql = "insert into smproblempanduan(problempanduanid,answerid,userid,smkey,smscore) " +
							"values('"+pdpid+"','"+answerid+"','"+userid+"','"+smpdvalue+"','"+smscore+"')";
					pdsql = new String(pdsql.getBytes("UTF-8"),"UTF-8");//答的判断插入数据库
					System.out.println("pdsql=="+pdsql);
					pdnum += DataBase.UpdateInsertSubmitSql(pdsql, stat, conn);
				}
			}catch (Exception e) {
				System.out.println("panduanEEEEEEEEE");
			}
			System.out.println("--pdnum--"+pdnum);
				
			//填空题
			String[] tkproblemid = request.getParameterValues("tkproblemid");
			String[] smtiankong = request.getParameterValues("smtiankong");
			String tksql = "";
			try{
				for(int pid = 0 ; pid < tkproblemid.length ; pid++){
					String tkpid = tkproblemid[pid];//传进来的填空id
					System.out.println("tkpid=="+tkpid);
					
					String smtkvalue = smtiankong[pid];//员工答的
					System.out.println("smtkvalue=="+smtkvalue);
					
					tksql = "insert into smproblemquestinfo(problemquestid,answerid,userid,smkey) " +
							" values('"+tkpid+"','"+answerid+"','"+userid+"','"+smtkvalue+"')";
					tksql = new String(tksql.getBytes("UTF-8"),"UTF-8");
					System.out.println("tksql=="+tksql);
					tknum += DataBase.UpdateInsertSubmitSql(tksql, stat, conn);
				}
			}catch (Exception e) {
				System.out.println("tiankongEEEEEEEEE");
			}
			System.out.println("--tknum--"+tknum);
			
			//简答题
			String[] jdproblemid = request.getParameterValues("jdproblemid");
			String[] smjianda = request.getParameterValues("smjianda");
			String jdsql = "";
			try{
				for(int pid = 0 ; pid < jdproblemid.length ; pid++){
					String jdpid = jdproblemid[pid];//传进来的填空id
					System.out.println("jdpid=="+jdpid);
					
					String smjdvalue = smjianda[pid];//员工答的
					System.out.println("smjdvalue=="+smjdvalue);
					
					jdsql = "insert into smproblemquestinfo(problemquestid,answerid,userid,smkey) " +
							" values('"+jdpid+"','"+answerid+"','"+userid+"','"+smjdvalue+"')";
					jdsql = new String(jdsql.getBytes("UTF-8"),"UTF-8");
					System.out.println("jdsql=="+jdsql);
					jdnum += DataBase.UpdateInsertSubmitSql(jdsql, stat, conn);
				}
			}catch (Exception e) {
				System.out.println("jiandaEEEEEEEEE");
			}
			System.out.println("--jdnum--"+jdnum);
			
			//问答题
			String[] wdproblemid = request.getParameterValues("wdproblemid");
			String[] smwenda = request.getParameterValues("smwenda");
			String wdsql = "";
			try{
				for(int pid = 0 ; pid < wdproblemid.length ; pid++){
					String wdpid = wdproblemid[pid];//传进来的填空id
					System.out.println("wdpid=="+wdpid);
					
					String smwdvalue = smwenda[pid];//员工答的
					System.out.println("smwdvalue=="+smwdvalue);
					
					wdsql = "insert into smproblemquestinfo(problemquestid,answerid,userid,smkey) " +
							" values('"+wdpid+"','"+answerid+"','"+userid+"','"+smwdvalue+"')";
					wdsql = new String(wdsql.getBytes("UTF-8"),"UTF-8");
					System.out.println("wdsql=="+wdsql);
					wdnum += DataBase.UpdateInsertSubmitSql(wdsql, stat, conn);
				}
			}catch (Exception e) {
				System.out.println("wendaEEEEEEEEE");
			}
			System.out.println("--wdnum--"+wdnum);
			
			//附加题
			String[] fjproblemid = request.getParameterValues("fjproblemid");
			String[] smfujia = request.getParameterValues("smfujia");
			String fjsql = "";
			try{
				for(int pid = 0 ; pid < fjproblemid.length ; pid++){
					String fjpid = fjproblemid[pid];//传进来的填空id
					System.out.println("fjpid=="+fjpid);
					
					String smfjvalue = smfujia[pid];//员工答的
					System.out.println("smfjvalue=="+smfjvalue);
					
					fjsql = "insert into smproblemquestinfo(problemquestid,answerid,userid,smkey) " +
							" values('"+fjpid+"','"+answerid+"','"+userid+"','"+smfjvalue+"')";
					fjsql = new String(fjsql.getBytes("UTF-8"),"UTF-8");
					System.out.println("wdsql=="+fjsql);
					fjnum += DataBase.UpdateInsertSubmitSql(fjsql, stat, conn);
				}
			}catch (Exception e) {
				System.out.println("fujiaEEEEEEEEE");
			}
			System.out.println("--fjnum--"+fjnum);
			
			//数据库执行完成，关闭连接
			
			try {
				conn.commit();
				conn.close();
				stat.close();
				System.out.println("--commit--conn,stat-close--");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				System.out.println("MMMMMMMMM");
				e.printStackTrace();
			}
			
			
			
			//int allnum = DataBase.insertAllProblem(singlesql, multiplesql, pdsql, tksql, jdsql, wdsql, fjsql);
			haveallnum = singnum+mulnum+pdnum+tknum+jdnum+wdnum+wdnum+fjnum;
			System.out.println("haveallnum=="+haveallnum);
			if(haveallnum >= 1){
				message = "大功告成";
			}
			System.out.println("message=="+message);
			request.setAttribute("message", message);
			this.getServletContext().getRequestDispatcher("/student/problemShow.jsp").forward(request, response);
		}

	}

}
