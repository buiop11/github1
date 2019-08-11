package spring.mvc.myproject.persistence;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import spring.mvc.myproject.vo.ArtboxCartVO;
import spring.mvc.myproject.vo.ArtboxOrderVO;
import spring.mvc.myproject.vo.ArtboxProductVO;

@Repository
public class ProductDAOImpl implements ProductDAO{


	@Autowired
	SqlSession sqlSession;
	
	
	// ---상품리스트 카테고리별 갯수 구하기 (코드별로 - 공통페이지에 코드별로 출력할거)
	@Override
	public int getProductListCnt(String category) {
        return sqlSession.selectOne("spring.mvc.myproject.persistence.ProductDAO.getProductListCnt" , category);
	}
	
	// 검색 상품 갯수구하기 
	@Override
	public int getSearchProduct(String input) {
        return sqlSession.selectOne("spring.mvc.myproject.persistence.ProductDAO.getSearchProduct" , input);
	}

	
	// 토이 - 상품리스트 출력하기!!!!! 
	@Override
	public List<ArtboxProductVO> getProductList(Map<String,Object> map) {
	    
        // 1. 큰바구니 선언  (ArrayList)
        List<ArtboxProductVO> productList = null; 
        ProductDAO dao = sqlSession.getMapper(ProductDAO.class);
        productList = dao.getProductList(map);
        return productList;            //arrayList 리턴!
	}

	
	// 검색 상품 출력 
	@Override
	public List<ArtboxProductVO> getSearchList(Map<String,Object> map) {
        // 1. 큰바구니 선언  (ArrayList)
        List<ArtboxProductVO> productList = null; 
        ProductDAO dao = sqlSession.getMapper(ProductDAO.class);
        productList = dao.getSearchList(map);
        return productList;            //arrayList 리턴!
	}

	// 상품 상세 내역보기 (p_code로)
	@Override
	public ArtboxProductVO getProduct(String p_code) {
	    return sqlSession.selectOne("spring.mvc.myproject.persistence.ProductDAO.getProduct", p_code);
	}

	
	// 상품 장바구니 추가(카트)담기 
	@Override
	public int cartInsert(ArtboxCartVO vo) {
        return sqlSession.insert("spring.mvc.myproject.persistence.ProductDAO.cartInsert", vo);
	}

	
	//  상품 주문 하기 처리 페이지 insert  + 주문 로그- 테이블에도 함께 넣어야함 
	@Override
	public int insertOrder(ArtboxOrderVO vo) {
		return sqlSession.insert("spring.mvc.myproject.persistence.ProductDAO.insertOrder", vo);
	}

	// 주문 로그 테이블 - 추가1 (오더넘버 가장 높은 값 가져오기)
	@Override
	public int getMaxOrderNum() {
		return sqlSession.selectOne("spring.mvc.myproject.persistence.ProductDAO.getMaxOrderNum");
	}
	
	/*
	 * // 주문 로그 테이블 - 추가2 (update 상태변경시 사용)
	 * 
	 * @Override public int updateOrderLog(ArtboxOrderVO vo) { return
	 * sqlSession.insert(
	 * "spring.mvc.myproject.persistence.ProductDAO.updateOrderLog", vo); }
	 */
	 
	
	//  로그테이블 insert  
	@Override
	public int insertLogOrder(ArtboxOrderVO vo) {
		
		int logCnt = 0; 
        int oo_num = vo.getO_num();		// 주문시 null 
        System.out.println(oo_num);
        // vo에서 받은 o_num: 첫 주문시에는 이게 값이 없음 위에서 주문테이블에 넣어서 주문테이블에는 있으나!
        // 근데 업데이트 시에는 무조건 vo.o_num에 값이 있다.
        
        if(oo_num == 0) {		// o_num 값이 없으면! => 주문오더도 첫 insert
        	
        	int maxNum =getMaxOrderNum();
        	System.out.println("~~~~~~~~~~~"   + maxNum);
        	
        	vo.setO_num(maxNum);	// 최대값을 vo에 넣어서 
        		
        	ProductDAO dao = sqlSession.getMapper(ProductDAO.class);
        	logCnt = dao.insertLogOrder(vo);
        	System.out.println("로그테이블 잘 작동되었는지 확인!! " + logCnt);
        	
        }else { 
        	
        	ProductDAO dao = sqlSession.getMapper(ProductDAO.class);
        	logCnt = dao.insertLogOrder(vo);
    		System.out.println("로그테이블 잘 작동되었는지 확인!! " + logCnt);
        }
            
        return logCnt;
	}

	
	// 고객별 주문 갯수 확인 
    public int getC_orderCnt(String strId) {
    	return sqlSession.selectOne("spring.mvc.myproject.persistence.ProductDAO.getC_orderCnt", strId);
    }
    
    // 고객별 주문 리스트 확인 
    public List<ArtboxOrderVO> getC_orderList(Map<String,Object> map) {
        return sqlSession.selectList("spring.mvc.myproject.persistence.ProductDAO.getC_orderList", map);
    }
	
	
	// 오더(주문테이블) 상태변경 - 프로시져, 로그테이블은 따로 만들어서 진행  
	@Override
	public int updateState(ArtboxOrderVO vo) {
        return sqlSession.update("spring.mvc.myproject.persistence.ProductDAO.updateState", vo);
	}

    
	// 취소완료 전용 수정처리!!! product_tbl 상품 복원 포함 
	@Override
	public int cancleState(ArtboxOrderVO vo) {
        return sqlSession.update("spring.mvc.myproject.persistence.ProductDAO.cancleState", vo);
	}


	// 장바구니 테이블 가지고오기 
	@Override
	public List<ArtboxCartVO> getCart(String id) {
        return sqlSession.selectList("spring.mvc.myproject.persistence.ProductDAO.getCart", id);
	}

	
	// 카트 삭제 처리 메소드 
	@Override
	public int deleteCart(Map<String,Object> map) {
        return sqlSession.delete("spring.mvc.myproject.persistence.ProductDAO.deleteCart", map);
	}

    
	// 주문 총 갯수 구하기!! 
	@Override
	public int getAllOrder(Map<String,Object> map) {
        return sqlSession.selectOne("spring.mvc.myproject.persistence.ProductDAO.getAllOrder", map);
	}
	
	// 주문 전체 가지고 오기 (총 수)
	@Override
	public List<ArtboxOrderVO> getOrderAllList(Map<String,Object> map) {
        return sqlSession.selectList("spring.mvc.myproject.persistence.ProductDAO.getOrderAllList", map);
	}
	
	
	// 결산 총 금액 구하기 
	@Override
	public int getTotalSale() {
        return sqlSession.selectOne("spring.mvc.myproject.persistence.ProductDAO.getTotalSale");
	}


	// 달별 총 합계 그래프  (chart1)
	@Override
	public List<Map<String,Object>> getChart() {
       
		ProductDAO dao = sqlSession.getMapper(ProductDAO.class);
		List<Map<String, Object>> chartList = dao.getChart();
		
		return chartList;
		//★★★★★★★★ 왜 에러남? ㅠㅠㅠㅠㅠ ★★★★★★★★★★★★★
	}


	//원하는 달별 카테고리 차트 가져오기 (chart2)
	@Override
	public List<Map<String,Object>> getCategory(String datell) {
		System.out.println("date11~~~~~~~~~~~~" + datell);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("datell", datell);
		return sqlSession.selectList("spring.mvc.myproject.persistence.ProductDAO.getCategory", map);
	}
	
    
	/*
	// 주문(오더) 회원 별 갯수 구하기 --> 관리자용으로 바꿔..ㅋ where절도 
	@Override
	public int getOrder(String id) {
		int selectCnt = 0; 
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = d_source.getConnection();
            String sql ="SELECT COUNT(*) as cnt FROM order_tbl WHERE id=?";  
            // as cnt => 별칭을 줘서 컬럼처럼 가져온다.
            pstmt = conn.prepareStatement(sql);
            
            pstmt.setString(1, id);
            
            rs = pstmt.executeQuery();
            
            if(rs.next()) {        // 존재한다면 
                selectCnt = rs.getInt("cnt");     // cnt대신 컬럼 index 1을 줘도 된다. 
            }
            
        } catch(SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if(rs != null) rs.close();
                if(pstmt != null) pstmt.close();
                if(conn != null) conn.close();
                
            }catch(SQLException e) {
                e.printStackTrace();
            }
        }
        return selectCnt;
	}


	// 상품 리스트 끌어오기 - 관리자용 오더 다보기 
	@Override
	public List<ArtboxOrderVO> getOrderList(int start, int end, String id) {
	     // 1. 큰바구니 선언  (ArrayList)
        ArrayList<ArtboxOrderVO> orderList = null; 
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null; 
        
        try {
            conn = d_source.getConnection();
            
            // sql문 공백도 주의해야함 (한줄끝나면 공백을 무조건 1칸 준다.
            String sql ="SELECT * " +
                    "FROM (SELECT id,p_code,p_name,p_image,o_name,o_phone,o_count,o_price,address,o_date,r_date,state, admin_id, rownum rNum " + 
                                "FROM( " + 
                                        "SELECT * FROM order_tbl " + 
                                        "WHERE id=? ORDER BY o_date DESC" + // 최신글부터 SELECT
                                      ")" + 
                          ")" +  // 2. 최신글부터 SELECT 한 레코드결과에 rowNum을 추가한다. (삭제데이터를 제외한 실제데이터를 최신글부터 넘버링)
                    "WHERE rNum >= ? AND rNum <= ?";  // 3.넘겨받은 start와 end 값으로  rowNum을  조회
                    
                    // 30건 기준 (실제 6페이지) => 최신 1페이지 1~5 
                    // 30건 기준 (실제 5페이지) => 최신 1페이지 6~10
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);
            pstmt.setInt(2, start);
            pstmt.setInt(3, end);
            
            rs = pstmt.executeQuery();
            
            if(rs.next()) { // 있는지 확인하고 시작!
                
                //2. 큰바구니 생성
            	orderList = new ArrayList<ArtboxOrderVO>(end-start+1);    
                // arrayList 만드는숫자(한페이지에 보이는수) 정확히 지정함 
                 
                do {
                    // 3. 작은 바구니 생성 
                	ArtboxOrderVO vo = new ArtboxOrderVO();
                    
                    // 4. 멤버 1건을 읽어서 rs를 작은바구니 (vo)에 담는다. 
                    vo.setId(rs.getString("id"));
                    vo.setP_code(rs.getString("p_code"));
                    vo.setP_name(rs.getString("p_name"));
                    vo.setP_image(rs.getString("p_image"));
                    vo.setO_name(rs.getString("o_name"));
                    vo.setO_phone(rs.getString("o_phone"));
                    vo.setAddress(rs.getString("address"));
                    vo.setO_count(rs.getInt("o_count"));
                    vo.setO_price(rs.getInt("o_price"));
                    vo.setState(rs.getString("state"));
                    vo.setAdmin_id(rs.getString("admin_id"));
                    vo.setO_date(rs.getTimestamp("o_date"));
                    vo.setR_date(rs.getTimestamp("r_date"));
                    
                    // 5. 큰바구니에 작은 바구니(vo 또는 dto, 게시글 1건씩)을 추가한다. 
                    orderList.add(vo);
                    
                }while(rs.next());    // rs.next가 존재할때까지 
            }
        }catch(SQLException e) {
            e.printStackTrace();
        }finally {
            try {
                if(rs!=null) rs.close();
                if(pstmt!=null) pstmt.close();
                if(conn!=null) conn.close();
            }catch(SQLException e) {
                e.printStackTrace();
            }
        }
        return orderList;            //arrayList 리턴!
	}


*/
	
	
	
	
}
