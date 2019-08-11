package spring.mvc.myproject.service;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.ui.Model;

import spring.mvc.myproject.persistence.DAO;
import spring.mvc.myproject.persistence.DAOImpl;
import spring.mvc.myproject.vo.ArtboxBoardVO;
import spring.mvc.myproject.vo.ArtboxMemberVO;

@org.springframework.stereotype.Service  // 이름이 같으면 이렇게되나봄..
public class ServiceImpl implements Service {

	@Autowired		// @Inject 도 같은 동작함. 
	DAO dao;	
	
	@Override
	public void loginPro(HttpServletRequest req, Model model) {
		
		// 3. 넘겨 받은 값 정리 
		//String strId = req.getParameter("id");
		//String strPwd = req.getParameter("pwd");
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication(); 
	    UserDetails user = (UserDetails) authentication.getPrincipal();
	    String strId = user.getUsername();
	    int loginCnt = 0;
	    ArtboxMemberVO auth;
	    
	    System.out.println("id~~~~~~~~~~~~~~~~" +  strId);
	    
	    String strPwd = user.getPassword();
	    
	    System.out.println("pwd~~~~~~~~~~~~~~~~" +  strPwd);
	    
		
		// 4. DAO 싱글톤으로 기능에 맞는 메소드 호출 
		//DAO dao = DAOImpl.getInstance();
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("strId", strId);
		
		//String pwd = dao.getPwd(map);
		
		map.put("strPwd", strPwd);
		
		loginCnt = dao.loginCheck(map);
		auth = dao.auth(strId); // 이메일 인증여부 체크 
		
		System.out.println("~~~~~~~~~ loginCnt " + loginCnt);
	
		// 5. 다시 컨트롤러로 전달하기 
		if(loginCnt == 1) {
			model.addAttribute("auth",auth);
			
			if(auth.getAuth().equals("1")) {
				// id를 세션값에 담기 !!!!
				req.getSession().setAttribute("memId", strId);
			}
		}
		
	
		model.addAttribute("cnt", loginCnt);
	}

	
	// 회원가입 처리 
	@Override
	public void inputPro(HttpServletRequest req, Model model) {
		
		ArtboxMemberVO vo = new ArtboxMemberVO();
		
		String strId = req.getParameter("id");
		
		vo.setUsername(strId);
		vo.setPassword(req.getParameter("pwd"));
		vo.setName(req.getParameter("name"));
		
		// 전화번호는 쪼개서 저장 , 필수요소는 아님 
		String hp = "";  
		String hp1 = req.getParameter("hp1");
		String hp2 = req.getParameter("hp2");
		String hp3 = req.getParameter("hp3");
		
		if(!hp1.equals("") && !hp2.equals("") && !hp3.equals("")) {
			hp = hp1 + "-" + hp2 + "-" + hp3;
		}
		vo.setPhone(hp);   
		
		//reg_date 
		vo.setReg_date(new Timestamp(System.currentTimeMillis()));
		
		// key 값 복사해오기  (이메일)
		StringBuffer temp = new StringBuffer();
		Random rnd = new Random();
		for (int i = 0; i < 6; i++) {
		    int rIndex = rnd.nextInt(2);
		    switch (rIndex) {
		    case 0:
		        // A-Z
		        temp.append((char) ((int) (rnd.nextInt(26)) + 65));
		        break;
		    case 1:
		        // 0-9
		        temp.append((rnd.nextInt(10)));
		        break;
		    }
		}
		
		String key = temp.toString();

		String email ="";
		String email1 = req.getParameter("email1");
		String email2 = req.getParameter("email2");
		
		email = email1 + "@" + email2; 
		vo.setEmail(email);  // 이메일 담고 
		vo.setKey(key); 	// 키 담고 
		
		// dao 호출 
		//DAO dao = DAOImpl.getInstance();
		int cnt = dao.insertMember(vo);
		
		// 이메일 인증 발송 
		if(cnt==1){
			dao.sendmail(email, key, strId);
		}
		
		// 값 보내기 
		model.addAttribute("insertCnt", cnt);
		
	}
	
	
	// 회원가입 - 아이디 중복 확인 처리 
	@Override
	public void comfirmId(HttpServletRequest req, Model model) {
		
		String strId = req.getParameter("id");
		
		//DAO dao = DAOImpl.getInstance();
		int cnt = dao.idCheck(strId);
		
		model.addAttribute("id", strId);
		model.addAttribute("selectCnt", cnt);
	}


	//  회원가입 - 이메일 인증 처리 
	@Override
	public void emailChkPro(HttpServletRequest req, Model model) {
		// 3.
		String key = req.getParameter("key");
		String strId = req.getParameter("id");
		// 4.
		//DAO dao = DAOImpl.getInstance();
		// 5.
		int cnt = dao.emailChk(key);
		int cnt2 = dao.emailChk2(strId);
		System.out.println(cnt2 + "~~~~~~  권한테이블 설정 ");
		// 6.
		model.addAttribute("cnt", cnt);
		model.addAttribute("cnt2", cnt2);
		
	}
 
	
    // 글목록   --------------------- 페이징 처리 ----------------------
    @Override
    public void boardList(HttpServletRequest req, Model model) {
    	
    	// 검색된 요청  카테고리 파라미터 (작성자 또는  제목) 
    	String cate = (req.getParameter("searchCategory") == null)? "" : req.getParameter("searchCategory");
    	cate = cate.trim();	// 공백을 제거 
    	
    	// 검색된 input 값 
    	String input =(req.getParameter("searchInput") == null) ? "" : req.getParameter("searchInput");
    	input = input.trim();	// 공백을 제거 
    	
    	// 찍어본다 
    	System.out.println(cate + "     "  + input + "~~~~~~~~~~~~~");
        
        // 3단계. 화면으로부터 입력받은 값을 받아온다. 
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
        
        
        // 4단계. 다형성 적용 , 싱글톤 방식으로  dao 객체를 생성
        //DAO dao = DAOImpl.getInstance();
 
        // 5-1단계. 글갯수 구하기 (검색값 가지고 간다.)
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("category", cate);
        map.put("input", input);
        cnt = dao.getArticleCnt(map);
        
        System.out.println("cnt : " + cnt);  // 먼저 테이블에 30건 insert 해둠 
        
        // 받을 예정 
        pageNum = req.getParameter("pageNum");
        
        if(pageNum == null) {
            pageNum = "1";             // 첫 페이지를 1로 지정 
        }
        
        // 글 30건 기준 
        
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
        // 30 = 30 - (1 - 1) * 5; 
        number = cnt - (currentPage -1) * pageSize;
        
        System.out.println("number (출력용페이지) : " + number);
        System.out.println("pageSize : " + pageSize);
        
        
        if(cnt > 0) {
            
        // 5-2단계. 게시글 목록 조회 (위에서 선언한 map에 추가 - 안쓰는건 안쓰면됨  / map-키: 값)
        	map.put("start", start);
        	map.put("end", end);
            List<ArtboxBoardVO> boardList = dao.getArticleList(map);
            req.setAttribute("boardList", boardList);              //  큰바구니 : 게시글 목록 cf)작은 바구니 : 게시글 1건 
        }
        
        // 6단계. request 나 session에 처리 결과를 저장 (JSP에 전달하기 위함)
        
        // 시작페이지 
        // 1 = (1 / 3 ) * 3 + 1; 
        startPage = (currentPage / pageBlock) * pageBlock + 1;
        
        if(currentPage % pageBlock == 0) startPage -= pageBlock;        // ?????????? ?????  
        System.out.println("startPage : " + startPage);
        
        
        // 마지막 페이지 
        // 3 = 1 + 3 - 1; 
        endPage = startPage + pageBlock - 1;
        
        if(endPage > pageCount) endPage = pageCount;
        System.out.println("endPage : " + endPage);
        
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
 
   
    // 게시판 글 상세페이지 
    @Override
    public void contentForm(HttpServletRequest req, Model model) {
        // 3단계. 화면으로부터 입력받은 값을 받아온다. 
        int num = Integer.parseInt(req.getParameter("num"));
        int pageNum = Integer.parseInt(req.getParameter("pageNum"));
        int number = Integer.parseInt(req.getParameter("number"));
        
        // 4단계. 다형성 적용 , 싱글톤 방식으로  dao 객체를 생성
        //DAO dao = DAOImpl.getInstance();
        
        // 5-1단계. 조회 수 증가시키기
        dao.addReadCnt(num);
        
        // 5-2단계. 상세 페이지 조회 
        ArtboxBoardVO vo = dao.getArticle(num);
        
        // 6단계. request 나 session에 처리 결과를 저장(jsp에 전달하기 위함)
        model.addAttribute("vo", vo);     // 객체를 넘겨야함 통으로~~ 
        
        model.addAttribute("pageNum", pageNum);
        model.addAttribute("number", number);
        
    }
 
    
    // 글 수정 상세 페이지 
    @Override
    public void modifyView(HttpServletRequest req, Model model) {
 
        // 3단계. 화면으로부터 입력받은 값을 가져온다. 
        String pwd = req.getParameter("pwd");// hidden 으로 넘긴 값 
        
        int num = Integer.parseInt(req.getParameter("num"));
        int pageNum = Integer.parseInt(req.getParameter("pageNum"));
        
        // 4단계. 다형성 적용, 싱글톤방식으로 dao 객체 생성 
        //DAO dao = DAOImpl.getInstance();
        
        // 5-1단계. 비밀번호 인증 
        Map<String, Object> map = new HashMap<String,Object>();
        map.put("num", num);
        map.put("pwd", pwd);
        int selectCnt = dao.numPwdCheck(map); 
        
        // 5-2단계. 비밀번호가 일치하면 , 해당글 1건을 읽어서 BoardVO에 담아서 온다. 
        ArtboxBoardVO vo = null; // 넘겨야되니깐, 빼놓자
        
        if(selectCnt == 1) {
            vo = dao.getArticle(num);
        }
        
        // 6단계. request나 session에  처리 결과를 저장 (jsp에 전달하기 위함) 
        model.addAttribute("vo", vo);
        model.addAttribute("selectCnt", selectCnt);
        model.addAttribute("num", num);
        model.addAttribute("pageNum", pageNum);
        
    }
 
 
    // 글 수정 처리 페이지 
    @Override
    public void modifyPro(HttpServletRequest req, Model model) {
        
        // 3단계. 화면으로부터 입력받은 값을 가져온다. 
        int num = Integer.parseInt(req.getParameter("num"));
        int pageNum = Integer.parseInt(req.getParameter("pageNum"));
        
        // 내용이랑 제목은 바구니에 담는다
        ArtboxBoardVO vo = new ArtboxBoardVO();
        vo.setNum(num);
        vo.setSubject(req.getParameter("subject"));
        vo.setContent(req.getParameter("content"));
        
        // 4단계. 다형성 적용, 싱글톤방식으로 dao 객체 생성 
        //DAO dao = DAOImpl.getInstance();
        
        // 5단계. 글수정처리 
        int updateCnt = dao.updateBoard(vo);
        
        // 6단계. request나 session에  처리 결과를 저장 (jsp에 전달하기 위함) 
        model.addAttribute("updateCnt", updateCnt);
        model.addAttribute("num", num);
        model.addAttribute("pageNum", pageNum);
        
    }
 
 
    // 글쓰기 페이지 
    @Override
    public void writeForm(HttpServletRequest req, Model model) {

        // 3단계. 화면으로 입력받은 값을 가져온다. 
        // 제목글(답변글이 아닌 경우 - 전부 0으로 초기화)
        int num = 0;
        int ref = 0;
        int ref_step = 0;    // 글의 순서 
        int ref_level = 0;    // 글레벨(들여쓰기)
        int pageNum = 0; 
        
        // 답변글에 대한 글 작성시 
        if(req.getParameter("num") != null) {        
            // 게시판글이 있는경우 (값들이 있을 것이라 예상하고 받아온다)
            
            num = Integer.parseInt(req.getParameter("num"));
            ref = Integer.parseInt(req.getParameter("ref"));
            ref_step = Integer.parseInt(req.getParameter("ref_step"));
            ref_level = Integer.parseInt(req.getParameter("ref_level"));
        }
        
        pageNum = Integer.parseInt(req.getParameter("pageNum"));
        
        // 6단계. request 나 session에 처리 결과를 저장 (jsp에 전달하기 위함)
        model.addAttribute("num", num);
        model.addAttribute("ref", ref);
        model.addAttribute("ref_step", ref_step);
        model.addAttribute("ref_level", ref_level);
        model.addAttribute("pageNum", pageNum);
    }
 
    
    // 글쓰기 처리 페이지 
    @Override
    public void writePro(HttpServletRequest req, Model model) {
 
        // BoardVO 바구니 생성 
    	ArtboxBoardVO vo = new ArtboxBoardVO();
        
        // 3-1단계. writeForm의 hidden으로 넘긴 값을 받아온다. (넘기면서 바로 바구니 담음)
        int pageNum = Integer.parseInt(req.getParameter("pageNum"));
        vo.setNum(Integer.parseInt(req.getParameter("num")));
        vo.setRef(Integer.parseInt(req.getParameter("ref")));
        vo.setRef_step(Integer.parseInt(req.getParameter("ref_step")));
        vo.setRef_level(Integer.parseInt(req.getParameter("ref_level")));
        
        // 3-2단계. 화면으로부터 입력받은 값(작성자, 비밀번호, 제목, 내용)을 받아와서 바구니에 담는다.
        vo.setWirter(req.getParameter("writer"));
        vo.setPwd(req.getParameter("pwd"));
        vo.setSubject(req.getParameter("subject"));
        vo.setContent(req.getParameter("content"));
        
        // DB에서 reg_date가 default로 sysdate로 작성해 놓았으므로 
        // 별도로 아래 vo.set 작성안할 시  sysdate로 적용되고, 아래처럼 vo.set으로 작성시에는  이게 우선순위로 적용된다. 
        vo.setReg_date(new Timestamp(System.currentTimeMillis()));
        
        // url에 localhost대신 본인 IP를 입력하면 그  ip를 읽어서 바구니에 담는다.
        // 실행시에 http://192.168.219.100:8081/JSP_mvcBoard/boardList.bo  --> localhost말고 test해보려면 본인 ip를 넣고 실행시켜라 
        vo.setIp(req.getRemoteAddr());
        
        // 4단계. 다형성 적용, 싱글톤 방식으로 dao 객체생성
        //DAO dao = DAOImpl.getInstance();
        
        // 5단계. 글쓰기처리
        int insertCnt = dao.insertBoard(vo);
        
        // 6단계. request 나 session에 처리결과를 저장 (jsp에 전달하기 위함)
        model.addAttribute("insertCnt", insertCnt);
        model.addAttribute("pageNum", pageNum);
        
    }
 
  
    // 글삭제 처리 메소드 
    @Override
    public void deletePro(HttpServletRequest req, Model model) {
        
        // 3단계. 화면으로부터 넘어온 값을 받는다. 
        String pwd = req.getParameter("pwd");
        
        // deleteForm의 hidden으로부터 값을 받아온다. 
        int num = Integer.parseInt(req.getParameter("num"));
        int pageNum = Integer.parseInt(req.getParameter("pageNum"));
        
        
        // 4단계. 다형성적용, 싱글톤 방식으로 dao 객체생성 
        //DAO dao = DAOImpl.getInstance();
        
        // 5-1단계. 비밀번호 인증 
        Map<String,Object> map = new HashMap<String,Object>();
        map.put("num", num);
        map.put("pwd", pwd);
        int selectCnt = dao.numPwdCheck(map);
        int deleteCnt = 0;
        
        // 5-2단계. 비밀번호가 일치하면 , 해당글 1건을 삭제처리한다. 
        if(selectCnt == 1) {
            deleteCnt = dao.deleteBoard(num);
        }
        
        // 6단계. request 나  session에 처리 결과를 저장 (jsp에 전달하기 위함) 
        model.addAttribute("deleteCnt", deleteCnt);
        model.addAttribute("pageNum", pageNum);
        model.addAttribute("num", num);
        
    }

    // 회원정보 상세보기 (정보 보여주기)
	@Override
	public void c_modifyView(HttpServletRequest req, Model model) {
		// 3.화면으로 받은 값 정리 
		String strPwd = req.getParameter("pwd");
		//String strId = (String)req.getSession().getAttribute("memId");
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication(); 
	    User user = (User) authentication.getPrincipal();
	    String strId = user.getUsername();
	    
	    System.out.println(strId + " id~~~~~~~~~~~~ ");
		
		// 4. 다형성 적용, dao 객체 생성
		//DAO dao = DAOImpl.getInstance();
		// 5-1. 로그인 정보가 있는지 확인(아이디, 비밀번호 매칭) 
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("strId", strId);
		map.put("strPwd", strPwd);
		int loginCnt = dao.loginCheck(map);
		
		// 5-2. 매칭되면 로그인한 id로 정보 갖고 오기 
		if(loginCnt == 1) {
			ArtboxMemberVO vo = dao.getMemberInfo(strId);
			model.addAttribute("vo", vo);
		}
		// 6. 처리 결과를 저장 
		model.addAttribute("loginCnt",loginCnt);
	}

	
	// 회원정보 수정 치리 
	@Override
	public void c_modifyPro(HttpServletRequest req, Model model) {
		
		// 3.화면으로 받은 값 정리 
		ArtboxMemberVO vo = new ArtboxMemberVO(); // 바구니 생성 
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication(); 
	    User user = (User) authentication.getPrincipal();
	    String strId = user.getUsername();
	    
		vo.setUsername(strId);
		vo.setPassword(req.getParameter("pwd"));
		vo.setName(req.getParameter("name"));
		
		// 전화번호
		String hp ="";
		String hp1 = req.getParameter("hp1");
		String hp2 = req.getParameter("hp2");
		String hp3 = req.getParameter("hp3");
		hp = hp1 + "-" + hp2 + "-" + hp3;
		vo.setPhone(hp);
		
		// 이메일 
		String email = "";
		String email1 = req.getParameter("email1");
		String email2 = req.getParameter("email2");
		email = email1 + "@" + email2;
		vo.setEmail(email);
		
		// 4. 다형성 적용, dao 객체 생성
		//DAO dao = DAOImpl.getInstance();
		
		// 5. 회원 정보 수정처리 확인
		int updateCnt = dao.updateMember(vo);
		
		// 6. 처리 결과를 저장 
		model.addAttribute("updateCnt", updateCnt);
		
		
	}

	// 회원 탈퇴 처리 
	@Override
	public void c_deletePro(HttpServletRequest req, Model model) {

		//3. 값 읽어오기 
		//String strId = (String)req.getSession().getAttribute("memId");
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication(); 
	    User user = (User) authentication.getPrincipal();
	    String strId = user.getUsername();

		// 4. 다형성 적용 dao호출 
		//DAO dao = DAOImpl.getInstance();
		// 5. 삭제 처리 확인 
		int deleteCnt = dao.deleteMember(strId);
		
		// 6. 값 넘겨주기 
		model.addAttribute("deleteCnt", deleteCnt);
	}

	
	// 회원정보보기 (회원전용 - 주문하기에서 사용)
	@Override
	public void getMemberInfo(HttpServletRequest req, Model model) {
		// 3.화면으로 받은 값 정리 
		//String strId = (String)req.getSession().getAttribute("memId");
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication(); 
	    User user = (User) authentication.getPrincipal();
	    String strId = user.getUsername();
		
		// 4. 다형성 적용, dao 객체 생성
		//DAO dao = DAOImpl.getInstance();
		ArtboxMemberVO member = dao.getMemberInfo(strId);

		// 6. 처리 결과를 저장 
		model.addAttribute("member", member);
	}

	
    // 아이디  찾기(이름, 이메일- 아이디 결과값 보여주기 )
    @Override
    public String idFindPro(HttpServletRequest req, Model model) {
        // 3.화면으로 받은 값 정리 
        String name = req.getParameter("v_memname"); // 이름 
        //String type = req.getParameter("v_findtype");  // 찾는타입 -이메일만 적용함 
        String mail = req.getParameter("v_mememail");  // 이메일 
        
        // 리턴할거 미리 선언 
        String id = null;
        
        // DAO 탄다. 
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("name", name);
        map.put("mail", mail);
        id= dao.getFindId(map);
        
        return id;
    }


    // 비밀번호 찾기 1 - 아이디랑 이메일 체크 
	@Override
	public int idEmailChk(HttpServletRequest req, Model model) {

		// 3.화면으로 받은 값 정리 
        String username = req.getParameter("v_memid"); // 이름 
        String email = req.getParameter("v_mememail");  // 이메일 
        
        System.out.println(username);
        System.out.println(email);
        
        Map<String, Object>map = new HashMap<String, Object>();
        map.put("username", username);
        map.put("email", email);
        int cnt = dao.idEmailChk(map);
        
        return cnt;
        
	}
    
	// 비밀번호 찾기  (키값넘겨서 이메일보내기 / DB 키값 업데이트) 
	@Override
	public void pwdFindPro(HttpServletRequest req, Model model) {
		// 3.화면으로 받은 값 정리 
		//String strId = req.getParameter("memid"); // 이름 
		//String type = req.getParameter("v_findtype");  // 찾는타입 -이메일만 적용함 
		String email = req.getParameter("v_mememail");  // 이메일 
		
		// key 값 복사해오기  (이메일)
		StringBuffer temp = new StringBuffer();
		Random rnd = new Random();
		for (int i = 0; i < 6; i++) {
			int rIndex = rnd.nextInt(2);
			switch (rIndex) {
			case 0:
				// A-Z
				temp.append((char) ((int) (rnd.nextInt(26)) + 65));
				break;
			case 1:
				// 0-9
				temp.append((rnd.nextInt(10)));
				break;
			}
		}
		
		String key = temp.toString();
		
		System.out.println("DB삽입 전 key : " + key);
		
		// 이메일 인증 발송 (키만 보여주는거 보내기)
		dao.pwdFindMail(email, key);
		
		// DB 업데이트 해야함 key 값
		// 5. 회원 정보 수정처리 확인
		ArtboxMemberVO vo = new ArtboxMemberVO();
		vo.setKey(key);
		vo.setEmail(email);
		int result = dao.updateKey(vo);
		
		//req.getSession().setAttribute("key", key);
		model.addAttribute("key", key);
		
		System.out.println("DB삽입 후 vo.getKey() : " + vo.getKey());
		System.out.println("키 업데이트 " + result);
		
	}

	// DB- 키값 확인 
	@Override
	public int pwdFindPro2(HttpServletRequest req, Model model) {
		
		String inputKey = req.getParameter("v_sixnum");  // 입력된 키값 
		String username = req.getParameter("v_memid"); // 아이디
		
		ArtboxMemberVO vo = dao.equalsKey(username);

		int cnt = 0;
		if(vo.getKey().equals(inputKey)) {
			cnt = 1;
		}
		return cnt;
	}

	// 비밀번호 변경 
	@Override
	public int pwdModify(HttpServletRequest req, Model model) {
	
		String password = req.getParameter("v_mempwd");  // 입력된 비밀번호
		String username = req.getParameter("v_memid"); // 아이디

		System.out.println("~~~~~sdfsdf~~~~~~" + password);
		System.out.println(username);
		
		ArtboxMemberVO vo = new ArtboxMemberVO();
		vo.setPassword(password);
		vo.setUsername(username);
		
		int cnt = dao.pwdModify(vo);
		
		return cnt;
	}
    

}
