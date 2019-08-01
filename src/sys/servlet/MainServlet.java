package sys.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import sys.bean.Admininfo;
import sys.bean.DataBase;
import sys.bean.Userinfo;

public class MainServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		this.doPost(request, response);
	}


	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		System.out.println("~~~~~~~~~~MainServlet.java~~~~~~~~~~~~~~~~");
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
			session.setAttribute("Admininfo",admininfo);
		}
		
		Userinfo userinfo = (Userinfo)session.getAttribute("userinfo");
		if(userinfo==null){
			userinfo = new Userinfo();
			session.setAttribute("userinfo",userinfo);
		}
		
		System.out.printf("--action==="+action+"--\n");
		if(action == null){return;}
		if(action.equals("adminlogin")){//管理员登录
			String adminname = request.getParameter("aname");
			String adminpassword = request.getParameter("apassword");
			System.out.println("adminname==="+adminname+"\n");
			System.out.println("adminpassword==="+adminpassword+"\n");
			String sql = "select adminid from admininfo where adminname='"+adminname+"' and adminpassword='"+adminpassword+"'";
			sql = new String(sql.getBytes("UTF-8"),"UTF-8");
			String adminid = DataBase.selectOneString(sql);
			System.out.println("adminid=="+adminid);
			if(!"".equals(adminid) && adminid != null){
				admininfo.setAdminid(adminid);
				admininfo.setAdminname(adminname);
				admininfo.setAdminpassword(adminpassword);
				session.setAttribute("admininfo", admininfo);
				System.out.println("admininfo.getadminid=="+admininfo.getAdminid());
				System.out.println("登录成功");
				message = "登录成功";
				request.setAttribute("message", message);
				this.getServletContext().getRequestDispatcher("/admin/createAnswer.jsp").forward(request, response);
				return ;
			}else{
			    message = "账号或密码错误请重新登录";
				System.out.println("登录失败\n");
			}
			request.setAttribute("message",message);
			this.getServletContext().getRequestDispatcher("/admin/adminlogin.jsp").forward(request,response);
		}
		else if(action.equals("stulogin")){//用户登录
			String userid = request.getParameter("userid");
			String userpassword = request.getParameter("userpassword");
			System.out.println("userid=="+userid);
			System.out.println("userpassword=="+userpassword);
			if( userid.equals("") || userid == null || userpassword == null){
				message = "user为空";
			}else{
				String sql = "select username from userinfo where userid='"+userid+"' and userpassword='"+userpassword+"'";
				sql = new String(sql.getBytes("UTF-8"),"UTF-8");
				String username = "";
				username = DataBase.selectOneString(sql);
				System.out.println("get-username="+username);
				if( username == null || username.equals("") ){
					message = "用户名或密码错误";
					System.out.println("---登录失败---");
				}else{
					message = "stu登录成功";
					System.out.println("message=="+message);
					userinfo.setUserid(userid);
					userinfo.setUsername(username);
					userinfo.setUserpassword(userpassword);
					request.setAttribute("userinfo", userinfo);
					request.setAttribute("message", message);
					this.getServletContext().getRequestDispatcher("/student/stuanswerList.jsp").forward(request, response);
					return ;
				}
			}
			System.out.println("message=="+message);
			request.setAttribute("message", message);
			this.getServletContext().getRequestDispatcher("/student/stulogin.jsp").forward(request, response);
		}
		else if(action.equals("createstu")){//管理员创建新的用户
			String username = request.getParameter("username");
			String userid = request.getParameter("userid");
			String userpassword = request.getParameter("userpassword");
			System.out.println("username=="+username);
			System.out.println("userid=="+userid);
			System.out.println("userpassword=="+userpassword);
			if(username.equals("")){
				message = "添加失败";
			}else{
				String sql = "insert into userinfo(username,userid,userpassword) " +
						" values('"+username+"','"+userid+"','"+userpassword+"')";
				sql = new String(sql.getBytes("UTF-8"),"UTF-8");
				int i = DataBase.UpdateSql(sql);
				if(i >= 1 ){
					message = "添加员工成功";
				}
			}
			System.out.println("message=="+message);
			this.getServletContext().getRequestDispatcher("/admin/studentList.jsp").forward(request, response);
		}
		else if(action.equals("delestu")){//管理员删除用户
			String userid = request.getParameter("userid");
			System.out.println("userid=="+userid);
			if(userid.equals("") || userid == null){
				message = "删除失败";
			}else{
				String sql = "delete from userinfo where userid='"+userid+"'";
				sql = new String(sql.getBytes("UTF-8"),"UTF-8");
				int i = DataBase.UpdateSql(sql);
				if(i >= 1 ){
					message = "删除员工成功";
				}
			}
			System.out.println("message=="+message);
			this.getServletContext().getRequestDispatcher("/admin/studentList.jsp").forward(request, response);
		}
		
		//这里开始处理试卷的单个删除-begin
		else if(action.equals("sindelform")){//删除某试卷的单选题
			String deleid = request.getParameter("deleid");
			System.out.println("--deleid--"+deleid);
			message = "删除失败";
			String desql = "delete from probleminfo where problemid='"+deleid+"'";
			int i = DataBase.UpdateSql(desql);
			if(i >= 1){
				message = "删除成功";
			}
			System.out.println("message=="+message);
			this.getServletContext().getRequestDispatcher("/admin/problemsingleadd.jsp").forward(request, response);
		}
		else if(action.equals("muldelform")){//删除某试卷的多选题
			String deleid = request.getParameter("deleid");
			System.out.println("--deleid--"+deleid);
			message = "删除失败";
			String desql = "delete from probleminfo where problemid='"+deleid+"'";
			int i = DataBase.UpdateSql(desql);
			if(i >= 1){
				message = "删除成功";
			}
			System.out.println("message=="+message);
			this.getServletContext().getRequestDispatcher("/admin/problemmultipleadd.jsp").forward(request, response);
		}
		else if(action.equals("panduandelform")){//删除某试卷的判断题
			String deleid = request.getParameter("deleid");
			System.out.println("--deleid--"+deleid);
			message = "删除失败";
			String desql = "delete from problempanduan where problempanduanid='"+deleid+"'";
			int i = DataBase.UpdateSql(desql);
			if(i >= 1){
				message = "删除成功";
			}
			System.out.println("message=="+message);
			this.getServletContext().getRequestDispatcher("/admin/problemPanDuan.jsp").forward(request, response);
		}
		else if(action.equals("tiankongdelform")){//删除某试卷的填空题
			String deleid = request.getParameter("deleid");
			System.out.println("--deleid--"+deleid);
			message = "删除失败";
			String desql = "delete from problemquestinfo where problemquestid='"+deleid+"'";
			int i = DataBase.UpdateSql(desql);
			if(i >= 1){
				message = "删除成功";
			}
			System.out.println("message=="+message);
			this.getServletContext().getRequestDispatcher("/admin/problemQuestTianKong.jsp").forward(request, response);
		}
		else if(action.equals("jiandadelform")){//删除某试卷的简答题
			String deleid = request.getParameter("deleid");
			System.out.println("--deleid--"+deleid);
			message = "删除失败";
			String desql = "delete from problemquestinfo where problemquestid='"+deleid+"'";
			int i = DataBase.UpdateSql(desql);
			if(i >= 1){
				message = "删除成功";
			}
			System.out.println("message=="+message);
			this.getServletContext().getRequestDispatcher("/admin/problemQuestJianDa.jsp").forward(request, response);
		}
		else if(action.equals("wendadelform")){//删除某试卷的问答题
			String deleid = request.getParameter("deleid");
			System.out.println("--deleid--"+deleid);
			message = "删除失败";
			String desql = "delete from problemquestinfo where problemquestid='"+deleid+"'";
			int i = DataBase.UpdateSql(desql);
			if(i >= 1){
				message = "删除成功";
			}
			System.out.println("message=="+message);
			this.getServletContext().getRequestDispatcher("/admin/problemQuestWenDa.jsp").forward(request, response);
		}
		else if(action.equals("fujiadelform")){//删除某试卷的附加题
			String deleid = request.getParameter("deleid");
			System.out.println("--deleid--"+deleid);
			message = "删除失败";
			String desql = "delete from problemquestinfo where problemquestid='"+deleid+"'";
			int i = DataBase.UpdateSql(desql);
			if(i >= 1){
				message = "删除成功";
			}
			System.out.println("message=="+message);
			this.getServletContext().getRequestDispatcher("/admin/problemQuestFuJia.jsp").forward(request, response);
		}
		//这里开始处理试卷的单个删除-begin
		

	}

}
