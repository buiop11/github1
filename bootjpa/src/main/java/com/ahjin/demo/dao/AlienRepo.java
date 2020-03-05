package com.ahjin.demo.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
//import org.springframework.data.repository.CrudRepository;

import com.ahjin.demo.model.Alien;

public interface AlienRepo extends JpaRepository<Alien, Integer>{
// CrudRepository<Alien, Integer>  : Alien 객체의 Primary Key  --> 리턴타입들이 복잡 / JpaRepository는 List로 리턴가능
	

	List<Alien> findByTech(String tech);
	
	List<Alien> findByAidGreaterThan(int aid);
	// invaild derived query! No property GT found for type Traversed path: Alien.aid. 함수를 내맘대로 정하면 에러가 난다.
	// Unsatisfied dependency expressed through field 'repo';
	
	// JPQL / HQL
	// 없는 컬럼으로 sorted 시 org.h2.jdbc.JdbcSQLSyntaxErrorException: Column "NAME" not found; SQL statement: 에러발생
	@Query("from Alien where tech=?1 order by aname")
	List<Alien> findByTechSorted(String tech); // aname으로 정렬
	
}
