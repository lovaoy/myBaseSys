package com.example.demo.service;

public interface SysRolePermissionService {

	public void deleteByRoleId(Integer roleId);
	public void save(Integer roleId, Integer permissionId);

}
