package sys.bean;

public class Answerinfo {//试卷信息

	private String answerid;
	private String answertitle;//试卷标题
	private String answerdetail;//试卷描述
	private String answerstate;//试卷状态（on打开/no关闭）
	public String getAnswerid() {
		return answerid;
	}
	public void setAnswerid(String answerid) {
		this.answerid = answerid;
	}
	public String getAnswertitle() {
		return answertitle;
	}
	public void setAnswertitle(String answertitle) {
		this.answertitle = answertitle;
	}
	public String getAnswerdetail() {
		return answerdetail;
	}
	public void setAnswerdetail(String answerdetail) {
		this.answerdetail = answerdetail;
	}
	public String getAnswerstate() {
		return answerstate;
	}
	public void setAnswerstate(String answerstate) {
		this.answerstate = answerstate;
	}
	
}
