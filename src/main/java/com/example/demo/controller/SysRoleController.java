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

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.example.demo.domain.SysRole;
import com.example.demo.service.SysRolePermissionService;
import com.example.demo.service.SysRoleService;

@Controller
@RequestMapping("/role")
public class SysRoleController {

	@Autowired
	private SysRoleService sysRoleService;
	@Autowired
	private SysRolePermissionService sysRolePermissionService;
	
	@RequestMapping("/roleList")
	@ResponseBody
	public String listRole() {
		System.out.println("SysRoleController.listRole()");
		
		List<SysRole> roles = sysRoleService.findAll();
		Map<String,Object> resultMap = new HashMap<String,Object>();
    	resultMap.put("code", 0);
    	resultMap.put("msg", "");
    	resultMap.put("count", roles.size());
    	resultMap.put("data", roles);
    	String json = JSON.toJSONStringWithDateFormat(resultMap, "yyyy-MM-dd HH:mm:ss",SerializerFeature.DisableCircularReferenceDetect);
    	return json;
	}
	
	@RequestMapping("/roleInfo")
	@RequiresPermissions("roleInfo:view")//权限管理;
	public String roleInfo() {
		return "sysRole";
	}
	
	@RequestMapping("/roleInfoAdd")
	@RequiresPermissions("roleInfo:add")//权限管理;
	public String roleInfoAdd() {
		return "sysRoleAdd";
	}
	
	@RequestMapping("/roleAdd")
	public void roleAdd(String role,String description,HttpServletResponse response){
		System.out.println("---------role:"+ role);
    	SysRole r = sysRoleService.findByRole(role);
    	
    	//返回值,手动构造json字符串
    	String jsonStr = "";
    	//用户已存在
    	if(r != null) {
    		jsonStr = "{\"success\":false,\"msg\":\"角色已存在\"}";
    	}
		else {
			SysRole nr = new SysRole();
			nr.setRole(role);
			nr.setDescription(description);

			// 用户不存在，保存
			try {
				sysRoleService.save(nr);
			}catch (Exception e) {
				jsonStr = "{\"success\":false,\"msg\":\"系统异常\"}";
			}
			if(jsonStr.equals(""))
				jsonStr = "{\"success\":true,\"msg\":\"添加成功\"}";
		}
    	
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
	
	@RequestMapping("/permissionAllot")
	public void permissionAllot(String roleId,String[] permissionIds,HttpServletResponse response) {
		sysRolePermissionService.deleteByRoleId(Integer.valueOf(roleId));
		//返回值,手动构造json字符串
    	String jsonStr = "";
    	
    	if(permissionIds != null) {
    		for(int i = 0; i < permissionIds.length; i++) {
    			try {
    			sysRolePermissionService.save(Integer.valueOf(roleId),Integer.valueOf(permissionIds[i]));
    		
    			}catch(Exception e) {
    				jsonStr = "{\"success\":false,\"msg\":\"系统异常\"}";
    			}
    		}
    	}
    	
    	if(jsonStr.equals(""))
    		jsonStr = "{\"success\":true,\"msg\":\"分配成功\"}";
    	
    	
    	
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
