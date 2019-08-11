package spring.mvc.myproject.persistence;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.Message.RecipientType;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Repository;

import spring.mvc.myproject.vo.ArtboxBoardVO;
import spring.mvc.myproject.vo.ArtboxMemberVO;


@Repository
public class DAOImpl implements DAO{
	
	@Autowired
	SqlSession sqlSession;

	@Autowired
	private JavaMailSender mailSender;
	
	// 암호화된 비밀번호 먼저 찾기 
	public String getPwd(Map<String,Object> map) {
		return sqlSession.selectOne("spring.mvc.myproject.persistence.DAO.getPwd",map);
	}
	
	
	// 로그인 처리 
	@Override
	public int loginCheck(Map<String,Object> map) {
		
		DAO dao = sqlSession.getMapper(DAO.class);
		return dao.loginCheck(map);
	}

	
	// 이메일 인증 - auth 업데이트 (로그인시 필요)
	@Override
	public ArtboxMemberVO auth(String strId) {
		ArtboxMemberVO vo = new ArtboxMemberVO();
		DAO dao = sqlSession.getMapper(DAO.class);
		vo = dao.auth(strId);
		return vo;
	}

	
	// 이메일 인증처리 !! (회원가입시)
	@Override
	public int emailChk(String key) {
	
		DAO dao = sqlSession.getMapper(DAO.class);
		int cnt = dao.emailChk(key);
		if(cnt==1) System.out.println("인증완료");
		return cnt;
	}    
	
	@Override
	public int emailChk2(String strId) {
		return sqlSession.insert("spring.mvc.myproject.persistence.DAO.emailChk2", strId);
	}    

	// 회원가입 처리 
	@Override
	public int insertMember(ArtboxMemberVO vo) {
		DAO dao = sqlSession.getMapper(DAO.class);
		return dao.insertMember(vo);
	}
	
	//  회원가입 - 이메일 인증 보내기 
	@Override
	public void sendmail(String toEmail, String key, String strId) {
		
        try{
        	MimeMessage msg = mailSender.createMimeMessage();
           
            String content = "Artbox 회원가입 인증메일입니다. 링크를 눌러 회원가입을 완료하세요!"  
    	    		+ "<a href='http://localhost/myproject/emailChk?key=" + key +"&id=" + strId +"'> 링크 </a>";
            
            msg.setSubject("아트박스 회원가입인증 메일");  
            msg.setText(content, "UTF-8", "html");
            msg.setFrom(new InternetAddress("artbox_admin@artbox.com"));
            msg.addRecipient(RecipientType.TO, new InternetAddress(toEmail));
            mailSender.send(msg);
	         
            System.out.println("SEND!!");
            
        } catch(Exception e){
            e.printStackTrace();
    	}
		
	}
	

	//  회원가입 - 아이디 중복확인 
	@Override
	public int idCheck(String strId) {

		DAO dao = sqlSession.getMapper(DAO.class);
		return dao.idCheck(strId);
	}


    // 게시글  글 갯수 구하기 
    @Override
    public int getArticleCnt(Map<String, Object> map) {
        return sqlSession.selectOne("spring.mvc.myproject.persistence.DAO.getArticleCnt", map);
    }
 
 
    // 게시글 목록 조회 
    @Override
    public List<ArtboxBoardVO> getArticleList(Map<String,Object> map) {
        
        // 1. 큰바구니 선언  (ArrayList)
        List<ArtboxBoardVO> boardList = null; 
        DAO dao = sqlSession.getMapper(DAO.class);
        boardList = dao.getArticleList(map);
        
        return boardList;            //arrayList 리턴!
    }
 
 
    // 게시판 조회 수 증가시키기 
    @Override
    public void addReadCnt(int num) {
    	sqlSession.update("spring.mvc.myproject.persistence.DAO.addReadCnt", num);
    }
    
    // ---- 게시글 상세 내용 보기 , 게시글 수정 시 보여지는 상세페이지~~-------
    @Override
    public ArtboxBoardVO getArticle(int num) {
        return sqlSession.selectOne("spring.mvc.myproject.persistence.DAO.getArticle", num);
    }
 
    // 게시글 수정, 게시글 삭제 - 비밀번호 확인하기 
    @Override
    public int numPwdCheck(Map<String, Object> map) {
        return sqlSession.selectOne("spring.mvc.myproject.persistence.DAO.numPwdCheck", map);
    }
 
    // 게시글 수정 처리 
    @Override
    public int updateBoard(ArtboxBoardVO vo) {
        return sqlSession.update("spring.mvc.myproject.persistence.DAO.updateBoard", vo);
    }
 
    
    // 답변글이 아닌 경우(새로운 글쓰기인 경우 == 제목글인 경우) - 추가1 
 	public int getMaxNum(){
 		return sqlSession.selectOne("spring.mvc.myproject.persistence.DAO.getMaxNum");
 	}
 	
 	// -----답변글인 경우----- 추가 2
 	public void updateReply(ArtboxBoardVO vo) {
 		sqlSession.update("spring.mvc.myproject.persistence.DAO.updateReply",vo);
 	}
 
    // -----글쓰기 처리 -----
    @Override
    public int insertBoard(ArtboxBoardVO vo) {
 
         // 일단 받아서 변수에 넣는다. 
         int num = vo.getNum();
         int ref = vo.getRef();
         int ref_step = vo.getRef_step();
         int ref_level = vo.getRef_level();
         
         
         // 답변글이 아닌 경우(새로운 글쓰기인 경우 == 제목글인 경우) 
         if(num == 0) {    //  serviceImpl 에서 writeForm 에서 제목글인경우 전부다 0으로 초기화했다!!!!!!
             
        	 int cnt = getArticleCnt(null);
        	 
             // 첫 글이 아닌 경우 
             if(cnt > 0) {
            	 System.out.println(" -- 첫글이 아닌 경우 -- ");
                 ref = getMaxNum() + 1;      
             
             // 첫글인 경우  (게시글이 0인경우)
             } else {
                 ref = 1;
             }
             
             ref_step = 0;
             ref_level = 0; 
             
         // ---★-답변글인 경우 ★ ㅡㅡ
         // 삽입할 글(새로작성답변)보다 아래쪽 글들(기존 답변글)이 한 줄씩 밀려 내려간다. -> ref_step(=행)이 1씩 증가 
             }else {
 
              updateReply(vo);
                 
             ref_step++;    // 추가할 답변글 자신 스텝과 레벨도 올린다. 
             ref_level++;
         }
         
         // 공통 (insert) - readCnt = 0 
 		 // 주의사항  (위에서 값이 변경되었기 때문에 한번더 변경사항을 저장한 후 insert해야함) 
         vo.setRef(ref);
         vo.setRef_step(ref_step);
         vo.setRef_level(ref_level);
             
        return sqlSession.insert("spring.mvc.myproject.persistence.DAO.insertBoard", vo);
    }
 
 
    // ------ 삭제 처리 ----------
    
    // 답글이 존재하는지 여부  - 삭제의 추가 1 
 	public int checkReply(ArtboxBoardVO vo) {
 		return sqlSession.selectOne("spring.mvc.myproject.persistence.DAO.checkReply",vo);
 	}
 	
 	// 답글이 존재하는 경우 전체 삭제 - 삭제의 추가 2
 	public int deleteAll(ArtboxBoardVO vo) {
 		return sqlSession.delete("spring.mvc.myproject.persistence.DAO.deleteAll",vo);
 	}
    
    // 게시글 삭제처리 메소드  (답변글인 경우 ref_step도 낮춰야 한다.)
    @Override
    public int deleteBoard(int num) {
        int deleteCnt = 0; 

        ArtboxBoardVO vo = getArticle(num);
        
            // 글을 삭제하려면 뭐든 다 num 이 있음! 무조건 탄다. 
        if(vo.getNum() != 0) {
                
			// 추가1. 답글이 존재하는지 여부
			// checkReply(vo);
			//sql = "SELECT * FROM mvc_board_tbl WHERE ref =? AND ref_step=?+1 AND ref_level > ?";
			int replyCnt = checkReply(vo); 	// 호출하기 
         
			// 답글이 존재하는 경우 
            if(replyCnt != 0) {        //결과보여주고 
                    
            	// 답글이 존재하는 경우 전체 삭제 
				// deleteAll(vo);
				//sql= "DELETE FROM mvc_board_tbl WHERE num=? OR (ref=? AND ref_level > ?)";
				deleteCnt = deleteAll(vo);
				System.out.println("답글이 존재하는 경우 전체 삭제" + deleteCnt); 
					
			// 1-2. 답글이 존재하지 않는 경우 	
            }else {    // 답글이 존재하지 않는 경우 
				//sql = "DELETE mvc_board_tbl WHERE num=?"; // 일반글일때 삭제 (본 메소드꺼)
            	DAO dao = sqlSession.getMapper(DAO.class);
				deleteCnt = dao.deleteBoard(num);
				
				System.out.println("답글이 존재하지 않는 경우 전체 삭제 " + deleteCnt); 
            }
        }
        return deleteCnt;
    }


    // 회원 정보 가지고 오기 (보여주기) 
	@Override
	public ArtboxMemberVO getMemberInfo(String strId) {
		return sqlSession.selectOne("spring.mvc.myproject.persistence.DAO.getMemberInfo", strId);
	}

	// 회원 정보 수정 처리
	@Override
	public int updateMember(ArtboxMemberVO vo) {
		return sqlSession.update("spring.mvc.myproject.persistence.DAO.updateMember", vo);
	}

	// 회원정보 삭제 
	@Override
	public int deleteMember(String strId) {
		return sqlSession.delete("spring.mvc.myproject.persistence.DAO.deleteMember", strId);
	}


	// 아이디 찾기 
    @Override
    public String getFindId(Map<String,Object> map) {
        return sqlSession.selectOne("spring.mvc.myproject.persistence.DAO.getFindId", map);
    }

    // 비밀번호 이메일 인증 전 확인 
	@Override
	public int idEmailChk(Map<String, Object> map) {
		System.out.println(map  + " 맵~~~~~");
		return sqlSession.selectOne("spring.mvc.myproject.persistence.DAO.idEmailChk", map);
	}


	// 비밀번호 찾기 메일 보내기 -- 메일은 가는데 error 뜸 *****
	@Override
	public void pwdFindMail(String toEmail, String key) {
	
	        try{
	            
	        	MimeMessage msg = mailSender.createMimeMessage();
	           
	            String content = "Artbox 비밀번호 찾기 \n 이 값을     " + key + "    홈페이지에 입력해주세요!";  
	            
	            msg.setSubject("아트박스 비밀번호 찾기 메일");  
	            msg.setText(content, "UTF-8", "html");
	            msg.setFrom(new InternetAddress("artbox_admin@artbox.com"));
	            msg.addRecipient(RecipientType.TO, new InternetAddress(toEmail));
	            mailSender.send(msg);
		         
	            System.out.println("SEND!!");
	            
	        } catch(Exception e){
	            e.printStackTrace();
        	}
	}

	// 비밀번호 찾기 - 키 업데이트 
	@Override
	public int updateKey(ArtboxMemberVO vo) {
		return sqlSession.update("spring.mvc.myproject.persistence.DAO.updateKey", vo);
	}

	// 비밀번호 찾기 - 키비교 
	@Override
	public ArtboxMemberVO equalsKey(String username) {
		return sqlSession.selectOne("spring.mvc.myproject.persistence.DAO.equalsKey", username);
	}

	// 비밀번호 변경 
	@Override
	public int pwdModify(ArtboxMemberVO vo) {
		return sqlSession.update("spring.mvc.myproject.persistence.DAO.pwdModify", vo);
	}

	
	
	
}
