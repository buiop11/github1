package spring.mvc.myproject.controller;

import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import spring.mvc.myproject.service.ProductServiceImpl;
import spring.mvc.myproject.service.ServiceImpl;
import spring.mvc.myproject.vo.ArtboxMemberVO;

@org.springframework.stereotype.Controller
public class Controller {
	
	private static final Logger logger = LoggerFactory.getLogger(Controller.class);

	@Autowired
	ServiceImpl service;
	
	@Autowired
	ProductServiceImpl service_pro;
	
	//@Autowired
	//BCryptPasswordEncoder passwordEncoder;
	
	
	// 메인페이지 
	@RequestMapping("main")
	public String main(HttpServletRequest req, Model model) {
		logger.info("url ==> main");
		return "common/main";
	}
 
	// 로그인 페이지 이동  -> 시큐리티에서 완료시 홈페이지로 이동(security-context에서 설정)
	@RequestMapping("login")
	public String login(HttpServletRequest req, Model model) {
		logger.info("url ==> login");
		return "common/login";
	}
	
	// 로그인 처리 페이지 
	@RequestMapping("loginPro")
	public String loginPro(HttpServletRequest req, Model model) {
		logger.info("url ==> loginPro");

		service.loginPro(req, model);
		return "common/main";
	}
	
	
	// 회원가입 페이지 이동 
	@RequestMapping("join_member")
	public String join_member(HttpServletRequest req, Model model) {
		logger.info("url ==> join_member");
		return "common/join_member";
	}
		
	// 회원가입 처리 페이지  
	@RequestMapping("join_memberPro")
	public String join_memberPro(HttpServletRequest req, Model model) {
		logger.info("url ==> join_memberPro");
		
		service.inputPro(req, model);
		return "common/join_memberPro";
	}
	
	// 회원가입 - 아이디 중복확인 
	@RequestMapping("confirmId")
	public String confirmId(HttpServletRequest req, Model model) {
		logger.info("url ==> confirmId");
		
		service.comfirmId(req, model);
		return "common/confirmId";
	}
	
	// 이메일 인증 (users 테이블 auth, enabled - 권한테이블 insert 진행)
	@RequestMapping("emailChk")
	public String emailChk(HttpServletRequest req, Model model) {
		logger.info("url ==> emailChk");
		
		service.emailChkPro(req, model);
		return "common/emailChkPro";
	}

	
	// 	고객_ 마이페이지 이동 
	@RequestMapping("myPage")
	public String myPage(HttpServletRequest req, Model model) {
		logger.info("url ==> member/myPage");
		
		// 상품 서비스를 탄다. ==> 마이페이지리스트 가지고 와야함 , 게시판도 가지고와야함.(회원별) 
		service_pro.c_orderContent(req, model);
		// 게시판 ㅋ (그냥 다 갖고와서 페이지에서 아이디별로 거르자 ㅋㅋ)
		service.boardList(req, model);
		
		return "/customer/c_mypage";
	}
	
	
	//	고객_ 장바구니 이동
	@RequestMapping("cart")
	public String cart(HttpServletRequest req, Model model) {
		logger.info("url ==> member/cart");
		
		// 상품 서비스 타야함(장바구니 갖고와야함 ㅠㅠ) 
		service_pro.cartView(req, model);
		
		return "/customer/c_cart";
	}
	
	// 게시판 리스트(게시글목록)이동 (검색기능 추가) 
	@RequestMapping("board")
	public String board(HttpServletRequest req, Model model) {
		logger.info("url ==> board");
		
		// 서비스 호출 (ArrayList로 불러와야함)
		service.boardList(req, model);
		return "/common/board";
	}
	
	// 게시판 1건 - 상세페이지 
	@RequestMapping("contentForm")
	public String contentForm(HttpServletRequest req, Model model) {
		logger.info("url ==> contentForm");
		
		 service.contentForm(req, model);
		
		return "/common/board_detail";
	}
	
	
	// 글 수정 페이지 (비밀번호 확인)
	@RequestMapping("modifyForm")
	public String modifyForm(HttpServletRequest req, Model model) {
		logger.info("url ==> modifyForm");
		
		int num = Integer.parseInt(req.getParameter("num"));    
		int pageNum = Integer.parseInt(req.getParameter("pageNum"));
		
		// DB타지 않고 바로 값을 받아아와서 밑으로 넘긴다. get키값으로 받음 
		model.addAttribute("num", num);
		model.addAttribute("pageNum", pageNum);
		
		return "/common/modifyForm"; 		// 패스워드 입력받음 
	}
	
	
	// 게시글 수정 상세페이지     
	@RequestMapping("modifyView")
	public String modifyView(HttpServletRequest req, Model model) {
		logger.info("url ==> modifyView");
		
		service.modifyView(req, model);
		return "/common/modifyView";
	}
	
	
	// 게시글 수정 처리 페이지      
	@RequestMapping("modifyPro")
	public String modifyPro(HttpServletRequest req, Model model) {
		logger.info("url ==> modifyPro");
		
		service.modifyPro(req, model);
		return "/common/modifyPro";
	}
	
	// 글쓰기 , 답글 쓰기 !!!!!!!!!!!!!
	@RequestMapping("writeForm")
	public String writeForm(HttpServletRequest req, Model model) {
		logger.info("url ==> writeForm");
		
		 service.writeForm(req, model);
		return "/common/board_write";
	}
	
	// 글쓰기 처리    
	@RequestMapping("writePro")
	public String writePro(HttpServletRequest req, Model model) {
		logger.info("url ==> writePro");
		
		 // 서비스 글쓰기 처리 메소드 호출 
        service.writePro(req, model);
		return "/common/writePro";
	}
	
	
	// 글삭제 폼  - 비밀번호 인증 
	@RequestMapping("deleteForm")
	public String deleteForm(HttpServletRequest req, Model model) {
		logger.info("url ==> deleteForm");
	    
		// 보낸 num와 pageNum 받기
        int num = Integer.parseInt(req.getParameter("num"));
        int pageNum = Integer.parseInt(req.getParameter("pageNum"));
        
        model.addAttribute("num", num);
        model.addAttribute("pageNum", pageNum);
        
		return "/common/deleteForm";
	}
	
	
	// 글삭제 처리 페이지 
	@RequestMapping("deletePro")
	public String deletePro(HttpServletRequest req, Model model) {
		logger.info("url ==> deletePro");
		
		// 서비스 호출
        service.deletePro(req, model);
		return "/common/deletePro";
	}
	
	// 로그인전 카트 페이지 이동  (회원가입 페이지로 이동시키기)
	@RequestMapping("main_cart")
	public String main_cart(HttpServletRequest req, Model model) {
		logger.info("url ==> main_cart");
		
		return "/common/main_cart";
	}
	
	
	// 회원정보 수정 (기존정보 보여주기)
	@RequestMapping("c_modifyView")
	public String c_modifyView(HttpServletRequest req, Model model) {
		logger.info("url ==> c_modifyView");
		
		// 서비스 탄다. 비밀번호 확인 (세션 저장값 ID + DB 비밀번호 확인)
    	service.c_modifyView(req, model);
    	
		return "/customer/c_modifyView";
	}
	
	// 회원정보 수정처리
	@RequestMapping("c_modifyPro")
	public String c_modifyPro(HttpServletRequest req, Model model) {
		logger.info("url ==> c_modifyPro");
		
		//서비스, DB변경 
    	service.c_modifyPro(req, model);
    	
		return "/customer/c_modifyPro";
	}
	
	// 회원 탈퇴 처리 (정보수정에서 한번했음 - 비번은 확인안함)
	@RequestMapping("c_deletePro")
	public String c_deletePro(HttpServletRequest req, Model model) {
		logger.info("url ==> c_deletePro");
		
		// 서비스 호출 
    	service.c_deletePro(req, model);
		return "/customer/c_deletePro";
	}
	
	
	// 로그아웃 처리 	
	@RequestMapping("logoutPro")
	public String logoutPro(HttpServletRequest req, Model model) {
		logger.info("url ==> logoutPro");
		// 세션을 삭제 
		req.getSession().removeAttribute("memId");
		return "/common/logoutPro";
	}
	
	// 회사 위치보기 
	@RequestMapping("location")
	public String location(HttpServletRequest req, Model model) {
		logger.info("url ==> location");
		return "/common/location";
	}	

	// ---★★  ★★  --- 상품 리스트 페이지 이동 --★★  ★★  ----
	// 상품 리스트(토이, 문구, 리빙, 디지털 ) 페이지 이동 	
	@RequestMapping("product_list")
	public String product_list(HttpServletRequest req, Model model) {
		logger.info("url ==> product_list");
		
		//서비스 호출 (디비에서 상품 이미지랑 값 끌어와야함) 
		service_pro.productContent(req, model);
		return "/common/product_list";
	}
	
	
	// 상품 이름으로 검색 
	@RequestMapping("product_search")
	public String product_search(HttpServletRequest req, Model model) {
		logger.info("url ==> product_search");
		
		//서비스 호출 (디비에서 상품 이미지랑 값 끌어와야함) 
		service_pro.searchProduct(req, model);
		return "/common/product_list";
	}
	
	// 상품 상세보기 
	@RequestMapping("product_content")
	public String product_content(HttpServletRequest req, Model model) {
		logger.info("url ==> product_content");
		
		// 서비스 탄다. 
		service_pro.productView(req, model);
		return "/common/p_detail";
	}
	
	
	// ★★ 상품 주문페이지 가기 & 장바구니 담기 (장바구니-> 바로 구매하기도 여기를 탄다.) 
	@RequestMapping("product_order")
	public String product_order(HttpServletRequest req, Model model) {
		logger.info("url ==> product_order");

		// name="btnState" 에 따라서 서비스 탄다. 
		String btnState = req.getParameter("btnState");
		
		if(btnState.equals("바로 구매하기")) {
			// 값 다시 셋팅해서 다시 보내기 
			model.addAttribute("p_cnt", req.getParameter("p_cnt"));
			model.addAttribute("p_total",req.getParameter("p_total"));
			model.addAttribute("btnState", btnState);
			
			service_pro.productView(req, model); // 뷰페이지 보여줄거 (위랑같음) 
			service.getMemberInfo(req, model); // 회원정보 보여줄거 (이름이랑 연락처, 미리보여주기)
			
			return "/common/p_order";
			
		}else if(btnState.equals("장바구니 담기")){
			
			service_pro.cartInsert(req, model);
			return "/customer/c_cartInsertPro";
	
		// 장바구니에서 '바로 구매하기 누르면 타는거' 	=> 주문페이지로 이동 
		}else if(btnState.equals("바로 주문하기")) {
			
			// 값 다시 셋팅해서 다시 보내기 
			model.addAttribute("p_cnt", req.getParameter("p_cnt"));
			model.addAttribute("p_total",req.getParameter("p_total"));
			model.addAttribute("btnState", btnState);
			model.addAttribute("p_name", req.getParameter("p_name"));
			model.addAttribute("p_code", req.getParameter("p_code"));
			model.addAttribute("p_image", req.getParameter("p_image"));
			
			service.getMemberInfo(req, model); // 회원정보 보여줄거 
			return "/common/p_order";
		}else {
			
			return "";		// ????? 
		}
	}
	
	
	// 주문 처리 페이지  
	@RequestMapping("product_orderPro")
	public String product_orderPro(HttpServletRequest req, Model model) {
		logger.info("url ==> product_orderPro");
		
		//서비스 탄다. 오더테이블에 저장 + 오더로그테이블도 
		service_pro.productOrderPro(req, model);
		return "/common/p_orderPro";
	}
	
	
	// 상품 취소처리로 변경(결제완료 전!! 관리자 상태변경전에 탄다) 
	@RequestMapping("cancleUpdate")
	public String cancleUpdate(HttpServletRequest req, Model model) {
		logger.info("url ==> cancleUpdate");
		
		service_pro.orderUpdate(req, model);
		return "/customer/c_stateUpdate";
	}
	
	// 장바구니 개별 삭제 
	@RequestMapping("cartdelete")
	public String cartdelete(HttpServletRequest req, Model model) {
		logger.info("url ==> cartdelete");
		
		// 카트 DB 삭제 (id, cartNum 넘김)
		service_pro.cartDeletePro(req, model);
		return "/customer/c_cartDelete";
	}
	
	
	// 아이디 /비밀번호 찾기 페이지 이동
	@RequestMapping("id_pwdChk")
	public String id_pwdChk(HttpServletRequest req, Model model) {
		logger.info("url ==> id_pwdChk");
		return "/common/id_pwdChk";
	}
	
	
    // 아이디 찾기 처리
    @RequestMapping("idFindPro")
    public @ResponseBody Map<String, Object> idFindPro(HttpServletRequest req, Model model) {
        logger.info("url ==> idFindPro");
        
        Map<String,Object> map = new HashMap<String, Object>();
        //String name = req.getParameter("v_memname");
        //String type = req.getParameter("v_findtype");
        //String mail = req.getParameter("v_mememail");
        //System.out.println(name + type+ mail);
        
        // 서비스 타야함 (일단 아이디찾기)
        String id = service.idFindPro(req, model);
        map.put("id", id);
        
        return map;
    }
	
	// 비밀번호 찾기1 - 아이디, 이메일 확인하기 
	@RequestMapping("pwdFindPro")
	public @ResponseBody int pwdFindPro(HttpServletRequest req, Model model) {
		logger.info("url ==> pwdFindPro");
		// 일단 아이디/ 이메일 맞는지 확인 
		int cnt = service.idEmailChk(req, model);
		return cnt;
	}
	
	// 비밀번호 찾기2 - 이메일보내기 
	@RequestMapping("pwdFindPro2")
	public @ResponseBody String pwdFindPro2(HttpServletRequest req, Model model) {
		logger.info("url ==> pwdFindPro2 / 이메일 발송 ");
		
		service.pwdFindPro(req, model);
		return "send";
	}
	
	// 비밀번호 찾기3 - 키값 확인하기 
	@RequestMapping("pwdFindPro3")
	public @ResponseBody int pwdFindPro3(HttpServletRequest req, Model model) {
		logger.info("url ==> pwdFindPro3 / DB 키값 확인 ");
		
		int cnt = service.pwdFindPro2(req, model);
		return cnt;
	}
	
	// 비밀번호 수정 4
	@RequestMapping("pwdModify")
	public @ResponseBody int pwdModify(HttpServletRequest req, Model model) {
		logger.info("url ==> pwdModify");
		
		int cnt = service.pwdModify(req, model);
		return cnt;
	}
		
	
}
