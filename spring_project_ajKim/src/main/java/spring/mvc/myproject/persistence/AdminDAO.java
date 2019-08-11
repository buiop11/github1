package spring.mvc.myproject.persistence;

import java.util.List;
import java.util.Map;

import spring.mvc.myproject.vo.ArtboxMemberVO;
import spring.mvc.myproject.vo.ArtboxProductVO;



public interface AdminDAO {
	
	// 로그인 처리 
	public int loginCheck(Map<String,Object> map); 
	
	// ---★★  ★★   상품 관리 ----★★   수정해야함 -- 
	// 상품  갯수 구하기 
	public int getProductCnt();
	
	 // 상품 목록조회 
    public List<ArtboxProductVO> getProductList(Map<String,Object> map);    
    
    // 멤버 갯수 구하기 
    public int getMemberCnt();
	
    // 멤버 목록조회 
    public List<ArtboxMemberVO> getArticleList(Map<String,Object> map);    

    // 상품정보 등록 처리 
    public int insertProduct(ArtboxProductVO vo);
    
    // 상품정보 수정처리 
    public int updateProduct(ArtboxProductVO vo);   
    
    // 상품정보 삭제 처리 
    public int deleteProduct(String p_code);
    
    /*
    
    
    // 멤버 삭제 처리 
    public int deleteMember(String strId);
	
    
    // 상품 상세 내용 조회 , 상품 정보 수정을 위한 게시글 상세 내용 조회 
    public ArtboxProductVO getProduct(String p_code);
    

	*/
}
