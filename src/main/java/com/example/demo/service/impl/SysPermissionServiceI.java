package com.example.demo.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.dao.SysPermissionDao;
import com.example.demo.domain.SysPermission;
import com.example.demo.service.SysPermissionService;

@Service
public class SysPermissionServiceI implements SysPermissionService {

	@Autowired
	private SysPermissionDao sysPermissionDao;
	
	@Override
	public List<SysPermission> findAll() {
		// TODO Auto-generated method stub
		return sysPermissionDao.findAll();
	}

	@Override
	public SysPermission save(SysPermission permission) {
		// TODO Auto-generated method stub
		return sysPermissionDao.save(permission);
	}

}
