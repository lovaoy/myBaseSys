package com.example.demo.dao;

import org.springframework.data.repository.CrudRepository;

import com.example.demo.domain.SysRole;
import java.util.List;


public interface SysRoleDao extends CrudRepository<SysRole,Long>{

	public List<SysRole> findAll();
	
	public SysRole save(SysRole role);
	
	public void delete(SysRole role);
	
	public SysRole findByRole(String role);
}
