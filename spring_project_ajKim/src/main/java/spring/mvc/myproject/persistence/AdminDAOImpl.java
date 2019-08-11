package spring.mvc.myproject.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import spring.mvc.myproject.vo.ArtboxMemberVO;
import spring.mvc.myproject.vo.ArtboxProductVO;




@Repository
public class AdminDAOImpl implements AdminDAO {


	@Autowired
	SqlSession sqlSession;
	
	
	// 로그인 처리 
	@Override
	public int loginCheck(Map<String,Object> map) {
		return sqlSession.selectOne("spring.mvc.myproject.persistence.AdminDAO.loginCheck" , map);
	}


	// 상품 갯수 구하기 
	@Override
	public int getProductCnt() {
        return sqlSession.selectOne("spring.mvc.myproject.persistence.AdminDAO.getProductCnt");
	}
	
	// 상품 리스트 보기 
	@Override
	public List<ArtboxProductVO> getProductList(Map<String,Object> map) {
		return sqlSession.selectList("spring.mvc.myproject.persistence.AdminDAO.getProductList", map);
	}

	//  회원 수 구하기 
	@Override
	public int getMemberCnt() {
        return sqlSession.selectOne("spring.mvc.myproject.persistence.AdminDAO.getMemberCnt");
	}

	
	// 회원 테이블 목록 보기 
	@Override
	public List<ArtboxMemberVO> getArticleList(Map<String,Object> map) {
        return sqlSession.selectList("spring.mvc.myproject.persistence.AdminDAO.getArticleList", map);            //arrayList 리턴!
	}


	// 상품 등록하기 
	@Override
	public int insertProduct(ArtboxProductVO vo) {
		return sqlSession.insert("spring.mvc.myproject.persistence.AdminDAO.insertProduct", vo);
	}

	
	// 상품 수정하기 
	@Override
	public int updateProduct(ArtboxProductVO vo) {
        return sqlSession.update("spring.mvc.myproject.persistence.AdminDAO.updateProduct", vo);
	}
	
	// 상품 삭제하기 
	@Override
	public int deleteProduct(String p_code) {
        return sqlSession.delete("spring.mvc.myproject.persistence.AdminDAO.deleteProduct", p_code);
	}


	
	
	
	/*
	// 회원 삭제 
	@Override
	public int deleteMember(String strId) {

		int deleteCnt = 0;
		Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = d_source.getConnection();
            
            // sql문 공백도 주의해야함 (한줄끝나면 공백을 무조건 1칸 준다.
            String sql ="DELETE FROM board_tbl WHERE id=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, strId);
            deleteCnt = pstmt.executeUpdate();
                    
        }catch(SQLException e) {
            e.printStackTrace();
        }finally {
            try {
                if(pstmt!=null) pstmt.close();
                if(conn!=null) conn.close();
            }catch(SQLException e) {
                e.printStackTrace();
            }
        }
        return deleteCnt;             
	}





	
	// 상품상세보기  -- 스트링으로 바꿔야함 
	@Override
	public ArtboxProductVO getProduct(String p_code) {
		
		ArtboxProductVO vo = new ArtboxProductVO();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            
            conn = d_source.getConnection();
            String sql ="SELECT * FROM product_tbl WHERE p_code = ?";
            pstmt = conn.prepareStatement(sql);
            
            pstmt.setString(1, p_code);
            rs = pstmt.executeQuery();
            
            if(rs.next()) {
            	vo.setP_code(rs.getString("p_code"));
            	vo.setP_name(rs.getString("p_name"));
            	vo.setP_image(rs.getString("p_image"));
            	vo.setP_info(rs.getString("p_info"));
            	vo.setP_price(rs.getInt("p_price"));
            	vo.setP_count(rs.getInt("p_count"));
            	vo.setP_date(rs.getTimestamp("p_date"));
            	vo.setAdmin_id(rs.getString("admin_id"));
            }
        }catch(SQLException e) {
            e.printStackTrace();
        }finally {
            try {
                if(rs!=null) rs.close();
                if(pstmt !=null) pstmt.close();
                if(conn !=null) conn.close();
            }catch(SQLException e){
                e.printStackTrace();
            }
        }
        return vo;
	}


*/






	

}
