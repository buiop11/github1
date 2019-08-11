package spring.mvc.myproject.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import spring.mvc.myproject.persistence.AdminDAO;
import spring.mvc.myproject.persistence.DAO;
import spring.mvc.myproject.persistence.ProductDAO;
import spring.mvc.myproject.vo.ArtboxMemberVO;
import spring.mvc.myproject.vo.ArtboxProductVO;

//import com.oreilly.servlet.MultipartRequest;
//import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;


@org.springframework.stereotype.Service
public class AdminServiceImpl implements AdminService {

	
	@Autowired
	AdminDAO dao;
	
	@Autowired
	ProductDAO p_dao;
	
	@Autowired
	AdminDAO a_dao;
	
	@Autowired
	DAO c_dao;
	
	// 로그인 처리 
	@Override
	public void loginPro(HttpServletRequest req, Model model) {
		
		// 3. 넘겨 받은 값 정리 
		String strId = req.getParameter("id");
		String strPwd = req.getParameter("pwd");
		
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("strId", strId);
		map.put("strPwd", strPwd);
		int loginCnt = dao.loginCheck(map);
		
		// 5. 다시 컨트롤러로 전달하기 
		if(loginCnt == 1) {
			req.getSession().setAttribute("adminId", strId);
		}
	
		model.addAttribute("cnt", loginCnt);
	}

	
	//---- ★★  ★★   상품 등록, 처리 ★★  ★★   --- 

	// 상품 테이블 리스트 보기 
	@Override
	public void productList(HttpServletRequest req, Model model) {
        // 페이징 처리 
        int pageSize = 10;          // 한 페이지당 출력할 글 갯수 
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
        
        // 5-1단계. 글갯수 구하기 
        cnt = dao.getProductCnt();
        
        System.out.println("cnt : " + cnt);  // 먼저 테이블에 30건 insert 해둠 
        
        // 받을 예정 
        pageNum = req.getParameter("pageNum");
        
        if(pageNum == null) {
            pageNum = "1";             // 첫 페이지를 1로 지정 
        }
        
        // 현재페이지 출력 
        currentPage = Integer.parseInt(pageNum);        // 현재페이지 : 1 / 계산을 위해서 안에서 pageNum을 int로 변환 
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
        	Map<String,Object> map = new HashMap<String, Object>();
        	map.put("start", start);
        	map.put("end", end);
            List<ArtboxProductVO> productList = dao.getProductList(map);
            model.addAttribute("productList", productList);              //  큰바구니 : 게시글 목록 cf)작은 바구니 : 게시글 1건 
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
	
	
	// 회원테이블 보기 (ad_member_3.jsp 열때 보이기) 
	@Override
	public void memberContent(HttpServletRequest req, Model model) {
        int pageSize = 10;          // 한 페이지당 출력할 글 갯수 
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
        
        // 5-1단계. 글갯수 구하기 
        cnt = dao.getMemberCnt();
        System.out.println("cnt : " + cnt);  // 먼저 테이블에 30건 insert 해둠 
        
        // 받을 예정 
        pageNum = req.getParameter("pageNum");
        
        if(pageNum == null) {
            pageNum = "1";             // 첫 페이지를 1로 지정 
        }
        
        // 현재페이지 출력 
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
        	Map<String,Object> map = new HashMap<String,Object>();
        	map.put("start", start);
        	map.put("end", end);
            List<ArtboxMemberVO> memberList = dao.getArticleList(map);
            model.addAttribute("memberList", memberList);              //  큰바구니 : 게시글 목록 cf)작은 바구니 : 게시글 1건 
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
	
	
	// 상품 상세 
	@Override
	public void p_contentForm(HttpServletRequest req, Model model) {
	       
		String p_code = req.getParameter("p_code");
        int pageNum = Integer.parseInt(req.getParameter("pageNum"));
        
        //해당글 1건을 읽어서 BoardVO에 담아서 온다. 
        ArtboxProductVO vo = p_dao.getProduct(p_code);
        
        // 6단계. request나 session에  처리 결과를 저장 (jsp에 전달하기 위함) 
        req.setAttribute("vo", vo);
        req.setAttribute("p_code", p_code);
        req.setAttribute("pageNum", pageNum);		
		
	}
	
	
	// 상품 등록 처리 (파일업로드)
	@Override
	public void p_insertPro(MultipartHttpServletRequest req, Model model) {
		
		// 이미지 파일 올리기 
		MultipartFile file = req.getFile("img");  // img, info 랑 2개임. .
		MultipartFile file2 = req.getFile("info");
		// 업로드할 파일의 최대 사이즈(10 * 1024 * 1024 = 10MB)
		int maxSize = 10 * 1024 * 1024;
		// 임시 파일이 저장되는 논리적인 경로
		String saveDir = req.getRealPath("/resources/images/p_detail/");
		// 업로드할 파일이 위치하게될 물리적인 경로
		String realDir = "C:\\Dev50\\workspace_spring\\spring_project_ajKim\\src\\main\\webapp\\resources\\images\\p_detail\\";
		
		ArtboxProductVO vo = new ArtboxProductVO(); //   담을 그릇
		
		try {
			file.transferTo(new File(saveDir+file.getOriginalFilename()));
			FileInputStream fis = new FileInputStream(saveDir + file.getOriginalFilename());
			FileOutputStream fos = new FileOutputStream(realDir + file.getOriginalFilename());
			
			int data = 0;
			
				while((data = fis.read()) != -1) {
					fos.write(data);
				}
			fis.close();
			fos.close();
			
	
			// "img" 파일 담기
			String filename = file.getOriginalFilename();
			vo.setP_image(filename);
			
			// info 이미지 
			file2.transferTo(new File(saveDir+file2.getOriginalFilename()));
			FileInputStream fis2 = new FileInputStream(saveDir + file2.getOriginalFilename());
			FileOutputStream fos2 = new FileOutputStream(realDir + file2.getOriginalFilename());
			
			int data2 = 0;
			
				while((data2 = fis2.read()) != -1) {
					fos2.write(data2);
				}
			fis2.close();
			fos2.close();
			
			// "info" 파일 담기
			String filename2 = file2.getOriginalFilename();
			vo.setP_info(filename2);
			
			
			// 파일 외에 나머지 값들 받기 
			// 코드 담기 
			String code1 = req.getParameter("category");//t, d
	
			//  상품 code에 부여할 날짜 셋팅 
			Date now = new Date();
			SimpleDateFormat sf = new SimpleDateFormat("yyyyMMdd");
			String today = sf.format(now);
			
			// 날짜 뒤에 붙일 1~100 사이 랜덤 번호 (중복제거) -->> ★★  ★★  ★★   중복 제거 안됨 ㅠㅠ 
			int[] numbers = new int[6];
			Random gen = new Random();
			
			for(int i =0 ; i<6 ; i++  ){
			 numbers[i] = gen.nextInt(100)+1; // 2자리 난수생성
				for(int j = 0; j < i; j++){              
				 if(numbers[i] == numbers[j]){  
				  i = i-1;                                 
				  break;                             
				 }
				}
			}
			int r_code = 0; // 담을 변수 선언 
			for(int a =0 ; a <1; a++){
				r_code = numbers[a];
			}
			String code2 = String.valueOf(r_code);
			String p_code = code1 + today +"_" + code2; 
			vo.setP_code(p_code);
			
			vo.setP_name(req.getParameter("name"));
			vo.setP_price(Integer.parseInt(req.getParameter("price")));
			vo.setP_count(Integer.parseInt(req.getParameter("count")));
			vo.setP_date(new Timestamp(System.currentTimeMillis()));
			vo.setAdmin_id(req.getParameter("admin_id"));
			vo.setCategory(req.getParameter("category"));
	
			// dao 호출 
			//AdminDAO dao = AdminDAOImpl.getInstance();
			int cnt = a_dao.insertProduct(vo);
			
			// 값보내기 
			model.addAttribute("insertCnt", cnt);
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
	}

	
	// 상품 수정페이지 
	@Override
	public void p_modifyView(HttpServletRequest req, Model model) {

        String p_code = req.getParameter("p_code");
        int pageNum = Integer.parseInt(req.getParameter("pageNum"));
        
        // 5.해당글 1건을 읽어서 BoardVO에 담아서 온다. 
        ArtboxProductVO vo = p_dao.getProduct(p_code);
        
        // 6단계. request나 session에  처리 결과를 저장 (jsp에 전달하기 위함) 
        model.addAttribute("vo", vo);
        model.addAttribute("p_code", p_code);
        model.addAttribute("pageNum", pageNum);
	        
	}

	
	// 상품 수정 처리 
	@Override
	public void p_modifyPro(MultipartHttpServletRequest req, Model model) {
		
		// 이미지 파일 올리기 
		MultipartFile file = req.getFile("img");  
		MultipartFile file2 = req.getFile("info");
		
		System.out.println("~~~~sddfsdf~~~" + file);
		System.out.println(file2);
		
		/*
		  ~~~~sddfsdf~~~org.springframework.web.multipart.commons.CommonsMultipartFile@5b3c98d4
			org.springframework.web.multipart.commons.CommonsMultipartFile@34bb59ad
			
			안넣었는데 값이 있음....-_- ..... 
		 */

		// 업로드할 파일의 최대 사이즈(10 * 1024 * 1024 = 10MB)
		// 임시 파일이 저장되는 논리적인 경로
		String saveDir = req.getRealPath("/resources/images/p_detail/");
		// 업로드할 파일이 위치하게될 물리적인 경로
		String realDir = "C:\\Dev50\\workspace_spring\\spring_project_ajKim\\src\\main\\webapp\\resources\\images\\p_detail\\";
		
		try {
			
		 ArtboxProductVO vo = new ArtboxProductVO();	// 담을 그릇 
		
		if(file != null) {
			file.transferTo(new File(saveDir+file.getOriginalFilename()));
			FileInputStream fis = new FileInputStream(saveDir + file.getOriginalFilename());
			FileOutputStream fos = new FileOutputStream(realDir + file.getOriginalFilename());
			
			int data = 0;
			// 논리적인 경로에 저장된 임시 파일을 물리적인 경로로 복사함
			while((data = fis.read()) != -1) {
				fos.write(data);
			}
			fis.close();
			fos.close();
			
			// "img" 파일 담기
			String filename = file.getOriginalFilename();
			vo.setP_image(filename);
			
		}else {
			vo.setP_image(req.getParameter("old_image"));
			
		}
		
		// 상품 정보를 위해 다시 생성함 
		if(file2 != null) {
			file2.transferTo(new File(saveDir+file2.getOriginalFilename()));
			FileInputStream fis1 = new FileInputStream(saveDir + file2.getOriginalFilename());
			FileOutputStream fos1 = new FileOutputStream(realDir + file2.getOriginalFilename());
			int data1 = 0;
			// 논리적인 경로에 저장된 임시 파일을 물리적인 경로로 복사함
			while((data1 = fis1.read()) != -1) {
				fos1.write(data1);
			}
			fis1.close();
			fos1.close();
			
			// "info" 파일 담기
			String filename2 = file2.getOriginalFilename();
			vo.setP_info(filename2);
		}else {
			vo.setP_info(req.getParameter("old_info"));
		}
		
		
		String p_code = req.getParameter("p_code");
        int pageNum = Integer.parseInt(req.getParameter("pageNum"));
		
       // 내용이랑 제목은 바구니에 담는다
       
        vo.setP_code(p_code);
        vo.setP_name(req.getParameter("name"));
        vo.setP_price(Integer.parseInt(req.getParameter("price")));
        vo.setP_count(Integer.parseInt(req.getParameter("count")));
        vo.setP_date(new Timestamp(System.currentTimeMillis()));
        
		// 5단계. 글수정처리 
        int updateCnt = dao.updateProduct(vo);
		
		// 6단계. request나 session에  처리 결과를 저장 (jsp에 전달하기 위함) 
        req.setAttribute("updateCnt", updateCnt);
        req.setAttribute("p_code", p_code);
        req.setAttribute("pageNum", pageNum);		
		}catch(Exception e) {
			e.printStackTrace();
		}
        
	}
	
	
	// 상품 삭제 처리 
	@Override
	public void p_deletePro(HttpServletRequest req, Model model) {
	    
        String p_code = req.getParameter("p_code");
        int pageNum = Integer.parseInt(req.getParameter("pageNum"));
        
        int deleteCnt = dao.deleteProduct(p_code);
        
        // 6단계. request 나  session에 처리 결과를 저장 (jsp에 전달하기 위함) 
        model.addAttribute("deleteCnt", deleteCnt);
        model.addAttribute("pageNum", pageNum);
        model.addAttribute("p_code", p_code);
        
	}

	// 비밀번호 없이 바로 게시판 글 1개 삭제하기 
	@Override
	public void directBoardDelete(HttpServletRequest req, Model model) {

		// 값을 받아온다. 
		int num = Integer.parseInt(req.getParameter("num"));
        int pageNum = Integer.parseInt(req.getParameter("pageNum"));

        int deleteCnt = 0;
        deleteCnt = c_dao.deleteBoard(num);
		
        // 6단계. request 나  session에 처리 결과를 저장 (jsp에 전달하기 위함) 
        req.setAttribute("deleteCnt", deleteCnt);
        req.setAttribute("pageNum", pageNum);
        req.setAttribute("num", num);
	}


	// 회원 멤버 삭제 (관리자 권한 ㅋ) 
	@Override
	public void memberDelete(HttpServletRequest req, Model model) {
		// 3. 받은값 정리 
		// 4. 다형성적용 dao 객체생성
		// 5. 처리 
		// 6. 다시 보내기 
		
	}

	
}
