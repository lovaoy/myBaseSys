package com.example.demo.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.dao.SysUserRoleDao;
import com.example.demo.service.SysUserRoleService;

@Service
public class SysUserRoleServiceI implements SysUserRoleService {

	@Autowired
	private SysUserRoleDao sysUserRoleDao;
	@Override
	public void deleteByUid(Integer uid) {
		// TODO Auto-generated method stub
		sysUserRoleDao.deleteByUid(uid);
	}

	@Override
	public void save(Integer uid, Integer roleId) {
		// TODO Auto-generated method stub
		sysUserRoleDao.save(uid,roleId);
	}

}
