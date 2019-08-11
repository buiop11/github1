package spring.mvc.myproject.controller;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import spring.mvc.myproject.service.AdminService;
import spring.mvc.myproject.service.ProductService;
import spring.mvc.myproject.service.Service;

@org.springframework.stereotype.Controller
public class AdminController {
	
	
	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);
	
	
	@Autowired
	ProductService service_pro;
	
	@Autowired
	AdminService service_ad;
	
	@Autowired
	Service service;
	
	// 시큐리티  관리자로그인-> 시큐리티 타고, -> 로그인시, 관리자홈으로
	@RequestMapping("admin/main")
	public String admin_main(HttpServletRequest req, Model model) {
		logger.info("url ==> admin_main");
		
		return "/admin/ad_home";  
		//관리자 홈으로 바로 이동
	}
	
	//---------------------------------------//
	// 관리자 메인페이지 
	//@RequestMapping("admin_main")
	//public String main(HttpServletRequest req, Model model) {
	//	logger.info("url ==> admin_main");
		
	//	return "/admin/ad_login";
	//}
	
	
	// 로그인 처리 페이지 (**시큐리티 때문에 안탐)
	@RequestMapping("admin_loginPro")
	public String admin_loginPro(HttpServletRequest req, Model model) {
		logger.info("url ==> admin_loginPro");
		
		// 서비스 
		service_ad.loginPro(req, model);
		
		return "/admin/ad_login";
	}
	
	
	// 로그인 완료시 홈으로 이동 (**시큐리티 때문에 안탐)
	@RequestMapping("admin_loginOK")
	public String admin_loginOK(HttpServletRequest req, Model model) {
		logger.info("url ==> admin_loginOK");
		
		return "/admin/ad_home";
	}
	
	// 로그아웃 처리  (**시큐리티 때문에 안탐)
	@RequestMapping("admin_logoutPro")
	public String admin_logoutPro(HttpServletRequest req, Model model) {
		logger.info("url ==> admin_logoutPro");
		
		// 세션을 삭제 
		req.getSession().removeAttribute("adminId");
		
		return "/admin/ad_login";
	}
	
	// ---페이지 이동 묶음--- 
	// 로그아웃 처리 
	@RequestMapping("admin/home")
	public String admin_home(HttpServletRequest req, Model model) {
		logger.info("url ==> admin_home");
		
		return "/admin/ad_home";
	}
	
	// 상품관리_1 페이지 이동 
	@RequestMapping("admin/product")
	public String admin_product(HttpServletRequest req, Model model) {
		logger.info("url ==> admin_product");
		// 상품 테이블 불러오기 
		service_ad.productList(req, model);
		
		return "/admin/ad_product_1";
	}
	
	
	// 상품 이름으로 검색 
	@RequestMapping("admin/product_search")
	public String product_search(HttpServletRequest req, Model model) {
		logger.info("url ==> product_search");
		
		//서비스 호출 (디비에서 상품 이미지랑 값 끌어와야함) 
		service_pro.searchProduct(req, model);
		return "/admin/ad_product_1";
	}
	
	
	// 주문/환불승인_2 페이지 이동 
	@RequestMapping("admin/order")
	public String admin_order(HttpServletRequest req, Model model) {
		logger.info("url ==> admin_order");
		// 주문 테이블 불러오기 
		service_pro.orderContent(req, model);
		
		return "/admin/ad_order_2";
	}
	
	// 회원관리_3 페이지 이동  
	@RequestMapping("admin/member")
	public String admin_member(HttpServletRequest req, Model model) {
		logger.info("url ==> admin_member");
		// 회원테이블 불러오기 
		service_ad.memberContent(req, model);
		
		return "/admin/ad_member_3";
	}
	
	// 게시판관리_4 페이지 이동
	@RequestMapping("admin/board")
	public String admin_board(HttpServletRequest req, Model model) {
		logger.info("url ==> admin_board");
		// 게시글을 갖고 오자 
		service.boardList(req, model);
		
		return "/admin/ad_board_4";
	}
	
	// 결산 _5 페이지 이동
	@RequestMapping("admin/totalCalc")
	public String admin_totalCalc(HttpServletRequest req, Model model) {
		logger.info("url ==> admin_totalCalc");
		
		try {
			service_pro.totalcalc(req, model);
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("결산로딩에 실패!!ㅠㅠ");
		}
		
		return "/admin/ad_totalCalc_5";
	}
	
	
	// 상품 상세보기 
	@RequestMapping("admin/p_contentForm")
	public String admin_p_contentForm(HttpServletRequest req, Model model) {
		logger.info("url ==> admin/p_contentForm");
		
		// 서비스 호출
		service_ad.p_contentForm(req, model);
		return "/admin/p_contentForm";
	}
	
	// 상품 등록하기 페이지 이동 
	@RequestMapping("admin/product_regist")
	public String admin_product_regist(HttpServletRequest req, Model model) {
		logger.info("url ==> admin/product_regist");
		return "/admin/product_regist";
	}
	
	// 상품 등록 처리 	
	@RequestMapping("admin/p_insertPro")
	public String admin_p_insertPro(MultipartHttpServletRequest req, Model model) {
		logger.info("url ==> admin/p_insertPro");
		
		// 서비스 호출
		service_ad.p_insertPro(req, model);
		return "/admin/product_writePro";
	}
	
	// 상품 수정 페이지 호출  
	@RequestMapping("admin/p_updateView")
	public String admin_p_updateView(HttpServletRequest req, Model model) {
		logger.info("url ==> admin/p_updateView");
		
		// 서비스 호출 
		service_ad.p_modifyView(req, model);
		return "/admin/p_updateView";
	}
	
	
	// 상품 수정 처리 	 (************* null 값 java.io.IOException: 발생 ******** ) 
	@RequestMapping("admin/p_updatePro")
	public String admin_p_updatePro(MultipartHttpServletRequest req, Model model) {
		logger.info("url ==> admin/p_updatePro");
		
		// 서비스 호출
		service_ad.p_modifyPro(req, model);
		return "/admin/p_updatePro";
	}
	
	
	// 상품 삭제 처리 
	@RequestMapping("admin/p_delete")
	public String admin_p_delete(HttpServletRequest req, Model model) {
		logger.info("url ==> admin/p_delete");
		
		// 서비스 호출
		service_ad.p_deletePro(req, model);
		return "/admin/p_delete";
	}
	
	//게시판_상세글보기 이동 
	@RequestMapping("admin/board_detail")
	public String admin_board_detail(HttpServletRequest req, Model model) {
		logger.info("url ==> admin/board_detail");
		
		// 서비스 호출
		service.contentForm(req, model);
		return "/admin/board_detail";
	}
	
	// 게시판_글쓰기 페이지 이동
	@RequestMapping("admin/board_write")
	public String admin_board_write(HttpServletRequest req, Model model) {
		logger.info("url ==> admin/board_write");
		
		// 서비스 호출
		service.writeForm(req, model);
		return "/admin/board_write";
	}
	
	// 게시판 글쓰기 처리 
	@RequestMapping("admin/board_writePro")
	public String admin_board_writePro(HttpServletRequest req, Model model) {
		logger.info("url ==> admin/board_write");
		
		// 서비스 호출
		service.writePro(req, model);
		return "/admin/board_writePro";
	}
	
	
	//게시판 글삭제	(비밀번호 없이 바로 삭제됨)
	@RequestMapping("admin/board_delete")
	public String admin_board_delete(HttpServletRequest req, Model model) {
		logger.info("url ==> admin/board_write");
		
		// 서비스 호출
		service_ad.directBoardDelete(req, model);
		return "/admin/board_delete";
	}
	
	// 회원 바로 삭제 
	@RequestMapping("admin/member_delete")
	public String admin_member_delete(HttpServletRequest req, Model model) {
		logger.info("url ==> admin/member_delete");
		
		// 서비스 호출
		service_ad.memberDelete(req, model);
		return "/admin/member_deletePro";
	}
	
	
	// 주문(오더) - 결제 완료, 환불처리 (결국은 수정처리- 같은 프로시저)
	@RequestMapping("admin/stateUpdate")
	public String admin_stateUpdate(HttpServletRequest req, Model model) {
		logger.info("url ==> admin/stateUpdate");
		
		// 상품 서비스 탄다. 
		service_pro.orderUpdate(req, model);
		return "/admin/stateUpdate";
	}
	
	

}
