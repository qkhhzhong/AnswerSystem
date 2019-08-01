package sys.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Vector;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import sys.bean.Admininfo;
import sys.bean.Answerinfo;
import sys.bean.DataBase;
import sys.bean.Userinfo;

public class AdminServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		this.doPost(request, response);
	}


	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		System.out.println("~~~~~~~~~~AdminServlet.java~~~~~~~~~~~~~~~~");
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
		if(action.equals("createanswer")){//管理员创建试卷
			String answertitle = request.getParameter("answertitle");
			String answerdetail = request.getParameter("answerdetail");
			System.out.println("answertitle==="+answertitle+"\n");
			System.out.println("answerdetail==="+answerdetail+"\n");
			if(!answertitle.equals("")){
				String sql = "insert into answer(answertitle,answerdetail)" +
						" values('"+answertitle+"','"+answerdetail+"')";
				sql = new String(sql.getBytes("UTF-8"),"UTF-8");
				int i = DataBase.UpdateSql(sql);
				if(i >= 1){
					message = "创建成功";
				}
				System.out.println("message=="+message);
				request.setAttribute("message", message);
				this.getServletContext().getRequestDispatcher("/admin/createAnswer.jsp").forward(request, response);
				return ;
			}
			message = "创建失败";

			System.out.println("message=="+message);
			request.setAttribute("message",message);
			this.getServletContext().getRequestDispatcher("/admin/adminlogin.jsp").forward(request,response);
		}
		else if(action.equals("comeinproblem")){//点击试卷进入试卷具体题目管理创建
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
			this.getServletContext().getRequestDispatcher("/admin/problemsingleadd.jsp").forward(request, response);
		}
		else if(action.equals("deleteproblem")){//删除试卷，包括删除所有创建的题目。
			String answerid = request.getParameter("answerid");
			System.out.println("answerid=="+answerid);
			message = "删除失败";
			if(answerid != null && !answerid.equals("")){
				String delsql1 = "delete from smproblemquestinfo where answerid='"+answerid+"'";
				String delsql2 = "delete from smproblempanduan where answerid='"+answerid+"'";
				String delsql3 = "delete from smprobleminfo where answerid='"+answerid+"'";
				String delsql4 = "delete from problemquestinfo where answerid='"+answerid+"'";
				String delsql5 = "delete from problempanduan where answerid='"+answerid+"'";
				String delsql6 = "delete from probleminfo where answerid='"+answerid+"'";
				String delsql7 = "delete from answer where answerid='"+answerid+"'";
				DataBase.UpdateSql(delsql1);
				DataBase.UpdateSql(delsql2);
				DataBase.UpdateSql(delsql3);
				DataBase.UpdateSql(delsql4);
				DataBase.UpdateSql(delsql5);
				DataBase.UpdateSql(delsql6);
				DataBase.UpdateSql(delsql7);
				message = "删除成功";
			}
			System.out.println("message"+message);
			request.setAttribute("message", message);
			this.getServletContext().getRequestDispatcher("/admin/answerList.jsp").forward(request, response);
		}
		else if(action.equals("openonproblem")){//管理员发布试卷
			String answerid = request.getParameter("answerid");
			System.out.println("answerid=="+answerid);
			message = "发布失败";
			if(answerid != null && !answerid.equals("")){
				String onsql = "update answer set answerstate='on' where answerid='"+answerid+"'";	
				int i = DataBase.UpdateSql(onsql);
				if(i >= 1){
					message = "发布成功";
				}	
			}
			System.out.println("message"+message);
			request.setAttribute("message", message);
			this.getServletContext().getRequestDispatcher("/admin/answerList.jsp").forward(request, response);
		}
		else if(action.equals("closeproblem")){//管理员关闭试卷
			String answerid = request.getParameter("answerid");
			System.out.println("answerid=="+answerid);
			message = "关闭失败";
			if(answerid != null && !answerid.equals("")){
				String closesql = "update answer set answerstate='no' where answerid='"+answerid+"'";	
				int i = DataBase.UpdateSql(closesql);
				if(i >= 1){
					message = "关闭成功";
				}	
			}
			System.out.println("message"+message);
			request.setAttribute("message", message);
			this.getServletContext().getRequestDispatcher("/admin/answerList.jsp").forward(request, response);
		}
		else if(action.equals("addpanduan")){//增加某试卷的判断题
			String ppcontent = request.getParameter("ppcontent");
			String ppkey = request.getParameter("ppkey");
			String ppscore = request.getParameter("ppscore");
			SimpleDateFormat sm = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String pcreatetime = sm.format(new Date());
			String answerid = request.getParameter("answerid");
			System.out.println("ppcontent=="+ppcontent);
			System.out.println("ppkey=="+ppkey);
			System.out.println("ppscore=="+ppscore);
			System.out.println("pcreatetime=="+pcreatetime);
			System.out.println("answerid=="+answerid);
			if(answerid == null){
				message = "addpanduan插入失败";
			}else{
				String sql = "insert into problempanduan(ppcontent,ppkey,ppscore,pcreatetime,answerid) " +
						" values('"+ppcontent+"','"+ppkey+"','"+ppscore+"','"+pcreatetime+"','"+answerid+"')";
				sql = new String(sql.getBytes("UTF-8"),"UTF-8");
				int i = DataBase.UpdateSql(sql);
				if(i >= 1){
					message = "addpanduan插入成功";
				}
			}
			System.out.println("message=="+message);
			this.getServletContext().getRequestDispatcher("/admin/problemPanDuan.jsp").forward(request, response);
		}
		else if(action.equals("addsingle")){//增加某试卷的单选题
			String ptitle = request.getParameter("ptitle");
			String pa = request.getParameter("pa");
			String pb = request.getParameter("pb");
			String pc = request.getParameter("pc");
			String pd = request.getParameter("pd");
			String pkey = request.getParameter("pkey");
			String pscore = request.getParameter("pscore");
			String ptype = request.getParameter("ptype");
			
			SimpleDateFormat sm = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String pcreatetime = sm.format(new Date());
			String answerid = request.getParameter("answerid");
			System.out.println("ptitle=="+ptitle);
			System.out.println("pa=="+pa);
			System.out.println("pb=="+pb);
			System.out.println("pc=="+pc);
			System.out.println("pd=="+pd);
			System.out.println("pkey=="+pkey);
			System.out.println("pscore=="+pscore);
			System.out.println("ptype=="+ptype);
			System.out.println("pcreatetime=="+pcreatetime);
			System.out.println("answerid=="+answerid);
			if(ptitle == "" || answerid == ""){
				message = "addsingle-error";
				request.setAttribute("message", message);
				this.getServletContext().getRequestDispatcher("/admin/problemsingleadd.jsp").forward(request,response);
				return ;
			}
			String sql = "insert into probleminfo(ptitle,pa,pb,pc,pd,pkey,pscore,ptype,pcreatetime,answerid)" +
					" values('"+ptitle+"','"+pa+"','"+pb+"','"+pc+"','"+pd+"','"+pkey+"','"+pscore+"'" +
							",'"+ptype+"','"+pcreatetime+"','"+answerid+"')";
			sql = new String(sql.getBytes("UTF-8"),"UTF-8");
			int i = DataBase.UpdateSql(sql);
			if(i >= 1){
				message = "插入成功";
			}
			System.out.println("message=="+message);
			this.getServletContext().getRequestDispatcher("/admin/problemsingleadd.jsp").forward(request, response);
		}
		else if(action.equals("addmultiple")){//增加某试卷的多选题
			String ptitle = request.getParameter("ptitle");
			String pa = request.getParameter("pa");
			String pb = request.getParameter("pb");
			String pc = request.getParameter("pc");
			String pd = request.getParameter("pd");
			String[] pkeys = request.getParameterValues("pkey");
			String pkey = "";
			for(int i = 0 ; i < pkeys.length ; i++){//布置了多少个班级
				pkey += pkeys[i];
			}
			String pscore = request.getParameter("pscore");
			String ptype = request.getParameter("ptype");
			
			SimpleDateFormat sm = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String pcreatetime = sm.format(new Date());
			String answerid = request.getParameter("answerid");
			System.out.println("ptitle=="+ptitle);
			System.out.println("pa=="+pa);
			System.out.println("pb=="+pb);
			System.out.println("pc=="+pc);
			System.out.println("pd=="+pd);
			System.out.println("pkey=="+pkey);
			System.out.println("pscore=="+pscore);
			System.out.println("ptype=="+ptype);
			System.out.println("pcreatetime=="+pcreatetime);
			System.out.println("answerid=="+answerid);
			if(answerid.equals(null)){
				message = "addsingle-error";
				System.out.println("exit?");
				request.setAttribute("message", message);
				this.getServletContext().getRequestDispatcher("/admin/problemmultipleadd.jsp").forward(request,response);
				return ;
			}
			String sql = "insert into probleminfo(ptitle,pa,pb,pc,pd,pkey,pscore,ptype,pcreatetime,answerid)" +
					" values('"+ptitle+"','"+pa+"','"+pb+"','"+pc+"','"+pd+"','"+pkey+"','"+pscore+"'" +
							",'"+ptype+"','"+pcreatetime+"','"+answerid+"')";
			sql = new String(sql.getBytes("UTF-8"),"UTF-8");
			int i = DataBase.UpdateSql(sql);
			if(i >= 1){
				message = "插入成功";
			}
			System.out.println("message=="+message);
			this.getServletContext().getRequestDispatcher("/admin/problemmultipleadd.jsp").forward(request, response);
		}
		else if(action.equals("addquest")){//增加某试卷的大题：问答题、附加题等
			String pqcontent = request.getParameter("pqcontent");
			String pqkey = request.getParameter("pqkey");
			String pqscore = request.getParameter("pqscore");
			String ptype = request.getParameter("pqtype");
			SimpleDateFormat sm = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String pcreatetime = sm.format(new Date());
			String answerid = request.getParameter("answerid");
			System.out.println("pqcontent=="+pqcontent);
			System.out.println("pqkey=="+pqkey);
			System.out.println("pqscore=="+pqscore);
			System.out.println("ptype=="+ptype);
			System.out.println("pcreatetime=="+pcreatetime);
			System.out.println("answerid=="+answerid);
			if(answerid == null){
				message = "addquest插入失败";
			}else {
				String sql = "insert into problemquestinfo(pqcontent,pqkey,pqscore,pqtype,pcreatetime,answerid) " +
						"values('"+pqcontent+"','"+pqkey+"','"+pqscore+"','"+ptype+"','"+pcreatetime+"','"+answerid+"')";
				sql = new String(sql.getBytes("UTF-8"),"UTF-8");
				int i = DataBase.UpdateSql(sql);
				if(i >= i){
					message ="addquest插入成功";
				}
			}
			System.out.println("message=="+message);
			if(ptype.equals("jianda")){
				this.getServletContext().getRequestDispatcher("/admin/problemQuestJianDa.jsp").forward(request, response);
			}else if(ptype.equals("wenda")){
				this.getServletContext().getRequestDispatcher("/admin/problemQuestWenDa.jsp").forward(request, response);
			}else if(ptype.equals("fujia")){
				this.getServletContext().getRequestDispatcher("/admin/problemQuestFuJia.jsp").forward(request, response);
			}else if(ptype.equals("tiankong")){
				this.getServletContext().getRequestDispatcher("/admin/problemQuestTianKong.jsp").forward(request, response);
			}else{
				this.getServletContext().getRequestDispatcher("/admin/problemsingleadd.jsp").forward(request, response);
			}
		}
		else if(action.equals("lookresult")){//管理员预览试卷情况
			String answerid = request.getParameter("answerid");
			String userid = request.getParameter("userid");
			System.out.println("answerid=="+answerid);
			System.out.println("userid=="+userid);
			if(answerid == null || userid == null){
				message = "查看失败";
			}else{
				Vector<String[]> detailvv = null;
				String dsql = "select answertitle,answerdetail,answerstate,username,userpassword" +
						" from answer,userinfo where answerid='"+answerid+"' and userid='"+userid+"'";
				dsql = new String(dsql.getBytes("UTF-8"),"UTF-8");
				detailvv = DataBase.getMessage(dsql);
				int i = detailvv.size();
				if(i >= 1){
					message = "查看成功";
				}
				String answertitle = null;
				String answerdetail = null;
				String answerstate = null;
				String username = null;
				String userpassword = null;
				for(String[] st : detailvv){
					answertitle = st[0];
					answerdetail = st[1];
					answerstate = st[2];
					username = st[3];
					userpassword = st[4];
				}
				System.out.println("answertitle=="+answertitle);
				System.out.println("answerdetail=="+answerdetail);
				System.out.println("answerstate=="+answerstate);
				System.out.println("username=="+username);
				System.out.println("userpassword=="+userpassword);
				answerinfo.setAnswerid(answerid);
				answerinfo.setAnswertitle(answertitle);
				answerinfo.setAnswerdetail(answerdetail);
				answerinfo.setAnswerstate(answerstate);
				userinfo.setUserid(userid);
				userinfo.setUsername(username);
				userinfo.setUserpassword(userpassword);
			}
			request.setAttribute("answerinfo", answerinfo);
			request.setAttribute("userinfo", userinfo);
			this.getServletContext().getRequestDispatcher("/admin/lookResult.jsp").forward(request, response);
		}
		else if(action.equals("givescore")){//管理员对用户的答卷的大题评价并打分
			String answerid = request.getParameter("answerid");
			String userid = request.getParameter("userid");
			String problemquestid = request.getParameter("problemquestid");
			String giveevaluate = request.getParameter("giveevaluate");
			String givescore = request.getParameter("givescore");
			System.out.println("answerid=="+answerid);
			System.out.println("userid=="+userid);
			System.out.println("problemquestid=="+problemquestid);
			System.out.println("giveevaluate=="+giveevaluate);
			System.out.println("givescore=="+givescore);
			if(giveevaluate == null || giveevaluate.equals("")){
				message = "请先评价";
			}
			else if(givescore == null || givescore.equals("")){
				message = "请先打分！";
			}else{
				String sql = "update smproblemquestinfo set smscore='"+givescore+"',smevaluate='"+giveevaluate+"' where " +
				" answerid='"+answerid+"' and userid='"+userid+"' and problemquestid='"+problemquestid+"' ";
				sql = new String(sql.getBytes("UTF-8"),"UTF-8");
				int i = DataBase.UpdateSql(sql);
				if(i >= 1){
					message = "打分成功";
				}
			}
			System.out.println("message="+message);
			request.setAttribute("message", message);
			this.getServletContext().getRequestDispatcher("/admin/lookResult.jsp").forward(request, response);
		}

	}


}
