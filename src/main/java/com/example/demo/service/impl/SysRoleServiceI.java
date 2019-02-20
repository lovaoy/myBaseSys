package com.example.demo.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.dao.SysRoleDao;
import com.example.demo.domain.SysRole;
import com.example.demo.service.SysRoleService;

@Service
public class SysRoleServiceI implements SysRoleService {

	@Autowired
	private SysRoleDao sysRoleDao;
	
	@Override
	public List<SysRole> findAll() {
		// TODO Auto-generated method stub
		return sysRoleDao.findAll();
	}

	@Override
	public SysRole save(SysRole role) {
		// TODO Auto-generated method stub
		return sysRoleDao.save(role);
	}

	@Override
	public void delete(SysRole role) {
		// TODO Auto-generated method stub
		sysRoleDao.delete(role);
	}
	
	@Override
	public SysRole findByRole(String role) {
		return sysRoleDao.findByRole(role);
	}

}
