package com.example.demo.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.example.demo.domain.UserInfo;
import com.example.demo.service.SysUserRoleService;
import com.example.demo.service.UserInfoService;

@Controller
@RequestMapping("/userInfo")
public class UserInfoController {

	@Autowired
	private UserInfoService userInfoService;
	
	@Autowired
	private SysUserRoleService sysUserRoleService;
    /**
     * 用户管理.
     * @return
     */
    @RequestMapping("/userList")
    @RequiresPermissions("userInfo:view")//权限管理;
    public String userInfo(){
        return "userInfo";
    }
    /**
     * 用户添加.
     * @return
     */
    @RequestMapping("/userAdd")
    @RequiresPermissions("userInfo:add")//权限管理;
    public String userInfoAdd(){
        return "userInfoAdd";
    }
    
    /**
     * 用户查询
     */
    @RequestMapping("/userShow")
    @ResponseBody
    public String userShow(String name,String state,int page, int limit) {
    	System.out.println("UserInfoController.userShow()");
    	System.out.println("name:"+name + "  state:"+ state);
    	System.out.println("page:"+page + "  limit:"+ limit);
    	if(state != null) {
    		if(state.equals("正常"))
    			state = "1";
    		else if(state.equals("未认证"))
    			state = "0";
    		else if(state.equals("锁定"))
    			state = "2";
    	}
    	System.out.println("name:"+name + "  state:"+ state);
    	
    	Sort sort = Sort.by(Sort.Direction.ASC, "uid");
    	//此处page参数为zero based，故要page-1
    	Pageable pageable = PageRequest.of(page-1, limit, sort);
    	Page<UserInfo> datas = userInfoService.findByNameAndStatePageable(name, state, pageable);
    	long totalCount = datas.getTotalElements();
    	List<UserInfo> users = datas.getContent();
    	Map<String,Object> resultMap = new HashMap<String,Object>();
    	resultMap.put("code", 0);
    	resultMap.put("msg", "");
    	resultMap.put("count", totalCount);
    	resultMap.put("data", users);
    	String json = JSON.toJSONStringWithDateFormat(resultMap, "yyyy-MM-dd HH:mm:ss",SerializerFeature.DisableCircularReferenceDetect);
    	System.out.println("---------------count:"+totalCount);
    	System.out.println(json);
    	return json;
    }
    
    /**
     * 向数据库添加用户
     */
    @RequestMapping("/saveUser")
    public void saveUser(String username,String name,String password,String state,HttpServletResponse response) {
    	
    	System.out.println("---------username:"+ username);
    	UserInfo existUser = userInfoService.findByUsername(username);
    	
    	//返回值,手动构造json字符串
    	String jsonStr = "";
    	//用户已存在
    	if(existUser != null) {
    		jsonStr = "{\"success\":false,\"msg\":\"用户名已存在\"}";
    	}
		else {
			UserInfo user = new UserInfo();
			user.setName(name);
			user.setUsername(username);
			user.setPassword(password);
			if(state.equals("未认证"))
				user.setState((byte) 0);
			else if(state.equals("正常"))
				user.setState((byte) 1);
			else
				user.setState((byte) 2);
			// 设置salt，暂时写死，后期可用随机数生成
			user.setSalt("8d78869f470951332959580424d4bf4f");
			user.setRoleList(null);

			// 用户不存在，保存
			try {
				userInfoService.save(user);
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
    
    /**
     * 修改用户信息
     */
    @RequestMapping("/updateUser")
    public void updateUser(String username,String name,byte state,HttpServletResponse response) {
    	
    	UserInfo existUser = userInfoService.findByUsername(username);
    	existUser.setName(name);
    	existUser.setState(state);
    	//返回值,手动构造json字符串
    	String jsonStr = "";
    	
    	
    	    	
		try {
			userInfoService.save(existUser);
		} catch (Exception e) {
			jsonStr = "{\"success\":false,\"msg\":\"系统异常\"}";
		}
		if(jsonStr.equals(""))
			jsonStr = "{\"success\":true,\"msg\":\"更新成功\"}";

		System.out.println(jsonStr);
		response.setContentType("text/Xml;charset=utf-8");
		PrintWriter out = null;

		try {
			out = response.getWriter();
			out.println(jsonStr);
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
    		out.close();
    	}
    }
    
    /**
     * 重置密码
     */
    @RequestMapping("/resetPwd")
    public void resetPwd(String username,HttpServletResponse response) {
    	
    	UserInfo existUser = userInfoService.findByUsername(username);
    	existUser.setPassword("123");
    	//返回值,手动构造json字符串
    	String jsonStr = "";
    	
    	
    	    	
		try {
			userInfoService.save(existUser);
		} catch (Exception e) {
			jsonStr = "{\"success\":false,\"msg\":\"系统异常\"}";
		}
		if(jsonStr.equals(""))
			jsonStr = "{\"success\":true,\"msg\":\"重置密码成功\"}";

		System.out.println(jsonStr);
		response.setContentType("text/Xml;charset=utf-8");
		PrintWriter out = null;

		try {
			out = response.getWriter();
			out.println(jsonStr);
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
    		out.close();
    	}
    }
    
    /**
     * 修改密码
     */
    @RequestMapping("/changePwd")
    public void changePwd(String oldpassword,String newpassword,HttpServletResponse response) {
    	//返回值,手动构造json字符串
    	String jsonStr = "";
    	
    	//获取当前登录用户
    	Subject subject = SecurityUtils.getSubject();
    	UserInfo user = (UserInfo) subject.getPrincipal();
    	
    	if(!user.getPassword().equals(oldpassword)) {
    		jsonStr = "{\"success\":false,\"msg\":\"旧密码验证不通过，请重新输入！\"}";
    	}
    	else {
    		
    		user.setPassword(newpassword);
    		try {
    			userInfoService.save(user);
    		} catch (Exception e) {
    			jsonStr = "{\"success\":false,\"msg\":\"系统异常\"}";
    		}
    		if(jsonStr.equals(""))
    			jsonStr = "{\"success\":true,\"msg\":\"修改密码成功,返回重新登录！\"}";
    	}

		System.out.println(jsonStr);
		response.setContentType("text/Xml;charset=utf-8");
		PrintWriter out = null;

		try {
			out = response.getWriter();
			out.println(jsonStr);
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
    		out.close();
    	}
    }
    
    @RequestMapping("/roleAllot")
	public void roleAllot(String uid,String[] ids,HttpServletResponse response){
    	sysUserRoleService.deleteByUid(Integer.valueOf(uid));
    	
    	//返回值,手动构造json字符串
    	String jsonStr = "";
    	if(ids != null) {
    		for(int i=0; i<ids.length; i++) {
    			try {
    				sysUserRoleService.save(Integer.valueOf(uid),Integer.valueOf(ids[i]));
    			}catch (Exception e) {
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