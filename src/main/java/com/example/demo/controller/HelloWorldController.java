package com.example.demo.controller;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.fastjson.JSONObject;
import com.example.demo.domain.SysPermission;
import com.example.demo.domain.SysRole;
import com.example.demo.domain.UserInfo;

@Controller
public class HelloWorldController {
	
//
//	@RequestMapping("/hello")
//	public String hello(Model m) {
//		m.addAttribute("now", DateFormat.getDateTimeInstance().format(new Date()));
//		
//		Subject sub = SecurityUtils.getSubject();
//		UserInfo obj = (UserInfo) sub.getPrincipal();
//		if(obj != null ) {
//		    m.addAttribute("name",obj.getName());
//		}
//		return "/hello";
//	}
	
	@RequestMapping("/hello")
	public String helloAuto(Model m) {
		m.addAttribute("now", DateFormat.getDateTimeInstance().format(new Date()));
		
		Subject sub = SecurityUtils.getSubject();
		UserInfo obj = (UserInfo) sub.getPrincipal();
		List<SysPermission> result = new ArrayList<SysPermission>();
		if(obj != null ) {
		    m.addAttribute("name",obj.getName());
		    for(int i =0; i<obj.getRoleList().size(); i++)
		    {
		    	SysRole role = obj.getRoleList().get(i);
		    	for(int j=0; j<role.getPermissions().size(); j++) {
		    		result.add(role.getPermissions().get(j));
		    	}
		    }
		}else {
			return "redirect:/logout";
		}
		
		//去重
		removeDuplicate(result);
		//排序
		Collections.sort(result);
		
		Map<String,Object> resultMap = new HashMap<String,Object>();
    	resultMap.put("count", result.size());
    	resultMap.put("data", result);
    	JSONObject json = new JSONObject(resultMap);
    	m.addAttribute("data",json.toJSONString());
    	System.out.println("--------permissions:"+json.toJSONString());
    	return "/hello_auto";
	}
	
	//删除ArrayList中重复元素
	public static List<SysPermission> removeDuplicate(List<SysPermission> list) {   
	    HashSet<SysPermission> h = new HashSet<SysPermission>(list);   
	    list.clear();   
	    list.addAll(h);   
	    return list;   
	}  
	// 删除ArrayList中重复元素，保持顺序     
	 public static void removeDuplicateWithOrder(List<SysPermission> list) {    
	    Set<SysPermission> set = new HashSet<SysPermission>();    
	     List<SysPermission> newList = new ArrayList<SysPermission>();    
	   for (Iterator<SysPermission> iter = list.iterator(); iter.hasNext();) {    
		   SysPermission element = iter.next();    
	         if (set.add(element))    
	            newList.add(element);    
	      }     
	     list.clear();    
	     list.addAll(newList);    
	    System.out.println( " remove duplicate " + list);    
	 }   
}
