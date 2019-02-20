package com.example.demo.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.example.demo.domain.SysPermission;
import com.example.demo.service.SysPermissionService;

@Controller
@RequestMapping("permission")
public class SysPermissionController {

	@Autowired
	private SysPermissionService sysPermissionService;
	
	@RequestMapping("/permissionInfo")
	@RequiresPermissions("permissionInfo:view")//权限管理;
	public String permissionInfo() {
		return "permissionInfo";
	}
	
	@RequestMapping("/permissionInfoAdd")
	@RequiresPermissions("permissionInfo:add")//权限管理;
	public String permissionInfoAdd() {
		return "permissionInfoAdd";
	}
	
	@RequestMapping("/permissionList")
	@ResponseBody
	public String showPermissions() {
		List<SysPermission> result = sysPermissionService.findAll();
		Map<String,Object> resultMap = new HashMap<String,Object>();
    	resultMap.put("code", 0);
    	resultMap.put("msg", "");
    	resultMap.put("count", result.size());
    	resultMap.put("data", result);
    	JSONObject json = new JSONObject(resultMap);
    	return json.toJSONString();
	}
	
	@RequestMapping("/permissionAdd")
	public void savePermission(SysPermission permission,HttpServletResponse response) {
		
		//返回值,手动构造json字符串
    	String jsonStr = "";
		try{
			sysPermissionService.save(permission);
		}catch(Exception e) {
			jsonStr = "{\"success\":false,\"msg\":\"系统异常\"}";
		}
		
		if(jsonStr.equals(""))
			jsonStr = "{\"success\":true,\"msg\":\"添加成功\"}";
		
		System.out.println(jsonStr);
    	response.setContentType("text/Xml;charset=utf-8");
    	PrintWriter out = null;
    	
    	try {
    		out = response.getWriter();
    		out.println(jsonStr);
    	}catch (IOException e) {
    		e.printStackTrace();
    	} finally {
    		out.close();
    	}
	}
}
