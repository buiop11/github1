package spring.mvc.myproject.persistence;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import spring.mvc.myproject.vo.ArtboxBoardVO;
import spring.mvc.myproject.vo.ArtboxCartVO;
import spring.mvc.myproject.vo.ArtboxMemberVO;
import spring.mvc.myproject.vo.ArtboxOrderVO;
import spring.mvc.myproject.vo.ArtboxProductVO;

public interface ProductDAO {
	
	// ---------- 토이부터 ---------- 
	// 토이 - 상품 갯수 구하기 (코드별로 구해야함)
    public int getProductListCnt(String category);
    
    // 검색상품 갯수 구하기 
    public int getSearchProduct(String input);
    
    // 상품 목록 조회 
    public List<ArtboxProductVO> getProductList(Map<String,Object> map);    
    
    // 검색 상품 목록 조회 
    public List<ArtboxProductVO> getSearchList(Map<String,Object> map);  
    
    // 상품 1개 내용 조회 
    public ArtboxProductVO getProduct(String p_code);
    
    // 장바구니 추가하기 
    public int cartInsert(ArtboxCartVO vo);
    
    // 상품 주문처리 (프로시져)
    public int insertOrder(ArtboxOrderVO vo);
    
    // 주문 로그테이블!!!! (무조건 insert만한다.) 
    public int insertLogOrder(ArtboxOrderVO vo);
    
    // 주문 로그 테이블 - 추가1 (오더넘버 가장 높은 값 가져오기)
    public int getMaxOrderNum();
    
	/*
	 * // 주문 로그 테이블 - 추가2 (update 상태변경시 사용) public int updateOrderLog(ArtboxOrderVO
	 * vo);
	 */
    
    // 고객별 주문 정보 갯수 확인 
    public int getC_orderCnt(String strId);
    
    // 고객별 주문 리스트 확인 
    public List<ArtboxOrderVO> getC_orderList(Map<String,Object> map);
    
    // 주문테이블 수정처리 (결제완료, 환불완료건)
    public int updateState(ArtboxOrderVO vo);   

    // 취소완료 수정처리 전용 
    public int cancleState(ArtboxOrderVO vo);
    
    // 장바구니 가져오기 
    public List<ArtboxCartVO> getCart(String id);
    
    // 장바구니 삭제하기 
    public int deleteCart(Map<String,Object> map);
    
    // 주문(오더) 총 갯수 구하기 
    public int getAllOrder(Map<String,Object> map);

    // 주문테이블  전체(총) 목록 조회- 관리자용 (총)
    public List<ArtboxOrderVO> getOrderAllList(Map<String,Object> map);  
    
    // 결산 총 금액 구하기 (차트이용1)
    public int getTotalSale();
    
    // 묶음 달별 결산 차트 가져오기 (차트이용2)
    public List<Map<String,Object>> getChart(); //★★★★★★ 하는중★★ 왜 에러남? ㅠㅠㅠㅠㅠ ★★★★★★★★★★★★★
    
    // 원하는 달별 카테고리 차트 가져오기 (차트이용3)
   	//public List<Map<String,Object>> getCategory();
   	public List<Map<String,Object>> getCategory(String date);
    
    /*
    
 	// 주문 (오더) 갯수 구하기 - 전체임 
    public int getOrder(String id);
 	
    // 주문테이블 목록 조회 - 전체임 
    public List<ArtboxOrderVO> getOrderList(int start, int end, String id);    
    
    */
    
}
