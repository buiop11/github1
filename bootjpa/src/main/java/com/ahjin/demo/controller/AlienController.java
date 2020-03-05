package com.ahjin.demo.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ahjin.demo.dao.AlienRepo;
import com.ahjin.demo.model.Alien;

@Controller
public class AlienController {
	
	
	@Autowired
	AlienRepo repo;

	@RequestMapping("/")
	public String home() {
		return "home.jsp";
	}
	
	@RequestMapping("/addAlien")
	public String addAlien(Alien alien) {
		
		repo.save(alien);  // Alien을 저장한다.
		return "home.jsp";
	}
	
	@RequestMapping("/getAlien")
	public ModelAndView getAlien(@RequestParam int aid) {
		
		ModelAndView mv = new ModelAndView("showAlien.jsp");
		
		Alien alien = repo.findById(aid).orElse(new Alien());  // 또는 .orElse(null)
		
		// 값 넘기기 전에 한번 찍어보기 
		System.out.println(repo.findByTech("Java"));  
		//[Alien [aid=101, aname=Navin, tech=Java], Alien [aid=104, aname=Kamal, tech=Java]]
		System.out.println(repo.findByAidGreaterThan(102));
		System.out.println(repo.findByTechSorted("Java"));
		
		mv.addObject(alien);
		return mv;
	}
	
	
	//@RequestMapping("/aliens")
	@RequestMapping(path="/aliens", produces= {"application/xml"})   // only xml 로만 받겠다
	@ResponseBody
	public List<Alien> getAliens() {  
		return repo.findAll();  // 원래 있던 메소드 .findAll()
		//data로 리턴시 @ResponseBody 사용 
		// .toString() 하려면 return 타입을 String으로  --> findAll()은 JpaRepository에서 한번더 정의되어서 리턴타입 List<T>
		// 리턴타입 String 아니면 json타입으로 리턴됨
	}
	
	
	@RequestMapping("/alien/{aid}")   // 와일드카드 {} 
	@ResponseBody
	public Optional<Alien> getUrlAlien(@PathVariable("aid") int aid) {
		return repo.findById(aid); 
		// .toString() 하려면 return 타입을 String으로  --> findById() 리턴타입은 CrudRepository에 있고 Optinal<T>타입
		// 리턴타입 String 아니면 json타입으로 리턴됨
	}
}
