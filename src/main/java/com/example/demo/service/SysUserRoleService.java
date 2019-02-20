package com.example.demo.service;



public interface SysUserRoleService {

	public void deleteByUid(Integer uid);
	
	public void save(Integer uid, Integer roleId);
}
