package com.example.demo.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.dao.SysRolePermissionDao;
import com.example.demo.service.SysRolePermissionService;

@Service
public class SysRolePermissionServiceI implements SysRolePermissionService {

	@Autowired
	private SysRolePermissionDao sysRolePermissionDao;
	
	@Override
	public void deleteByRoleId(Integer roleId) {
		// TODO Auto-generated method stub
		sysRolePermissionDao.deleteByRoleId(roleId);
	}

	@Override
	public void save(Integer roleId, Integer permissionId) {
		// TODO Auto-generated method stub
		sysRolePermissionDao.save(roleId, permissionId);
	}

}
