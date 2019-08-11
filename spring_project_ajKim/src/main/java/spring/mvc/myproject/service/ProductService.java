package spring.mvc.myproject.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

public interface ProductService {
	
	// 토이 상품 리스트 갯수 구하기 
	public void productContent(HttpServletRequest req, Model model);
	
	// 검색 상품리스트 
	public void searchProduct(HttpServletRequest req, Model model);
	
	// 게시판 - 글상세 페이지 
	public void productView(HttpServletRequest req, Model model);
	
	// 장바구니 추가하기 
	public void cartInsert(HttpServletRequest req, Model model);
	
	// 주문 처리 페이지 
	public void productOrderPro(HttpServletRequest req, Model model);

	// 주문 정보 보기 (마이페이지 열릴때 항상 로드 된다. / 아이디별로 갖고와야함) 
	public void c_orderContent(HttpServletRequest req, Model model);
	
	// 주문 결제완료 업데이트 시키기 
	public void orderUpdate(HttpServletRequest req, Model model);
	
	// 장바구니 페이지 보기 
	public void cartView(HttpServletRequest req, Model model);
	
	// 장바구니 삭제처리 
	public void cartDeletePro(HttpServletRequest req, Model model);
	
	// 주문 정보 보기 - 관리자용(전체)
	public void orderContent(HttpServletRequest req, Model model);
	
	
 	// 결산 처리 
 	public void totalcalc(HttpServletRequest req, Model model);
 	 
 	 
}
