package spring.mvc.myproject.persistence;
import java.util.List;
import java.util.Map;

import spring.mvc.myproject.vo.ArtboxBoardVO;
import spring.mvc.myproject.vo.ArtboxMemberVO;

public interface DAO {
	
	// 암호화된 비밀번호 먼저 찾기 
	public String getPwd(Map<String,Object> map);

	// 로그인 처리 (회원정보 탈퇴시 비밀번호 인증, 회원정보 수정시 비밀번호 인증) 
	public int loginCheck(Map<String,Object> map); 
	
	// 이메일 인증1 - auth 업데이트 (?)
	public ArtboxMemberVO auth(String strId);
	
	// 이메일 인증2 (권한 insert)
	public int emailChk2(String strId);
	
	// 회원가입 처리 
	public int insertMember(ArtboxMemberVO vo);
	
	// 이메일 인증 메일 보내기 
	public int emailChk(String key);
	
	// 이메일 인증 메일 보내기 
	public void sendmail(String toEmail, String key, String strId); 
	
	// 회원가입 - 아이디 중복처리 
	public int idCheck(String strId);

    // 게시글 갯수 구하기 
    public int getArticleCnt(Map<String, Object> map);

    // 게시글 목록조회 
    public List<ArtboxBoardVO> getArticleList(Map<String, Object> map);    
    // 게시판 한개의 글  ArtboxBoardVO 근데 그걸 게시판 있는거 만큼 다 가지고 와야함 -> 객체 여러개!! List로 받음 
    
    // 게시글 조회 숫자증가 
    public void addReadCnt(int num);    // 증가만시키고 끝

    // 게시글 상세 내용 조회 , 게시글 수정을 위한 게시글 상세 내용 조회 
    public ArtboxBoardVO getArticle(int num);
    
    // 게시글 수정전 - 비밀번호 체크 
    public int numPwdCheck(Map<String, Object> map);
    
    // 게시글 수정처리 
    public int updateBoard(ArtboxBoardVO vo);     // 글과 제목을가지고 수정여부(int)반환 
    
    // 게시글 쓰기 처리 (기존)
    public int insertBoard(ArtboxBoardVO vo);
    
	// 답변글이 아닌 경우(새로운 글쓰기인 경우 == 제목글인 경우) - 추가1 
    public int getMaxNum();
    
    //-----답변글인 경우----- 추가 2
    public void updateReply(ArtboxBoardVO vo);
    
    // 게시글 삭제 처리 
    public int deleteBoard(int num);
    
    // 답글이 존재하는지 여부  - 삭제의 추가 1 
 	public int checkReply(ArtboxBoardVO vo); 
    
 	// 답글이 존재하는 경우 전체 삭제 - 삭제의 추가 2
 	public int deleteAll(ArtboxBoardVO vo) ;
 	
 	// 회원 정보 상세 페이지 (열기)
 	public ArtboxMemberVO getMemberInfo(String strId);
 	
 	// 회원정보 수정 처리 
 	public int updateMember(ArtboxMemberVO vo);
 	
 	// 회원탈퇴처리 
 	public int deleteMember(String strId);
    
    // 아이디 찾기 
    public String getFindId(Map<String, Object> map);
    
    // 비밀번호 이메일 인증 전 확인 
    public int idEmailChk(Map<String, Object>map);
    
    // 비밀번호 찾기 - 이메일 발송 
    public void pwdFindMail(String email, String key);
    
    // 비밀번호 찾기 - 키 업데이트 
    public int updateKey(ArtboxMemberVO vo);
    
    // 비밀번호 찾기2 - 키 값 비교 
    public ArtboxMemberVO equalsKey(String username);
    
    // 비밀번호 변경 
    public int pwdModify(ArtboxMemberVO vo);
    
}
