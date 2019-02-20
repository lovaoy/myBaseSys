package com.example.demo.controller;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class LoginController {

	/**
	 * shiro验证方法一，此方法可以实现功能，但是逻辑对新人来说不是太容易理解
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/login")
	public String login(HttpServletRequest request) throws Exception{
	    System.out.println("LoginController.login()");
	    // 登录失败从request中获取shiro处理的异常信息。
	    // shiroLoginFailure:就是shiro异常类的全类名.
	    String exception = (String) request.getAttribute("shiroLoginFailure");
	    System.out.println("exception=" + exception);
	    String msg = "";
	    if (exception != null) {
	        if (UnknownAccountException.class.getName().equals(exception)) {
	            System.out.println("UnknownAccountException -- > 账号不存在：");
	            msg = "账号不存在";
	        } else if (IncorrectCredentialsException.class.getName().equals(exception)) {
	            System.out.println("IncorrectCredentialsException -- > 密码不正确：");
	            msg = "密码不正确";
	        } else if ("kaptchaValidateFailed".equals(exception)) {
	            System.out.println("kaptchaValidateFailed -- > 验证码错误");
	            msg = "验证码错误";
	        } else if (AuthenticationException.class.getName().equals(exception)){
	        	msg = "账号状态异常";
	        }
	        else{
	            msg = "else >> "+exception;
	            System.out.println("else -- >" + exception);
	        }
	    }
	    //map.put("msg", msg);
	    request.setAttribute("msg", msg);
	    // 此方法不处理登录成功,由shiro进行处理
	    return "/login";
	}
	
	
	/**
	 * shiro验证方法二，该方法逻辑比较清晰
	 * @param request
	 * @return
	 * @throws Exception
	 
	@RequestMapping("/login")
	public String login(String username, String password, HttpServletRequest request) throws Exception{
	    System.out.println("LoginController.login()");
	    System.out.println("username:"+ username + "----password:"+password);
	    
	    String msg = "";
	    System.out.println("-----msg:"+msg);
	    
	    //当用户名密码均为空时，不进入验证
	    if(username != null && password != null) {
	    	
	    
	    //关键
	    Subject subject = SecurityUtils.getSubject();
	    UsernamePasswordToken token = new UsernamePasswordToken(username,
	    		password);
	    
	    try {
	    	//执行登录操作，进入doGetAuthenticationInfo执行登录认证
	    	subject.login(token);
	    } catch (UnknownAccountException e) {
	    	msg = "用户名不存在";
	    } catch (IncorrectCredentialsException e) {
	    	msg = "密码错误";
	    } catch (AuthenticationException e) {
	    	// 其他错误，比如锁定，如果想单独处理请单独catch处理
	    	msg = e.getMessage();
	    }

	    }
	    // 此方法不处理登录成功,由shiro进行处理，具体在ShiroConfig中进行配置登录成功
	    //后要跳转当页面即可
	    request.setAttribute("msg", msg);
	    return "/login";
	}
	*/
	
	@RequestMapping("/403")
	public String noPermission() {
		return "/403";
	}
	
	@RequestMapping({"/","/index"})
	public String index() {
		System.out.println("LoginController.index()");
		return "redirect:/hello";  //关键，重定向到controller中到/hello方法，而不是直接到页面
	}
	
}
