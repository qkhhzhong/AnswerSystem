package sys.bean;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class DataBase {	
	
	public static int UpdateSql(String sql){
		int flag = 0;
		System.out.println("--sql---=="+sql);
		try {
			Context initial = new InitialContext();
			DataSource ds = (DataSource)initial.lookup("java:comp/env/jdbc/AnswerSource");
			Connection conn = ds.getConnection();
			Statement stat = conn.createStatement();
			flag = stat.executeUpdate(sql);
			System.out.println("--insertInfo--flag=="+flag);
			stat.close();
			conn.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return flag;
	}
	
	//这里是员工提交试卷，事务处理
	public static int UpdateInsertSubmitSql(String problemsql,Statement stat,Connection conn){
		int flag = 0;
		System.out.println("--problemsql---=="+problemsql);
		try {
			flag = stat.executeUpdate(problemsql);
			System.out.println("--problemsql--flag=="+flag);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			System.out.println("!!!!!!!!!error!!!!!!!!!!!!!!!!!!!");
			if(conn != null){
				try {
					System.out.println("!!!!!!!!rollback!!!!!!");
					conn.rollback();				
				} catch (SQLException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
			}
			e.printStackTrace();
		}
		return flag;
	}
		
	public static String selectOneString(String sql){
		String str = null;
		try {
			Context initial = new InitialContext();
			//数据源jndi-mysql 名称
			DataSource ds = (DataSource) initial.lookup("java:comp/env/jdbc/AnswerSource");
			Connection conn = ds.getConnection();//获得连接
			Statement stat = conn.createStatement();//初始化statement对象
			ResultSet rs = null;
			System.out.println("--sql---=="+sql);
			rs = stat.executeQuery(sql);//查询并得到结果
			while(rs.next()){
				str = rs.getString(1);
			}
			rs.close();
			stat.close();
			conn.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
		return str; 
	}
	
	public static Vector<String[]> getMessage(String sql){
		
		Vector<String[]> vstring = new Vector<String[]>();
		try {
			//初始化上下文
			Context initial = new InitialContext();
			DataSource ds = (DataSource)initial.lookup("java:comp/env/jdbc/AnswerSource");
			//得到连接
			Connection con = ds.getConnection();
			//声明
			Statement st = con.createStatement();
			//执行并得到结果集
			ResultSet rs = st.executeQuery(sql);
			//获取结果集的元数据
			ResultSetMetaData rsmd = rs.getMetaData();
			//得到结果集中的总列数
			System.out.println("--sql--="+sql);
			int count = rsmd.getColumnCount();
			System.out.println("count=="+count);
			while(rs.next()){
				String[] str = new String[count];
				for(int i = 0 ; i<count ; i++){
					str[i] = rs.getString(i+1);
					str[i] = new String(str[i].getBytes("UTF-8"),"UTF-8");
					System.out.println("str"+i+"=="+str[i]);
				}
				vstring.add(str);
			}
			rs.close();
			st.close();
			con.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return vstring;
	}
	
	
	public static int insertAllProblem(String singlesql,String multiplesql,String pdsql,String tksql,String jdsql,String wdsql,String fjsql){
		int num = 0;
		int singnum = 0;
		int mulnum = 0;
		int pdnum = 0;
		int tknum = 0;
		int jdnum = 0;
		int wdnum = 0;
		int fjnum = 0;
		System.out.println("---singlesql---="+singlesql);
		System.out.println("---multiplesql---="+multiplesql);
		System.out.println("---pdsql---="+pdsql);
		System.out.println("---tksql---="+tksql);
		System.out.println("---jdsql---="+jdsql);
		System.out.println("---wdsql---="+wdsql);
		System.out.println("---fjsql---="+fjsql);
		Connection conn = null;
		try {
			Context initial = new InitialContext();
			//数据源jndi-mysql 名称
			DataSource ds = (DataSource) initial.lookup("java:comp/env/jdbc/AnswerSource");
			conn = ds.getConnection();//获得连接
			
			System.out.println("aaa");
			conn.setAutoCommit(false);//关闭自动提交
			System.out.println("bbb");
			
			Statement stat = conn.createStatement();//初始化statement对象
			
			singnum = stat.executeUpdate(singlesql);
			System.out.println("exe-singlesql");	
			mulnum = stat.executeUpdate(multiplesql);
			System.out.println("exe-multiplesql");			
			pdnum = stat.executeUpdate(pdsql);
			System.out.println("exe-pdsql");			
			tknum = stat.executeUpdate(tksql);
			System.out.println("exe-tksql");			
			jdnum = stat.executeUpdate(jdsql);
			System.out.println("exe-jdsql");			
			wdnum = stat.executeUpdate(wdsql);
			System.out.println("exe-wdsql");			
			fjnum = stat.executeUpdate(fjsql);
			System.out.println("exe-fjsql");
			num = singnum+mulnum+pdnum+tknum+jdnum+wdnum+fjnum;
			System.out.println("num=="+num);
			System.out.println("全部完成！！！！");
			conn.commit();		
			stat.close();
			conn.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			if(conn != null){
				try {
					conn.rollback();
					num = 0;
					System.out.println("rollback");
				} catch (SQLException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
			}
			e.printStackTrace();
			System.out.println("eee");
		}		
		return num; 
	}
	
	
}
