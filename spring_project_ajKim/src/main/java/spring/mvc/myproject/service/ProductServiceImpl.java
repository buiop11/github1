package spring.mvc.myproject.service;

import java.security.Principal;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.ui.Model;

import spring.mvc.myproject.persistence.ProductDAO;
import spring.mvc.myproject.vo.ArtboxCartVO;
import spring.mvc.myproject.vo.ArtboxMemberVO;
import spring.mvc.myproject.vo.ArtboxOrderVO;
import spring.mvc.myproject.vo.ArtboxProductVO;

@org.springframework.stereotype.Service
public class ProductServiceImpl implements ProductService {

	@Autowired
	ProductDAO dao;
	
	
	//  상품리스트보기 
	@Override
	public void productContent(HttpServletRequest req, Model model) {
        // 페이징 처리 
        int pageSize = 16;          // 한 페이지당 출력할  상품 갯수 
        int pageBlock = 3;        // 한 블럭당 페이지 갯수 
        
        int cnt = 0;             // 글의 갯수 
        int start = 0;            // 현재페이지의 시작 페이지번호   ex) <1|2|3> 의 1 -> db파라미터로 넘겨줄값
        int end = 0;             // 현재페이지의 마지막 페이지번호  ex) <1|2|3> 의 3 -> db파라미터로 넘겨줄값
        int number = 0;            // 출력용 글번호  (보이는 , 중간글이 삭제되도 알아서 맞춰지게)
        String pageNum = "";     // 페이지 번호  ( 넘겨받을 )
        int currentPage = 0;    // 현재 페이지 
        
        int pageCount = 0;        // 페이지 갯수
        int startPage = 0;        // 시작 페이지 
        int endPage = 0;        // 마지막 페이지 
        
        String category = req.getParameter("category"); // 카테고리 받기 
        
        // 4단계. 다형성 적용 , 싱글톤 방식으로  dao 객체를 생성
        //ProductDAO dao = ProductDAOImpl.getInstance();
 
        // 5-1단계. 상품 갯수 구하기  (카테고리 코드별로 - 공통페이지에 코드별로 출력할거)
        cnt = dao.getProductListCnt(category);
        
        System.out.println("cnt : " + cnt);  // 먼저 테이블에 30건 insert 해둠 
        
        // 받을 예정 
        pageNum = req.getParameter("pageNum");
        
        if(pageNum == null) {
            pageNum = "1";             // 첫 페이지를 1로 지정 
        }
        
        // 현재페이지 출력 
        System.out.println("~~~~~~~~~~~~~~" + pageNum);
        currentPage = Integer.parseInt(pageNum);        // 현재페이지 : 1 / 계산을 위해서 안에서 pageNum을 int로 변환 
        System.out.println("currentPage : " + currentPage);
        
        // 페이지 갯수   6 = (30 / 5) + (0)  // pagesize= 5, pageBlock = 3
        pageCount = (cnt / pageSize) + (cnt % pageSize > 0 ? 1: 0);    // 삼항연산자 
        // 예) 글갯수가 31건인 경우, 6페이지 이후 1개에 대한 추가적인 페이지가 필요함.  (페이지 갯수 + 나머지 있으면 1추가) 
        
        // 현재 페이지  시작 글번호 (페이지별) ----- DB에서 가져올 글 숫자 구함 !!
        // 1 = (1 - 1) * 5 + 1         // pagesize= 5, pageBlock = 3
        start = (currentPage - 1) * pageSize + 1; 
        
        // 현재페이지 마지막 글번호 (페이지별)
        // 5 = 1 + 5 - 1 
        end = start + pageSize - 1; 
        
        System.out.println("start : " + start);
        System.out.println("end : " + end);
        
        if(end > cnt) end = cnt;  // 혹시 이런 경우를 대비해서 
        
        // 출력용 글번호
        number = cnt - (currentPage -1) * pageSize;
        
        System.out.println("number (출력용페이지) : " + number);
        System.out.println("pageSize : " + pageSize);
        
        if(cnt > 0) {
            
        // 5-2단계. 게시글 목록 조회 
        	Map<String, Object> map = new HashMap<String,Object>();
        	map.put("start", start);
        	map.put("end", end);
        	map.put("category", category);
            List<ArtboxProductVO> productList = dao.getProductList(map);
            model.addAttribute("productList", productList);              //  큰바구니 : 게시글 목록 cf)작은 바구니 : 게시글 1건 
        }
        
        // 6단계. request 나 session에 처리 결과를 저장 (JSP에 전달하기 위함)
        // 1 = (1 / 3 ) * 3 + 1; 
        startPage = (currentPage / pageBlock) * pageBlock + 1;
        
        if(currentPage % pageBlock == 0) startPage -= pageBlock;         
        System.out.println("startPage : " + startPage);
        
        // 마지막 페이지 
        // 3 = 1 + 3 - 1; 
        endPage = startPage + pageBlock - 1;
        
        if(endPage > pageCount) endPage = pageCount;
        System.out.println("endPage : " + endPage);
 
        model.addAttribute("cnt", cnt);            // 글 갯수
        model.addAttribute("number", number);      // 출력용 글번호 
        model.addAttribute("pageNum", pageNum);    // 페이지 번호
        model.addAttribute("category", category); // 카테고리
        
        if(cnt > 0) {
        	model.addAttribute("startPage", startPage);         // 시작페이지
        	model.addAttribute("endPage", endPage);             // 마지막페이지
        	model.addAttribute("pageBlock", pageBlock);         // 출력할 페이지 갯수 
        	model.addAttribute("pageCount", pageCount);         // 페이지 갯수
        	model.addAttribute("currentPage", currentPage);     // 현재 페이지 
        }
		
	}
	
	
	// 검색된 상품 리스트 보기 
	@Override
	public void searchProduct(HttpServletRequest req, Model model) {
        // 페이징 처리 
        int pageSize = 16;          // 한 페이지당 출력할  상품 갯수 
        int pageBlock = 3;        // 한 블럭당 페이지 갯수 
        
        int cnt = 0;             // 글의 갯수 
        int start = 0;            // 현재페이지의 시작 페이지번호   ex) <1|2|3> 의 1 -> db파라미터로 넘겨줄값
        int end = 0;             // 현재페이지의 마지막 페이지번호  ex) <1|2|3> 의 3 -> db파라미터로 넘겨줄값
        int number = 0;            // 출력용 글번호  (보이는 , 중간글이 삭제되도 알아서 맞춰지게)
        String pageNum = "";     // 페이지 번호  ( 넘겨받을 )
        int currentPage = 0;    // 현재 페이지 
        
        int pageCount = 0;        // 페이지 갯수
        int startPage = 0;        // 시작 페이지 
        int endPage = 0;        // 마지막 페이지 
        
        String input = req.getParameter("searchInput"); // 카테고리 받기 
        input = input.trim();
        System.out.println("input~~~~~"   + input);

        // 5-1단계. 상품 갯수 구하기  (카테고리 코드별로 - 공통페이지에 코드별로 출력할거)
        cnt = dao.getSearchProduct(input);
        
        System.out.println("cnt : " + cnt);  // 먼저 테이블에 30건 insert 해둠 
        
        // 받을 예정 
        pageNum = req.getParameter("pageNum");
        if(pageNum == null) {
            pageNum = "1";             // 첫 페이지를 1로 지정 
        }
        
        // 현재페이지 출력 
        System.out.println("~~~~~~~~~~~~~~" + pageNum);
        currentPage = Integer.parseInt(pageNum);        // 현재페이지 : 1 / 계산을 위해서 안에서 pageNum을 int로 변환 
        System.out.println("currentPage : " + currentPage);
        
        pageCount = (cnt / pageSize) + (cnt % pageSize > 0 ? 1: 0);    // 삼항연산자 
        
        // 현재 페이지  시작 글번호 (페이지별) ----- DB에서 가져올 글 숫자 구함 !!
        start = (currentPage - 1) * pageSize + 1; 
        
        // 현재페이지 마지막 글번호 (페이지별)
        end = start + pageSize - 1; 
        
        System.out.println("start : " + start);
        System.out.println("end : " + end);
        
        if(end > cnt) end = cnt;  // 혹시 이런 경우를 대비해서 
        
        // 출력용 글번호
        number = cnt - (currentPage -1) * pageSize;
        
        System.out.println("number (출력용페이지) : " + number);
        System.out.println("pageSize : " + pageSize);
        
        if(cnt > 0) {
            
        // 5-2단계. 게시글 목록 조회 
        	Map<String, Object> map = new HashMap<String,Object>();
        	map.put("start", start);
        	map.put("end", end);
        	map.put("input", input);
            List<ArtboxProductVO> productList = dao.getSearchList(map);
            model.addAttribute("productList", productList);              //  큰바구니 : 게시글 목록 cf)작은 바구니 : 게시글 1건 
        }
        
        // 6단계. request 나 session에 처리 결과를 저장 (JSP에 전달하기 위함)
        // 1 = (1 / 3 ) * 3 + 1; 
        startPage = (currentPage / pageBlock) * pageBlock + 1;
        
        if(currentPage % pageBlock == 0) startPage -= pageBlock;         
        System.out.println("startPage : " + startPage);
        
        // 마지막 페이지 
        // 3 = 1 + 3 - 1; 
        endPage = startPage + pageBlock - 1;
        
        if(endPage > pageCount) endPage = pageCount;
        System.out.println("endPage : " + endPage);
 
        model.addAttribute("cnt", cnt);            // 글 갯수
        model.addAttribute("number", number);      // 출력용 글번호 
        model.addAttribute("pageNum", pageNum);    // 페이지 번호
        model.addAttribute("input", input); // 카테고리
        
        if(cnt > 0) {
        	model.addAttribute("startPage", startPage);         // 시작페이지
        	model.addAttribute("endPage", endPage);             // 마지막페이지
        	model.addAttribute("pageBlock", pageBlock);         // 출력할 페이지 갯수 
        	model.addAttribute("pageCount", pageCount);         // 페이지 갯수
        	model.addAttribute("currentPage", currentPage);     // 현재 페이지 
        }
		
	}


	
	// 상품 상세 보기 !!! 
	@Override
	public void productView(HttpServletRequest req, Model model) {
        // 3단계. 화면으로부터 입력받은 값을 받아온다. 
        String p_code = req.getParameter("p_code");
        
        // 4단계. 다형성 적용 , 싱글톤 방식으로  dao 객체를 생성
        //ProductDAO dao = ProductDAOImpl.getInstance();
        // 5-2단계. 상세 페이지 조회 
        ArtboxProductVO vo = dao.getProduct(p_code);
        
        // 6단계. request 나 session에 처리 결과를 저장(jsp에 전달하기 위함)
        req.setAttribute("vo", vo);   
	}
	
	
	// 장바구니 추가하기 
	@Override
	public void cartInsert(HttpServletRequest req, Model model) {
		
		// 3. 받아서 셋팅 
		ArtboxCartVO vo = new ArtboxCartVO();
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication(); 
	    User user = (User) authentication.getPrincipal();
	    String strId = user.getUsername();
	    
		//vo.setId((String)req.getSession().getAttribute("memId"));	// 아이디 
	    vo.setId(strId);	// 아이디
		vo.setP_code(req.getParameter("p_code"));	// 상품코드 
		vo.setP_name(req.getParameter("p_name"));	// 상품이름 
		vo.setP_image(req.getParameter("p_image"));	// 상품 이미지
		vo.setC_count(Integer.parseInt(req.getParameter("p_cnt"))); // 주문 수
		vo.setC_price(Integer.parseInt(req.getParameter("p_total")));	// 가격 
		
		System.out.println("~~~~상품수~~~~" + Integer.parseInt(req.getParameter("p_cnt")));
		System.out.println("~~~ 상품가격~~~" + Integer.parseInt(req.getParameter("p_total")));
		
		// 4. 
		//ProductDAO dao = ProductDAOImpl.getInstance();
		// 5. dao 호출 
		int insertCnt = dao.cartInsert(vo);
		
		// 6. 다시 값 전달 
		model.addAttribute("insertCnt", insertCnt);
	}

	
	// 상품 주문처리 페이지!
	@Override
	public void productOrderPro(HttpServletRequest req, Model model) {
		
		// 오더 vo 만들어야함 
		ArtboxOrderVO vo = new ArtboxOrderVO();
		//vo.setId(req.getParameter("id"));	// 회원 id
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication(); 
	    User user = (User) authentication.getPrincipal();
	    String strId = user.getUsername();
	    
	    vo.setId(strId);	// 회원 id
		vo.setP_code(req.getParameter("p_code"));
		vo.setP_name(req.getParameter("p_name"));
		vo.setP_image(req.getParameter("p_image"));
		vo.setO_count(Integer.parseInt(req.getParameter("o_count")));
		vo.setO_price(Integer.parseInt(req.getParameter("o_price")));
		vo.setO_name(req.getParameter("o_name"));	// 받는사람이름
		vo.setAddress(req.getParameter("address"));	// 받는사람 주소
		
		// 전화번호는 쪼개서 저장  
		String hp = "";  
		String hp1 = req.getParameter("hp1");
		String hp2 = req.getParameter("hp2");
		String hp3 = req.getParameter("hp3");
		
		if(!hp1.equals("") && !hp2.equals("") && !hp3.equals("")) {
			hp = hp1 + "-" + hp2 + "-" + hp3;
		}
		vo.setO_phone(hp);	// 받는사람 연락처
		
		//주문일자 
		vo.setO_date(new Timestamp(System.currentTimeMillis()));
		
		//★★state 첫 상태는 무조건 일단 '결제요청'으로 생성
		vo.setState("결제요청"); //프로시저에서 처리 
		
		// dao 호출 (프로시저 사용) 
		//ProductDAO dao = ProductDAOImpl.getInstance();
		int cnt = dao.insertOrder(vo);
		
		dao.insertLogOrder(vo); // 로그테이블에 insert!!
		
		// 값 보내기 
		model.addAttribute("insertCnt", cnt);
		
	}

	
	// 주문 정보 보기 (마이페이지 열릴때 항상 로드 된다. / 아이디별로 갖고와야함) 
	@Override
	public void c_orderContent(HttpServletRequest req, Model model) {
	     int pageSize = 5;          // 한 페이지당 출력할 글 갯수 
	     int pageBlock = 3;        // 한 블럭당 페이지 갯수 
	     
	     int cnt = 0;             // 글의 갯수 
	     int start = 0;            // 현재페이지의 시작 페이지번호   ex) <1|2|3> 의 1 -> db파라미터로 넘겨줄값
	     int end = 0;             // 현재페이지의 마지막 페이지번호  ex) <1|2|3> 의 3 -> db파라미터로 넘겨줄값
	     int number = 0;            // 출력용 글번호  (보이는 , 중간글이 삭제되도 알아서 맞춰지게)
	     String pageNum = "";     // 페이지 번호  ( 넘겨받을 )
	     int currentPage = 0;    // 현재 페이지 
	     
	     int pageCount = 0;        // 페이지 갯수
	     int startPage = 0;        // 시작 페이지 
	     int endPage = 0;        // 마지막 페이지 
	     
	     // 회원id 세션 값 가져옴 
	     //String strId = (String)req.getSession().getAttribute("memId");
	     Authentication authentication = SecurityContextHolder.getContext().getAuthentication(); 
	     User user = (User) authentication.getPrincipal();
	     String strId = user.getUsername();
	     
	     // 5-1단계. 회원별!!! ★오더 건 수 구하기 
	     cnt = dao.getC_orderCnt(strId);
	     
	     System.out.println("cnt : " + cnt); 
	     
	     // 받을 예정 
	     pageNum = req.getParameter("pageNum");
	     
	     if(pageNum == null) { pageNum = "1";}		 // 첫 페이지를 1로 지정
	     
	     // 현재페이지 출력 
	     System.out.println("~~~~~~~~~~~~~~" + pageNum);
	     currentPage = Integer.parseInt(pageNum);        // 현재페이지 : 1 / 계산을 위해서 안에서 pageNum을 int로 변환 
	     System.out.println("currentPage : " + currentPage);
	     
	     pageCount = (cnt / pageSize) + (cnt % pageSize > 0 ? 1: 0);    // 삼항연산자 
	     start = (currentPage - 1) * pageSize + 1; 
	     end = start + pageSize - 1; 
	     
	     System.out.println("start : " + start);
	     System.out.println("end : " + end);
	     
	     if(end > cnt) end = cnt;  // 혹시 이런 경우를 대비해서 
	     
	     // 출력용 글번호
	     number = cnt - (currentPage -1) * pageSize;
	     
	     System.out.println("number (출력용페이지) : " + number);
	     System.out.println("pageSize : " + pageSize);
	     
	     // ★회원 별 오더수가 있다면 
	     if(cnt > 0) {
	    	 Map<String,Object> map = new HashMap<String,Object>();
	    	 map.put("strId", strId);
	    	 map.put("start", start);
	    	 map.put("end", end);
	         List<ArtboxOrderVO> orderList = dao.getC_orderList(map); //회원별 주문건 가져오기
	         model.addAttribute("orderList", orderList);              
	     }
	     
	     // 6단계. request 나 session에 처리 결과를 저장 (JSP에 전달하기 위함)
	     // 시작페이지 
	     // 1 = (1 / 3 ) * 3 + 1; 
	     startPage = (currentPage / pageBlock) * pageBlock + 1;
	     
	     if(currentPage % pageBlock == 0) startPage -= pageBlock;         
	     System.out.println("startPage : " + startPage);
	     
	     // 마지막 페이지 
	     endPage = startPage + pageBlock - 1;
	     
	     if(endPage > pageCount) endPage = pageCount;
	     System.out.println("endPage : " + endPage);
	     
	     System.out.println("=======================");
	
	     model.addAttribute("cnt", cnt);            // 글 갯수
	     model.addAttribute("number", number);        // 출력용 글번호 
	     model.addAttribute("pageNum", pageNum);    // 페이지 번호
	     
	     if(cnt > 0) {
	    	 model.addAttribute("startPage", startPage);         // 시작페이지
	    	 model.addAttribute("endPage", endPage);             // 마지막페이지
	    	 model.addAttribute("pageBlock", pageBlock);         // 출력할 페이지 갯수 
	    	 model.addAttribute("pageCount", pageCount);         // 페이지 갯수
	    	 model.addAttribute("currentPage", currentPage);     // 현재 페이지 
	     }
	}
	
	
	// 주문건 상태 변경 시키기   
	@Override
	public void orderUpdate(HttpServletRequest req, Model model) {
		// 3. 받아온 값 정리 
		int o_num = Integer.parseInt(req.getParameter("o_num"));
		
		// 로그 인서트해야하니깐 값 받기 
		// 오더 vo 만들어야함 
		ArtboxOrderVO vo = new ArtboxOrderVO();
		vo.setO_num(o_num);
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication(); 
	    User user = (User) authentication.getPrincipal();
	    String strId = user.getUsername();
	    vo.setId(strId);
		//vo.setId(req.getParameter("id"));	// 회원 id
		vo.setP_code(req.getParameter("p_code"));
		vo.setP_name(req.getParameter("p_name"));
		vo.setP_image(req.getParameter("p_image"));
		vo.setO_count(Integer.parseInt(req.getParameter("o_count")));
		vo.setO_price(Integer.parseInt(req.getParameter("o_price")));
		vo.setO_name(req.getParameter("o_name"));	// 받는사람이름
		vo.setAddress(req.getParameter("address"));	// 받는사람 주소
		vo.setO_phone(req.getParameter("o_phone"));	// 받는사람 연락처

		// 상태 -- 로그에만 남길거니깐 !
		String state = req.getParameter("state");
		
		// 5. dao호출 (프로시저)
		int updateCnt = 0;

		//처리하는자 (관리자/ 고객 다 같은 테이블에 있어서 다 같음 ^^ㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎ)
		vo.setAdmin_id(strId);
		
		if(state.equals("결제요청")) { 	// 관리자만 버튼있다. 
			vo.setState("결제요청"); 
			updateCnt = dao.updateState(vo);
			
		}else if(state.equals("결제완료")) {	// 손님이 환불요청을 한거임
			vo.setState("결제완료"); 
			//환불일자 (로그에 넣을거임)
			vo.setR_date(new Timestamp(System.currentTimeMillis()));
			updateCnt = dao.updateState(vo);	//여기서끝내고 ㅋㅋ;; 다시 로그를 위해서 
			
			vo.setState("환불요청"); // 환불요청으로 셋팅..ㅋㅋ;;; 
			
		}else if(state.equals("환불요청")) { // 관리자만 버튼있다. 
			vo.setState(state);
			//환불일자 (로그에 넣을거임)
			vo.setR_date(new Timestamp(System.currentTimeMillis()));
			updateCnt = dao.cancleState(vo);
			
		}else if(state.equals("취소완료")) {	// 손님이 취소요청을 한거임(결제완료전)
			vo.setState("취소완료");
			//환불일자 (로그에 넣을거임)
			vo.setR_date(new Timestamp(System.currentTimeMillis()));
			//취소완료는 말그대로 상태만 변경하는거라 로그테이블처럼 똑같이 수정하나해야함 
			updateCnt = dao.cancleState(vo);
		
		// 주문확정처리는 상태변경만 할꺼 	
		}else if(state.equals("주문확정")) {
			vo.setState("주문확정"); 
			updateCnt = dao.updateState(vo);
		}
		
		// dao 호출 (로그테이블에 넣을거)
		dao.insertLogOrder(vo);

		// 6. 다시 값 전달 
		model.addAttribute("updateCnt", updateCnt);
	}
	
	
	// 장바구니 (카트) 리스트보이기  
	@Override
	public void cartView(HttpServletRequest req, Model model) {
		//3.값가져온다 
		//String id = (String)req.getSession().getAttribute("memId");
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication(); 
		User user = (User) authentication.getPrincipal();
		String id = user.getUsername();
		
		// 5.
		List<ArtboxCartVO> cart = dao.getCart(id); 
		// 6. 
		model.addAttribute("cart", cart);
	}

	
	// 장바구니 삭제하기 
	@Override
	public void cartDeletePro(HttpServletRequest req, Model model) {
	     // 3단계. 화면으로부터 넘어온 값을 받는다. 
        int cartNum = Integer.parseInt(req.getParameter("cartNum"));
        String id = (String)req.getSession().getAttribute("memId");
        
        Map<String,Object> map = new HashMap<String,Object>();
        map.put("cartNum", cartNum);
        map.put("id", id);
        int deleteCnt = dao.deleteCart(map);
        
        // 6단계. request 나  session에 처리 결과를 저장 (jsp에 전달하기 위함) 
        model.addAttribute("deleteCnt", deleteCnt);
		
	}
	
	
	
	// 주문 정보 보기- 관리자용 /전체 
	@Override
	public void orderContent(HttpServletRequest req, Model model) {
		// 검색값 일단 전달 받기 
		String p_name = (req.getParameter("productName") == null)? "" : req.getParameter("productName");
		p_name = p_name.trim();
		
		String id = (req.getParameter("memberId") == null)? "": req.getParameter("memberId");
		id = id.trim();
		
		String state = (req.getParameter("state") == null)? "" : req.getParameter("state");
		state.trim();
		
		//-----------------
		int pageSize = 5;          // 한 페이지당 출력할 글 갯수 
        int pageBlock = 3;        // 한 블럭당 페이지 갯수 
        
        int cnt = 0;             // 글의 갯수 
        int start = 0;            // 현재페이지의 시작 페이지번호   ex) <1|2|3> 의 1 -> db파라미터로 넘겨줄값
        int end = 0;             // 현재페이지의 마지막 페이지번호  ex) <1|2|3> 의 3 -> db파라미터로 넘겨줄값
        int number = 0;            // 출력용 글번호  (보이는 , 중간글이 삭제되도 알아서 맞춰지게)
        String pageNum = "";     // 페이지 번호  ( 넘겨받을 )
        int currentPage = 0;    // 현재 페이지 
        
        int pageCount = 0;        // 페이지 갯수
        int startPage = 0;        // 시작 페이지 
        int endPage = 0;        // 마지막 페이지 
        
        // 5-1단계. 오더 건 수 (갯수)구하기
        Map<String, Object> map = new HashMap<String, Object>();
        // 검색된 값 map에 넣기 
        map.put("p_name", p_name); 	
        map.put("id", id);
        map.put("state", state);
        
        cnt = dao.getAllOrder(map);
        System.out.println("cnt : " + cnt);  // 먼저 테이블에 30건 insert 해둠 
        
        // 받을 예정 
        pageNum = req.getParameter("pageNum");
        
        if(pageNum == null) {
            pageNum = "1";             // 첫 페이지를 1로 지정 
        }
        
        // 현재페이지 출력 
        System.out.println("~~~~~~~~~~~~~~" + pageNum);
        currentPage = Integer.parseInt(pageNum);        // 현재페이지 : 1 / 계산을 위해서 안에서 pageNum을 int로 변환 
        System.out.println("currentPage : " + currentPage);
        
        pageCount = (cnt / pageSize) + (cnt % pageSize > 0 ? 1: 0);    // 삼항연산자 
        
        // 현재 페이지  시작 글번호 (페이지별) ----- DB에서 가져올 글 숫자 구함 !!
        start = (currentPage - 1) * pageSize + 1; 
        
        // 현재페이지 마지막 글번호 (페이지별)
        end = start + pageSize - 1; 
        
        System.out.println("start : " + start);
        System.out.println("end : " + end);
        
        if(end > cnt) end = cnt;  // 혹시 이런 경우를 대비해서 
        
        // 출력용 글번호
        number = cnt - (currentPage -1) * pageSize;
        
        System.out.println("number (출력용페이지) : " + number);
        System.out.println("pageSize : " + pageSize);
        
        if(cnt > 0) {
        	// 5-2단계. 게시글 목록 조회 
        	//Map<String,Object> map = new HashMap<String, Object>();
        	map.put("start", start);
        	map.put("end", end);
            List<ArtboxOrderVO> orderList = dao.getOrderAllList(map);
            model.addAttribute("orderList", orderList);              
        }
        
        // 6단계. request 나 session에 처리 결과를 저장 (JSP에 전달하기 위함)
        // 시작페이지 
        startPage = (currentPage / pageBlock) * pageBlock + 1;
        
        if(currentPage % pageBlock == 0) startPage -= pageBlock;         
        System.out.println("startPage : " + startPage);
        
        // 마지막 페이지 
        endPage = startPage + pageBlock - 1;
        
        if(endPage > pageCount) endPage = pageCount;
        System.out.println("endPage : " + endPage);
        
        System.out.println("=======================");
 
        model.addAttribute("cnt", cnt);            // 글 갯수
        model.addAttribute("number", number);        // 출력용 글번호 
        model.addAttribute("pageNum", pageNum);    // 페이지 번호
        
        if(cnt > 0) {
        	model.addAttribute("startPage", startPage);         // 시작페이지
        	model.addAttribute("endPage", endPage);             // 마지막페이지
        	model.addAttribute("pageBlock", pageBlock);         // 출력할 페이지 갯수 
        	model.addAttribute("pageCount", pageCount);         // 페이지 갯수
        	model.addAttribute("currentPage", currentPage);     // 현재 페이지 
        }
	}
	
	
	// 결산 처리 서비스!!
	@Override
	public void totalcalc(HttpServletRequest req, Model model) {

        // 총판매액 가져옴 
        int totalSale = dao.getTotalSale();
        
        // 차트 가져옴 (카테고리별로)
        List<Map<String,Object>> chart1 = dao.getChart();	// 달별 
        List<Map<String,Object>> chart2 = dao.getCategory("1907");  // 카테고리 별 1907월것만 일단 볼거임 
        //List<Map<String,Object>> chart2 = dao.getCategory();
        
        System.out.println(chart1);
        System.out.println(chart2);
        
        // 값 넘기기 
        model.addAttribute("totalSale", totalSale);
        model.addAttribute("chart1", chart1);	//★★★★★★ 하는중★★ 왜 에러남? ㅠㅠㅠㅠㅠ ★★★★★★★★★★★★★
        model.addAttribute("chart2", chart2);
		
	}
	
	
	
	
	
	
}
