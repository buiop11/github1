package spring.mvc.myproject.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;

public interface AdminService {
	
	// 로그인 처리 
	public void loginPro(HttpServletRequest req, Model model);
	
	//---- 상품 등록, 처리 --- 
	
	// 상품  목록보기 
	public void productList(HttpServletRequest req, Model model);
	
	// 회원테이블 보기 
	public void memberContent(HttpServletRequest req, Model model);
	
	 // 상품 - 상품 상세페이지 
    public void p_contentForm(HttpServletRequest req, Model model);
	
    // 상품 - 상품 등록처리 페이지 (파일업로드)
    public void p_insertPro(MultipartHttpServletRequest req, Model model);
    
    // 상품 - 상품수정을 위한 뷰 페이지 
    public void p_modifyView(HttpServletRequest req, Model model);
    
    // 상품 - 상품 수정 페이지 
    public void p_modifyPro(MultipartHttpServletRequest req, Model model);
    
    // 상품- 상품삭제처리 페이지 
    public void p_deletePro(HttpServletRequest req, Model model);
	
    // 관리자는 ㅋ 비밀번호없이 게시판 삭제 
 	public void directBoardDelete(HttpServletRequest req, Model model);
 	
	// 회원 삭제 
	public void memberDelete(HttpServletRequest req, Model model);


}
