package com.example.demo.config;

import java.io.IOException;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.authc.FormAuthenticationFilter;
import org.apache.shiro.web.util.WebUtils;

/**
 * 自定义拦截器，解决框架中session失效后重新登录直接跳转到失效前页面到问题
 * @author ylmac
 *
 */
public class MyFormAuthenticationFilter extends FormAuthenticationFilter {

	/**
	 * 重写onLoginSuccess方法，通过WebUtils.issueRedirect(request, response, "/hello");实现登录后跳转到指定页面
	 */
	@Override
	protected boolean onLoginSuccess(AuthenticationToken token,Subject subject,ServletRequest request,ServletResponse response) {
		System.out.println("MyFormAuthenticationFilter.onLoginSuccess()");
		try {
			WebUtils.issueRedirect(request, response, "/hello");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}
}
