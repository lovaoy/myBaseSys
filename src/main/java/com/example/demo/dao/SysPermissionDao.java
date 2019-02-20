package com.example.demo.dao;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.example.demo.domain.SysPermission;

public interface SysPermissionDao extends CrudRepository<SysPermission,Long>{
	
	public List<SysPermission> findAll();
	public SysPermission save(SysPermission permission);
}
