package spring.mvc.myproject.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.Model;

public interface Service {
	
	// 로그인 처리 
	public void loginPro(HttpServletRequest req, Model model);
	
	// 회원가입 처리 
	public void inputPro(HttpServletRequest req, Model model);
	
	// 회원가입 - 아이디 중복 확인 처리 
	public void comfirmId(HttpServletRequest req, Model model);
	
    // 이메일 인증처리 
    public void emailChkPro(HttpServletRequest req, Model model);
	
    // 게시판 목록보기 
    public void boardList(HttpServletRequest req, Model model);
    
    // 게시판 - 글상세 페이지 
    public void contentForm(HttpServletRequest req, Model model);
    
    // 게시판 - 글 수정 상세 페이지 
    public void modifyView(HttpServletRequest req, Model model);
    
    // 게시판 - 글 수정 처리 페이지 
    public void modifyPro(HttpServletRequest req, Model model);
    
    // 게시판 - 글쓰기 페이지 / 답글쓰기 폼페이지 
    public void writeForm(HttpServletRequest req, Model model);

    // 게시판 - 글쓰기 처리 페이지 / 답글 처리 페이지 
    public void writePro(HttpServletRequest req, Model model);
    
    // 게시판 - 글삭제 처리 페이지 
    public void deletePro(HttpServletRequest req, Model model);
    
    // 회원정보 수정 상세페이지 
    public void c_modifyView(HttpServletRequest req, Model model);
    
    // 회원정보 수정처리 
    public void c_modifyPro(HttpServletRequest req, Model model);
    
    // 회원 탈퇴 처리 
    public void c_deletePro(HttpServletRequest req, Model model);
    
    // 회원 정보 보기 (주문하기시 사용- 로그인 없음)
    public void getMemberInfo(HttpServletRequest req, Model model);
	
	// 아이디 찾기 
	public String idFindPro(HttpServletRequest req, Model model);
    
	// 비밀번호 이메일 인증 전 id, email 찾기
	public int idEmailChk(HttpServletRequest req, Model model);

	// 비밀번호 찾기 (이메일보내기)
	public void pwdFindPro(HttpServletRequest req, Model model);
	
	// 비밀번호 찾기2 
	public int pwdFindPro2(HttpServletRequest req, Model model);
	
	// 비밀번호 변경 
	public int pwdModify(HttpServletRequest req, Model model);

	
}
