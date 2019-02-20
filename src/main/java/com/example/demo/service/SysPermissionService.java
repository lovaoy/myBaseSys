package com.example.demo.service;

import java.util.List;

import com.example.demo.domain.SysPermission;

public interface SysPermissionService {

	public List<SysPermission> findAll();
	public SysPermission save(SysPermission permission);
}
