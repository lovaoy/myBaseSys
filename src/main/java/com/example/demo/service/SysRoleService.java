package com.example.demo.service;

import com.example.demo.domain.SysRole;

import java.util.List;

public interface SysRoleService {

	public List<SysRole> findAll();
	
	public SysRole save(SysRole role);
	
	public void delete(SysRole role);
	
	public SysRole findByRole(String role);
}
